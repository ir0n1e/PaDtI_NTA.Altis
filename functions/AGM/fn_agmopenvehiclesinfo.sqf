if (!(isClass(configFile/"CfgPatches"/"AGM_Interaction"))) exitwith {};
private ["_vec", "_actions", "_array"];
NTA_VEC = _this select 0;

_actions = [_this select 1 , "Do it"] call AGM_Interaction_fnc_prepareSelectMenu;
_locked = "LOCK";

if (NTA_VEC getvariable ["locked", false]) then {
	_locked = "UNLOCK";
};
_array = ["INFO"];

if ((getPlayerUID player) in (call NTA_fnc_players_id)) then {
	_array = ["INFO", _locked];
	_array pushback "RESPAWN";
};

{
	_actions = [
		_actions,
		format [getText (ConfigFile >> "CfgVehicles" >> typeof (_this select 0) >> "displayName") + " >> %1", _x],
		getText (ConfigFile >> "CfgVehicles" >> typeof (_this select 0) >> "picture"),
		_x
	] call AGM_Interaction_fnc_AddSelectableItem;
} foreach _array;

[
	_actions,
	{
		call AGM_Interaction_fnc_hideMenu;
		switch (_this) do {
		    case "RESPAWN": {
		    	NTA_VEC setvariable ["respawnnow", true, true];
		    };
		    case "INFO": {
		    	[NTA_VEC, true] call NTA_fnc_vehicles_info;
		    };
		    case "UNLOCK": {
		    	[NTA_VEC] call NTA_fnc_vehicles_unlock;
			};
			case "LOCK": {
		    	[NTA_VEC] call NTA_fnc_vehicles_lock;
			};
		};
	},
	{
		call AGM_Interaction_fnc_hideMenu;
		call NTA_fnc_agmopenvehicleslist;
		//if !(profileNamespace getVariable ["AGM_Interaction_AutoCloseMenu", false]) then {"Default" call AGM_Interaction_fnc_openMenu};
	}
] call AGM_Interaction_fnc_openSelectMenu;