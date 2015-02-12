/*
	Author: Ir0n1E original Lala14, Tajin

	Description:
	Checks if we can switch to green

	Parameter(s):
	#0 OBJECT - player

	Returns:
	BOOL
*/

private ["_veh", "_player", "_show", "_index"];

_player = _this select 0;
_veh 	= vehicle _player;
_index 	= _veh call IL_fnc_inList;
_show 	= false;

if (!(isNil {_veh getVariable 'IL_override'}) && {IL_c_green in ((_veh getVariable ['IL_override', []]) select 0)}) then {
	_player setUserActionText[IL_action2,IL_Red_Text];
};

if (isNil {_veh getVariable 'IL_override'}) then {
	_player setUserActionText[IL_action2,IL_Green_Text];
};

if (_veh != _player && {_index > -1}) then {
	_show = (_index > -1 && {(call IL_fnc_config select _index) select 3});
};

if (_veh getvariable ["IL_Crew_Only", IL_Crew_Only]) then {
	_show = (_show && {_player == driver _veh || {_player == gunner _veh} || {_player == commander _veh} || {_player in (_veh call IL_fnc_returnTurretUnits)}});
};

_veh getVariable ["interiorlight", false] && _show