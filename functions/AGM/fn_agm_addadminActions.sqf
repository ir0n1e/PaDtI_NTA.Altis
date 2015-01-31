if (isClass(configFile/"CfgPatches"/"AGM_Interaction")) then {
	NTA_agm_adminmenu = ["Admin Menu", {call NTA_fnc_core_isAdmin}, {[] call NTA_fnc_agm_openadminmenu}, false] call AGM_Interaction_fnc_addInteractionSelf;
};