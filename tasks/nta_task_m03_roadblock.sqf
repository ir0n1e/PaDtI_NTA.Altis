

private ["_grp","_grp1","_grp2","_grp3","_grp4","_objlist",
		"_marker_town","_del_marker","_marker","_pos","_object",
		"_heli1","_tank1","_tank2","_tank3","_hmg1","_hmg2"];



_grp = createGroup east;
_grp2 = createGroup east;
_grp3 = createGroup east;
_grp4 = createGroup east;
_objlist = [];
_markers = [];
_marker_town = createMarker ["town",[20620.5,11706.6]];
_marker_town setMarkerSize [1000,1000];
_markers pushBack _marker_town;
_del_marker = createMarker ["delete", [20620.5,11706.6]];
_markers pushBack _del_marker;


PO3_TASK__POS	= getmarkerpos "delete";
PO3_TASK__IDD	= format["%1%2:%3",round(PO3_TASK__POS select 0),round(PO3_TASK__POS select 1),(round random 99)];
PO3_TOTAL_UNITS = [];
PO3_TOTAL_VEHICLES = [];



_pos = [20091.015625,12001.169922,-0.115654];
_object = createVehicle ["Land_HBarrier_5_F", _pos, [], 0, "CAN_COLLIDE"];
_object setDir 0;
_object setPosATL _pos;
_object enableSimulation false;
_objlist pushback _object;

_pos = [20094.322266,11998.876953,-0.506554];
_object = createVehicle ["Land_HBarrier_5_F", _pos, [], 0, "CAN_COLLIDE"];
_object setDir 89.9999;
_object setPosATL _pos;
_object enableSimulation false;
_object setVehicleVarName "test";
_objlist pushback _object;

_pos = [20087.259766,11999.474609,-0.803467];
_object = createVehicle ["Land_HBarrier_5_F", _pos, [], 0, "CAN_COLLIDE"];
_object setDir 89.9999;
_object setPosATL _pos;
_object enableSimulation false;
_objlist pushback _object;

_pos = [20089.279297,12001.114258,0.237236];
_object = createVehicle ["Land_HBarrier_5_F", _pos, [], 0, "CAN_COLLIDE"];
_object setDir 0;
_object setPosATL _pos;
_object enableSimulation false;
_objlist pushback _object;

_pos = [20093.287109,12001.102539,0.327141];
_object = createVehicle ["Land_HBarrier_3_F", _pos, [], 0, "CAN_COLLIDE"];
_object setDir 0;
_object setPosATL _pos;
_object enableSimulation false;
_objlist pushback _object;

_pos = [20087.136719,11995.0185547,-0.222221];
_object = createVehicle ["Land_HBarrier_3_F", _pos, [], 0, "CAN_COLLIDE"];
_object setDir 89.9999;
_object setPosATL _pos;
_object enableSimulation false;
_objlist pushback _object;


_pos = [20094.419922,11994.331055,-0.0675812];
_object = createVehicle ["Land_HBarrier_3_F", _pos, [], 0, "CAN_COLLIDE"];
_object setDir 89.9999;
_object setPosATL _pos;
_object enableSimulation false;
_objlist pushback _object;


_pos = [20094.419922,11994.331055,-0.0675812];
_object = createVehicle ["Land_HBarrier_3_F", _pos, [], 0, "CAN_COLLIDE"];
_object setDir 89.9999;
_object setPosATL _pos;
_object enableSimulation false;
_objlist pushback _object;

_pos = [20094.419922,11994.331055,-0.0675812];
_object = createVehicle ["Land_HBarrier_3_F", _pos, [], 0, "CAN_COLLIDE"];
_object setDir 89.9999;
_object setPosATL _pos;
_object enableSimulation false;
_objlist pushback _object;





_pos = [20102.755859,11756.0683594,0];
_object = createVehicle ["Land_HelipadSquare_F", _pos, [], 0, "CAN_COLLIDE"];
_object setDir 0;
_object setPosATL _pos;
_object enableSimulation false;
_objlist pushback _object;




