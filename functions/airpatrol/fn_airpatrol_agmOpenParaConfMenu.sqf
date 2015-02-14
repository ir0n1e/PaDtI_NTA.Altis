if (!(isClass(configFile/"CfgPatches"/"AGM_Interaction"))) exitwith {};
private ["_actions", "_player", "_height", "_name", "_picture"];

ParaVars 	= _this;
_player 	= _this select 1;
_actions 	= [format ["Jump Height: %1", NTA_airpatrolParaMinHeight + (_player getvariable [format ["ParaJumpHeight%1", (group _player)], 0])], "Do it >>"] call AGM_Interaction_fnc_prepareSelectMenu;
_picture 	= getText (configfile >> "CfgVehicles" >> _player getvariable ["Airpatrol_ParaChute", NTA_airpatrol_Parachute] >> "picture");
_name 		= getText (configfile >> "CfgVehicles" >> _player getvariable ["Airpatrol_ParaChute", NTA_airpatrol_Parachute] >> "DisplayName");


{
	_actions = [
		_actions,
		_x,
		"",
		[_x, _player]
	] call AGM_Interaction_fnc_AddSelectableItem;
} foreach ["Height +50", "Height +100", "Height +200"];

_actions = [_actions, "", "", ""] call AGM_Interaction_fnc_AddSelectableItem;

if (isclass (configfile >> "CfgPatches" >> "AGM_Parachute")) then {
	_actions = [_actions, _name, _picture, ["Chute", _player]] call AGM_Interaction_fnc_AddSelectableItem;
};

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
		    case "Chute": {
		    	if ((_this select 1) getvariable ["Airpatrol_ParaChute", NTA_airpatrol_Parachute] == NTA_airpatrol_Parachute) then {
					(_this select 1) setvariable ["Airpatrol_ParaChute", "AGM_NonSteerableParachute", true];
				} else {
					(_this select 1) setvariable ["Airpatrol_ParaChute", NTA_airpatrol_Parachute, true];
				};
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
		player setvariable ["Airpatrol_ParaChute", NTA_airpatrol_Parachute, true];
		player setvariable [format ["ParaJumpHeight%1", group player], 0];
		call AGM_Interaction_fnc_hideMenu;
		[player] call NTA_fnc_airpatrol_agmOpenParaMenu;
		//if !(profileNamespace getVariable ["AGM_Interaction_AutoCloseMenu", false]) then {"Default" call AGM_Interaction_fnc_openMenu};
	}
] call AGM_Interaction_fnc_openSelectMenu;
