if (!(isClass(configFile/"CfgPatches"/"AGM_Interaction"))) exitwith {};
private ["_actions", "_player", "_height"];

ParaVars 	= _this;
_player 	= _this select 1;
_actions 	= [format ["Jump Height: %1", NTA_airpatrolParaMinHeight + (_player getvariable [format ["ParaJumpHeight%1", (group _player)], 0])], "Do it >>"] call AGM_Interaction_fnc_prepareSelectMenu;

{
	_actions = [
		_actions,
		_x,
		"",
		[_x, _player]
	] call AGM_Interaction_fnc_AddSelectableItem;
} foreach ["Height +50", "Height +100", "Height +200"];
_actions = [_actions, "", "", ""] call AGM_Interaction_fnc_AddSelectableItem;
_actions = [_actions, "---------------", "", ""] call AGM_Interaction_fnc_AddSelectableItem;
_actions = [_actions, "Call Chopper", "", ["CallChopper", _player]] call AGM_Interaction_fnc_AddSelectableItem;

[
	_actions,
	{
		call AGM_Interaction_fnc_hideMenu;
		_height = (_this select 1) getvariable [format ["ParaJumpHeight%1", group (_this select 1)], 0];
		switch (_this select 0) do {
		    case "Height +50": {
		    	(_this select 1) setvariable [format ["ParaJumpHeight%1", group (_this select 1)], _height + 50];
		    };
		    case "Height +100": {
		    	(_this select 1) setvariable [format ["ParaJumpHeight%1", group (_this select 1)], _height + 100];
		    };
		    case "Height +200": {
		    	(_this select 1) setvariable [format ["ParaJumpHeight%1", group (_this select 1)], _height + 100];
		    };
		    case "CallChopper": {
				ParaVars call NTA_fnc_airpatrol_userInsertion;
			};
		};

		if ((_this select 0) != "CallChopper") then {
			ParaVars call NTA_fnc_airpatrol_agmOpenParaConfMenu;
		};
	},

	{
		player setvariable [format ["ParaJumpHeight%1", group player], 0];
		call AGM_Interaction_fnc_hideMenu;
		[player] call NTA_fnc_airpatrol_agmOpenParaMenu;
		//if !(profileNamespace getVariable ["AGM_Interaction_AutoCloseMenu", false]) then {"Default" call AGM_Interaction_fnc_openMenu};
	}
] call AGM_Interaction_fnc_openSelectMenu;
