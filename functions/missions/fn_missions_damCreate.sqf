private ["_start","_obj","_objPos","_objDir", "_lamps", "_shed", "_gate"];

_objects    = [];
_lamps      = [];
_pipe       = [];
_pos        = [_this select 0, -20, 90] call BIS_fnc_relPos;

fnc_dam_active = {

    [] spawn {
        _time = time;
        while {time < (_time + 300)} do {
            playSound3D ["A3\Sounds_F\sfx\alarm_opfor.wss", (server getvariable ["DamHouses", []]) select 0];
            sleep 3;
        };
    };

    [(server getvariable ["DamHouses", []]) select 0, damactive] call NTA_fnc_spawnFlare;
    [[server getvariable 'DamLamps', true],'NTA_fnc_lamps_LampSwitch', nil, true] call BIS_fnc_MP;
    [EAST,[10892.2,8552.28,0], nil, getpos ([getpos _this, 1000, playableunits] call NTA_fnc_core_findnearestobject),
    ['O_Heli_Light_02_unarmed_F', 'O_Heli_Transport_04_bench_F']] call NTA_fnc_airpatrol_callGroup;

    {
        [_x,currentWaypoint _x, getpos ([getpos _this, 1000, playableunits] call NTA_fnc_core_findnearestobject), 'FULL','SAD','Combat'] call NTA_fnc_vehicles_addwaypoint
    } foreach (server getvariable ['Dampatrols',[]]);

    for "_i" from 0 to count (list _this) -1 do {
        {
            _x reveal ((list _this) select _i);
        } foreach (server getvariable ['Dampatrols',[]]);
    };
};

DamTrigger = createTrigger ["EmptyDetector", [9257.33,13832.9,0]];
DamTrigger setTriggerArea [300, 250, 90, true];
DamTrigger setTriggerType "SWITCH";
DamTrigger setTriggerActivation ["WEST", "EAST D", false];
DamTrigger setSoundEffect ["Alarm", "", "", ""];
DamTrigger setTriggerStatements ["this && damactive && {vehicle _x in thisList && isplayer _x && ((getPosATL _x) select 2) < 15} count playableunits > 0", "thistrigger call fnc_dam_active", ""];

 _start = createVehicle ["Land_Factory_Tunnel_F", _pos, [], 0, "CAN_COLLIDE"];

_objects pushback _start;
_start setVectorUp [0,0,1];
_start setDir (_this select 1) - 90;
_start setPosATL [_pos select 0, _pos select 1, (_pos select 2)-4];
_dir = 180;
_pos = [9104.36,13741.4,5.09896];

for "_i" from 0 to 5 do {
    _dir = (_dir +45);
    _obj = "Land_BagFence_Long_F" createVehicle [0,0,0];
    _pos = [[9104.36,13741.4,43.4], 2, _dir  ] call BIS_fnc_relPos;
    _obj setposASL _pos;
    _obj setdir (_dir + 1.8);

    _objects pushBack _obj;
};
_dir = 180;
for "_i" from 0 to 5 do {
    _dir = (_dir +45);
    _obj = "Land_BagFence_Long_F" createVehicle [0,0,0];
    _pos = [[9104.36,13741.4,43.6], 2, _dir  ] call BIS_fnc_relPos;
    _obj setposASL _pos;
    _obj setdir (_dir + 1.8);

    _objects pushBack _obj;
};

_pos = [[getposASl _start select 0, getposASl _start select 1,(getposASl _start select 2) + 0.5] , 2.8, 180] call BIS_fnc_relPos;

for "_i" from 0 to 5 do {
    _obj = "Land_IndPipe1_20m_F" createVehicle [0,0,0];
    _obj setPosASL _pos;
    _obj setDir (getdir _obj) + 91.2;
    _pos = [getposASL _obj, 20, 91.2] call BIS_fnc_relPos;
    _objects pushback _obj;
    _pipe pushback _obj;
};

_pos = [getposASL _obj, 12, 90] call BIS_fnc_relPos;
_obj = "Land_IndPipe1_valve_F" createVehicle [0,0,0];
_obj setPosASL _pos;
_obj setDir (getdir _obj) + 91.2 +180;
_objects pushback _obj;
_pipe pushback _obj;

DamVent = _obj;
publicVariable "Damvent";

DamVent addEventHandler ["handledamage", {
    if (((_this select 4) in ["SatchelCharge_Remote_Ammo","DemoCharge_Remote_Ammo","DemoCharge_Remote_Ammo_Scripted","SatchelCharge_Remote_Ammo_Scripted"]) && ((_this select 2) > 0.15) ) then {1} else {_this select 2};

    }];

