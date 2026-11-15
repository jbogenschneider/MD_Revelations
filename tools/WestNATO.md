# WestNATO membership

New WestNATO alliances use a separate generic faction named WestNATO, with their
own membership idea, global member array, research group and opinion modifiers.
They do not instantiate NATO's faction template, goals or rules. The older
WestNATO template remains supported for existing saves. Existing NATO membership
is unchanged at startup.
Historical NATO accession events, national focuses, and decisions remain NATO
content; WestNATO membership is controlled by the effects below.

All effects run in the country being moved. For example, in an event or focus:

```hoi4
POL = { WestNATO_join = yes }
ROM = { NATO_transfer_to_WestNATO = yes }
POL = { WestNATO_transfer_to_NATO = yes }
ROM = { WestNATO_leave = yes }
```

The first country to join creates WestNATO and becomes its leader. Subsequent
countries join that faction. No starting leader or members are assigned.
Joins require an existing independent country that is not at war with the
destination alliance leader. Joining WestNATO removes previous NATO membership;
returning to NATO removes WestNATO membership. Leaving updates the member array,
research group, opinions, military access, and faction membership.

Use `WestNATO_member` for membership checks, `global.westnato_members` for member
loops, and `rev_is_westnato_faction = yes` to recognize both generic and older
template factions. Call the
membership effects instead of changing only the idea or faction.

The Canada invasion warning now performs the split directly, before any USA
departure or declaration of war. It records current NATO members, secures German
leadership, and moves Britain, Canada, Denmark, Iceland, Norway, Sweden and the Netherlands into
WestNATO. NATO recovery uses actual membership records rather than a fixed list
of countries, and never takes members out of WestNATO or unrelated alliances.
The Great Peace reunion recognizes both forms of WestNATO.

The split also establishes non-aggression pacts and a cooperation opinion bonus
between the two blocs. WestNATO's leader refreshes the accord weekly, including
in existing saves. Reciprocal AI strategies reduce front unit requests against
peaceful members of the other bloc; wartime enemies remain eligible targets.

Console examples (with debug console effects enabled):

```text
effect POL = { WestNATO_join = yes }
effect POL = { WestNATO_transfer_to_NATO = yes }
effect POL = { WestNATO_leave = yes }
```
