# Recreate the units based in the six eastern states in Germany's active OOBs.
# Preserve source templates, experience and equipment; do not copy production or
# national stockpiles. Explicit division names avoid GER-only naming groups.
$modRoot = Split-Path -Parent $PSScriptRoot
$encoding = [Text.UTF8Encoding]::new($false)
$eastStates = @(539,1079,45,972,44,545)
$eastProvinces = [Collections.Generic.HashSet[int]]::new()
foreach ($state in $eastStates) {
    $file = Get-ChildItem (Join-Path $modRoot 'history/states') -Filter "$state-*"
    $text = [IO.File]::ReadAllText($file.FullName)
    $provinces = [regex]::Match($text, '(?s)\bprovinces\s*=\s*\{([^}]+)\}').Groups[1].Value
    foreach ($number in [regex]::Matches($provinces,'\b\d+\b')) { [void]$eastProvinces.Add([int]$number.Value) }
}
function Get-Blocks([string]$Text, [string]$KeyPattern) {
    foreach ($start in [regex]::Matches($Text, "(?m)^\s*(?:$KeyPattern)\s*=\s*\{")) {
        $depth = 0
        foreach ($token in [regex]::Matches($Text.Substring($start.Index), '"(?:\\.|[^"\\])*"|#[^\r\n]*|[{}]')) {
            if ($token.Value -eq '{') { $depth++ }
            elseif ($token.Value -eq '}') {
                $depth--
                if ($depth -eq 0) { $Text.Substring($start.Index,$token.Index+1).Trim(); break }
            }
        }
        if ($depth -ne 0) { throw 'Unbalanced source block' }
    }
}
function Save-Oob([string]$Name, [string]$Text) {
    [IO.File]::WriteAllText((Join-Path $modRoot "history/units/$Name.txt"), $Text + "`r`n", $encoding)
}
$names = @{
    'Panzerdivision' = "14. Panzergrenadier-Division 'Hanse'"
    'Panzergrenadierdivision' = '13. Panzergrenadier-Division'
    'Jägerbrigade' = "Jägerbrigade 37 'Freistaat Sachssen'"
    'Wehrbereichskommando' = 'Wehrbereichskommando VII'
    'Drone Defense Brigade' = 'Wehrbereichskommando VII'
}
foreach ($source in @('GER_2000_nsb','GER_2017_nonnsb')) {
    $text = [IO.File]::ReadAllText((Join-Path $modRoot "history/units/$source.txt"))
    $divisions = @(Get-Blocks $text 'division' | Where-Object {
        $eastProvinces.Contains([int][regex]::Match($_,'\blocation\s*=\s*(\d+)').Groups[1].Value)
    })
    $templates = [Collections.Generic.List[string]]::new()
    $units = [Collections.Generic.List[string]]::new()
    $used = [Collections.Generic.HashSet[string]]::new()
    foreach ($division in $divisions) {
        $templateName = [regex]::Match($division,'division_template\s*=\s*"([^"]+)"').Groups[1].Value
        if (-not $names.ContainsKey($templateName)) { throw "Unmapped eastern unit name: $templateName" }
        if ($used.Add($templateName)) {
            $template = @(Get-Blocks $text 'division_template' | Where-Object {
                [regex]::Match($_,'\bname\s*=\s*"([^"]+)"').Groups[1].Value -eq $templateName
            })
            if ($template.Count -ne 1) { throw "Missing or duplicate template: $templateName" }
            $templates.Add([regex]::Replace($template[0], '(?m)^\s*division_names_group\s*=\s*\S+\s*$', ''))
        }
        $unit = [regex]::Replace($division, '(?s)division_name\s*=\s*\{[^}]*\}', ('name = "' + $names[$templateName] + '"'), 1)
        $units.Add($unit)
    }
    $suffix = if ($source -eq 'GER_2000_nsb') { 'nsb' } else { 'nonnsb' }
    Save-Oob "DDR_endtimes_$suffix" ("# Generated from $source.txt; eastern-state divisions only.`r`n" + ($templates -join "`r`n`r`n") + "`r`n`r`nunits = {`r`n" + ($units -join "`r`n") + "`r`n}")
    Write-Output "$source : $($divisions.Count) eastern divisions"
}
$airSource = [IO.File]::ReadAllText((Join-Path $modRoot 'history/units/GER_2000_bba.txt'))
$wings = @(Get-Blocks $airSource '\d+' | Where-Object {
    $eastStates -contains [int][regex]::Match($_,'^\d+').Value
})
$air = "# Generated from GER_2000_bba.txt; eastern air bases only.`r`nair_wings = {`r`n" + ($wings -join "`r`n") + "`r`n}"
Save-Oob 'DDR_endtimes_air_bba' $air
# Germany's non-BBA file has stockpiles only, so retain the BBA basing/strength
# and use the corresponding legacy aircraft types for this DLC fallback.
$legacyAir = $air.Replace('large_plane_air_transport_airframe_1','transport_plane2').Replace('small_plane_airframe_2','AS_Fighter2')
$legacyAir = [regex]::Replace($legacyAir, '\s+version_name\s*=\s*"[^"]*"', '')
Save-Oob 'DDR_endtimes_air_legacy' $legacyAir
Write-Output "Eastern air bases: $($wings.Count)"
$navalSource = [IO.File]::ReadAllText((Join-Path $modRoot 'history/units/GER_2017_naval_mtg.txt'))
$fleets = @(Get-Blocks $navalSource 'fleet' | Where-Object {
    $eastProvinces.Contains([int][regex]::Match($_,'\bnaval_base\s*=\s*(\d+)').Groups[1].Value)
})
$navy = "# Generated from GER_2017_naval_mtg.txt; eastern home ports only.`r`nunits = {`r`n" + ($fleets -join "`r`n") + "`r`n}"
Save-Oob 'DDR_endtimes_naval_mtg' $navy
$legacyNavy = $navy.Replace('corvette_hull_1','missile_corvette_1').Replace('corvette_hull_2','missile_corvette_2')
$legacyNavy = [regex]::Replace($legacyNavy, '\s+version_name\s*=\s*"[^"]*"', '')
Save-Oob 'DDR_endtimes_naval_legacy' $legacyNavy
Write-Output "Eastern fleets: $($fleets.Count); ships: $([regex]::Matches($navy,'\bship\s*=').Count)"
