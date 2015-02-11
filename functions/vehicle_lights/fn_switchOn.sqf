/*
	Author: Ir0n1E original Lala14, Tajin

	Description:
	switch light on

	Parameter(s):
	#0 OBJECT - Vehicle

	Returns:
	None
*/




private ["_veh", "_ison"];

_veh 	= _this select 0;
_ison 	= _veh getVariable ["interiorlight", false];

if (_ison) then {
	_veh setVariable["interiorlight", false, true];
} else {
	_veh setVariable["interiorlight", true, true];
};