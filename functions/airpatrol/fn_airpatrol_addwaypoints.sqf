scriptName "fn_airpatrol_addwaypoints";
/*
	Author: Ir0n1E

	Description:
	Adds Waypoints - set WP3 to SAD

	Parameter(s):
	#0 OBJECT - GRP
	#1 ARRAY - STARTPOS
	#1 ARRAY - ENDPOS
	#1 ARRAY - TARGETPOS

	Returns:
	NONE
*/
#define SADTIME 	10*60
#define RANDOMTIME	6*60

private ["_grp", "_targetPos", "_endPos", "_targetPos"];

_grp 		= _this select 0;
_startPos 	= _this select 1;
_endPos 	= _this select 2;
_targetPos 	= _this select 3;

NTA_Airpatrol_switchwp = {
	private ["_grp", "_wp", "_time", "_side"];
	_unit 	= _this select 0;
	_grp	= group _unit;
	_time 	= time;
	_random = 0;
	_side 	= side (leader _grp);
	//if (isnil "_grp") exitwith {};

	[_grp, 2] setWaypointType "SAD";



	if (_side == WEST && {NTA_airpatrolCache getvariable["NTA_Airpatrol_Serverside_West", false]} && {[getWPPos [_grp, 2], 1000, 3, EAST] call NTA_fnc_core_findnearunits} && {((vehicle leader _grp) getvariable "airpatrol_mission") != "MovingHome"}) then {
		"sad west" call nta_fnc_log;
		_random = SADTIME + (random RANDOMTIME);
		{
			(vehicle _x) setvariable ["airpatrol_mission", "Attacking", true]
		} foreach units _grp;
	};

	if (NTA_airpatrolCache getvariable["NTA_Airpatrol_Serverside_East", false] || {NTA_airpatrolCache getvariable["NTA_Airpatrol_CAS_West", false]}) then {
		_random = SADTIME + (random RANDOMTIME);
		{
			(vehicle _x) setvariable ["airpatrol_mission", "Attacking", true]
		} foreach units _grp;
	};

	waituntil {!alive (leader _grp) || {time > (_time + _random)}};
	if (alive (leader _grp)) then {
		[_grp] call NTA_fnc_Airpatrol_moveGroupHome;
	};

};

_wp = [_grp, '', ([_targetPos, 1000, (getdir leader _grp) -180 ] call BIS_fnc_relPos), "NORMAL", "MOVE","CARELESS","GREEN",['true', '{_x flyInHeight 50} foreach thislist; [this] spawn NTA_AIRPATROL_switchwp']] call NTA_fnc_vehicles_addwaypoint;

_wp = [_grp, '', _targetPos, "NORMAL", "MOVE", "COMBAT", "RED", ['true', '{_x setcombatmode "RED"} foreach thislist']] call NTA_fnc_vehicles_addwaypoint;
_wp setWaypointCompletionRadius 500;

_wp = [_grp, '', _endPos, "NORMAL", "MOVE", "CARELESS", "BLUE", ["true", "{[_x] call NTA_fnc_vehicles_delete} foreach thislist"]] call NTA_fnc_vehicles_addwaypoint;
_wp setWaypointCompletionRadius 500;