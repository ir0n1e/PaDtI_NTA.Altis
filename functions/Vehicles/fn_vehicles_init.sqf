/*
	Author: Ir0n1E

	Description:
	vehicle init

	Parameter(s):
	none

	Returns:
	none
*/

if (!isServer) exitwith {};
private ["_time", "_veh"];

"Starting Vehicle Init..." call NTA_fnc_log;
_time = diag_ticktime;
NTA_VehiclesFirstrun = true;
{
	_veh = call compile _x;

	if (format ["NTA_%1", _x] call bis_fnc_getParamValue == 0 && {"NTA_Vehicles" call bis_fnc_getParamValue == 0}) then {
		_veh allowDamage false;
		_veh hideObjectGlobal true;
	};

	//_veh setVehicleVarName _x;

	[_veh] call NTA_fnc_vehicles_defaults;

} forEach (call NTA_fnc_all_vehicles);



if (("NTA_EVENT" call bis_fnc_getParamValue) > 0) then {
	"EVENT NO VEHICLE RESPAWN" call NTA_fnc_log;
};

missionNamespace setvariable ["NTA_VehiclesInit", true];
publicvariable "NTA_VehiclesInit";

format ["Vehicle Init in %1 sec Done...", (diag_ticktime - _time)] call NTA_fnc_log;

NTA_VehiclesFirstrun = false;
[] spawn NTA_fnc_vehicles_respawn;
