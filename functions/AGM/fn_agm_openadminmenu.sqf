if (!(isClass(configFile/"CfgPatches"/"AGM_Interaction"))) exitwith {};

_actions = ["Admin Menu", "Do it >>"] call AGM_Interaction_fnc_prepareSelectMenu;

{
	_actions = [
		_actions,
		_x,
		"",
		_x
	] call AGM_Interaction_fnc_AddSelectableItem;
} foreach ["DEBUG", "PLAYERS", "TICKETS", "VEHICLE LIST", "TASK MENU"];

[
	_actions,
	{
		call AGM_Interaction_fnc_hideMenu;
		switch (_this) do {
		    case "DEBUG": {
		    	[] call NTA_fnc_core_debug;
		    };
		    case "PLAYERS": {
		    	[] call NTA_fnc_agm_openplayerlist;
		    };
		    case "NTA PLAYERS": {
		    	[] call NTA_fnc_agm_openNTAplayerMenu;
			};

		    case "TICKETS": {
		    	[] call NTA_fnc_agm_openticketmenu;
			};
			case "VEHICLE LIST": {
		    	[] call NTA_fnc_agmopenvehicleslist;
			};
			case "TASK MENU": {
		    	[] call NTA_fnc_agmopentaskmenu;
			};
		};
	},
	{
		call AGM_Interaction_fnc_hideMenu;
		if !(profileNamespace getVariable ["AGM_Interaction_AutoCloseMenu", false]) then {"Default" call AGM_Interaction_fnc_openMenu};
	}
] call AGM_Interaction_fnc_openSelectMenu;