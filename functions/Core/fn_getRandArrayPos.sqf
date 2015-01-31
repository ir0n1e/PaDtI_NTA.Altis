scriptName "fn_getRandArrayPos";
/*
	Author: Ir0n1E

	Description:
	Returns  Random Pos in Array

	Parameter(s):
	#0 ARRAY

	Returns:
	OBJECT
*/
private ["_array", "_element"];

_array = _this;

//_array call BIS_fnc_arrayShuffle;

_element = _array select (floor (random (count _this)));

if (isnil "_element") exitwith {
	_array select 0
};

_element