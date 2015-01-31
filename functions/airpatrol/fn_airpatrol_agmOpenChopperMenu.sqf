if (!(isClass(configFile/"CfgPatches"/"AGM_Interaction"))) exitwith {};
private ["_actions", "_picture", "_player", "_playerCount", "_seats", "_tickets", "_name", "_grpCount"];

_player 	= _this select 0;
_grpCount 	= count (_player getvariable format ["insert%1", (group _player)]);

apinsertgroupall = [];

for "_i" from 0 to (_grpCount -1) do {
	{
		apinsertgroupall pushback _x;
	} foreach (_player getvariable format ["insert%1", (group _player)] select _i);
};

_actions = [format ["Chopper Menu - %1 Units", count apinsertgroupall], "Call"] call AGM_Interaction_fnc_prepareSelectMenu;

{
	if (getNumber (configfile >> "CfgVehicles" >> _x >> "transportsoldier") > 0) then {

		_picture 		= getText (configfile >> "CfgVehicles" >> _x >> "picture");
		_name 			= getText (configfile >> "CfgVehicles" >> _x >> "DisplayName");

		_actions = [
			_actions,
			format ["%1 Count: %2", _name, _grpCount],
			_picture,
			[_x, _player, apinsertgroupall]
		] call AGM_Interaction_fnc_AddSelectableItem;

		for "_i" from 0 to (_grpCount -1) do {
			_playerCount	= count ((_player getvariable format ["insert%1", (group _player)]) select _i);
			_seats 			= getNumber (configfile >> "CfgVehicles" >> _x >> "transportsoldier") + (count (getarray (configfile >> "CfgVehicles" >> _x >> "memoryPointsGetInCargoPrecise")) -1)- _playerCount;
			_tickets 		= (_seats * 10) + 20;

			_actions = [
				_actions,
				format ["Chopper %1 Free Seats: %2 Tickets: %3", (_i + 1), _seats, _tickets],
				_picture,
				[_x, _player, apinsertgroupall]
			] call AGM_Interaction_fnc_AddSelectableItem;

		};
		_actions = [_actions, "----------------", "", ""] call AGM_Interaction_fnc_AddSelectableItem;

	};
} foreach NTA_Airpatrol_WEST + NTA_Airpatrol_Insert_West;

if (_grpCount < 3) then {
	_actions = [
		_actions,
		"Call Extra Chopper",
		"",
		["Chopper", _player]
	] call AGM_Interaction_fnc_AddSelectableItem;
};

[
	_actions,
	{
		call AGM_Interaction_fnc_hideMenu;
		if ((_this select 0) == "Chopper") then {
			_count = count ((_this select 1) getvariable format ["insert%1", (group (_this select 1))]);
			_array = [apinsertgroupall, (_count + 1)] call NTA_fnc_arraySplit;
			(_this select 1) setvariable [format ["insert%1", group (_this select 1)], _array, true];
			[(_this select 1)] call NTA_fnc_airpatrol_agmOpenChopperMenu;
		} else {
			_this call NTA_fnc_airpatrol_userInsertion;
		};
	},
	{
		player  setvariable [format ["insert%1", group player], apinsertgroupall];
		call AGM_Interaction_fnc_hideMenu;
		[player] call NTA_fnc_airpatrol_agmOpenInsertMenu;
		//if !(profileNamespace getVariable ["AGM_Interaction_AutoCloseMenu", false]) then {"Default" call AGM_Interaction_fnc_openMenu};
	}
] call AGM_Interaction_fnc_openSelectMenu;