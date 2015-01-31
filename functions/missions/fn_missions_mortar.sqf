



_markers = [];
_marker = createmarker ["Artistellung",[21023.9,9179.55,0]];
_marker setMarkerSize [60,60];
_markers pushBack _marker;

_marker = createmarker ["Artistellung_sniper",[20806.3,9311.38,0]];
_marker setMarkerSize [80,80];
_markers pushBack _marker;

_marker = createmarker ["Artistellung_patrol1",[20549.8,8795.51,0]];
_marker setMarkerSize [200,200];
_markers pushBack _marker;

_marker = createmarker ["Artistellung_patrol2",[21844.8,8811.51,0]];
_marker setMarkerSize [100,100];
_markers pushBack _marker;

PO3_TASK__POS	= getmarkerpos "Artistellung_patrol2";
PO3_TASK__IDD	= format["%1%2:%3",round(PO3_TASK__POS select 0),round(PO3_TASK__POS select 1),(round random 99)];
PO3_TOTAL_UNITS = [];
PO3_TOTAL_VEHICLES = [];

_objlist = [];
_pos = [20994.990234,9165.448242,-0.199448];
_object = createVehicle ["Land_BagFence_Long_F", _pos, [], 0, "CAN_COLLIDE"];
_object setDir 50;
_object setPosATL _pos;
_object enableSimulation false;
_objlist pushback _object;

_pos = [20993.164063,9167.631836,-0.136124];
_object = createVehicle ["Land_BagFence_Long_F", _pos, [], 0, "CAN_COLLIDE"];
_object setDir 55;
_object setPosATL _pos;
_object enableSimulation false;
_objlist pushback _object;

_pos = [20991.5625,9169.797852,-0.229965];
_object = createVehicle ["Land_BagFence_Long_F", _pos, [], 0, "CAN_COLLIDE"];
_object setDir 70;
_object setPosATL _pos;
_object enableSimulation false;
_objlist pushback _object;

_pos = [20990.96875,9171.857422,-0.204506];
_object = createVehicle ["Land_BagFence_Long_F", _pos, [], 0, "CAN_COLLIDE"];
_object setDir 80;
_object setPosATL _pos;
_object enableSimulation false;
_objlist pushback _object;

_pos = [21017.984375,9172.273438,-0.0987854];
_object = createVehicle ["Land_BagFence_Long_F", _pos, [], 0, "CAN_COLLIDE"];
_object setDir 50;
_object setPosATL _pos;
_object enableSimulation false;
_objlist pushback _object;

_pos = [21019.535156,9170.400391,-0.0958176];
_object = createVehicle ["Land_BagFence_Long_F", _pos, [], 0, "CAN_COLLIDE"];
_object setDir 50;
_object setPosATL _pos;
_object enableSimulation false;
_objlist pushback _object;

_pos = [21021.417969,9170.217773,-0.0398026];
_object = createVehicle ["Land_BagFence_Long_F", _pos, [], 0, "CAN_COLLIDE"];
_object setDir 320;
_object setPosATL _pos;
_object enableSimulation false;
_objlist pushback _object;

_pos = [21023.316406,9171.849609,-0.116379];
_object = createVehicle ["Land_BagFence_Long_F", _pos, [], 0, "CAN_COLLIDE"];
_object setDir 320;
_object setPosATL _pos;
_object enableSimulation false;
_objlist pushback _object;

_pos = [21016.226563,9174.399414,-0.0696487];
_object = createVehicle ["Land_BagFence_Long_F", _pos, [], 0, "CAN_COLLIDE"];
_object setDir 50;
_object setPosATL _pos;
_object enableSimulation false;
_objlist pushback _object;

_pos = [21016.574219,9176.258789,-0.0760727];
_object = createVehicle ["Land_BagFence_Long_F", _pos, [], 0, "CAN_COLLIDE"];
_object setDir 320;
_object setPosATL _pos;
_object enableSimulation false;
_objlist pushback _object;

_pos = [21017.943359,9177.373047,-0.0819855];
_object = createVehicle ["Land_BagFence_Long_F", _pos, [], 0, "CAN_COLLIDE"];
_object setDir 320;
_object setPosATL _pos;
_object enableSimulation false;
_objlist pushback _object;



_pos = [21046.425781,9216.731445,0.00569153];
_object = createVehicle ["Land_BagBunker_Small_F", _pos, [], 0, "CAN_COLLIDE"];
_object setDir 170;
_object setPosATL _pos;
[_object, 0, -0] call BIS_fnc_setPitchBank;
_object enableSimulation false;
_objlist pushback _object;

_pos = [21051.744141,9206.833984,-0.30983];
_object = createVehicle ["Land_BagBunker_Small_F", _pos, [], 0, "CAN_COLLIDE"];
_object setDir 280;
_object setPosATL _pos;
[_object, 10, -2.26489e-005] call BIS_fnc_setPitchBank;
_object enableSimulation false;
_objlist pushback _object;




