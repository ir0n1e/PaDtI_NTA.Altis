private ["_civilianArray", "_vehicleArray", "_ParkedArray", "_string", "_mkr", "_counter", "_GarbageArray", "_patrolArray"];
_mkr = _this select 0;

_string = format["trig%1_units", _mkr];
_civilianArray = (server getvariable _string) select 0;
_vehicleArray = (server getvariable _string) select 1;
_ParkedArray = (server getvariable _string) select 2;
_GarbageArray = (server getvariable _string) select 3;
_patrolArray = (server getvariable _string) select 5;

waituntil {!populatingCOS};

// Delete all pedestrians
_counter=0;
_countGrps = 0;
{
	_grp = _x;
	_counter=_counter+1;

	{ deleteVehicle _x } forEach units _grp;
	deleteGroup _grp;
	_countGrps = _countGrps + 1;
} foreach _civilianArray;
server setvariable ["civcount", (server getvariable "civcount") - (server getvariable format["%1_civcount", format["trig%1", _mkr]]), true];

//Delete all vehicles and crew

{
	deletevehicle _x;

} foreach _patrolArray;

 _counter=0;
{
	_veh=_x select 0;
	_unit=_x select 1;
	_grp=_x select 2;
	_counter=_counter+1;

	//CHECK VEHICLE IS NOT TAKEN BY PLAYER
	if ({isPlayer _veh} count (crew _veh) == 0) then {
		{deleteVehicle _x} forEach (crew _veh); deleteVehicle _veh;
	};

	deletevehicle _unit;
	deletegroup _grp;
	_countGrps = _countGrps + 1;
} foreach _vehicleArray;

// Delete all parked vehicles
 _counter=0;
{
	_counter=_counter+1;
	if (debugCOS) then {deletemarker (format["Park%1,mkr%2",_counter,_mkr]);};

  	//CHECK VEHICLE IS NOT TAKEN BY PLAYER
	if ({isPlayer _x} count (crew _x) == 0) then {
		deletevehicle _x;
	};
} foreach _ParkedArray;

_counter = 0;
{
	_counter = _counter + 1;
	if (debugCOS) then {deletemarker (format["Garbage%1,mkr%2",_counter,_mkr]);};
	if (_x getvariable ["burning", false]) then {
		{
			if (typeOf _x == "#particlesource") then {
				deleteVehicle _x;
			};
		} forEach (_x nearObjects 5);
	};

	deletevehicle _x;
} foreach _GarbageArray;

// Update global groups
_glbGrps=server getvariable "cosGrpCount";
_glbGrps=_glbGrps-_countGrps;
server setvariable ["cosGrpCount",_glbGrps, true];