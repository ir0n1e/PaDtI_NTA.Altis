BWA3_Faction_mappings = [] call ALIVE_fnc_hashCreate;
[BWA3_Faction_mappings, "Side", "WEST"] call ALIVE_fnc_hashSet;
[BWA3_Faction_mappings, "GroupSideName", "WEST"] call ALIVE_fnc_hashSet;
[BWA3_Faction_mappings, "FactionName", "BWA3_Faction"] call ALIVE_fnc_hashSet;
[BWA3_Faction_mappings, "GroupFactionName", "Bundeswehr"] call ALIVE_fnc_hashSet;

BWA3_Faction_typeMappings = [] call ALIVE_fnc_hashCreate;
[BWA3_Faction_typeMappings, "Air", "Air"] call ALIVE_fnc_hashSet;
[BWA3_Faction_typeMappings, "Armored", "Mechanized_Fleck"] call ALIVE_fnc_hashSet;
[BWA3_Faction_typeMappings, "Infantry", "Infantry_Fleck"] call ALIVE_fnc_hashSet;
[BWA3_Faction_typeMappings, "Mechanized", "Mechanized"] call ALIVE_fnc_hashSet;
[BWA3_Faction_typeMappings, "Motorized", "Motorized"] call ALIVE_fnc_hashSet;
[BWA3_Faction_typeMappings, "Motorized_MTP", "Motorized_MTP"] call ALIVE_fnc_hashSet;
[BWA3_Faction_typeMappings, "SpecOps", "SpecOps_Fleck"] call ALIVE_fnc_hashSet;
[BWA3_Faction_typeMappings, "Support", "Support"] call ALIVE_fnc_hashSet;

[BWA3_Faction_mappings, "GroupFactionTypes", BWA3_Faction_typeMappings] call ALIVE_fnc_hashSet;
[ALIVE_factionCustomMappings, "BWA3_Faction", BWA3_Faction_mappings] call ALIVE_fnc_hashSet;

[ALIVE_factionDefaultSupplies, "BWA3_Faction", ["BWA3_Box_Weapons","BWA3_Box_Ammo","AGM_Box_Medical"]] call ALIVE_fnc_hashSet;