_pos = [20064.189453,11989.72168,-0.345551];
_object = createVehicle ["Land_HBarrier_Big_F", _pos, [], 0, "CAN_COLLIDE"];
_object setDir 360;
_object setPosATL _pos;
_object enableSimulation false;
_objlist pushback _object;

_pos = [20067.675781,11986.106445,-0.764999];
_object = createVehicle ["Land_HBarrier_Big_F", _pos, [], 0, "CAN_COLLIDE"];
_object setDir 90.9999;
_object setPosATL _pos;
_object enableSimulation false;
_objlist pushback _object;


_pos = [20060.869141,11985.729492,-0.659019];
_object = createVehicle ["Land_HBarrier_Big_F", _pos, [], 0, "CAN_COLLIDE"];
_object setDir 90.9999;
_object setPosATL _pos;
_object enableSimulation false;
_skill = 0.75;
_objlist pushback _object;



_side = createCenter EAST;

_pos = [20090.7,11997.6,-0.0759506];
_tank1 = createVehicle ["O_MBT_02_cannon_F", _pos, [], 0, "CAN_COLLIDE"];
_objlist pushback _tank1;
_tank1 setDir 0;
_tank1 setPosATL _pos;
_crew = [ _tank1, _grp2 ] call bis_fnc_spawncrew;

{
	PO3_TOTAL_UNITS pushBack _x;
} forEach (units _grp2);

_null=[leader _grp2,_marker_town,"nomove","nowp3","spawned","combat"] execVM "scripts\UPSMON.sqf";
gunner _tank1 setUnitAbility 1;
gunner _tank1 setskill _skill;
gunner _tank1 setSkill ["spotDistance", 1];
gunner _tank1 setSkill ["spotTime", 1];
commander _tank1 setUnitAbility 1;
commander _tank1 setskill _skill;
commander _tank1 setSkill ["spotDistance", 1];
commander _tank1 setSkill ["spotTime", 1];

_pos = [20064.2,11985.9,0.412094];

_tank2 = createVehicle ["O_MBT_02_cannon_F", _pos, [], 0, "CAN_COLLIDE"];
_tank2 setDir 0;
_tank2 setPosATL _pos;
_crew = [ _tank2, _grp ] call bis_fnc_spawncrew;
{
	PO3_TOTAL_UNITS pushBack _x;
} forEach (units _grp);

_null=[leader _grp, _marker_town ,"NOMOVE","NOWP3","spawned","combat"] execVM "scripts\UPSMON.sqf";
_objlist pushback _tank2;
gunner _tank2 setUnitAbility 1;
gunner _tank2 setskill _skill;
gunner _tank2 setSkill ["spotDistance", 1];
gunner _tank2 setSkill ["spotTime", 1];
commander _tank1 setUnitAbility 1;
commander _tank1 setskill _skill;
commander _tank1 setSkill ["spotDistance", 1];
commander _tank1 setSkill ["spotTime", 1];
_pos = [20064.228516,11984.731445,-1.3251];
_object = createVehicle ["CamoNet_OPFOR_big_F", _pos, [], 0, "CAN_COLLIDE"];
_object setDir 180;
_object setPosATL _pos;
_object enableSimulation false;
_object allowDamage true;
_objlist pushback _object;

_pos = [20084.244141,11744.183594,0.0405273];
_object = createVehicle ["CamoNet_OPFOR_F", _pos, [], 0, "CAN_COLLIDE"];
_object setDir 20;
_object setPosATL _pos;
_object enableSimulation false;
_object allowDamage true;
_objlist pushback _object;
_pos = [20090.7,11997.6,-0.0759506];
_object = createVehicle ["CamoNet_OPFOR_big_F", _pos, [], 0, "CAN_COLLIDE"];
_object setDir 190;
_object setPosATL _pos;
_object enableSimulation false;
_object allowDamage true;
_objlist pushback _object;

