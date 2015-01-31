/*
	Author: Ir0n1E

	Description:
	Creates Static emplacement

	Parameter(s):
	#0 ARRAY 	- Position
	#1 STRING 	- Type of Static
	#2 OBJECT	- Side
	#3 NUMBER	- Direction

	Returns:
	ARRAY [Objects, Units]
*/

private ["_pos", "_static", "_obj", "_side", "_unit", "_type", "_objects", "_units", "_dir"];

_pos 		= _this select 0;
_type 		= _this select 1;
_side 		= _this select 2;
_dir 		= 180;

if (count _this > 3) then {
	_dir = _this select 3;
};

_objects 	= [];
_units		= [];

createCenter _side;

_static = _type createVehicle [0,0,0];
_static setPosASL _pos;
_static setdir _dir;
_objects pushBack _static;

_grp = createGroup _side;
_unit = _grp createUnit ["O_support_MG_F", [0,0,0], [], 6, "NONE"];
_unit moveInGunner _static;
_units pushBack _unit;

_unit = _grp createUnit ["O_support_MG_F", position _static, [], 2, "NONE"];
_units pushBack _unit;

[_grp, '', [_pos, 2, _dir] call BIS_fnc_relPos, "LIMITED", "HOLD", "COMBAT"] call NTA_fnc_vehicles_addwaypoint;
_grp setFormDir _dir;

_pos = getposASL _static;
for "_o" from 0 to 1 do {
	_dir = (getdir _static) + 180;

	for "_i" from 1 to 6 do {
		_dir = (_dir +45);
		_obj = "Land_BagFence_Long_F" createVehicle [0,0,0];
		_newpos = [[_pos select 0, _pos select 1, (_pos select 2) + (_o*0.6) - 0.5], 2, _dir  ] call BIS_fnc_relPos;
		_obj setposASL _newpos;
		_obj setdir (_dir + 1.8);

		_objects pushBack _obj;
	};
};

[_objects, _units]