server setvariable ["DamVent", _obj, true];

_pos  = getposASL _obj;
_shed = "Land_Shed_Small_F" createVehicle [0,0,0];
_shed setPosASL [_pos select 0, _pos select 1, (_pos select 2)-1.8];
_shed setDir (getdir _shed) + 91.2 +180;
_objects pushback _shed;

_pos = [getposASL _obj, 4, 0] call BIS_fnc_relPos;
_gate = "Land_Net_Fence_Gate_F" createVehicle [0,0,0];
 _gate setPosASL _pos;
//_shed setDir (getdir _shed) + 91.2 +180;
_objects pushback _gate;

_pos = [getposASL _gate, 5, -90] call BIS_fnc_relPos;
_shed = "Land_Net_Fence_4m_F" createVehicle [0,0,0];
_shed setPosASL _pos;
//_shed setDir (getdir _shed) + 91.2 +180;
_objects pushback _shed;

_pos = [getposASL _gate, 8, -90] call BIS_fnc_relPos;
_shed = "Land_Net_Fence_8m_F" createVehicle [0,0,0];
_shed setPosASL _pos;
//_shed setDir (getdir _shed) + 91.2 +180;
_objects pushback _shed;


_pos = [getposASL _gate, 5, 90] call BIS_fnc_relPos;
_shed = "Land_Net_Fence_4m_F" createVehicle [0,0,0];
_shed setPosASL _pos;
//_shed setDir (getdir _shed) + 91.2 +180;
_objects pushback _shed;
 _pos = [getposASL _gate, 8, 90] call BIS_fnc_relPos;
_shed = "Land_Net_Fence_8m_F" createVehicle [0,0,0];
_shed setPosASL _pos;
//_shed setDir (getdir _shed) + 91.2 +180;
_objects pushback _shed;
_pos = [getposASL _obj, 12, 90] call BIS_fnc_relPos;
_shed = "Land_Net_Fence_8m_F" createVehicle [0,0,0];
_shed setPosASL _pos;
_shed setDir (getdir _shed) +90;
_objects pushback _shed;

_pos = [getposASL _obj, -12, 90] call BIS_fnc_relPos;
_shed = "Land_Net_Fence_8m_F" createVehicle [0,0,0];
_shed setPosASL _pos;
_shed setDir (getdir _shed) -90;
_objects pushback _shed;

_pos = [getposASL _obj, 6, 85] call BIS_fnc_relPos;
for "_i" from 1 to 3  do {
    _shed = "Land_MetalBarrel_F" createVehicle [0,0,0];
    _shed setPosASL _pos;
     _pos = [getposASL _shed, _i, 90] call BIS_fnc_relPos;
    _objects pushback _shed;
};
_pos = [getposASL _shed, 1, 0] call BIS_fnc_relPos;
for "_i" from 1 to 3  do {
    _shed = "Land_MetalBarrel_F" createVehicle [0,0,0];
    _shed setPosASL _pos;
     _pos = [getposASL _shed, _i, -90] call BIS_fnc_relPos;
    _objects pushback _shed;
};

_pos = [getposASL _obj, 12.9, 92.3] call BIS_fnc_relPos;
for "_i" from 0 to 5 do {
    _obj = "Land_IndPipe1_20m_F" createVehicle [0,0,0];
    _obj setPosASL _pos;
    _obj setDir (getdir _obj) + 91.2;
    _pos = [getposASL _obj, 20, 91.2] call BIS_fnc_relPos;
    _objects pushback _obj;
    _pipe pushback _obj;

};
_start = createVehicle [
    _this select 2,
    _this select 0,
    [],
    0,
    "CAN_COLLIDE"
];

_objects pushback _start;
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


    _objects pushback _obj;
};
_pos = [_this select 0, -3.5, 180 +(_this select 1)] call BIS_fnc_relPos;
_obj = "Land_Concrete_SmallWall_8m_F" createVehicle [0,0,0];
_obj setPos [_pos select 0, _pos select 1, (_pos select 2)+6];
_obj setdir (_this select 1);
_objects pushback _obj;

_pos = [getposASL _obj, 8, 90] call BIS_fnc_relPos;
_dir = getdir _obj;
for "_i" from 0 to 23  do {
    _obj = "Land_Concrete_SmallWall_8m_F" createVehicle [0,0,0];
     _obj setPosASL _pos;
    _obj setdir _dir;
    _pos = [getposASL _obj, 8, 91.2] call BIS_fnc_relPos;
    _dir = getdir _obj;
    _objects pushback _obj;

};

