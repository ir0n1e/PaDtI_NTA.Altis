//O_HMG_01_high_F MapBoard_altis_F  Land_WoodenTable_large_F "O_officer_F" "O_Soldier_F"
private ["_obj", "_objects", "_pos", "_newPos", "_objTargets", "_dir", "_objTargets", "_unit", "_grp", "_anim", "_task", "_intel", "_unitTargets"];

fn_table_compose = {
    private ["_obj", "_objects", "_ordi", "_file", "_pan", "_can", "_objArray", "_intel"];
    _obj        = _this select 0;
    _objArray   = _this select 1;

    _ordi = ["Land_Laptop_unfolded_F","Land_Laptop_F"] call BIS_fnc_selectRandom;
    _file = ["Land_File1_F","Land_FilePhotos_F","Land_File2_F"] call BIS_fnc_selectRandom;
    _pen = ["Land_PenRed_F","Land_PenBlack_F"] call BIS_fnc_selectRandom;
    _can = ["Land_Can_V2_F","Land_Can_V3_F","Land_Can_Rusty_F","Land_Can_V1_F"] call BIS_fnc_selectRandom;

    _objects = [[_obj,"TOP"],_can,1,[0.2,-0.4,-0.4],0] call BIS_fnc_spawnObjects;
    _objArray = _objArray + _objects;

    _objArray = [[_obj,"TOP"],"Land_PortableLongRangeRadio_F",1,[0.4,0.5,-0.1],0] call BIS_fnc_spawnObjects;
    _objArray = _objArray + _objects;

    _objects = [[_obj,"TOP"],_file,1,[-0.4,-0.6,0],90] call BIS_fnc_spawnObjects;
    _objArray = _objArray + _objects;
    _intel = _objects select 0;


    _objects = [[_obj,"TOP"],_pen,1,[-0.3,-0.5,0],random 90] call BIS_fnc_spawnObjects;
    _objArray = _objArray + _objects;
    _objects = [[_obj,"TOP"],_ordi,1,[0,0,0],(getdir _obj) +270] call BIS_fnc_spawnObjects;
    _objArray = _objArray + _objects;

    _objects = [[_obj,"TOP"],"Land_MobilePhone_smart_F",1,[-0.4,(random 0.2)+0.3,-0.4],(random 20)-20] call BIS_fnc_spawnObjects;
    _objArray = _objArray + _objects;

    [_objArray, _intel]
};

_pos            = _this select 0;
_objTargets     = [];
_unitTargets    = [];
_objects        = [];
_newpos         = [_pos, [300, 600], 15, 0] call PO3_fnc_getSafePos;
_task           = format ["Command_%1", floor (time + random(99))];


_grp = createGroup EAST;

for "_i" from 0 to 1 do {
    _pos = [_newpos, 25, 0 ] call BIS_fnc_relPos;
    _unit = _grp createUnit ["O_Soldier_F", _pos, [], 6,""];
    _objects pushBack _unit;
};

_dir = 0;

for "_i" from 0 to 9 do {
    _pos = [_newpos, 25, _dir ] call BIS_fnc_relPos;
    [_grp, '', _pos, "LIMITED","MOVE", "SAFE"] call NTA_fnc_vehicles_addwaypoint;
    _dir = _dir + 36;
};

 _pos = [_newpos, 25, _dir ] call BIS_fnc_relPos;
[_grp, '', _pos, "LIMITED", "CYCLE"] call NTA_fnc_vehicles_addwaypoint;


//container
_obj = "Land_Cargo_House_V3_F" createVehicle [0,0,0];
_obj setpos _newpos;
_objTargets pushBack _obj;

_grp = createGroup EAST;
for "_i" from 0 to 1 do {
    _grp = createGroup EAST;
    _unit = _grp createUnit ["O_Soldier_F", getposatl _obj, [], 6,""];
    _unit setpos (getposatl _obj);
    _objects pushBack _unit;
};

// net
_obj = "CamoNet_opfor_big_F" createvehicle [0,0,0];
_obj setpos [_newpos select 0, _newpos select 1, (_newpos select 2) - 0.5];
_objects pushBack _obj;


//tower
_pos = [_newpos, 10, 180 ] call BIS_fnc_relPos;
_obj = "Land_Cargo_Patrol_V3_F" createVehicle [0,0,0];
_obj setpos _pos;
_objTargets pushBack _obj;
_obj setdir ((getdir _obj) + 90);

//hmg on tower
_pos = [getposATL _obj, 2.1, 230 ] call BIS_fnc_relPos;
_pos = [_pos select 0, _pos select 1, 5];
_obj = "O_HMG_01_high_F" createVehicle [0,0,0];
_obj setPosATL _pos;
//_obj setdir (getdir _obj) + 150;
_objects pushBack _obj;

