
if (!(isClass(configFile/"CfgPatches"/"AGM_Interaction"))) exitwith {};
private ["_actions", "_array"];


_actions = [format ["NTA Tickets: %1 Active: %2", NTA_Tickets, NTA_TicketsActive], "Do it"] call AGM_Interaction_fnc_prepareSelectMenu;

_array = ["Tickets to default", "Tickets +50", "Tickets +100"];


{
	_actions = [
		_actions,
		_x,
		"",
		_x
	] call AGM_Interaction_fnc_AddSelectableItem;
} foreach _array;

[
	_actions,
	{
		call AGM_Interaction_fnc_hideMenu;
		switch (_this) do {
		    case "Tickets to default": {
		    	NTA_Tickets = ("NTA_Tickets" call bis_fnc_getParamValue);
		    	publicvariable "NTA_Tickets";
		    };
		    case "Tickets +50": {
		    	NTA_Tickets = NTA_Tickets + 50;
		    	publicvariable "NTA_Tickets";
		    };
		    case "Tickets +100": {
		    	NTA_Tickets = NTA_Tickets + 100;
		    	publicvariable "NTA_Tickets";
		    };
		};
	},
	{
		call AGM_Interaction_fnc_hideMenu;
		[] call NTA_fnc_agm_openadminmenu;
		//if !(profileNamespace getVariable ["AGM_Interaction_AutoCloseMenu", false]) then {"Default" call AGM_Interaction_fnc_openMenu};
	}
] call AGM_Interaction_fnc_openSelectMenu;