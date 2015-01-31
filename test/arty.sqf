if (NTA_artyActive) exitWith {};
_this spawn {
    _mainPos 	= _this select 0;
    _mainDir 	= [90, -90] call NTA_fnc_getRandArrayPos;
    _objects 	= [];
    _arty		= [];
    _units 		= [];

    _newpos     = [_mainpos, 0, _mainDir + 90 ] call BIS_fnc_relPos;
    _array      = [_newpos, _mainDir + 90, true] call NTA_fnc_vehicles_createArty;
    _objects    = _objects + (_array select 0);
    _units      = _units + (_array select 1);
    _arty pushBack (_array select 2);

    _pos        = [_newpos, 50, _mainDir] call BIS_fnc_relPos;
    _array      = [_pos, _mainDir + 90, true] call NTA_fnc_vehicles_createArty;
    _objects    = _objects + (_array select 0);
    _units      = _units + (_array select 1);
    _arty pushBack (_array select 2);

    _newpos     = [_mainPos, 60, _mainDir - 120] call BIS_fnc_relPos;
    _array      = [_newpos, _mainDir + 180, true] call NTA_fnc_vehicles_createArty;
    _objects    = _objects + (_array select 0);
    _units      = _units + (_array select 1);
    _arty pushBack (_array select 2);

    _pos        = [_newpos, 50, _mainDir - 90] call BIS_fnc_relPos;
    _array      = [_pos, _mainDir + 180, true] call NTA_fnc_vehicles_createArty;
    _objects    = _objects + (_array select 0);
    _units      = _units + (_array select 1);
    _arty pushBack (_array select 2);

    _newpos = [_mainpos, -38, _mainDir-7] call BIS_fnc_relPos;

    for "_i" from 1 to 30 do {

        _script = _newPos spawn {
    	   obj = "Land_BagFence_Long_F" createVehicle [0,0,0];

            obj setposATL _this;
            obj setdir (getdir obj);
        };
        waituntil {scriptDone _script};

        _obj = obj;
        obj = nil;

        _newPos = [getposATL _obj, 3, 360 + _mainDir] call BIS_fnc_relPos;
        _objects pushBack _obj;
    };

    _newpos = [_mainpos, -38, _mainDir-10] call BIS_fnc_relPos;
    for "_i" from 1 to 30 do {

        _script = _newPos spawn {
            obj = "Land_BagFence_Long_F" createVehicle [0,0,0];

            obj setposATL _this;
            obj setdir (getdir obj);
            _pos2 = getposASL obj;
            _dir2 = getdir obj;
            obj2 = "Land_BagFence_Long_F" createVehicle [0,0,0];
            obj2 setposASL [_pos2 select 0, _pos2 select 1, (_pos2 select 2) + 0.5];
            obj2 setdir _dir2;
        };
        waituntil {scriptDone _script};
        _newPos = [getposATL obj, 3, 360 + _mainDir] call BIS_fnc_relPos;


        _objects pushBack obj;
        _objects pushBack obj2;
        obj = nil;
        obj2 = nil;
    };

    _newpos = [_mainPos, -35, _mainDir  ] call BIS_fnc_relPos;
    for "_i" from 1 to 35 do {

        _script = _newPos spawn {
            obj = "Land_BagFence_Long_F" createVehicle [0,0,0];

            obj setposATL _this;
        };
        waituntil {scriptDone _script};

        _obj = obj;
        obj = nil;
        _obj setdir _mainDir;

        _newPos = [getposATL _obj, 3, 360 -_mainDir + 90] call BIS_fnc_relPos;
        _objects pushBack _obj;
    };

    _newpos = [_mainPos, -38, _mainDir  ] call BIS_fnc_relPos;
    for "_i" from 1 to 35 do {

        _script = [_newPos, _mainDir] spawn {
            _newPos     = _this select 0;
            _mainDir    = _this select 1;

            obj = "Land_BagFence_Long_F" createVehicle [0,0,0];
            obj setposATL _newPos;
            obj setdir _mainDir;

            _pos2 = getposASL obj;
            _dir2 = getdir obj;
            obj2 = "Land_BagFence_Long_F" createVehicle [0,0,0];
            obj2 setposASL [_pos2 select 0, _pos2 select 1, (_pos2 select 2) + 0.5];
            obj2 setdir _dir2;
        };
        waituntil {scriptDone _script};

        _newPos = [getposATL obj, 3, 360 -_mainDir + 90] call BIS_fnc_relPos;
        _objects pushBack obj;
        _objects pushBack obj2;
        obj = nil;
        obj2 = nil;
    };

    _array = [([_mainpos, 30, _mainDir + 180] call BIS_fnc_relPos), "O_HMG_01_high_F", EAST, _maindir + 125, true, true] call NTA_fnc_vehicles_createStatic;

    _objects = _objects + (_array select 0);
    _units = _units + (_array select 1);

    _array = [([_mainpos, 60, _mainDir -60] call BIS_fnc_relPos), "O_HMG_01_high_F", EAST, _maindir -60, true, true] call NTA_fnc_vehicles_createStatic;

    _objects = _objects + (_array select 0);
    _units = _units + (_array select 1);

    _obj =  "O_supplyCrate_F" createvehicle ([_mainpos, 50, _mainDir -60] call BIS_fnc_relPos);
    _obj addMagazinecargoGlobal ["DemoCharge_Remote_Mag", 8];
    _objects pushBack _obj;

    _newPos = [_mainPos , 80, _mainDir -60 ] call BIS_fnc_relPos;
    _grp = [ _newPos, EAST, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam")] call BIS_fnc_spawnGroup;

    {
    	_units pushback _x;
    } foreach (units _grp);

    _dir = 0;

    for "_i" from 0 to 9 do {
        _pos = [_mainPos, 100, _dir ] call BIS_fnc_relPos;
        [_grp, '', _pos, "LIMITED","MOVE", "SAFE"] call NTA_fnc_vehicles_addwaypoint;
        _dir = _dir + 36;
    };

     _pos = [_mainPos, 100, _dir ] call BIS_fnc_relPos;
    [_grp, '', _pos, "LIMITED", "CYCLE"] call NTA_fnc_vehicles_addwaypoint;



    _task = format ["Arty_%1", time + (random 99)];
    NTA_artyActive = true;
    publicVariable "NTA_artyActive";

    [ _task, "Destroy Artillary" , "Destroy", WEST, [], "assigned", _mainPos] call SHK_Taskmaster_add;


    waituntil {{alive _x} count _arty <= 0};
    [_task, "succeeded"] call SHK_Taskmaster_upd;

    waitUntil {sleep 10; !({_x distance _this > 500} count playableUnits == 0) };

    {
    	deleteGroup (group _x);
    	deletevehicle _x;
    } foreach _objects + _units;
    NTA_artyActive = false;
    publicVariable "NTA_artyActive";
};