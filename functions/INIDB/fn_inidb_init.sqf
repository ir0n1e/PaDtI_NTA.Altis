_this spawn {
	missionNamespace setvariable ["nta_inidb", isclass(configFile/"CfgPatches"/"iniDBi")];
	sleep 0.25;
	publicvariable "nta_inidb";


		//call compile preProcessFile "\iniDB\init.sqf";
		inidb_initscript = compile (gettext (configfile >> "CfgPatches" >> "iniDBI" >> "init"));
		publicVariableServer "inidb_initscript";
		call inidb_initscript;
		sleep 1;
		"nta_inidb Loaded..." call NTA_fnc_log;
		["", "read"] call NTA_fnc_inidb_NTAusers;

		missionNamespace setvariable ["nta_inidb", isclass(configFile/"CfgPatches"/"iniDBi")];
			sleep 0.25;
			publicvariable "nta_inidb";

};