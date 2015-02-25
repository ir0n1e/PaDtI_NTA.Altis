if (!(local player) || {str player == "Zeus3"} || {name player == "NTAHC"}) exitwith{};
private ["_time", "_medic"];

"Starting Player Init..." call NTA_fnc_log;
Player_initTime = diag_ticktime;

player setvariable ["haveBWA3", false];
player setvariable ["haveBWplus", false];
player setvariable ["haveAGM", false];
player setvariable ["haveCBA", false];
respawnMarkers = [];
Respawn_unitGear = [];
NTA_MissionEnd = false;
NTAmedic = ["medic1", "medic2", "medic3", "medic4"];
publicVariable "NTAmedic";

if (isClass(configFile/"CfgPatches"/"BWplus_vehicles") && isClass(configFile/"CfgPatches"/"BWplus_Weapons")) then {
	player setvariable ["haveBWplus", true];
};

if (isClass(configFile/"CfgPatches"/"BWA3_Common")) then {
	player setvariable ["haveBWA3", true];
};

if (isClass(configFile/"CfgPatches"/"AGM_Core")) then {
	player setvariable ["haveAGM", true];
};

if (isClass(configFile/"CfgPatches"/"CBA_main_a3")) then {
	player setvariable ["haveCBA", true];
};

player setVariable ["NTA_Campos_internal", true, true];
player setVariable ["respawnBoxes", true];
player setvariable ["Playerbox", format ["ammo_%1", player], true];
player setVariable["profileName", name player, true];

[player] spawn NTA_fnc_crate_respawn;
player call NTA_fnc_standardItems_player;
if (str player in NTAmedic) then {
	player setvariable ["AGM_ismedic",true, true];
};

"b1" setMarkerTextlocal localize "STR_NTA_Base";
"b2" setMarkerTextlocal localize "STR_NTA_Hill46";
"mshoothouse" setMarkerTextlocal localize "STR_NTA_Shoothouse";
"range" setMarkerTextlocal localize "STR_NTA_Schootingrange";
"range1" setMarkerTextlocal localize "STR_NTA_Schootingrange";
"vehicleTrainig" setMarkerTextlocal localize "STR_NTA_VehicleTrainigArea";


player addeventhandler ["killed", {
	_p = _this select 0;
	Respawn_unitGear = [_p] call NTA_fnc_players_saveGear;
	[[_p, primaryWeapon _p], "NTA_fnc_inidb_writePlayerStats", false, false] call bis_fnc_mp;

	{deleteMarkerLocal _x} foreach respawnMarkers;

	m1 = createmarkerlocal ["respawn_west_1", getmarkerpos "west_1"];
	m1 setMarkerTextLocal localize "STR_NTA_Base";
	m2 = createmarkerlocal ["respawn_west_2", getmarkerpos "west_2"];
	m2 setMarkerTextLocal localize "STR_NTA_Hill46";
	respawnMarkers = [m1, m2];
	if (leader (group _p) != _p  && {leader (group _p) distance getmarkerpos "west_1" > 1000} && {leader (group _p) distance getmarkerpos "west_2" > 1000} ) then {
		m3 = createmarkerlocal ["respawn_west_3", [getpos (leader group _p), [5, 10],2,0] call PO3_fnc_getSafePos];
		m3 setMarkerTextLocal format ["%1 %2", name (leader group _p), localize "STR_NTA_SMALLGEAR"];

		m4 = createmarkerlocal ["respawn_west_4", [getpos (leader group _p), [800, 1000],2,0] call PO3_fnc_getSafePos];
		m4 setMarkerTextLocal format ["%1 %2", name (leader group _p),  localize "STR_NTA_FULLGEAR"];
		respawnMarkers pushBack m3;
		respawnMarkers pushBack m4;
	};

	[_p, (-10)] call NTA_fnc_core_addTickets;
}];

player addeventhandler ["respawn", {

	_p = _this select 0;

	_p setvariable ["Playerbox", format ["ammo_%1", _p]];
	[_p] call NTA_fnc_crate_respawn;

	if (_p getvariable "haveBWA3" && {_p getvariable "haveAGM"}) then {
		[_p] call NTA_fnc_players_actions;
	};
	[] call NTA_fnc_airpatrol_agmAddaction;

	if (str _p in NTAmedic) then {
		_p setvariable ["AGM_ismedic",true, true];
	};

	[_p, Respawn_unitGear] call NTA_fnc_players_respawnSwitch;
}];

[player] call NTA_fnc_players_actions;
//[] call NTA_fnc_AGM_addadminActions;
[] call NTA_fnc_airpatrol_agmAddaction;
[] call IL_fnc_init;
[] call NTA_fnc_welcome;


if (("NRF_Training" call bis_fnc_getParamValue) > 0) then {
	_this spawn {
		while {true} do {
			if (cameraView == "External") then
			{
				if ((vehicle player) == player || {player getvariable  "NTA_Campos_internal"}) then {
					vehicle player switchCamera "Internal";
					player setVariable ["NTA_Campos_internal",true,true];
				};
			};
			sleep 1;
		};
	};
};

if (("NTA_Tickets" call bis_fnc_getParamValue) > 0) then {
	"NTA_MissionEnd" addPublicVariableEventHandler {
		if (_this select 1) then {
			["epicFail",false,2] call BIS_fnc_endMission;
		};
	};
};





waituntil {diag_ticktime > (Player_initTime + 40)};



format ["Player Init in %1 sec Complete...", (diag_ticktime - Player_initTime)] call NTA_fnc_log;
