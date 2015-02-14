private ["_grp", "_unit","_hostilefactor", "_distance", "_firer", "_notOnfire", "_missions", "_obj", "_objects"];

_unit = _this select 0;
_firer = _this select 1;
_distance = _this select 2;

_mkr = _unit getvariable "marker";
_hostilefactor = server getvariable format["trig%1_hostilefactor", _mkr];
_garbageArray = (server getvariable format["trig%1_units", _mkr]) select 3;
_grp = group _unit;

if ((side _unit) == CIVILIAN && {alive _unit}) then {

    _hostilefactor = _hostilefactor + 0.08;
    server setvariable [format["trig%1_hostilefactor", _mkr], _hostilefactor, true];

    _grp setBehaviour "CARELESS";
    _grp setSpeedMode "Normal";
};

if ((side _unit) == CIVILIAN && {_distance <= 30}) then {
    _unit setvariable ["ShotsCount", (_unit getvariable ["ShotsCount", 0]) + 1];
    if ((_unit getvariable ["ShotsCount", 0]) <= 3) exitwith {};
    _unit setvariable ["ShotsCount", 0];

    if (debugCOS) then {
        hintsilent format ["Unit: %1 Factor: %2 PersonalFac: %3", _unit, _hostilefactor, _unit getvariable ["personalhostilefactor",0]];
    };

    _unit setvariable ["personalhostilefactor",
        (_unit getvariable "personalhostilefactor") + (_hostilefactor * 0.2)];

    if(_unit getvariable "agent") exitwith {
        [_unit, _mkr] call NTA_fnc_civilians_agent;
    };

    if (_unit getvariable "OnMission") exitwith {};

    if ((_unit getvariable ["personalhostilefactor",0]) >= 10) exitwith {
        _missions = ["riotmovehome", "riotied"];
        _unit setvariable ["Mission", (_missions call NTA_fnc_getRandArraypos)];
        [_unit, []] call NTA_fnc_civilians_riot;
    };

    if ((_unit getvariable ["personalhostilefactor",0]) >= 6) exitwith {
        _objects = (getposASL _unit) nearObjects ["Car",200];
        _notOnfire = [];

        {
            if (!(_x getvariable ["burning", false]) && {str (driver _x) == "<NULL-object>"}) then {
                _notOnfire pushback _x;
            };
        } foreach _garbageArray + _objects;

        if ((count _notOnfire) > 0) then {
            _obj = [(getposASL _unit), 200, _notOnfire] call NTA_fnc_core_findnearestobject;

            if (str _obj != "<NULL-object>") then {
                _unit setvariable ["Mission", "setcaronfire"];
                [_unit, _obj] call NTA_fnc_civilians_riot;
            };
        };
    };

    _unit setvariable ["Mission", "fleeing"];
    _grp allowFleeing 1;
    [_unit, (getposASL _firer)] call NTA_fnc_civilians_riot;
};