_pos = [20379.6,11739.2,0.00120926];
_tank3 = createVehicle ["O_MBT_02_cannon_F", _pos, [], 0, "CAN_COLLIDE"];
_tank3 setDir 0;
_tank3 setPosATL _pos;
_crew = [ _tank3, _grp3 ] call bis_fnc_spawncrew;
{
	PO3_TOTAL_UNITS pushBack _x;
} forEach (units _grp3);
_marker = createMarker ["Marker5", _pos];

sleep 2;
_tank3 setDamage 0;
_null=[leader _grp3,_marker_town ,"NOMOVE","NOWP3","spawned"] execVM "scripts\UPSMON.sqf";
_objlist pushback _tank3;
gunner _tank3 setUnitAbility 1;
gunner _tank3 setskill _skill;
gunner _tank3 setSkill ["spotDistance", 1];
gunner _tank3 setSkill ["spotTime", 1];
commander _tank3 setUnitAbility 1;
commander _tank3 setskill _skill;
commander _tank3 setSkill ["spotDistance", 1];
commander _tank3 setSkill ["spotTime", 1];



_grp = createGroup EAST;
_pos = [20646.511719,11887.376953,4.38889];
_hmg1 = createVehicle ["O_HMG_01_high_F", _pos, [], 0, "CAN_COLLIDE"];
_objlist pushback _hmg1;
_hmg1 setDir 99.9999;
_hmg1 setPosATL _pos;
_crew = [ _hmg1, _grp ] call bis_fnc_spawncrew;
{
	PO3_TOTAL_UNITS pushBack _x;
} forEach (units _grp);
_null=[leader _grp,_marker_town,"nomove","nowp3","spawned"] execVM "scripts\UPSMON.sqf";

_pos = [19905.25,11871.177734,4.46837];
_hmg2 = createVehicle ["O_HMG_01_high_F", _pos, [], 0, "CAN_COLLIDE"];
_objlist pushback _hmg2;
_hmg2 setDir 270;
_hmg2 setPosATL _pos;
_crew = [ _hmg2, _grp ] call bis_fnc_spawncrew;
{
	PO3_TOTAL_UNITS pushBack _x;
} forEach (units _grp);
_null=[leader _grp,_marker_town,"nomove","nowp3","spawned"] execVM "scripts\UPSMON.sqf";
_marker = getMarkerPos "patrol1";
_marksize = getMarkerSize "patrol1";



//Mines
_marker = createMarker ["patrol1",[19864.1,11806.9,0]];
_marker setMarkerSize [50,50];
_markerpos = getmarkerpos _marker;
_markers pushBack _marker;

