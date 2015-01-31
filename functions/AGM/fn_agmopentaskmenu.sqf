if (!(isClass(configFile/"CfgPatches"/"AGM_Interaction"))) exitwith {};
private ["_actions"];

_actions = ["Task Menu", "Start"] call AGM_Interaction_fnc_prepareSelectMenu;
if (!isnil "PO3_missions") then {
	{
		_actions = [
			_actions,
			_x,
			"",
			_x
		] call AGM_Interaction_fnc_AddSelectableItem;
	} foreach PO3_missions + ["Skip Task"];
};
if (!DAMACTIVE) then {
_actions = [
		_actions,
		"DESTROY DAM",
		"",
		"DESTROY DAM"
	] call AGM_Interaction_fnc_AddSelectableItem;
};

[
	_actions,
	{
		call AGM_Interaction_fnc_hideMenu;
	 	switch (_this) do {
	 	    case "Skip Task": {
	 	    	[] call PO3_fnc_skipTask;
	 	    };
	 	    case "DESTROY DAM": {
	 	    	["","NTA_fnc_missions_Dam", false, false] call bis_fnc_mp;
	 		};
	 	    default {
	 	     	PO3_ForceTask = [true, _this];
	 			publicvariable "PO3_ForceTask";
	 			[] call PO3_fnc_skipTask;
	 	    };
	 	};
	},
	{
		call AGM_Interaction_fnc_hideMenu;
		if !(profileNamespace getVariable ["AGM_Interaction_AutoCloseMenu", false]) then {"Default" call AGM_Interaction_fnc_openMenu};
	}
] call AGM_Interaction_fnc_openSelectMenu;