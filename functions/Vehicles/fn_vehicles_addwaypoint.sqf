scriptName "fn_vehicles_addwaypoint";
/*
	Author: Ir0n1E

	Description:
	Add Waipoint.

	Parameter(s):
	#0 OBJECT - Group
	#1 Number - Wp Number - "" for Autonumber
 	#2 ARRAY  - Position
 	#3 String - Speed "UNCHANGED" "LIMITED" "NORMAL" "FULL"
    #4 String - Type "MOVE" "DESTROY" "GETIN" "SAD" "JOIN" "LEADER" "GETOUT" "CYCLE" "LOAD" "UNLOAD" "TR UNLOAD" "HOLD" "SENTRY" "GUARD" "TALK" "SCRIPTED" "SUPPORT" "GETIN NEAREST" "DISMISS"
 	#5 String - Behaviour "UNCHANGED" "CARELESS" "SAFE""AWARE" "COMBAT" "STEALTH"
 	#6 STRING - Combatmode "NO CHANGE" (No change) "BLUE" (Never fire) "GREEN" (Hold fire - defend only) "WHITE" (Hold fire, engage at will) "YELLOW" (Fire at will) "RED" (Fire at will, engage at will)
	#7 ARRAY - Statemant
 	#8 STRING - Script

	Returns:
	Waipoint
*/

private ["_wp","_grp","_pos","_number","_speed","_type","_statemant","_script"];

_grp 		= _this select 0;
_number 	= [_this, 1, (currentWaypoint _grp) +1] call BIS_fnc_param;
_pos 		= _this select 2;
_speed 		= [_this, 3, "UNCHANGED"] call BIS_fnc_param;
_type 		= [_this, 4, "MOVE"] call BIS_fnc_param;
_behaviour 	= [_this, 5, "UNCHANGED"] call BIS_fnc_param;
_combatmode = [_this, 6, "UNCHANGED"] call BIS_fnc_param;
_statemant 	= [_this, 7, ["true",""]] call BIS_fnc_param;
_script 	= [_this, 8, ""] call BIS_fnc_param;

if (!isnil "_number") then {
	_number = 1;
};

_wp = _grp addWaypoint [_pos, _number];

_wp setWaypointSpeed _speed;
_wp setWaypointtype _type;
_wp setWaypointBehaviour _behaviour;
_wp setWaypointCombatmode _combatmode;
_wp setWaypointStatements _statemant;
_wp setWaypointScript _script;

_wp
