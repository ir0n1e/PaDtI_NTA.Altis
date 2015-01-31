/*
	Author: Ir0n1E

	Description:
	locks vehicle

	Parameter(s):
	#0 OBJECT - vehicle

	Returns:
	none
*/

private "_veh";

_veh =  _this select 0;
[[_veh, 2], "lock", _veh] call BIS_fnc_MP;
_veh setVariable ["locked", true, true];