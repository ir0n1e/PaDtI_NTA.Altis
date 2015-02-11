/*
	Author: Ir0n1E original Lala14, Tajin

	Description:
	Returns Number if vehicle in config

	Parameter(s):
	#0 Object - Vehicle

	Returns:
	Number
*/

private ["_found", "_index", "_types"];

_found = false;
_index = -1;
{
	_types = _x select 0;

	{
		if (_this isKindOf _x) exitWith { _found = true; };
	} forEach _types;

	if (_found) exitWith {_index = _forEachIndex;};

} forEach (call IL_fnc_config);

_index