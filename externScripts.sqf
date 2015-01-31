

call compile preprocessfilelinenumbers "scripts\shk_taskmaster.sqf";



if (("NTA_LIGHTS" call bis_fnc_getParamValue) > 0) then {
	nul=[] execVM "IntLight.sqf";
};

if (("NTA_Cache" call bis_fnc_getParamValue) > 0) then {
	[1800,-1,false,1800]execvm "zbe_cache\main.sqf";
};




//0 = [true] execVM "Scripts\zlt_fieldrepair.sqf";
//0 = [3] execvm "tpwcas\tpwcas_script_init.sqf";



if !(isClass(configFile/"CfgPatches"/"AGM_Logistics")) then {
	_igiload = [] execVM "scripts\IgiLoad\IgiLoadInit.sqf";
};
/*if (isserver) then {
	//["PO3_taskmaster"] call PO3_fnc_runTaskSequence;
	PO3_Taskrun = compile preprocessfilelinenumbers "tasks\po3_taskmaster.sqf";
*/
