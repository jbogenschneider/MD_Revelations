# SOLOMON adoption events

USA's one-world currency focus applies adoption and triggers all three country
events for existing countries that have not adopted yet:

```hoi4
CHI = { country_event = { id = rev_solomon.1 } }
SAU = { country_event = { id = rev_solomon.2 } }
UAE = { country_event = { id = rev_solomon.3 } }
```

Each event is independent of the USA, the date, and war status, so future story
paths can call it directly. China's November alliance event also calls its
adoption event, replacing the previous separate 90% debt reduction.

Adoption removes 80% of current debt and grants `Solomon_one_world_currency`
(+4% gross weekly revenue). Each adoption broadcasts WNN event `rev_solomon.10`.
The country flag `rev_solomon_currency_adopted` prevents repeated debt reductions
and duplicate announcements. Benefits apply in the event's immediate effects.

For other countries, call `rev_solomon_adopt_currency = yes` in country scope.

The October 2, 2028 MeccaPact realignment uses separate terms: eligible members
without the spirit receive it and a 30% debt write-off. Existing adopters receive
no additional debt relief. This route sets the same adoption flag to prevent a
later 80% write-off. Russia is excluded from the realignment and this grant.
