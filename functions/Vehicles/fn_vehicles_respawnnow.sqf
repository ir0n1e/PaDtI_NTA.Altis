scriptName "fn_vehicles_respawnnow";
/*
	Author: Ir0n1E

	Description:
	Respawns vehicle - needs fn_vehicles_respawn

	Parameter(s):
	#0 OBJECT - vehicle

	Returns:
	none
*/

private "_vehicle";

_vehicle = _this select 0;

_vehicle setVariable ["respawnnow", true, true];
