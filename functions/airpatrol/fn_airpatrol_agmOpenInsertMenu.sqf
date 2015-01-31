if (!(isClass(configFile/"CfgPatches"/"AGM_Interaction"))) exitwith {};
private ["_actions", "_array", "_picture", "_player"];

_player 	= _this select 0;
_actions 	= [format ["Insertion %1", (group _player)], "Do It >>"] call AGM_Interaction_fnc_prepareSelectMenu;
Insertarray = [];

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
{
	_actions = [_actions, _x, "", [_x, _player]] call AGM_Interaction_fnc_AddSelectableItem;
} foreach ["","Add All", "Call Chopper"];
[
	_actions,
	{

		if (str (_this select 0) == str "Add All") exitwith {
			(_this select 1) setvariable [format ["insert%1", group (_this select 1)], InsertArray];
			call AGM_Interaction_fnc_hideMenu;
			[(_this select 1)] call NTA_fnc_airpatrol_agmOpenInsertMenu;
		};

		_insplayers = (_this select 1) getvariable [format ["insert%1", group (_this select 1)], []];
		if (str (_this select 0) == str "Call Chopper") then {
			call AGM_Interaction_fnc_hideMenu;

			if (count _insPlayers > 0) then {
				(_this select 1) setvariable [format ["insert%1", group (_this select 1)], [_insplayers], true];
				[(_this select 1)] call NTA_fnc_airpatrol_agmOpenChopperMenu;
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
		call AGM_Interaction_fnc_hideMenu;
		if !(profileNamespace getVariable ["AGM_Interaction_AutoCloseMenu", false]) then {"Default" call AGM_Interaction_fnc_openMenu};

	}
] call AGM_Interaction_fnc_openSelectMenu;