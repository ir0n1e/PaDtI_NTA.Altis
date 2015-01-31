if (isserver) then {
	NTA_PUBLIC = true;
	NTA_Airpatrolrunning=false;
	EOS_ACTIVE = false;
	eosdone = false;
	execvm "test\hangar.sqf";
	[] call NTA_fnc_initServer;
	//[] call nta_fnc_inidb_init;

};

//[] call NTA_fnc_initServer;
