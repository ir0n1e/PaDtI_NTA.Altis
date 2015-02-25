_this spawn {
    waitUntil {missionNamespace getVariable ["NTA_VehiclesInit", false]};
    _first = true;
    sleep 20;

    while {_first || ("NTA_EVENT" call bis_fnc_getParamValue) <= 0} do {
        _time = time;
        {
                // Define variables
            _veh       = call compile _x;
            _variables  = _veh getvariable ["respawnVariables", []];
            _delay      = if (count _variables > 0) then {_variables select 0} else {30};
            _deserted   = if (count _variables > 1) then {_variables select 1} else {120};
            _respawns   = if (count _variables > 2) then {_variables select 2} else {0};
            _explode    = if (count _variables > 3) then {_variables select 3} else {false};
            _dynamic    = if (count _variables > 4) then {_variables select 4} else {false};
            _unitinit   = if (count _variables > 5) then {_variables select 5} else {};
            _haveinit   = if (count _variables > 5) then {true} else {false};
            _tickets    = if (count _variables > 6) then {_variables select 6} else {0};
            _hasname    = true;
            _unitname   = _x;
            _hasname    = true;
            _noend      = false;
            _rounds     = 0;


            if (_delay < 0) then {
                _delay = 0;
            };

            if (_deserted < 0) then {
                _deserted = 0;
            };

            _dir        = (_veh getvariable "RespawnPos") select 1;
            _position   = (_veh getvariable "RespawnPos") select 0;
            _type       = _veh getVariable "UnitType";
            _dead       = false;
            _nodelay    = false;

            if (_first) then {
                if (!_dynamic || {_veh getvariable ["defultlocked", false]}) then {
                   [_veh] call NTA_fnc_vehicles_lock;
                } else {
                   [_veh] call NTA_fnc_vehicles_unlock;
                };
                _veh setvariable ["NTA_Tickets", _tickets, true];
            };

            if (alive _veh) then {
                if (_dynamic || {{alive _veh} count (crew _veh) == 0 && _position distance (getposASL _veh) > 20 && {_x distance (getPos _veh) < 80} count playableUnits == 0 && !(_veh getVariable ["locked", false])}) then {
                    if !(_veh getvariable ["timeout", false]) then {
                        _veh setvariable ["timeout", true];
                        _veh setvariable ["time",  time + _deserted];
                    };
                } else {
                    _veh setvariable ["timeout", false];
                };
            };

            if (!(_veh getvariable ["timeout", false]) && {getdammage _veh >= 1 || (!alive _veh)}) then {
                _veh setvariable ["locked", false];
                _veh setvariable ["timeout", true];
                _veh setvariable ["time",  time + _delay];
            };

            if (_veh getvariable ["timeout", false] && {time > _veh getVariable "time"} && {{_x distance (getPos _veh) < 80} count playableUnits == 0}) then {
                _veh setvariable ["dead", true];
            };


            if (_veh getvariable "respawnnow") then {
                _veh setVariable ["dead", true, true];
            };

            if (_veh getvariable "dead") then {

                if (!(_veh getvariable ["respawnnow", false]) && !_dynamic) then {
                    [_veh, (-_tickets)] call NTA_fnc_core_addTickets;
                };

                if (_veh getvariable ["burning", false]) then {
                    {
                        if (typeOf _x == "#particlesource") then {
                            deleteVehicle _x;
                        };
                     } forEach (_x nearObjects 5);
                };

                deleteVehicle _veh;
                sleep 0.1;

                if (_type == "B_UAV_02_CAS_F") then {
                    _uav = [getMarkerPos "marker_drone1", 0, _type, WEST] call BIS_fnc_spawnVehicle;
                    _veh allowdammage false;
                    _veh = _uav select 0;
                    _veh setFuel 0;
                } else {
                    _veh = createVehicle [_type, [0,0,0], [], 0, "CAN_COLLIDE"];
                };
                _veh allowdammage false;
                _veh setPosASL _position;
                _veh setDir _dir;

                [_veh] call NTA_fnc_vehicles_defaults;

                if (_hasname) then {
                    [[netID _veh, _unitname], "NTA_fnc_vehicles_setVarName", true, true] spawn BIS_fnc_MP;
                };

                if (_haveinit) then {
                    [[netID _veh, _unitinit], "NTA_fnc_vehicles_setInit", true, true] spawn BIS_fnc_MP;
                };

                _veh setVariable ["NTA_Tickets", _tickets, true];
                _veh setVariable ["RespawnPos", [_position, _dir]];
                _veh setvariable ["respawnVariables", _variables];

                if (!_dynamic || {_veh getvariable ["defultlocked", false]}) then {
                    [_veh] call NTA_fnc_vehicles_lock;
                } else {
                    [_veh] call NTA_fnc_vehicles_unlock;
                };

                ////////////////////
                _veh setDammage 0;
                _veh allowdammage true;
            };
        } forEach (call NTA_fnc_all_vehicles);

        _first = false;
        if (("NTA_EVENT" call bis_fnc_getParamValue) > 0) exitWith {};
        sleep 60;
    };
};