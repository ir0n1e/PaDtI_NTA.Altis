//StorageBladder_01_fuel_sand_F Land_HBarrierBig_F
private ["_obj", "_objects", "_pos", "_newPos", "_objTargets", "_unit", "_task", "_grp", "_givenPos", "_dir"];

_pos        = _this select 0;
_givenPos   = false;
_dam        = false;

if (count _this > 1) then {
    _givenPos = _this select 1;
};
if (count _this > 2) then {
    _dam = _this select 2;
};

_task           = format ["Fuel_%1", floor (time + random(99))];
_objTargets     = [];
_objects        = [];

if (_givenPos) then {
    _newpos = _pos;
} else {
    _newpos = [_pos, [300, 600], 15, 0] call PO3_fnc_getSafePos;
};
_grp = createGroup EAST;
_grp setgroupID [format ["FuelPostP_%1", _task]];

for "_i" from 0 to 1 do {
    _pos = [_newpos, 0, 0 ] call BIS_fnc_relPos;
    _unit = _grp createUnit ["O_Soldier_F", _pos, [], 0,""];
    _unit call NTA_fnc_vehicles_unitLoadout;
    _objects pushBack _unit;
};

_dir = 0;
for "_i" from 0 to 1 do {
    _pos = [_newpos, 25, _dir ] call BIS_fnc_relPos;
    [_grp, '', _pos, "LIMITED","MOVE","SAVE"] call NTA_fnc_vehicles_addwaypoint;
    _dir = _dir + 180;
};
 _pos = [_newpos, 25, 0 ] call BIS_fnc_relPos;
[_grp, '', _pos, "LIMITED", "CYCLE"] call NTA_fnc_vehicles_addwaypoint;


//tower
_pos = [_newpos, 18, 150] call BIS_fnc_relPos;
_obj = "Land_Cargo_Patrol_V3_F" createVehicle [0,0,0];
_obj setpos _pos;
_objects pushBack _obj;
//_obj setdir ((getdir _obj) + 90);

//hmg on tower
_pos = [getposATL _obj, 2.1, 230 ] call BIS_fnc_relPos;
_pos = [_pos select 0, _pos select 1, 5];
_obj = "O_HMG_01_high_F" createVehicle [0,0,0];
_obj setPosATL _pos;
_obj setdir (getdir _obj) + 150;
_objects pushBack _obj;

_grp = createGroup EAST;
_unit = _grp createUnit ["O_Soldier_F", [0,0,0], [], 6,""];
_unit moveInGunner _obj;
_grp setFormDir 120;
_objects pushBack _unit;




_pos = [_newpos, 10, 270 ] call BIS_fnc_relPos;

//fuel + net
for "_i" from 0 to 2 do {
    _obj = "StorageBladder_01_fuel_sand_F" createVehicle [0,0,0];

    _obj setpos _pos;
    _objTargets pushBack _obj;
    _obj = "CamoNet_opfor_big_F" createvehicle [0,0,0];
    _obj setdir (getdir _obj) -80;
    _obj setpos _pos;
    _objects pushBack _obj;
    _pos = [getpos _obj, 15, 0  ] call BIS_fnc_relPos;
};
//_objects = _objects + _objTargets;


_pos = [_newpos, 10, 90 ] call BIS_fnc_relPos;

for "_i" from 0 to 2 do {

    _obj = "StorageBladder_01_fuel_sand_F" createVehicle [0,0,0];

    _obj setpos _pos;
    _objTargets pushBack _obj;
    _obj = "CamoNet_opfor_big_F" createvehicle [0,0,0];
    _obj setdir (getdir _obj) +80;
    _obj setpos _pos;
    _objects pushBack _obj;
    _pos = [getpos _obj, 15, 0  ] call BIS_fnc_relPos;
};

_objects = _objects + _objTargets;

//sandbags
_pos = [_newpos, 26, 130 ] call BIS_fnc_relPos;
for "_i" from 0 to 6 do {
	_obj = "Land_HBarrierBig_F" createvehicle [0,0,0];
     _obj setpos _pos;
     _obj setdir (getdir _obj) +90;
    _objects pushBack _obj;
    _pos = [getpos _obj, 8.3, 0  ] call BIS_fnc_relPos;
};

_pos = [_newpos, 26, 230 ] call BIS_fnc_relPos;
for "_i" from 0 to 6 do {
	_obj = "Land_HBarrierBig_F" createvehicle [0,0,0];
     _obj setpos _pos;
     _obj setdir (getdir _obj) +90;
    _objects pushBack _obj;
    _pos = [getpos _obj, 8.3, 0  ] call BIS_fnc_relPos;
};

_pos = [_newpos, -26, 320  ] call BIS_fnc_relPos;
_obj = "Land_HBarrierBig_F" createvehicle [0,0,0];
_obj setpos _pos;
_objects pushBack _obj;

_pos = [getpos _obj, 8.3, 270  ] call BIS_fnc_relPos;
_obj = "Land_HBarrierBig_F" createvehicle [0,0,0];
_obj setpos _pos;
_objects pushBack _obj;
_obj = "Land_LampHarbour_F" createVehicle [0,0,0];
 _obj setPos _pos;
 _objects pushBack _obj;


_pos = [getpos _obj, 20, 270  ] call BIS_fnc_relPos;
_obj = "Land_HBarrierBig_F" createvehicle [0,0,0];
_obj setpos _pos;
_objects pushBack _obj;



_pos = [getpos _obj, 4, 270  ] call BIS_fnc_relPos;
_obj = "Land_HBarrierBig_F" createvehicle [0,0,0];
_obj setpos _pos;
_objects pushBack _obj;
 _obj = "Land_LampHarbour_F" createVehicle [0,0,0];
 _obj setPos _pos;
 _objects pushBack _obj;



_pos = [_newpos, 41, 335 ] call BIS_fnc_relPos;
for "_i" from 0 to 4 do {
	_obj = "Land_HBarrierBig_F" createvehicle [0,0,0];
     _obj setpos _pos;
    _objects pushBack _obj;
    _pos = [getpos _obj, 8.3, 90  ] call BIS_fnc_relPos;
};


//house
_pos = [_newpos, 18, 220 ] call BIS_fnc_relPos;
_obj = "Land_Cargo_House_V3_F" createVehicle [0,0,0];
_obj setpos _pos;
_obj setdir (getdir _obj) -90;
_objects pushBack _obj;


for "_i" from 0 to 1 do {
    _grp = createGroup EAST;
    _unit = _grp createUnit ["O_Soldier_F", getposatl _obj, [], 6,"CORPORAL"];
    _unit setpos (getposatl _obj);
    _objects pushBack _unit;

};

[_task, _newPos, "Fuel Post", [_objTargets, _dam]] call NTA_fnc_missions_addTask;
server setvariable [_task, _objects, true];

_objects