_pos = [21008.794922,9162.481445,-0.531685];
_object = createVehicle ["Land_BagBunker_Tower_F", _pos, [], 0, "CAN_COLLIDE"];
_object setDir 40;
_object setPosATL _pos;
_object enableSimulation false;
_objlist pushback _object;


_pos = [21045.117188,9216.43457,-0.00389099];
_object = createVehicle ["CamoNet_OPFOR_Curator_F", _pos, [], 0, "CAN_COLLIDE"];
_object setDir 210;
_object setPosATL _pos;
[_object, 10, 6.50208e-006] call BIS_fnc_setPitchBank;
_object enableSimulation false;
_objlist pushback _object;

_pos = [21051.257813,9206.810547,-0.044838];
_object = createVehicle ["CamoNet_OPFOR_Curator_F", _pos, [], 0, "CAN_COLLIDE"];
_object setDir 240;
_object setPosATL _pos;
[_object, 10, -3.68451e-005] call BIS_fnc_setPitchBank;
_object enableSimulation false;
_objlist pushback _object;



_grp = createGroup east;
_skill = 0.75;
_pos = [21022.248047,9173.801758,-0.00778961];
_object = createVehicle ["O_static_AA_F", _pos, [], 0, "CAN_COLLIDE"];
_object setDir 169.895;
_object setPosATL _pos;
_object setName "AA1";
_marker = createMarker ["Marker5", _pos];
_markers pushBack _marker;

_crew = [ _object, _grp ] call bis_fnc_spawncrew;

_null=[leader _grp,_marker,"showmarker","track" ] execVM "scripts\UPSMON.sqf";
_objlist pushback _object;

_pos = [21005.316406,9158.950195,-0.0116119];
_object = createVehicle ["O_GMG_01_high_F", _pos, [], 0, "CAN_COLLIDE"];
_object setDir 228.928;
_object setPosATL _pos;
_object setName "GMG1";
_marker = createMarker ["Marker4", _pos];
_markers pushBack _marker;
_crew = [ _object, _grp ] call bis_fnc_spawncrew;
_objlist pushback _object;

_null=[leader _grp,_marker,"showmarker","track" ] execVM "scripts\UPSMON.sqf";

_pos = [21046.486328,9217.374023,-0.0492172];
_object = createVehicle ["O_HMG_01_high_F", _pos, [], 0, "CAN_COLLIDE"];
_object setDir 0;
_object setPosATL _pos;
[_object, 0, 0] call BIS_fnc_setPitchBank;
_objlist pushback _object;

_crew = [ _object, _grp ] call bis_fnc_spawncrew;

_null=[leader _grp,_marker,"showmarker","track" ] execVM "scripts\UPSMON.sqf";


_pos = [20545.105469,9452.641602,3.66931];
_object = createVehicle ["O_HMG_01_high_F", _pos, [], 0, "CAN_COLLIDE"];
_object setDir 40;
_object setPosATL _pos;
[_object, 0, 0] call BIS_fnc_setPitchBank;
_crew = [ _object, _grp ] call bis_fnc_spawncrew;
_objlist pushback _object;

_null=[leader _grp,_marker,"showmarker","track" ] execVM "scripts\UPSMON.sqf";


_pos = [21007.253906,9161.84668,2.53232];
_object = createVehicle ["O_HMG_01_high_F", _pos, [], 0, "CAN_COLLIDE"];
_object setDir 240;
_object setPosATL _pos;
_objlist pushback _object;


_crew = [ _object, _grp ] call bis_fnc_spawncrew;

_null=[leader _grp,_marker,"showmarker","track" ] execVM "scripts\UPSMON.sqf";


_pos = [21020.814453,9172.18457,0.0510712];
_mortar2 = createVehicle ["O_Mortar_01_F", _pos, [], 0, "CAN_COLLIDE"];
_mortar2 setDir 200.281;
_mortar2 setPosATL _pos;
_marker = createMarker ["Marker3", _pos];
_crew = [ _mortar2, _grp ] call bis_fnc_spawncrew;
{_x setSkill _skill} forEach units _grp;
gunner _mortar2 setUnitAbility 1;
gunner _mortar2 setskill 1;
gunner _mortar2 setSkill ["spotDistance", 1];
gunner _mortar2 setSkill ["spotTime", 1];

gunner _mortar2 setCombatMode "RED";
gunner _mortar2 setBehaviour "COMBAT";
0 = [leader _grp] execVM "scripts\UPSMON\MON_artillery_add.sqf";


_null=[leader _grp,_marker,"showmarker","track" ] execVM "scripts\UPSMON.sqf";


