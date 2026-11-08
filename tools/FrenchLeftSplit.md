# Prepared French left split

`FRC` is the French Popular Republic, led by Jean-Luc Mélenchon using
`gfx/leaders/FRA/Jean-Luc_Melenchon.dds`. Its only eligible parties are LFI,
EELV, and Parti Socialiste. Initial support is 60%, 20%, and 20%, respectively;
all three form the governing coalition. Elections remain enabled.

The country is dormant in a new 2026 campaign, with no initial FRC cores.
The civil-war split is scheduled for July 2, 2029, using the former French
monarchy timer. For earlier testing, use:

```text
event rev_fra_split.1 FRA
```

Future French events can instead call `rev_fra_start_left_split = yes` in FRA
scope. Both entry points require FRA to own states 56, 54, 55, 305, and 59, and
require FRC not to exist already. Only those five states become FRC, with Paris
as its capital. All other French states remain FRA. FRC then declares a war
using the game's `civil_war` war goal against FRA.

The split also sends the worldwide `endtimes.22` notification to every human
player, describing Le Pen's alliance with Alex, the proposed SOLOMON system,
and the far-left revolt. It is dispatched once when the civil war begins.

Five days after the split (normally July 7, 2029), FRA receives the royal restoration event
`endtimes.11`: Geoffroy Saint-Michel replaces the current leader, the former
nationalist parties are excluded, and elections end. The restoration restores
NATO membership and gives FRA no additional territory. States 857, 63, and 1000
pass from FRA to Italy, state 963 passes from FRA to Switzerland, and Italy
annexes Monaco. A separate popup (`rev_fra_split.2`) describes the loyalists'
flight one hour later. Transfers require FRA to own the relevant states and
the recipient countries to exist.

Spain and Portugal follow the French restoration after two days; Britain and
Ireland follow after ten days. Their former fixed-date dispatches have been
replaced with events queued by the actual French restoration.

FRC copies France's live technology and research-slot count at the split. Its
dormant history also inherits France's scenario technology. Run the event at
the beginning of 2026 for the starting research level, or later for advances
made during play.

## Army reassignment

The regional starting roster is extracted from the active French land OOB:

| Source | Regional formations | FRC OOB |
| --- | ---: | --- |
| FRA_2000_nsb | 5 | FRC_split_army_nsb |
| FRA_2000_nonnsb | 4 | FRC_split_army_legacy_2024 |
| FRA_2017_nonnsb | 4 | FRC_split_army_legacy_2026 |

The selected original formations still begin under FRA. Their original unit
definitions now run through `create_unit` with script IDs 9905601–9905605.
The split removes those IDs from FRA wherever they have moved and re-forms
the historical roster under FRC. Original templates, names, equipment factors,
forced equipment variants, experience factors, and starting locations are
preserved. This uses the history definitions, not the units' current battlefield
strength, upgraded templates, or accumulated experience.

Start a new campaign after installing these changes so the initial formations
receive their script IDs. Older saves without `rev_fra_regional_oob_mode` cannot
run the prepared split; the guard prevents creating a duplicate historical army.

Air wings and fleets are not transferred by this army-specific preparation.
The selected states contain historical French air deployments, but the game
does not document a corresponding way to select and transfer individual air
wings by their starting state. No French fleet in FRA_2017_naval_mtg is based
in the selected states.

To regenerate the prepared army data after reviewing the regional OOBs:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File tools/Generate-FrenchLeftSplitOob.ps1
```

On subsequent runs the FRC OOB files serve as the recorded regional roster.
The generator leaves unrelated French formations, stockpiles, and production
in the original files.
