
NTA_PUBLIC=true;
["INIT",format["Executing %1 init.sqf",missionName]] call PO3_fnc_log;

call compile preprocessfilelinenumbers "Scripts\Init_UPSMON.sqf";



[] execVM "Patrol_Ops_3.sqf";



[] call NTA_fnc_init;

if(!isDedicated) then {
	Receiving_finish = false;
	onPreloadFinished { Receiving_finish = true; onPreloadFinished {}; };
	WaitUntil{ !(isNull player) && !isNil "PO3_core_init" && Receiving_finish };
} else {
	WaitUntil{!isNil "PO3_core_init"};
};

if(!isDedicated && {!PO3_debug} && {!(getPlayerUID player in call NTA_fnc_players_id)} && {name player != "NTAHC"}) then {
	player setvariable ["NTA_PublicPlayer", true];
	playMusic "LeadTrack01a_F";
	0 fadeMusic 1;
	[5,""] spawn PO3_fnc_camera_fadein;
	if!(PO3_debug) then { [270,900,150] call PO3_fnc_introsequence };
	[] spawn { sleep 20; 8 fadeMusic 0; };
};
if(isnil "UPSMON_Total") then {
	UPSMON_Total = 0;
	publicvariable "UPSMON_Total";
};