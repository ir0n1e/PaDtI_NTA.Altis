0 spawn {
"Checking HC" call NTA_fnc_log;
if ( !hasInterface && !isServer) then {
	HCPresent = true;
	publicVariable "HCPresent";
	sleep 0.2;
	HCName = name player;
	publicVariable "HCName";
	sleep 4;
		[] spawn PO3_fnc_registerLocations;
		PO3_worldsize = call PO3_fnc_worldsize;
		0 = [] execvm "tasks\po3_taskmaster.sqf";
		addMissionEventHandler ["HandleDisconnect", {
		if (name (_this select 0) == HCname) then {
			HCpresent = nil;
			publicVariable "HCPresent";
			["","server_fn_calltask", false, false] call bis_fnc_mp;
		};

/*{
    	if ((_x distance [0,0,0]) < 1) then {
        	deleteVehicle _x;
    	};
	} count (allMissionObjects "EmptyDetector");
*/
	}];
 };



if (isserver) then {
	addMissionEventHandler ["HandleDisconnect", {
		if (name (_this select 0) == HCname) then {
			HCpresent = nil;
			publicVariable "HCPresent";
			["","server_fn_calltask", false, false] call bis_fnc_mp;
		};
		{
    	if ((_x distance [0,0,0]) < 1) then {
        	deleteVehicle _x;
    	};
	} count (allMissionObjects "EmptyDetector");

	}];
	server_fn_calltask = {
		[format["TASK%1",PO3_TASK__IDD],"canceled"] call PO3_fnc_updateTask;

		0 = [] execvm "tasks\po3_taskmaster.sqf";
	};


	format ["HC present: %1", !isnil "HCPresent"] call NTA_fnc_log;
	HCinit=true;


};

PO3_sVAR_HLCKeepAlive = [objNull,0,time];
if(isServer || hasInterface) exitWith {
	format["Exit fnc_sendKeepalive %1 || %2",isServer,hasInterface] call NTA_fnc_log;
	if(isServer) then {
		"PO3_sVAR_HLCKeepAlive" addPublicVariableEventHandler { (_this select 1) call PO3_fnc_hlc_assignOwner };
	};
};

str ["HLC","Beginning send KeepAlive"] call NTA_fnc_log;
waitUntil {
	waitUntil { !(isNull player) };
	waitUntil { alive player };

	PO3_sVAR_HLCKeepAlive = [player,diag_fps,time];
	publicVariableServer "PO3_sVAR_HLCKeepAlive";
	format["%1 sent %2 keepAlive to Server",player,PO3_sVAR_HLCKeepAlive] call NTA_fnc_log;

	sleep 15;
	false;
};
};