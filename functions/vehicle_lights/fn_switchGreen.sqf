/*
	Author: Ir0n1E original Lala14, Tajin

	Description:
	Switches green light on or off

	Parameter(s):
	#0 Object - Vehicle

	Returns:
	None
*/

private ["_veh", "_lights","_lighter","_lighters", "_lightamount", "_indexndex"];

_veh			= _this select 0;
_index 			= _veh call IL_fnc_inList;
_lightamount 	= (call IL_fnc_config select _index) select 4;
_lights 		=+ (call IL_fnc_config select _index) select 2;
_lighter 		= _lights select 0;

if (_index == -1) exitwith {};

if (isNil {_veh getVariable 'IL_override'}) then {
	_lighter set [1, IL_c_green];

	if (count _lights > 1 && {isNil {_lightamount}}) then {
		_lighters = _lights select 1;
		_lighters set [1, IL_c_green];
		_lights set [1, _lighters];
	};

	if (!isNil {_lightamount}) then {
		{
			_x set [1,IL_c_green];
			_lights set [_forEachIndex, _x];
		} forEach _lights;
	};

	_lights set [0,_lighter];
	_veh setVariable ['IL_override', _lights, true];
	_veh setVariable ['IL_timestamp', time, true];
} else {
	_veh setVariable ['IL_override', nil, true];
	_veh setVariable ['IL_timestamp', time, true];
};