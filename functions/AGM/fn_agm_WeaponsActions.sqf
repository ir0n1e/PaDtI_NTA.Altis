[_this, "Weapon Save", 10, {primaryweapon player != ""}, {[true] call NTA_fnc_agm_weaponsMenuSave}, false] call AGM_Interaction_fnc_addInteraction;

[_this, "Weapon Load", 10, {true}, {[false] call NTA_fnc_agm_weaponsMenuSave}, false] call AGM_Interaction_fnc_addInteraction;

[_this, "Statistics", 10, {true}, {call NTA_fnc_agm_openPlayerStats}, false] call AGM_Interaction_fnc_addInteraction;

[_this, "View Settings", 10, {true}, {call NTA_fnc_agm_viewSettingsMenu}, false] call AGM_Interaction_fnc_addInteraction;