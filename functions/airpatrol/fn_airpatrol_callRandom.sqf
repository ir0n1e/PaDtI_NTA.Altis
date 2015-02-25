/*
	Author: Ir0n1E

	Description:
	Calls a random Group (EAST)

	Parameter(s):
	#0 OBJECT - Target

	Returns:
	NONE
*/
private ["_target", "_planes", "_pos"];

_target = _this;
_pos = (getposASL _target);

waituntil {NTA_Airpatrolrunning && !NTA_csatplaneInbound};

switch (floor (random 3)) do {
    case 0: {
    	NTA_airpatrolTarget setMarkerAlpha 0;
        NTA_airpatrolTarget setmarkerpos [_pos select 0, _pos select 1, 0];
		NTA_airpatrolTarget setMarkerDir (getdir _target) + 90;

    	_planes = [NTA_airpatrolTarget,[2]] call NTA_fnc_airpatrol_callCsatPlane;
    	NTA_csatplaneInbound = true;
    	_planes spawn {

    		waituntil {{alive _x} count _this == 0 || {{!(_x getvariable ["NTA_bombsAway", false])} count _this == 0}};

    		NTA_airpatrolTarget setmarkerpos [0,0,0];
    		NTA_csatplaneInbound = false;
    	};
    };
    case 1: {
		[EAST,[14892.2,8552.28,0], nil, _pos, ["O_Heli_Light_02_unarmed_F", "O_Heli_Transport_04_bench_F"]] call NTA_fnc_airpatrol_callGroup;
		NTA_csatplaneInbound = true;
		[] spawn {
			sleep 10;
			NTA_csatplaneInbound = false;
		};
	};
    default {
    	"AIRPATROL: No Vehicles Done" call NTA_fnc_log;
     	true
    };
};
