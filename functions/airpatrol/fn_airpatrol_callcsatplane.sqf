/*
    Author: Ir0n1E

    Description:
    Calls two OPF CAS Jets

    Parameter(s):
    #0 OBJECT - Marker Name
    #1 ARRAY - Bombs Count
    Returns:
    ARRAY - [Plane0, Plane1]
*/

#define PLANE_TYPE      "O_Plane_CAS_02_F"
#define SPAWN_DISTANCE  150
#define SPAWN_HEIGHT    1200

private ["_csatplane_wp", "_wp", "_target", "_bombs", "_spawnPos"];
//AIRFIELD_BombMarkers select (floor(random(count AIRFIELD_BombMarkers)))
_target     = [_this, 0, objnull] call bis_fnc_param;
_bombs      = [_this,1,[3]] call bis_fnc_param;

if (str _target == "<NULL-object>") exitwith {
     format ["ERROR: Airpatrol Notarget %1", _this] call NTA_fnc_log;
};

_vehname            = getText (configFile >> "CfgVehicles" >> PLANE_TYPE >> "displayName");
_csatplane_wp       = [[24354,1346,100],[20993.764,7201.9443,0],[13508,27886,0],[21981,28740,0]];
_startPos           = _csatplane_wp select 0;
_spawnPos           = [_startPos select 0, _startPos select 1, SPAWN_HEIGHT];

_csatplane0         = [PLANE_TYPE, ([_spawnPos, SPAWN_DISTANCE, (180 - 90)] call BIS_fnc_relPos), 180, EAST] call NTA_fnc_vehicles_create;

waituntil {alive _csatplane0};

_spawnPos           = getposASL _csatplane0;
_csatplane1         = [PLANE_TYPE, ([_spawnPos, SPAWN_DISTANCE, (180 - 90)] call BIS_fnc_relPos), 180, EAST] call NTA_fnc_vehicles_create;

[_csatplane1] joinsilent (group _csatplane0);

_wp = [group _csatplane0, '', _startPos, "FULL", "MOVE", "CARELESS", "BLUE", ["true", "{_x flyInHeight 50} forEach thislist;"]] call NTA_fnc_vehicles_addwaypoint;
_wp setWaypointCompletionRadius 200;
_wp = [group _csatplane0, '', (getMarkerPos _target), "FULL", "MOVE", "CARELESS", "BLUE"] call NTA_fnc_vehicles_addwaypoint;
_wp setWaypointCompletionRadius 200;
_wp = [group _csatplane0, '', (_csatplane_wp select 2), "FULL", "MOVE", "CARELESS", "BLUE", ["true","{[_x] call NTA_fnc_vehicles_delete} forEach thislist;"]] call NTA_fnc_vehicles_addwaypoint;
_wp setWaypointCompletionRadius 200;

format["AIRPATROL: %1 Target: %2 - CREATE",_vehname, _target] call NTA_fnc_log;

{
    _x setvariable ["Airpatrol_Target", (getMarkerPos _target)];
    _x setvariable ["airpatrol_mission", "FlyingIn"];
    _x setvariable ["NTA_bombsAway", false];
    _x flyinheight 50;

    [_x,_target, _bombs, _vehname] spawn {
        _p = _this select 0;
        _t = _this select 1;
        _c = _this select 2;
        _n = _this select 3;

        waituntil {!alive _p || {_p distance (getmarkerpos _t) < 350}};

        if (alive _p) then {
            [_t, _c] spawn NTA_fnc_airpatrol_bombs;
            _p setvariable ["NTA_bombsAway", true];
            _p setvariable ["airpatrol_mission", "MovingHome"];
        };

        format["AIRPATROL: %1 Target: %2 - Done", _n, _t] call NTA_fnc_log;
    };

    if (NTA_Airpatrol_Debug) then {
         [_x] call NTA_fnc_Airpatrol_Debug;
    };

} foreach [_csatplane0, _csatplane1];

[_csatplane0, _csatplane1]