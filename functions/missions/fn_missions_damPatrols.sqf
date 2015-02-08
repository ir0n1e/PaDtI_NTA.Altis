if (isserver) then {

    if (!isnil "HCPresent") exitwith {

        [_this, "NTA_fnc_missions_DamPatrols", NTAHC] call BIS_fnc_MP;
        "DamPatrols switching to HC" call NTA_fnc_log;
        breakout "main";
    };

    "DamPatrols switching to Server" call NTA_fnc_log;
};

private ["_grp", "_pos", "_positions", "_newpos", "_units", "_unit", "_wp", "_dampatrol", "_dir"];
_newpos = [9301.53,13738.7,0.855];
_man        = "O_Soldier_F";

if (isclass (configfile >> "CfgPatches" >> "rhs_infantry")) then {
  _man        = "rhs_msv_rifleman";
};

_units      = [];
_dampatrol  = [];
createCenter EAST;
_positions = [[9230.21,13739.2,7.41142], [9133.65,13741.6,8.41668]];
for "_i" from 0 to 1 do {
	_grp = createGroup EAST;
    _unit = _grp createUnit [_man, (_positions select _i), [], 6,"NONE"];
    _unit call NTA_fnc_vehicles_unitLoadout;
    _units pushBack _unit;
    _dampatrol pushBack _grp;
};

_grp = createGroup EAST;

_newpos = [9266.11,13720.8,0.00143051] ;
for "_i" from 0 to 1 do {
	 //_pos = [_newpos, -150, 91.2 ] call BIS_fnc_relPos;
    _unit = _grp createUnit [_man, _newpos, [], 6,"NONE"];

    _unit call NTA_fnc_vehicles_unitLoadout;

    _units pushBack _unit;
};
	for "_i" from 1 to 5 /* step +1 */ do {
    _pos = [_newpos, -25*_i, 90.2 ] call BIS_fnc_relPos;
   _wp = [_grp, '', _pos, "LIMITED","MOVE","SAFE"] call NTA_fnc_vehicles_addwaypoint;
  // _wp setWaypointTimeout [5, 10, 6];
    _wp setWaypointCompletionRadius 15;
};

_wp = [_grp, 1, _newpos, "LIMITED", "CYCLE","SAFE"] call NTA_fnc_vehicles_addwaypoint;

_wp setWaypointTimeout [5, 10, 6];
_wp setWaypointCompletionRadius 15;
_dampatrol pushBack _grp;

_obj = "O_HMG_01_high_F" createVehicle [0,0,0];
_obj setPosATL [9308.61,13700.6,5.77834];
_obj setdir (getdir _obj) + 150;
_units pushBack _obj;

_grp = createGroup EAST;
_unit = _grp createUnit [_man, [0,0,0], [], 6, "NONE"];
_unit moveInGunner _obj;
_grp setFormDir 280;
_units pushBack _unit;

_obj = "O_HMG_01_high_F" createVehicle [0,0,0];
_obj setPosASL [9104.36,13741.4,43.4];
_obj setdir (getdir _obj) + 150;
_units pushBack _obj;

_grp = createGroup EAST;
_unit = _grp createUnit [_man, [0,0,0], [], 6, "NONE"];
_unit moveInGunner _obj;
_grp setFormDir 8;
_units pushBack _unit;



_obj = "O_HMG_01_high_F" createVehicle [0,0,0];
_obj setPosATL [9315.05,13707.8,3.73798];
_obj setdir (getdir _obj) + 150;
_units pushBack _obj;

_grp = createGroup EAST;
_unit = _grp createUnit [_man, [0,0,0], [], 6, "NONE"];
_unit moveInGunner _obj;
_grp setFormDir 39;
_units pushBack _unit;

_grp = createGroup EAST;
for "_i" from 0 to 3 do {
	 //_pos = [_newpos, -150, 91.2 ] call BIS_fnc_relPos;
    _unit = _grp createUnit [_man, [9325.77,13699.5,0.00125504], [], 2,"none"];
  _unit domove [9312.16,13705.4,0.03336];
    _unit call NTA_fnc_vehicles_unitLoadout;
    _units pushBack _unit;
};
_dampatrol pushBack _grp;

_grp = createGroup EAST;
for "_i" from 0 to 3 do {
    _unit = _grp createUnit [_man, [9325.77,13699.5,0.00125504], [], 2, "none"];
    _unit doMove  [9329.12,13692.1,0.402683];
    _unit call NTA_fnc_vehicles_unitLoadout;
    _units pushBack _unit;
};
_dampatrol pushBack _grp;

_grp = createGroup EAST;
_pos = [getpos DamTrigger, 300, 180 ] call BIS_fnc_relPos;
_veh = "O_Quadbike_01_F" createVehicle _pos;
_units pushBack _veh;

_unit = _grp createUnit [_man, [0,0,0], [], 0,"none"];
_unit moveindriver _veh;
_unit call NTA_fnc_vehicles_unitLoadout;
_unit assignasdriver _veh;
_units pushBack _unit;

_pos = [getpos DamTrigger, 310, 180 ] call BIS_fnc_relPos;
_veh = "O_Quadbike_01_F" createVehicle _pos;
_units pushBack _veh;

_unit = _grp createUnit [_man, [0,0,0], [], 0,"none"];
_unit moveindriver _veh;
_unit call NTA_fnc_vehicles_unitLoadout;
_unit assignasdriver _veh;
_units pushBack _unit;
_dir = 0;

for "_i" from 0 to 9 /* step +1 */ do {
    _pos = [getpos DamTrigger, -250, _dir ] call BIS_fnc_relPos;
   _wp = [_grp, '', _pos, "LIMITED","MOVE","combat"] call NTA_fnc_vehicles_addwaypoint;
    _dir = _dir + 36;
  // _wp setWaypointTimeout [5, 10, 6];
};
_pos = [getpos DamTrigger, -250, _dir ] call BIS_fnc_relPos;
_wp = [_grp, '', _pos, "LIMITED", "CYCLE", "Combat"] call NTA_fnc_vehicles_addwaypoint;
_dampatrol pushBack _grp;

_newpos = [getpos DamTrigger, 280, -91 ] call BIS_fnc_relPos;
_grp = createGroup EAST;
for "_i" from 0 to 3 do {
    _unit = _grp createUnit [_man, _newpos, [], 0, "CAN_COLLIDE"];
    _unit call NTA_fnc_vehicles_unitLoadout;
    _units pushBack _unit;
};
_dir = 0;
for "_i" from 0 to 9 /* step +1 */ do {
  _pos = [_newpos, -130, _dir ] call BIS_fnc_relPos;
  _wp = [_grp, '', _pos, "LIMITED","MOVE","Safe"] call NTA_fnc_vehicles_addwaypoint;
  _dir = _dir + 36;
  _wp setWaypointTimeout [5, 10, 6];
};
 _pos = [_newpos, -130, _dir ] call BIS_fnc_relPos;
_wp = [_grp, '', _pos, "LIMITED", "CYCLE", "Safe"] call NTA_fnc_vehicles_addwaypoint;

server setVariable ["DamPatrols", _dampatrol, true];

{
  [_x, "INFskill"] call NTA_fnc_eos_setSkill;
} foreach _dampatrol;

server setvariable ["DamUnits", _units, true];