_pos = [21020.160156,9173.87793,0.0562592];
_mortar1 = createVehicle ["O_Mortar_01_F", _pos, [], 0, "CAN_COLLIDE"];
_mortar1 setDir 250.19;
_mortar1 setPosATL _pos;
_mortar1 setName "MORTAR2";
_marker = createMarker ["Marker2", _pos];
_crew = [ _mortar1, _grp ] call bis_fnc_spawncrew;

gunner _mortar1 setUnitAbility 1;
gunner _mortar1 setskill 1;
gunner _mortar1 setSkill ["spotDistance", 1];
gunner _mortar1 setSkill ["spotTime", 1];
gunner _mortar1 setCombatMode "RED";
gunner _mortar1 setBehaviour "COMBAT";


0 = [leader _grp] execVM "scripts\UPSMON\MON_artillery_add.sqf";


_pos = [21035.712891,9194.838867,0.00683594];
_object = createVehicle ["O_Mortar_01_F", _pos, [], 0, "CAN_COLLIDE"];
_object setDir 0;
_object setPosATL _pos;
[_object, 0, 0] call BIS_fnc_setPitchBank;
_objlist pushback _object;





_pos = [21029.308594,9189.898438,0.0096817];
_object = createVehicle ["O_Mortar_01_F", _pos, [], 0, "CAN_COLLIDE"];
_object setDir 0;
_object setPosATL _pos;
[_object, 0, 0] call BIS_fnc_setPitchBank;
_objlist pushback _object;


_pos = [21004.740234,9163.119141,1.64218];
_object = createVehicle ["O_HMG_01_high_F", _pos, [], 0, "CAN_COLLIDE"];
_object setDir 250;
_object setPosATL _pos;
[_object, -10, -5.28836e-005] call BIS_fnc_setPitchBank;
_objlist pushback _object;

_crew = [ _object, _grp ] call bis_fnc_spawncrew;
{_x setSkill _skill} forEach units _grp;
_null=[leader _grp,_marker ] execVM "scripts\UPSMON.sqf";

_pos = [21000.3,9181.58,0.00185394];
_object = createVehicle ["O_HMG_01_high_F", _pos, [], 0, "CAN_COLLIDE"];
_object setDir 290;
_object setPosATL _pos;
_object setName "HMG1";
_marker = createMarker ["Marker6", _pos];
_crew = [ _object, _grp ] call bis_fnc_spawncrew;
{_x setSkill _skill} forEach units _grp;
_null=[leader _grp,_marker ] execVM "scripts\UPSMON.sqf";
_objlist pushback _object;






_marker = getMarkerPos "Artistellung";
_marksize = getMarkerSize "Artistellung";
_side = createCenter EAST;

_group = [_marker, _side, (configFile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfSquad")] Call BIS_fnc_spawnGroup;
{_x setSkill _skill} forEach units _group;
_null=[leader _group,"Artistellung","random","fortify",  "min:",1,"max:",1] execVM "scripts\UPSMON.sqf";
//_null=[leader _grp,_marker, "prefix:", house, "randomup","max:",10, "showmarker"] execVM "UPS.sqf";


_group = [_marker, _side, (configFile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OI_SniperTeam")] Call BIS_fnc_spawnGroup;
{_x setSkill _skill} forEach units _group;
_null=[leader _group,"Artistellung_sniper","random",  "min:",1,"max:",1] execVM "scripts\UPSMON.sqf";

_group = [_marker, _side, (configFile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OI_reconPatrol")] Call BIS_fnc_spawnGroup;
{_x setSkill _skill} forEach units _group;
_null=[leader _group,"Artistellung_patrol1","random",  "min:",1,"max:",1] execVM "scripts\UPSMON.sqf";
_group = [_marker, _side, (configFile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OI_reconPatrol")] Call BIS_fnc_spawnGroup;
{_x setSkill _skill} forEach units _group;
_null=[leader _group,"Artistellung_patrol2","random",  "min:",1,"max:",1] execVM "scripts\UPSMON.sqf";




waitUntil {alive _mortar1 && alive _mortar2};

PO3_TOTAL_UNITS 	= _objlist;
PO3_TOTAL_VEHICLES 	= [];

[ format["TASK%1",PO3_TASK__IDD],
		localize "STR_PO3_M22_TITLE",
		format[ localize "STR_PO3_M22_DESCR",PO3_TASK__IDD,(PO3_side_3 select 2)],
		(PO3_side_1 select 0),
		[format["MRKR%1",PO3_TASK__IDD],PO3_TASK__POS,"mil_objective",(PO3_side_3 select 0) call PO3_fnc_getUnitMarkerColour,localize "STR_PO3_M22_TITLE"],
		"assigned",
		PO3_TASK__POS,
		localize "STR_PO3_M21_TITLE"
	] call PO3_fnc_addTask;

waitUntil {!(alive _mortar1 && alive _mortar2)};

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
} foreach _m;

if(true) exitWith {};