/*
	Author: Ir0n1E

	Description:
	Describe your function

	Parameter(s):
	#0 NUMBER - Initial waittime
	#1 NUMBER - Waittime between spawn
	#2 NUMBER - Delete Patrol after this
	#3 ARRAY  - Start Position (optional)
	#4 ARRAY  - End Position (optional)


	Returns:
	NONE

	Example:
	[1800, 1800, 3600, getmarkerpos "foo", [0,0,0]] call NTA_fnc_airpatrol_init
	[0,0,0] call NTA_fnc_airpatrol_init (disables Airpatrol loop)

	Note:
	For Userinsertion name an object 'NTA_Airpatrol_UserInsertion_Obj'
*/
// start [28713.2,27432.7,0]
// end [1637.84,13848.8,0]

#define DELETE_TIME 	1800
#define WAIT_TIME 		1800
#define INIT_WAIT_TIME 	3600
#define STARTPOS 		[29838.9, 22916.7, 0]
#define ENDPOS 			[1637.84, 13848.8, 0]
#define USERINSERTION	true

if (!isserver) exitwith {};
"Starting Airpatrol Init" call NTA_fnc_log;

NTA_airpatrol_DEBUG = false;
publicVariable "NTA_airpatrol_DEBUG";

NTA_Airpatrol_WEST = [
	"B_Heli_Transport_01_camo_F",
	"B_Plane_CAS_01_F",
	"B_Heli_Light_01_armed_F",
	"B_Heli_Attack_01_F"
];

NTA_Airpatrol_Insert_West = [
	"B_Heli_Light_01_F",
	"B_Heli_Transport_03_F"
];

NTA_Airpatrol_EAST = [
	"O_Heli_Attack_02_black_F",
	"O_Plane_CAS_02_F",
	"O_Heli_Light_02_F",
	"O_Heli_Light_02_unarmed_F",
	"O_Heli_Transport_04_bench_F"
];
publicVariable "NTA_Airpatrol_EAST";
publicVariable "NTA_Airpatrol_WEST";
publicVariable "NTA_Airpatrol_Insert_West";


NTA_airpatrolTarget = createmarker ["NTA_AirpatrolTarget", [0, 0, 0]];
NTA_airpatrolTarget setMarkerShape "RECTANGLE";
NTA_airpatrolTarget setMarkerSize [20, 50];
NTA_airpatrolTarget setMarkerColor "ColorBlack";
NTA_airpatrolTarget setMarkerBrush "DIAGGRID";
NTA_airpatrolTarget setmarkerAlpha 0;
publicvariable "NTA_airpatrolTarget";

NTA_airpatrolCache = "Land_HelipadEmpty_F" createvehicle [0,0,0];
publicVariable "NTA_airpatrolCache";


if (NTA_Airpatrol_Debug) then {
		NTA_airpatrolTarget setmarkerAlpha 1;
};

NTA_Airpatrolrunning = true;
publicVariable "NTA_Airpatrolrunning";

NTA_csatplaneInbound = false;
publicVariable "NTA_csatplaneInbound";

NTA_airpatrolCache setvariable["NTA_Airpatrol_West", grpnull, true];
NTA_airpatrolCache setvariable["NTA_Airpatrol_East", grpnull, true];
NTA_airpatrolCache setvariable["NTA_Airpatrol_CASunit_WEST", "none", true];

if (USERINSERTION && {!isnil "NTA_Airpatrol_UserInsertion_Obj"}) then {
	[NTA_Airpatrol_UserInsertion_Obj, "Chopper Insertion", 10, {true}, {
		(_this select 1) setvariable [format ["insert%1", group (_this select 1)],
		[]];
		[_this select 1] call NTA_fnc_airpatrol_agmOpenInsertMenu
		},
		false
	] call AGM_Interaction_fnc_addInteraction;
};

if (_this select 0 == 0 && {_this select 1 == 0} && {_this select 2 == 0}) exitwith {
	"NO Airpatrol loop" call NTA_fnc_log;
};

_this spawn {

	_INIT_WAIT_TIME = [_this, 0, INIT_WAIT_TIME] call BIS_fnc_param;
	_WAIT_TIME 		= [_this, 1, WAIT_TIME] call BIS_fnc_param;
	_DELETE_TIME 	= [_this, 2, DELETE_TIME] call BIS_fnc_param;
	_STARTPOS 		= [_this, 3, STARTPOS] call BIS_fnc_param;
	_ENDPOS			= [_this, 4, ENDPOS] call BIS_fnc_param;

	"Airpatrol waiting for Players" call NTA_fnc_log;
	waitUntil {((count playableunits) > 0)};
	"Airpatrol Init Done.." call NTA_fnc_log;
	[] call NTA_fnc_airpatrol_callCAS;
	_first_run = true;

	while {NTA_Airpatrolrunning} do {
		_randomwait = (random _WAIT_TIME) + 900;
		_time = time;

		if (_first_run) then {
			format["AIRPATROL sleeping for %1 sec",(_INIT_WAIT_TIME)] call NTA_fnc_log;


			waitUntil {time >= (_time + _INIT_WAIT_TIME)};
			_first_run = false;
		} else {
			format["AIRPATROL sleeping for %1 sec", _time + _randomwait] call NTA_fnc_log;
			waitUntil {time >= (_time + _randomwait)};
		};

		_veh = [_STARTPOS, _ENDPOS, [], []] call NTA_fnc_airpatrol_Create;

		if (count _veh > 0) then {
			_time = time;
			waitUntil {time >= (_time + _DELETE_TIME)};

			{
				if (!isnil "_x") then {
					deletevehicle _x;
				};
			} foreach units (_veh select 0);
			deletegroup (_veh select 0);

		};
	};
};