scriptName "fn_core_findnearunits";
/*
	Author: Ir0n1E

	Description:
	Find given number of units near position

	Parameter(s):
	#0 ARRAY - Position
	#1 NUMBER - Distance (Radius)
	#2 NUMBER - Count (How many to find)
	#3 OBJECT - Side

	Returns:
	BOOL - TRUE when done
*/

private ["_objects", "_pos", "_radius", "_side", "_count", "_return"];

_pos 		= _this select 0;
_radius 	= _this select 1;
_count 		= _this select 2;
_side 		= _this select 3;

_return 	= false;
_objects 	= _pos nearObjects ["Man",_radius];

if (({side _x == _side} count _objects) > _count) then {
	_return = true;
};

_return