waitUntil {!isNil "ALIVE_profileSystemInit"};
waituntil {(player getvariable ["alive_sys_player_playerloaded",false])};
[
	"ALIVE_SYS_PROFILE",
	"ALIVE_MIL_OPCOM",
	"ALIVE_AMB_CIV_POPULATION",
	"ALIVE_MIL_LOGISTICS",
	"ALiVE_civ_placement",
	"ALiVE_mil_placement",
	"ALiVE_mil_cqb"
] call ALiVE_fnc_unpauseModule;

diag_log "ALIVE UNPAUSE";