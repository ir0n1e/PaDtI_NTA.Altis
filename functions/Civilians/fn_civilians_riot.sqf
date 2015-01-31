scriptName "fn_civilians_riot";
/*
    Author: Ir0n1E

    Description:
    Sends Civilian on Mission

    Parameter(s):
    #0 OBJECT - unit
    #1 ARRAY - Position Target
    #2 STRING - Mission name

    Returns:
    NONE
*/
private ["_unit", "_target", "_mission"];

_unit = _this select 0;
_target = _this select 1;

if (!alive _unit) exitwith {};

_unit setvariable ["OnMission", true];
_unit setskill ["courage",1];
_mission = _unit getvariable ["Mission", "none"];

switch (_mission) do {
    case "fleeing": {
         [_unit, _target] spawn {
            _u = _this select 0;
            _t = _this select 1;
            _mkr = _u getvariable "marker";
            _roadPosArray = (server getvariable format["population%1", _mkr]) select 3;

            _time = time;
            _u setskill ["courage",0.5];
            _u setvariable ["OnMission", false];

            waituntil{(!alive _u) || {(_u distance _t) > 80} || {time > (_time+30)}};

            if (!alive _u) exitwith {};
            _u allowFleeing 0;
            _u setvariable ["mission", "patrol"];
            _u setskill ["courage",0.8];
            //[_u, _roadPosArray, _mkr] call NTA_fnc_civilians_patrol;
        };
    };
    case "setcaronfire": {
        [_unit, _target] spawn {
            _u = _this select 0;
            _t = _this select 1;
            _mkr = _u getvariable "marker";
            _roadPosArray = (server getvariable format["population%1", _mkr]) select 3;
            _u allowFleeing 0;
            (group _u) setSpeedMode "Full";
            _u domove ([_t, 8, 90] call BIS_fnc_relPos);
            _u setvariable ["OnMission",true];
            _time = time;
            _t call NTA_fnc_log;
            waituntil{(!alive _u) || {(_u distance _t) < 12} || {time > (_time+180)}};

            if (!alive _u) exitwith {};
            if (!(_t getvariable ["burning", false])) then {
                _t call NTA_fnc_vehicles_createFire;
                _u setvariable ["Mission", "settingonfire"];
            };
            _u setvariable ["OnMission", false];
            _u setvariable ["mission", "patrol"];
            [_u, _roadPosArray, _mkr] call NTA_fnc_civilians_patrol;
        };
    };

    case "riotmovehome": {
        _unit spawn {
            _u              = _this;
            _mkr            = _this getvariable "marker";
            _information    = server getvariable format["population%1", _mkr];
            _roadPosArray   = (_information select 3);
            _t              = _u getvariable "home";

            if (isnil "_t") exitwith {
                _u setvariable ["OnMission", false];
                [_u, _roadPosArray, _mkr] call NTA_fnc_civilians_patrol;
            };

            (group _u) setSpeedMode "Full";
            _u allowFleeing 0;
            _u domove _t;
            _time = time;

            waituntil{(!alive _u) || {(_u distance _t) < 3} || {time > (_time+240)}};

            if (!alive _u) exitwith {};
            if ((_u distance _t) < 5) then {
                group _u setCombatMode "RED";
                group _u setBehaviour "CARELESS";
                _u addweapon "SMG_02_F";
                _u addmagazine "30Rnd_9x21_Mag";
                _u addmagazine "30Rnd_9x21_Mag";

                _u setvariable ["agent", true];
                _u setvariable ["Mission", "athome"];
                sleep 10;
            };
            _u setvariable ["OnMission", false];
            _u setvariable ["Mission", "patrol"];

            [_u, _roadPosArray, _mkr] call NTA_fnc_civilians_patrol;
        };
    };

    case "riotied": {
        [_unit, _target] spawn {
            _u = _this select 0;
            _mkr = _u getvariable "marker";
            _roadPosArray = (server getvariable format["population%1", _mkr]) select 3;
            _objects = (getposASL _u) nearObjects ["Car",250];

            _noIEDobj = [];
            {
                if (!(_x getvariable ["IED", false]) && {!(_x getvariable ["burning", false])} ) then {
                    _noIEDobj pushback _x;
                };
            } foreach _objects;

            _t = [(getposASL _u), 200, _noIEDobj] call NTA_fnc_core_findnearestobject;
            if (str _t != "<NULL-object>") exitwith {
                _u setvariable ["OnMission", false];
                [_u, _roadPosArray, _mkr] call NTA_fnc_civilians_patrol;
            };
            (group _u) setSpeedMode "Full";
            _u allowFleeing 0;
            _u domove (getposASL _t);

            waituntil{(!alive _u) || {(_u distance _t) < 10}};

            _t setvariable ["IED", true];
            _t addEventHandler ["Engine", {
                _self = _this select 0;
                _start = _this select 1;
                if (_start) then {
                    sleep 10;
                    _self setdammage 1;
                };
            }];
            _u setvariable ["OnMission", false];
            _u setvariable ["Mission", "patrol"];
            [_u, _roadPosArray, _mkr] call NTA_fnc_civilians_patrol;
        };
    };
};