// =========================================================================================================
// MPSF PO3 Edition - MultiPlayer Scripting Framework by EightySix
// Version Release 3.1.1
// PERMITTED FOR PUBLIC RELEASE WITHOUT MODIFICATION
// =========================================================================================================

["INIT",format["Executing Patrol_Ops_3.sqf"]] call PO3_fnc_log;
PO3_debug = false;
publicvariable "PO3_debug";
PO3_debug_log = false;
publicvariable "PO3_debug";
// =========================================================================================================
// !!  DO NOT MODIFY THIS FILE  !!
// =========================================================================================================
["INIT",format["Debug set: %1, Debug Log set: %2",PO3_debug,PO3_debug_log]] call PO3_fnc_log;

#include "Patrol_Ops_3_Configuration.hpp"

[] call PO3_fnc_init;
[] call PO3_fnc_processParams;
[] call PO3_fnc_taskmaster;
//[] call PO3_fnc_syncMPEnv;
//[] spawn PO3_fnc_cleanup;
if(PO3SRV || !hasinterface) then {
	PO3_SRV_HLC_grp_recieved = nil;
	{ switch (side _x) do { case west : { PO3_active_side_west = true }; case east : { PO3_active_side_east = true }; case resistance : { PO3_active_side_guer = true }; case civilian : { PO3_active_side_civ = true }; case sidelogic : { PO3_active_side_logic = true }; }; }forEach allunits;
	if (isserver) then {
	if(isNil "PO3_active_side_west") then { createCenter west };
	if(isNil "PO3_active_side_east") then { createCenter east };
	if(isNil "PO3_active_side_guer") then { createCenter resistance };
	if(isNil "PO3_active_side_civ")  then { createCenter civilian };
	if(isNil "PO3_active_side_logic") then { createCenter sideLogic };
	west setFriend [civilian, 1]; west setFriend [east, 0];// west setFriend [resistance, 0];
	east setFriend [civilian, 1]; east setFriend [west, 0];// east setFriend [resistance, 0];
//	resistance setFriend [civilian,0]; resistance setFriend [east,0]; resistance setFriend [west,0];
	civilian setFriend [east,1]; civilian setFriend [west,1];// civilian setFriend [resistance, 1];
	["Centers","All Centers Created and Friendships set"] call PO3_fnc_log;

	PO3_respawn_positions_global = PO3_CfgRespawn_PreDefinedPositions; publicVariable "PO3_respawn_positions_global";
	["Redeploy",format["Initilised with points: %1",PO3_CfgRespawn_PreDefinedPositions] ] call PO3_fnc_log;
};
};
if(PO3CLI) then {
	[] call PO3_fnc_diary;
};



PO3_core_init = true;
["Init",format["Completed Initilise of %1",missionName]] call PO3_fnc_log;

sleep 1;


if(PO3SRV || !hasinterface) then {
	[] spawn PO3_fnc_registerLocations;
	PO3_worldsize = call PO3_fnc_worldsize;

PO3_param_ambientIEDs = false;
PO3_param_ambient_civs_enable = false;
PO3_param_ambient_civtraffic_enable = false;


};