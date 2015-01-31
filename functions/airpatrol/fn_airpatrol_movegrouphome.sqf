private ["_grp", "_veh"];

if (count _this > 1) then {
	_grp 	=  NTA_airpatrolCache getvariable["NTA_Airpatrol_Group_West", grpnull];
} else {
	_grp = _this select 0;
};

if (str _grp == "<NULL-group>") exitwith {};

_veh 	= vehicle (leader _grp);

if (!alive _veh) exitwith {};

_grp setCurrentWaypoint [_grp, 3];
_veh setvariable ["airpatrol_mission", "MovingHome", true];

{
	_x setCombatMode "BLUE";
	_x domove (_veh getvariable ["Airpatrol_EndPos", [0,0,0]]);
	(vehicle _x) setvariable ["airpatrol_mission", "MovingHome", true];
	(vehicle _x) setvariable ["Airpatrol_Target", _veh getvariable ["Airpatrol_EndPos", [0,0,0]], true];
} foreach units _grp;
