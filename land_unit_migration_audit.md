# Land unit migration audit

Backup: C:\Users\jeff7\AppData\Local\Temp\MD_Revelations-before-land-unit-migration-20261029-184728

HOI4 setup.log confirms that the legacy file and split unit files are both loaded.
The legacy MD_land_units.txt matches the supplied MD 1.12.3b reference byte-for-byte.
For overlapping IDs, its values were treated as authoritative and merged into the split files.
New 1.19-only fields and additional equipment requirements were retained.

## Migrated definitions

| Unit | Active file |
| --- | --- |
| L_Ranger_Recce_Comp | common/units/MD_division_support.txt |
| attack_helo_comp | common/units/MD_regimental_support.txt |
| armor_Comp | common/units/MD_regimental_support.txt |
| L_Recce_Comp | common/units/MD_regimental_support.txt |
| Mot_Recce_Comp | common/units/MD_regimental_support.txt |
| Mech_Recce_Comp | common/units/MD_regimental_support.txt |
| Arm_Recce_Comp | common/units/MD_regimental_support.txt |
| armor_Recce_Comp | common/units/MD_regimental_support.txt |
| L_Engi_Comp | common/units/MD_division_support.txt |
| H_Engi_Comp | common/units/MD_division_support.txt |
| Arty_Battery | common/units/MD_regimental_support.txt |
| SP_Arty_Battery | common/units/MD_regimental_support.txt |
| SP_R_Arty_Battery | common/units/MD_regimental_support.txt |
| SP_AA_Battery | common/units/MD_regimental_support.txt |
| combat_service_support_company | common/units/MD_division_support.txt |
| helicopter_combat_service_support | common/units/MD_division_support.txt |
| air_assault_Arty_Battery | common/units/MD_regimental_support.txt |
| drone_tactical_company | common/units/MD_regimental_support.txt |
| HOL_marechaussee_support_company | common/units/MD_special_units.txt |
| Zombies | common/units/MD_special_units.txt |

## Equipment requirements

- infantry_weapons_type maps to Inf_equipment.
- cnc_equipment_type maps to command_control_equipment, matching legacy unit requirements.
- util_vehicle_type maps to util_vehicle_equipment.
- FPV platoon retains 120 land drones and now requires 10 robots.
- Drone recon retains 25 land drones and now requires 5 robots.
- Robot equipment is available after the 2025 robot technology.
- Fixed the legacy FPV supply_consumption typo from 0.03. to 0.03.

## Remaining unrelated overlaps

Six missile IDs still overlap between MD_air_units.txt and MD_missile_units.txt; these were not changed.

## Validation

- All 20 migrated IDs have exactly one remaining project definition.
- Legacy balance, equipment, and terrain values were checked recursively against the migrated definitions.
- Retained the 1.19 engineer support-family grouping (engineer) instead of the legacy flame grouping for L_Engi_Comp and H_Engi_Comp.
- Collapsed the duplicate legacy Zombies training_time fields to the final value, 1.
- All common/units root files have balanced braces.

## Support roster cleanup

- Removed the newer MD communications_company, military_police_attachment, and Sniper_company definitions.
- Vanilla signal.txt and military_police.txt remain overridden by empty sub_units blocks.
- All 55 original MD 1.12.3b land-unit IDs are still defined.
- The FPV drone company remains available in both division and regimental support after research.
- Twelve original support-unit IDs are restricted to regimental support in the 1.19 layout; their definitions are present.