_group1 = [_markerpos, _side, (configFile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam_AT")] Call BIS_fnc_spawnGroup;
{
	PO3_TOTAL_UNITS pushBack _x;
} forEach (units _group1);
_null=[leader _group1,_marker,"random","ambush","SPAWNED" ] execVM "scripts\UPSMON.sqf";

_marker = createMarker ["patrol2",[20934.2,12274.3,0]];
_marker setMarkerSize [50,50];
_markerpos = getmarkerpos _marker;

_group2 = [_markerpos, _side, (configFile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam_AT")] Call BIS_fnc_spawnGroup;
{
	PO3_TOTAL_UNITS pushBack _x;
} forEach (units _group2);
_null=[leader _group2,_marker, "ambush", "SPAWNED" ] execVM "scripts\UPSMON.sqf";



//mortar
_grp = createGroup EAST;
_pos = [20048.5,11982.9,0.00154114];
_mortar = createVehicle ["O_Mortar_01_F", _pos, [], 0, "CAN_COLLIDE"];
_objlist pushback _mortar;
_mortar setDir 250.19;
_mortar setPosATL _pos;
_mortar setName "MORTAR2";
_marker = createMarker ["Marker2", _pos];
_markers pushBack _marker;

_crew = [ _mortar, _grp ] call bis_fnc_spawncrew;
{
	PO3_TOTAL_UNITS pushBack _x;
} forEach (units _grp);

gunner _mortar setUnitAbility 1;
gunner _mortar setskill 1;
gunner _mortar setSkill ["spotDistance", 1];
gunner _mortar setSkill ["spotTime", 1];

gunner _mortar setCombatMode "RED";
gunner _mortar setBehaviour "COMBAT";

0 = [leader _grp] execVM "scripts\UPSMON\MON_artillery_add.sqf";
_skill = 0.75;




_markerpos = getMarkerPos _marker;
for "_i" from 1 to 4 do {
	_grp = createGroup EAST;
	_grp = [_markerpos, _side, (configFile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam")] Call BIS_fnc_spawnGroup;
	{
		PO3_TOTAL_UNITS pushBack _x;
	} forEach (units _grp);
	_null=[leader _grp,"town","random","SPAWNED"] execVM "scripts\UPSMON.sqf";
	//_null=[leader _grp,_marker, "prefix:", house, "randomup","max:",10, "showmarker"] execVM "UPS.sqf";
};
_marker = createMarker ["town_inner",[20228.5,11676.6,0]];
_marker setMarkerSize [200,200];
_markerpos = getMarkerPos _marker;
_markers pushBack _marker;

for "_i" from 1 to 3 do {
	_grp = createGroup EAST;
	_grp = [_markerpos, _side, (configFile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam")] Call BIS_fnc_spawnGroup;
	{
		PO3_TOTAL_UNITS pushBack _x;
	} forEach (units _grp);
	_null=[leader _grp,_marker,"random","SPAWNED"] execVM "scripts\UPSMON.sqf";
};

_pos = [20102.929688,11755.605469,0.019104];
_heli1 = createVehicle ["O_Heli_Attack_02_F", _pos, [], 0, "CAN_COLLIDE"];
_objlist pushback _heli1;
_heli1 setDir 0;
_heli1 setPosATL _pos;
sleep 2;
_heli1 setDamage 0;

_crew = [ _heli1, _grp4 ] call bis_fnc_spawncrew;
{
	PO3_TOTAL_UNITS pushBack _x;
} forEach (units _grp4);
_null=[leader _grp4,_marker_town,"nowp","SPAWNED"] execVM "scripts\UPSMON.sqf";
PO3_TOTAL_VEHICLES 	= _objlist;


[ format["TASK%1",PO3_TASK__IDD],
		localize "STR_PO3_M23_TITLE",
		format[ localize "STR_PO3_M23_DESCR",PO3_TASK__IDD,(PO3_side_3 select 2)],
		(PO3_side_1 select 0),
		[format["MRKR%1",PO3_TASK__IDD],PO3_TASK__POS,"mil_objective",(PO3_side_3 select 0) call PO3_fnc_getUnitMarkerColour,localize "STR_PO3_M23_TITLE"],
		"assigned",
		PO3_TASK__POS,
		localize "STR_PO3_M23_TITLE"
	] call PO3_fnc_addTask;

waitUntil {{alive _x} count PO3_TOTAL_UNITS <= 5 && {!alive _tank1} && {!alive _tank2}};
sleep 1;
	[format["TASK%1",PO3_TASK__IDD],"succeeded"] call PO3_fnc_updateTask;

sleep 5;

[_pos,PO3_TOTAL_UNITS, PO3_TOTAL_VEHICLES] spawn {
	private["_target","_units","_vehicles"];

	_target = _this select 0;
	_units = _this select 1;
	_vehicles = _this select 2;

	waitUntil { count ([_target,500,(PO3_side_1 select 0),["CAManBase"]] call PO3_fnc_getNearbyPlayers) == 0 };

	{ if(alive _x) then { deletevehicle _x }; }forEach _units;
	{ if( {isPlayer _x} count (crew _x) == 0 ) then { deletevehicle _x }; }forEach _vehicles;
};
{
	deletemarker _x;
} foreach _markers;

if(true) exitWith {};



//deleteMarker _marker;
//deleteMarker _marker_town;