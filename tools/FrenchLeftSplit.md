# Prepared French left split

`FRC` is the French Popular Republic, led by Jean-Luc Mélenchon using
`gfx/leaders/FRA/Jean-Luc_Melenchon.dds`. Its only eligible parties are LFI,
EELV, and Parti Socialiste. Initial support is 60%, 20%, and 20%, respectively;
all three form the governing coalition. Elections remain enabled.

The country is dormant in a new 2026 campaign, with no initial FRC cores.
The civil-war split is scheduled from November 27 through December 5, 2028.
For earlier testing, use the console command below.

```text
event rev_fra_split.1 FRA
```

Future French events can instead call `rev_fra_start_left_split = yes` in FRA
scope. Both entry points require FRA to own states 56, 54, 55, 59, 959, 64, and 961,
and require FRC not to exist already. Those seven states become FRC, with Paris
as its capital. France keeps state 305, Champagne-Ardennes, then declares war
on FRC with the `annex_everything` war goal.

The split also sends the worldwide `endtimes.22` notification to every human
player, describing Le Pen's alliance with Alex, the proposed SOLOMON system,
and the far-left revolt. It is dispatched once when the civil war begins.

Five days after the split, FRA receives `endtimes.11`. Geoffroy Saint-Michel leads
a constitutional monarchy with democratic elections and restores NATO membership.
One hour later, `rev_fra_split.2` reports that Le Pen's administration fled France.

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
the historical roster under FRC using the original templates, names, equipment
and experience factors. The two formations from Champagne-Ardennes redeploy to
Rennes and Nantes when they join FRC. Re-formed units use their history definitions.

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