for "_i" from 0 to 5 do {
    _obj = "Land_LampHarbour_F" createVehicle [0,0,0];
     _obj setPosASL _pos;
    _obj setdir (getdir _obj) +180;
    _pos = [getposASL _obj, -50, 91.2] call BIS_fnc_relPos;
    _objects pushback _obj;
};



 _pos = [getposATL _start, -30, 180] call BIS_fnc_relPos;

for "_i" from 0 to 37 do {
    _obj = "Land_Razorwire_F" createVehicle [0,0,0];
     _obj setPosATL _pos;
    _obj setdir _dir;
    _pos = [getposATL _obj, 5, 91.2] call BIS_fnc_relPos;
    _dir = getdir _obj;
    _objects pushback _obj;

};

_pos = [getposATL _start, 30, 230] call BIS_fnc_relPos;
_gate = "Land_Net_Fence_Gate_F" createVehicle [0,0,0];
_gate setPosAtl [_pos select 0, _pos select 1, (_pos select 2)-1];
_gate setDir (getdir _gate) + 90;
_objects pushback _gate;

 _pos = [getposatl _gate, 5, 0] call BIS_fnc_relPos;
for "_i" from 1 to 3 do {
    _shed = "Land_Net_Fence_4m_F" createVehicle [0,0,0];
    _shed setPosAtl _pos;
    _shed setDir (getdir _shed) + 90;
    _pos = [getposatl _shed, 4, 0] call BIS_fnc_relPos;
    _objects pushback _shed;
};
_pos = [getposATL _gate, -3, 0] call BIS_fnc_relPos;

for "_i" from 0 to 22 do {
    _obj = "Land_Net_Fence_8m_F" createVehicle [0,0,0];
     _obj setPosATL _pos;
    _obj setdir _dir;
    _pos = [getposATL _obj, 8, 91.2] call BIS_fnc_relPos;
    _dir = getdir _obj;
    _objects pushback _obj;

};
_pos = [getposATL _obj, 4, 0] call BIS_fnc_relPos;
_obj = "Land_Net_Fence_8m_F" createVehicle [0,0,0];
_obj setPosATL _pos;
_objects pushback _obj;
_obj setdir (_dir - 90);

_pos = [getposATL _obj, 3, 0] call BIS_fnc_relPos;
for "_i" from 0 to 3 do {
    _obj = "Land_LampHalogen_F" createVehicle [0,0,0];
     _obj setPosATL _pos;
    _obj setdir (_dir+90);
    _pos = [getposATL _obj, -50, 91.2] call BIS_fnc_relPos;
    _lamps pushback _obj;

};
_pos = [getposATL _obj, -3, 0] call BIS_fnc_relPos;
for "_i" from 0 to 3 do {
    _obj = "Land_LampHalogen_F" createVehicle [0,0,0];
     _obj setPosATL _pos;
    _obj setdir (_dir - 90);
    _pos = [getposATL _obj, 50, 91.2] call BIS_fnc_relPos;
    _lamps pushback _obj;
};


{
   _obj = "Land_LampHalogen_F" createVehicle [0,0,0];
   _obj setPosATL _x;
   _lamps pushback _obj;

   if(_foreachindex == 1) then {
        _obj setdir (getdir _obj) + 180;
   };
} foreach [[9322.47,13716.7,0.000595093],[9341.08,13688.8,0.00160599],[9315.54,13681.4,0.00141907]];

_objects = _objects + _lamps;

_pos = [getposATL _start, -25, 180] call BIS_fnc_relPos;
for "_i" from 0 to 4 do {
    _obj = "Land_Razorwire_F" createVehicle [0,0,0];
     _obj setPosATL _pos;
    _obj setdir (_dir+90);
    _pos = [getposATL _obj, -5, 0] call BIS_fnc_relPos;
    //_dir = getdir _obj;
    _objects pushback _obj;

};
_obj =  "O_supplyCrate_F" createvehicle [9323.86,13697.1,0.00176239];
_obj addMagazinecargoGlobal ["DemoCharge_Remote_Mag", 8];
_objects pushBack _obj;

server setvariable ["DamPipe", _pipe, true];
server setvariable ["DamLamps", [_lamps, "NTA_DamLamps_on"], true];
[[_lamps, "NTA_DamLamps_on"], false] call NTA_fnc_lamps_LampSwitch;

DAMACTIVE = true;
publicVariable "DAMACTIVE";

_obj2       = [[9377.59,13689.8,0.00165176], true, true] call NTA_fnc_missions_compFuel;
_objects = _objects + _obj2;
server setvariable ["damhouses", [9321.72,13700.9,0.00140762] nearObjects ["House",15], true];
server setvariable ["DamObjects", _objects, true];
0 = [] call NTA_fnc_missions_DamPatrols;