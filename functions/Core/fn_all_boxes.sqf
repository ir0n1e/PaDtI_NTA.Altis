if (!isserver || isnil "ammo_at1") exitwith {};
private ["_ammo_at", "_ammo_auto", "_ammo_crew", "_engineer","_ammo_exp","_ammo_gren","_ammo_jtac","_ammo_leader","_ammo_medic","_ammo_sniper", "_time"];
"Starting Playerboxes Init" call NTA_fnc_log;
_time = diag_ticktime;

_ammo_at 		= ["ammo_at1", "ammo_at2", "ammo_at3", "ammo_at4"];
_ammo_auto 		= ["ammo_auto1", "ammo_auto2", "ammo_auto3", "ammo_auto4", "ammo_auto5"];
_ammo_crew 		= ["ammo_crew1", "ammo_crew2", "ammo_crew3", "ammo_crew4", "ammo_crew5"];
_ammo_engineer 	= ["ammo_engineer1", "ammo_engineer2", "ammo_engineer3", "ammo_engineer4", "ammo_engineer5"];
_ammo_exp 		= ["ammo_exp1"];
_ammo_gren 		= ["ammo_gren1", "ammo_gren2", "ammo_gren3", "ammo_gren4", "ammo_gren5"];
_ammo_jtac 		= ["ammo_jtac1", "ammo_jtac2", "ammo_jtac3"];
_ammo_leader 	= ["ammo_leader1", "ammo_leader2", "ammo_leader3", "ammo_leader4", "ammo_leader5", "ammo_leader6"];
_ammo_medic 	= ["ammo_medic1", "ammo_medic2", "ammo_medic3", "ammo_medic4"];
_ammo_sniper 	= ["ammo_sniper1", "ammo_sniper2"];


{
 	call compile format ["%1 setvariable ['CrateFnc', 'NTA_fnc_crate_at', true]", _x];
} foreach _ammo_at;

{
 	call compile format ["%1 setvariable ['CrateFnc', 'NTA_fnc_crate_auto', true]", _x];
} foreach _ammo_auto;
{
 	call compile format ["%1 setvariable ['CrateFnc', 'NTA_fnc_crate_crew', true]", _x];
} foreach _ammo_crew;
{
 	call compile format ["%1 setvariable ['CrateFnc', 'NTA_fnc_crate_engineer', true]", _x];
} foreach _ammo_engineer;
{
 	call compile format ["%1 setvariable ['CrateFnc', 'NTA_fnc_crate_exp', true]", _x];
} foreach _ammo_exp;
{
 	call compile format ["%1 setvariable ['CrateFnc', 'NTA_fnc_crate_gren', true]", _x];
} foreach _ammo_gren;
{
 	call compile format ["%1 setvariable ['CrateFnc', 'NTA_fnc_crate_jtac', true]", _x];
} foreach _ammo_jtac;
{
 	call compile format ["%1 setvariable ['CrateFnc', 'NTA_fnc_crate_leader', true]", _x];
} foreach _ammo_leader;
{
 	call compile format ["%1 setvariable ['CrateFnc', 'NTA_fnc_crate_medic', true]", _x];
} foreach _ammo_medic;
{
 	call compile format ["%1 setvariable ['CrateFnc', 'NTA_fnc_crate_sniper', true]", _x];
} foreach _ammo_sniper;

NTA_PALAYERBOXES = true;
publicVariable "NTA_PALAYERBOXES";
format ["Playerboxes Init done... %1", diag_ticktime - _time] call NTA_fnc_log;