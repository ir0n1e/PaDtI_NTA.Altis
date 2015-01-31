scriptName "fn_core_findnearplayer";
/*
	Author: Ir0n1E

	Description:
	Find near Player position

	Parameter(s):
	#0 ARRAY - Position
	#1 NUMBER - Radius
	#2 ARRAY - Objects

	Returns:
	ARRAY - Position
*/

private ["_objects", "_pos", "_radius", "_nearest", "_dist"];

_pos = _this select 0;
_radius = _this select 1;
_objects = _this select 2;
_nearest = objnull;
{
	_dist = vehicle _x distance _pos;

	if (_dist < _radius) then {
		_nearest = _x;
		_radius = _dist;
	};

} forEach _objects;

_nearest