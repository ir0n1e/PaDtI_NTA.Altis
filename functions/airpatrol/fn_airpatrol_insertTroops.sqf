private ["_inf", "_vehicles", "_targetPos", "_grp", "_landPos", "_min", "_max", "_vehname", "_apUserInsert", "_apUser", "_padClass", "_pos", "_dir"];




_vehicles 		= _this select 0;
_targetPos 		= _this select 1;
_apUserInsert 	= _this select 2;
_apUser 		= _this select 3;

_grp 			= group (_vehicles select 0);
_xm 			= 300;
_ym 			= 300;
_gradient 		= 0.3;
_counter 		= 5;
_padClass 		= "Land_HelipadEmpty_F";
_landpos 		= [];
_ounter 		= 0;
_marker = createMarker ["marker_player", _targetPos];
_marker setMarkerShape "RECTANGLE";
_marker setMarkerSize [_ym, _xm];

if (NTA_Airpatrol_Debug) then {
	_padClass = "Land_HelipadCivil_F";
};
/*
while {count _landPos < (count _vehicles) && {{alive _x} count _vehicles == (count _vehicles)}} do {
	_landPos = [_marker, [count _vehicles],(_vehicles select 0), 0.5] call NTA_fnc_getRandMkrLocs;
	//_marker setMarkerSize [_ym + 50, _xm + 50];
	_counter = _counter + 1;
};
*/

{
	_landPos  pushback ([_marker, [(1 +_foreachIndex) *_ym, _ym], 10, 0] call PO3_fnc_getSafePos);
} foreach _vehicles;

/*
if (_counter == 5 || {count _landPos < (count _vehicles)}) exitWith {
	"Airpatrol No LZ found" call NTA_fnc_log;
	{
		deleteVehicle _x;
	} foreach _vehicles;
	if (_apUserInsert) then {
		["No LZ found!", "NTA_fnc_note", _apUser] call bis_fnc_mp;
	};
};
*/
deletemarker _marker;

for "_i" from 0 to (count _vehicles) -1 do {

	if (!_apUserInsert) then {
		_infgroup = [[0,0,0], EAST, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam")] call BIS_fnc_spawnGroup;
		[_infgroup,'', (_landPos select _i), "FULL", "GETOUT"]  call NTA_fnc_vehicles_addwaypoint;
		[_infgroup,'', _targetPos, "FULL", "SAD"] call NTA_fnc_vehicles_addwaypoint;
		_inf = units _infgroup;
		{
			_x call NTA_fnc_vehicles_unitLoadout;
		} foreach _inf;

	} else {
		_inf = (_apUser getvariable format ["insert%1", group _apUser]) select _i;
	};

	for "_o" from 0 to (count _inf) -1 do {
		[[(_inf select _o), (_vehicles select _i), _o], "NTA_fnc_airpatrol_movein", (_inf select _o)] call bis_fnc_mp;
	};

	_pad = _padClass createvehicle (_landPos select _i);
 	_pad setdir (getdir (_vehicles select _i));
	(_vehicles select _i) setVariable ["Aipatrol_Pad", _pad];
	_dir = [getpos (_vehicles select _i), (_landPos select _i)] call BIS_fnc_dirTo;

	_pos = [(_landPos select _i), -850, (_dir -30)] call BIS_fnc_relPos;

	_wp = [group (_vehicles select _i), 1, _pos, 'NORMAL', 'MOVE', 'CARELESS', 'RED', ['true', '{_x flyInHeight 35; _x setcombatmode "RED"} foreach thislist']] call NTA_fnc_vehicles_addwaypoint;
	_wp setWaypointCompletionRadius 200;

	_wp = [group (_vehicles select _i), 2, (_landPos select _i), 'FULL', 'TR UNLOAD', 'CARELESS', 'RED', ['true', '{_x flyInHeight 35; _x setcombatmode "RED"} foreach thislist']] call NTA_fnc_vehicles_addwaypoint;
	_wp setWaypointCompletionRadius 200;

	_Pos = (_vehicles select _i) getvariable ["Airpatrol_EndPos", [0,0,0]];



	_wp = [group (_vehicles select _i), 3, _Pos, 'FULL', 'MOVE', 'CARELESS', 'RED', ['true', '{[_x] call NTA_fnc_vehicles_delete} forEach thislist']]  call NTA_fnc_vehicles_addwaypoint;
	_wp setWaypointCompletionRadius 200;
	[_inf, (_vehicles select _i), _pad, _apUserInsert, false] call NTA_fnc_airpatrol_combatInsertion;
};

if (_apUserInsert) then {
	_apUser setVariable [format ["insert%1", group _apUser], []];
};

_grp

//A3\functions_f\waypoints\fn_wpLand.sqf