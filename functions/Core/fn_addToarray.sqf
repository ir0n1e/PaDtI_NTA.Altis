scriptName "fn_addToarray.sqf";
/*
	Author: Eightysix

	Description:
	Adds value to existing Array.

	Syntax:
	[<array>,<newValue>] call NTA_fnc_addToarray;

	Example:

*/
(_this select 0) set [count (_this select 0), _this select 1];

(_this select 0)