_grp = createGroup EAST;
_unit = _grp createUnit ["O_Soldier_F", [0,0,0], [], 6,""];
_unit moveInGunner _obj;
_grp setFormDir (getdir _unit) + 180;
_objects pushBack _unit;


_dir = 180;
_pos = [_newpos, 8, _dir ] call BIS_fnc_relPos;

// sandbags
for "_i" from 0 to 17 do {
	_dir = (_dir +18);
    _obj = "Land_BagFence_Long_F" createVehicle [0,0,0];
    _pos = [_newpos, 9, _dir  ] call BIS_fnc_relPos;
    _obj setpos _pos;
    _obj setdir (_dir + 0.8);

    _objects pushBack _obj;
};

_pos = [_newpos, 7, 130 ] call BIS_fnc_relPos;
_obj = "O_HMG_01_high_F" createVehicle [0,0,0];
_obj setpos _pos;
//_obj setdir (getdir _obj) + 150;
_objects pushBack _obj;
_grp = createGroup EAST;
_unit = _grp createUnit ["O_Soldier_F", [0,0,0], [], 6,""];
_unit moveInGunner _obj;
_grp setFormDir 270;
_objects pushBack _unit;


//map
_obj = "MapBoard_altis_F" createVehicle [0,0,0];
_pos = [_newpos, 5, 245 ] call BIS_fnc_relPos;
_obj setpos _pos;
_objects pushBack _obj;
_obj setdir ((getdir _obj)-45);


//table
_obj = "Land_WoodenTable_large_F" createVehicle [0,0,0];
_pos = [_newpos, 5, 210 ] call BIS_fnc_relPos;
_obj setpos _pos;
_objects pushBack _obj;
_obj setdir ((getdir _obj)+45);

_pos = [getposATL _obj, 1.5, 300 ] call BIS_fnc_relPos;

_unit = _grp createUnit ["O_officer_F", [0,0,0], [], 6,""];
_unit setposATL _pos;
_unit setdir ((getdir _unit) + 90);

//LEAN_ON_TABLE BRIEFING_POINT_TABLE
[_unit,"BRIEFING", "FULL"] call BIS_fnc_ambientAnim;
_objects pushBack _unit;
_unitTargets pushback _unit;

_dir = 110;
_anim = ["LISTEN_BRIEFING", "SIT_LOW","BRIEFING"];
for "_i" from 0 to 2 do {
    _pos = [getposATL _obj, 1.5 + (random 1.5), _dir ] call BIS_fnc_relPos;

    _unit = _grp createUnit ["O_Soldier_F", [0,0,0], [], 6,""];
    _unit setposATL _pos;
    _unit setdir ((getdir _unit) - 30);

    //LEAN_ON_TABLE BRIEFING_POINT_TABLE
    [_unit, _anim call NTA_fnc_getRandArrayPos] call BIS_fnc_ambientAnim;
    _dir = _dir + 50;
    _objects pushBack _unit;
};

_obj = ([_obj, _objects] call fn_table_compose);
_objects = _objects + (_obj select 0);
_intel = _obj select 1;
_objects = _objects + _objTargets;

[_task, _newPos, "Command Post", [_objTargets, false], _unitTargets, _intel] call NTA_fnc_missions_addTask;

_objects

/*
sleep 360;
{
    deleteVehicle _x;
} foreach _objects;
*/
/*
fnc_bridgeA3 = {
    private ["_start","_obj","_objPos","_objDir"];
    _start = createVehicle [
        _this select 2,
        _this select 0,
        [],
        0,
        "CAN_COLLIDE"
    ];
    _start setVectorUp [0,0,1];
    _start setDir (_this select 1);
    _start setPosATL (_this select 0);
    for "_i" from 1 to (_this select 3) do {
        _obj = createVehicle [
            _this select 2,
            _this select 0,
            [],
            0,
            "CAN_COLLIDE"
        ];
        _obj attachTo [_start, [
            _i*(_this select 4),
            _i*(_this select 5),
            _i*(_this select 6)
        ]];
        _objPos = getPosATL _obj;
        _objDir = getDir _obj;
        detach _obj;
        _obj setPosATL _objPos;
        _obj setDir _objDir;
    };
};

[startingPosition, direction, objectClass, repeats, offsetX, offsetY, offsetZ]
for "_c" from 0 to 15 do
    {
        _pos = [_flatPos, _distance, _dir] call BIS_fnc_relPos;
        _barrier = "Land_HBarrier_3_F" createVehicle _pos;
        waitUntil {alive _barrier};
        _barrier setDir _dir;
        _dir = _dir + 22.5;

        _unitsArray = _unitsArray + [_barrier];
    };


*/