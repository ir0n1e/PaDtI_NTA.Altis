

if (!isServer) exitWith {};
	// -------------------------------------------------------------------------------------------------------------
	// override default data
	// see script/staticData.sqf
	["MISSION INIT - Waiting"] call ALIVE_fnc_dump;

	waitUntil {!isNil "ALiVE_STATIC_DATA_LOADED"};

	["MISSION INIT - Continue"] call ALIVE_fnc_dump;

	// override static data settings
	//call compile (preprocessFileLineNumbers "script\staticData.sqf");

	call NTA_fnc_alive_cqb_blacklist;
	//call NTA_fnc_alive_faction_bwa3;
	["MISSION INIT - Static data override loaded"] call ALIVE_fnc_dump;
	//["CUSTOM BLACKLIST LOADED: %1",ALIVE_unitBlackist] call ALIVE_fnc_dump;

if (("NRF_Training" call bis_fnc_getParamValue) > 0) then {

	call NTA_fnc_pause_alive;
};




	// -------------------------------------------------------------------------------------------------------------
