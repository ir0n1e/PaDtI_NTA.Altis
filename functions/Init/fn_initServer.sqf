if (!isServer) exitwith {};
private ["_time", "_veh","_tickets"];
_time = diag_ticktime;

"Starting Server Init..." call NTA_fnc_log;


NTA_Serverinit 			= false;
NTA_mainINIT 			= false;
NTA_MOLOS 				= true;
NTA_TMPplayers 			= [];
NTA_TicketsActive 		= false;
NTA_Airpatrolrunning 	= false;
NTA_artyActive 			= false;
NTA_Tickets 			= ("NTA_Tickets" call bis_fnc_getParamValue);
NTAmedic = ["medic1", "medic2", "medic3", "medic4"];

publicvariable "NTA_mainInit";
publicvariable "NTA_ServerInit";
publicVariable "NTA_TMPplayers";
publicvariable "NTA_TicketsActive";
publicvariable "NTA_Tickets";
publicVariable "NTAmedic";
publicVariable "NTA_artyActive";


missionNamespace setvariable ["haveBWplus", false];
missionNamespace setvariable ["haveBWA3", false];
missionNamespace setvariable ["haveAGM", false];

if (isClass(configFile/"CfgPatches"/"BWplus_vehicles") && isClass(configFile/"CfgPatches"/"BWplus_Weapons")) then {
	missionNamespace setvariable ["haveBWplus", true];
};

if (isClass(configFile/"CfgPatches"/"BWA3_Common")) then {
	missionNamespace setvariable ["haveBWA3", true];
};
if (isClass(configFile/"CfgPatches"/"AGM_Core")) then {
	missionNamespace setvariable ["haveAGM", true];
};


setdate [2015, 06, 15, ("NTA_TIME" call bis_fnc_getParamValue), 0];

Wache3 setpos [26763.6,24796.6,0.00135994];

Swamp = createMarker ["Swamp",[21281.1,14651.5]];
Swamp setMarkerSize [1000,600];

Island = createMarker ["Island",[13469.6,11979.3]];
Island setMarkerSize [600,600];

Factory = createMarker ["Factory",[5255.61,20921.3]];
Factory setMarkerSize [600,600];

Island_house = createMarker ["Island_house",[13592.1,12196.9,0]];
Island_house setMarkerSize [20,20];



if (("NTA_TRAINING_Shoothouse" call bis_fnc_getParamValue) > 0) then {
	[] call NTA_fnc_base_Shoothouse;
};

if (("NTA_TRAINING_Shootingrange" call bis_fnc_getParamValue) > 0) then {
	[] call NTA_fnc_base_Shootingrange;
};

if (!NTA_PUBLIC) then {
	[] call NTA_fnc_mcc_init;
};

if (("NTA_EVENT" call bis_fnc_getParamValue) == 0) then {
	//0 = [] call NTA_fnc_init_alive;
};

if (("NRF_Training" call bis_fnc_getParamValue) > 0) then {
	"============== TRAINING ==============" call NTA_fnc_log;
} else {
	if (!NTA_Airpatrolrunning && ("NTA_Airpatrol" call bis_fnc_getParamValue) == 1) then {
		[1800,1500,1800] call NTA_fnc_airpatrol_init;
		if (!NTA_PUBLIC) then {
			[] call NTA_fnc_init_alive;
		};
	};
};

call NTA_fnc_inidb_init;
call NTA_fnc_lamps_create;
call NTA_fnc_lamps_runwayCreate;
call NTA_fnc_agmlogistics_init;
call NTA_fnc_vehicles_init;
call NTA_fnc_players_adminActions;
call NTA_fnc_base_weapons;
//call NTA_fnc_cleanup;

if (("NTA_Civilians" call bis_fnc_getParamValue) > 0) then {
	call NTA_fnc_civilians_init;
};




if (NTA_PUBLIC) then {
	call NTA_fnc_eos_init;
};

//_boxes = ["medic_box1", "medic_box2", "agm_box2", "player_box"];
{
	if (!(str _x in call NTA_fnc_all_vehicles) && {isnull (driver _x)} && {!(_x isKindOf "static")} && {!(typeof _x iskindof "ReammoBox_F")}) then {
		_x enableSimulationGlobal false;
	};
} foreach vehicles;

NTA_ServerInit = true;
publicvariable "NTA_ServerInit";
format ["Server Init in %1 sec Complete...", (diag_ticktime - _time)] call NTA_fnc_log;

format ["Server waiting for HC...", (diag_ticktime - _time)] call NTA_fnc_log;
waituntil {diag_ticktime > (_time + 40)};

if (isserver && {isnil "HCpresent"}) then {
	"HC not present Done..." call nta_fnc_log;
	if (NTA_PUBLIC) then {
		0 = [] execvm "tasks\po3_taskmaster.sqf";
	};
};

