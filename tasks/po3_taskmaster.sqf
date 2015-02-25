//if (!isserver) exitwith {};
private["_list","_j","_next","_prev","_lim","_script", "_taskMarker", "_mkrArray", "_alpha", "_task_script"];
call compile preprocessFileLineNumbers "Patrol_Ops_3_Configuration.hpp";


waituntil {!isnil "EOSDone"};


// ==== PO3 Mission Types ==================================================================================
PO3_missions = [
	 "PO3_task_m01_attackBase"			// <!-- TEST
	,"PO3_task_m02_attackConvoyArmour"	// <!-- TEST
	,"PO3_task_m03_attackConvoySupply"	// <!-- TEST
//	,"PO3_task_m04_captureIntel"		// <!-- TEST
	,"PO3_task_m05_captureOfficer"		// <!-- TEST
	,"PO3_task_m06_captureTown"			// <!-- TEST
	,"PO3_task_m07_captureVehicle"		// <!-- TEST
	,"PO3_task_m08_clearMinefield"		// <!-- TEST
	//,"PO3_task_m09_clearRunway"			// <!-- TEST
//	,"PO3_task_m10_clearSeaMinefield"	// <!-- TEST
	,"PO3_task_m11_createSupplies"		// <!-- TEST
	,"PO3_task_m12_createTower"			// <!-- TEST
	,"PO3_task_m13_defendBase"			// <!-- TEST
	//,"PO3_task_m14_defendDamagedBoat"	// <!-- TEST
	,"PO3_task_m15_defendTown"			// <!-- TEST
	,"PO3_task_m16_destroyArtillery"	// <!-- TEST
	,"PO3_task_m17_destroyCaches"		// <!-- TEST
	,"PO3_task_m18_destroyTower"		// <!-- TEST
	,"PO3_task_m19_intelDrone"			// <!-- TEST
	,"PO3_task_m20_rescuePilots"		// <!-- TEST
	,"NTA_task_m01_attackMortar"		// <!-- TEST
	,"NTA_task_m02_attackWarehouse"		// <!-- TEST
	,"NTA_task_m03_roadblock"		// <!-- TEST
];
publicvariable "PO3_missions";
PO3_ForceTask = [false, ""];
PO3_TASK__POS = [0,0,0];
damactive = false;
_list = PO3_missions;
_eosMarkers=server getvariable "EOSmarkers";
_mkrArray = [];
//_list = ["PO3_task_m07_captureVehicle"];
_j = (count _list - 1) min (round random (count _list));
_next = _list select _j;
_prev = _list;
_missioncount = if(isNil "PO3_param_missioncount") then { 3 }else{ PO3_param_missioncount };
if !(PO3_debug) then { sleep 30 };
while { _missioncount != 0 } do {
	waituntil {!damactive && {!EOS_ACTIVE}};
	if (!(PO3_ForceTask select 0)) then {
		_lim = 0;
		while{ _next IN _prev && _lim < count _list } do {
			_j = (count _list - 1) min (round random (count _list));
			_next = _list select _j;
			_lim = _lim + 1;
		};
		_prev = if(count _prev >= count _list) then { [_next] }else{ _prev + [_next] };
	} else {
		_next = PO3_forceTask select 1;
		PO3_ForceTask = [false, ""];
	};
	_missioncount = _missioncount - 1;
	sleep 5;
	waituntil {count _mkrArray == 0};

	_TASK_Script = execvm format["tasks\%1.sqf", _next];
	format ["Task isHC: %1 isServer: %2", (!isServer && !hasinterface), isserver] call NTA_fnc_log;

	/*if (!isnil "HCPresent") then {
		"TASK switching to HC" call NTA_fnc_log;
		(owner NTAHC) publicVariableClient "hc_fn_calltask";
		[_TASK_Script, "HC_fn_callTask", NTAHC] call bis_fnc_mp;
	} else {
		if (isServer) then {
			"TASK switching to Server" call NTA_fnc_log;

		};
	};*/

	waituntil {str PO3_TASK__POS != "[0,0,0]"};
	publicVariableserver "PO3_TASK__POS";
	[] spawn {
		waituntil {({_x distance PO3_TASK__POS < 350}count playableunits) > 0};
		{

			if (_x distance PO3_TASK__POS < 350) exitwith {
				_x call NTA_fnc_airpatrol_callRandom;

			};
		} count playableunits;
	};

	{
		if (((getmarkerpos _x) distance PO3_TASK__POS) <= 1000) then {
			_alpha = markeralpha _x;
			_x setMarkerAlpha 0;
			[0,"setmarkeralpha",_x,true] call BIS_fnc_MP;
			_mkrArray pushback [_x, _alpha];
			[str _x, str ( markeralpha _x)] call nta_fnc_log;
		};
	} foreach _eosMarkers;

	waitUntil{ sleep 10; scriptdone _TASK_Script || {!isNil "PO3_force_TASKEND"}};
	{
		if (typeOf _x == "#particlesource") then {
			deleteVehicle _x
		};
	} forEach (PO3_TASK__POS nearObjects 500);

	PO3_TASK__POS = [0,0,0];
	publicVariableserver "PO3_TASK__POS";
	publicVariableServer "PO3_TASK__IDD";
	if (count _mkrArray > 0) then {
		{
			(_x select 0) setMarkerAlpha (_x select 1);
			[(_x select 1) ,"setmarkeralpha",(_x select 0),true] call BIS_fnc_MP;
		} foreach _mkrArray;
		_mkrArray = [];
	};

	if!(isNil "PO3_force_TASKEND") then {
		terminate _TASK_Script;

		[format["TASK%1",PO3_TASK__IDD],"canceled"] call PO3_fnc_updateTask;

		{ if(alive _x) then { deletevehicle _x }; }forEach PO3_TOTAL_UNITS;
		{ if( {isPlayer _x} count (crew _x) == 0 ) then { deletevehicle _x }; }forEach PO3_TOTAL_VEHICLES;


		PO3_force_TASKEND = nil;
		_missioncount = _missioncount + 1;
	};
};
/*
_counter = 0;
{
	switch (_x select 5) do {
		case "succeeded" : {
			_counter = _counter + 1;
		};
		case "failed" : {
			_counter = _counter - 1;
		};
	};
} foreach PO3_tasks_Tasks;

PO3_mission_Status = if(_counter >= 0) then { true }else{ false }; publicVariable "PO3_mission_Status";
*/