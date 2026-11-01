# Drone and robot AI: initial balance

The new policies are in `common/ai_strategy/rev_drone_robot_adoption.txt` and `common/ai_templates/rev_drone_robot_templates.txt`. They supplement existing MD country policies. The weights below are AI preferences, not percentages or guaranteed shares of factories.

## Research and prerequisites

- Land-drone research receives a +150 `research_tech` strategy when its historical year arrives, from the early prerequisites through 2035. Each successor waits for its predecessor.
- Robot research receives +200 in 2025, 2030 and 2035, with predecessor and special-project checks.
- The fire-support land-drone special project's AI weight increases from 1 to 2, rising to 8 from 2023. Its existing requirements remain in force. A country still needs the facilities, breakthroughs and project completion to unlock robots.
- Drone recon now unlocks with `land_Drone_equipment3` (2015), alongside the tactical drone company. It previously had no technology unlock.
- Tactical drone company unit `ai_priority` is 10; drone recon is 8 (both were 0).

## Production

| Equipment | Initial production weight | Later weight |
| --- | ---: | ---: |
| Land drones | +100 after the 2015 unlock | +250 after the 2025 unlock |
| Robots | +250 after the 2025 unlock | +350 after the 2030 unlock |

Each equipment archetype also receives the following minimum factories while its stockpile is below reserve. Production starts only after its equipment unlock; the tiers are mutually exclusive for each archetype.

| Military factories | Minimum factories for drones | Minimum factories for robots |
| --- | ---: | ---: |
| 0–5 | No additional minimum | No additional minimum |
| 6–19 | 1 | 1 |
| 20–49 | 2 | 2 |
| 50+ | 4 | 4 |

Reserve thresholds are 1,500 land drones and 500 robots. Reaching the threshold removes the extra factory minimum; the production weight continues to encourage meeting unit demand. These are starting values to tune against observed shortages and industrial capacity. Policies target archetypes so later models inherit them.

## Templates and army mix

Four preferred AI template groups use the existing `L_Inf`, `infantry`, `apc_mechanized` and `ifv_mechanized` roles. Each target has six infantry/vehicle battalions, two artillery battalions, engineers, combat service support and a tactical drone company. Mobile/mechanized formations also use drone recon; light infantry retains light recon because drone recon permits mobile/armor battalion groups.

Templates become eligible from 2025 with the 2015 drone technology and at least six military factories (eleven for APC/IFV). They respect the normal God of War game-rule restriction. Their upgrade weights rise further after the 2030 robot technology. They receive robots through the technology requirements already added to these units; there is no separate robot battalion.

From 2025, after either 2025 drones or robots are researched, additive production weights decrease by 25 for MBTs and attack helicopters and by 15 for transport helicopters. The MD equipment IDs are `medium_tank_chassis`, `heavy_tank_chassis`, and `heavy_tank_amphibious_chassis`, respectively. APCs and IFVs retain their production weights.

Army role weights change by -15 armor, -3 helicopter infantry, -5 mechanized airborne, and +10 each motorized infantry, APC infantry and IFV infantry. Existing country policies still contribute, and existing units remain available.

## Validation and next tuning pass

Static validation checked all 21 strategy blocks, four template groups, technology/equipment/unit references, support-slot counts and edited-file braces. The new strategy types follow existing MD and installed HOI4 examples. Runtime AI behavior has not been tested.

For the next game test, inspect a developed AI country after its drone/robot unlocks: research selection, special-project progress, drone/robot production lines, equipment shortages and support-company adoption. Templates still require army experience and equipment; preference does not guarantee immediate conversion. Global and country-specific policies can outweigh these initial settings.
