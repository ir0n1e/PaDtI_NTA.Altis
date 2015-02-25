if (!(isClass(configFile/"CfgPatches"/"AGM_Interaction"))) exitwith {};
private ["_actions", "_array", "_picture", "_player", "_chopperString"];

_player 	= _this select 0;
_actions 	= [format ["Insertion %1", (group _player)], "Do It >>"] call AGM_Interaction_fnc_prepareSelectMenu;
_chopperStr = "Call Chopper";
Insertarray = [];

if (_player getVariable [format ["ParaDrop%1", group _player], false]) then {
	_chopperStr = "Call ParaDrop";
};


{
	if ((_x distance _player) < 10) then {
		Insertarray pushback _x;
	};
} foreach units (group _player);

{
	_picture = "PictureThing";
	if (count (squadParams _x) > 0) then {
		_picture = (squadParams _x select 0) select 4;
	};

	_actions = [
		_actions,
		format ["%1 In Insertion Team: %2", name _x, _x in (_player getvariable [format ["insert%1", (group _player)], []])],
		_picture,
		[_x, _player]
	] call AGM_Interaction_fnc_AddSelectableItem;

} foreach InsertArray;
_actions = [_actions, "", "", ""] call AGM_Interaction_fnc_AddSelectableItem;
_actions = [_actions, "Add All", "", ["Add All", _player]] call AGM_Interaction_fnc_AddSelectableItem;
_actions = [_actions, "---------------", "", ""] call AGM_Interaction_fnc_AddSelectableItem;

if (count (_player getvariable [format ["insert%1", group _player], []]) > 5 || {name _player == "drei.zehn"}) then {
	_actions = [_actions, format ["Para Drop %1", _player getVariable [format ["ParaDrop%1", group _player], false]], "", ["ParaDrop", _player]] call AGM_Interaction_fnc_AddSelectableItem;
};

_actions = [_actions, _chopperStr, "", ["CallChopper", _player]] call AGM_Interaction_fnc_AddSelectableItem;

[
	_actions,
	{

		if (str (_this select 0) == str "Add All") exitwith {
			(_this select 1) setvariable [format ["insert%1", group (_this select 1)], InsertArray];
			call AGM_Interaction_fnc_hideMenu;
			[(_this select 1)] call NTA_fnc_airpatrol_agmOpenInsertMenu;
		};

		if (str (_this select 0) == str "ParaDrop") exitwith {
			(_this select 1) setVariable [format ["ParaDrop%1", group (_this select 1)], true];
			call AGM_Interaction_fnc_hideMenu;
			[(_this select 1)] call NTA_fnc_airpatrol_agmOpenInsertMenu;
		};

		_insplayers = (_this select 1) getvariable [format ["insert%1", group (_this select 1)], []];
		if (str (_this select 0) == str "CallChopper") then {
			call AGM_Interaction_fnc_hideMenu;

			if (count _insPlayers > 0) then {
				(_this select 1) setvariable [format ["insert%1", group (_this select 1)], [_insplayers], true];
				if !((_this select 1) getVariable [format ["ParaDrop%1", group (_this select 1)], false]) then {
					[(_this select 1)] call NTA_fnc_airpatrol_agmOpenChopperMenu;
				} else {
					[(_this select 1)] call NTA_fnc_airpatrol_agmOpenParaMenu;
				};
			} else {
				[(_this select 1)] call NTA_fnc_airpatrol_agmOpenInsertMenu;
			};
		} else {
			call AGM_Interaction_fnc_hideMenu;

			if !((_this select 0) in _insplayers) then {
				_insplayers pushback (_this select 0);
			};

			(_this select 1) setvariable [format ["insert%1", group (_this select 1)], _insplayers];
			[(_this select 1)] call NTA_fnc_airpatrol_agmOpenInsertMenu;
		};
	},
	{
		player setVariable [format ["ParaDrop%1", group player], false];
		call AGM_Interaction_fnc_hideMenu;
		if !(profileNamespace getVariable ["AGM_Interaction_AutoCloseMenu", false]) then {"Default" call AGM_Interaction_fnc_openMenu};

	}
] call AGM_Interaction_fnc_openSelectMenu;
