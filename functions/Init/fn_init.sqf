private "_time";
_time = diag_ticktime;

"Starting Main Initialisation..." call NTA_fnc_log;
NTA_DEBUG	= false;
publicvariable "NTA_DEBUG";
NTA_MOLOS 	= true;
nopop 		= true;

enableSaving [false, false];
enableTeamswitch false;
enableEngineArtillery true;
enableSentences false;

0 = [] execvm "externScripts.sqf";
if (("NTA_Weather" call bis_fnc_getParamValue) > 0) then {
	[] call NTA_fnc_weather;
};

call NTA_fnc_taskforce_init;
// moved to description.ext
//call NTA_fnc_agmmedsys_init;
call NTA_fnc_RAVlifter_init;

if (NTA_DEBUG) then {
	OnMapSingleClick "vehicle player SetPos [_pos select 0, _pos select 1, if( (vehicle player) isKindof ""AIR"" && isEngineOn (vehicle player) ) then { 100 }else{ 0 } ]";
	player allowDamage false;
};

NTA_mainINIT = true;
publicvariable "NTA_mainINIT";

format ["Main Initialisation Done... %1", diag_ticktime - _time] call NTA_fnc_log;