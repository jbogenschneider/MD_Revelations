# MeccaPact

A standalone CSTO-style defensive faction for future Middle East and Asian
content. It has no Russian, former Soviet, geographic, or religious membership
requirements. It retains CSTO's non-democratic normal admission rule, defensive
calls to war, leader-only war declarations, and claimed-state peace doctrine.
Scripted joins can choose countries regardless of ideology.

The faction has separate membership, research sharing (1% per country), and
goals for reaching five and ten members. It currently reuses CSTO graphics.
No faction or members are added at game startup.

All effects run in the country being changed:

```hoi4
SAU = { MeccaPact_create = yes } # Optional: create with Saudi Arabia only.
PAK = { MeccaPact_join = yes }   # Creates under SAU if needed, then adds Pakistan.
PER = { MeccaPact_join = yes }
PAK = { MeccaPact_leave = yes }
```

The first join requires an existing independent Saudi Arabia that is not at war
with the applicant. Founding the pact moves Saudi Arabia out of its previous
alliance. Later joins follow the pact's current leader, so it can survive a
leadership change. Joins reject subjects and countries at war with pact members.
Repeated joins do not duplicate the membership array.

Joining removes previous NATO, WestNATO, or CSTO membership and research sharing
before changing factions. Use the effects instead of changing only the idea or
faction. The regular NATO, WestNATO, and CSTO join helpers remove MeccaPact
membership when transferring back.

Membership identifiers:

- Idea: `MeccaPact_member`
- Member array: `global.meccapact_members`
- Template: `faction_template_meccapact`
- Research group: `MeccaPact_Tech_Share`

Console examples:

```text
effect SAU = { MeccaPact_create = yes }
effect PAK = { MeccaPact_join = yes }
effect PAK = { MeccaPact_leave = yes }
```
