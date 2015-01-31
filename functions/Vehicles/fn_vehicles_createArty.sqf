/*
	Author: Ir0n1E

	Description:
	Creates Arty emplacement

	Parameter(s):
	#0 ARRAY 	- Position
	#1 NUMBER	- Direction
	#2 BOOL		- autofire

	Returns:
	ARRAY - [objects, units, arty]
*/

private ["_pos", "_dir", "_units", "_grp", "_unit", "_obj", "_side", "_newPos", "_objects", "_arty"];

_pos 		= _this select 0;
_dir 		= _this select 1;
_autoFire	= _this select 2;

_units 		= [];
_objects 	= [];

_grp 		= createGroup EAST;
_unit 		= createvehicle ["O_MBT_02_arty_F", _pos, [], 0, "None"];

_unit allowdammage false;
_unit setpos _pos;
_unit setdir _dir;
_unit setFuel 0;
[_unit] joinSilent _grp;
_arty = _unit;
if (_autofire) then {
	[_unit] call NTA_fnc_vehicles_artydoFire;
};

_units pushback _unit;

_units = _units + ([_unit, _grp] call BIS_fnc_spawnCrew);
_grp setFormDir _dir;

{
	_x setskill 1;
	_x setCombatMode "RED";
} foreach (units _grp);




_newPos = [getposATL _unit, 5.5, _dir + 90] call BIS_fnc_relPos;
_obj = "Land_HBarrier_5_F" createvehicle [0,0,0];
_obj setposATL _newPos;
_obj setdir (_dir + 90) ;
_objects pushBack _obj;

_newpos = [getposATL _unit, -5.5, _dir + 90 ] call BIS_fnc_relPos;
_obj = "Land_HBarrier_5_F" createvehicle _newPos;

_obj setposATL _newPos;
_obj setdir (_dir + 90 );
_objects pushBack _obj;

_newpos = [getposATL _unit, 3.5, _dir ] call BIS_fnc_relPos;
_obj = "Land_HBarrier_5_F" createvehicle _newPos;

_obj setposATL _newPos;
_obj setdir _dir;
_objects pushBack _obj;

_newPos = [getposASL _unit, -5, getdir _unit] call BIS_fnc_relPos;
_obj = "CamoNet_OPFOR_big_F" createvehicle [0,0,0];
_obj setposASL _newPos;
_obj setdir (_dir +195);
_objects pushBack _obj;

_newPos = [getposATL _unit, 10, _dir +180 ] call BIS_fnc_relPos;
_grp = createGroup EAST;
_grp = [ _newPos, EAST, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam")] call BIS_fnc_spawnGroup;
[_grp, '', _newPos, "LIMITED", "HOLD", "SAFE"] call NTA_fnc_vehicles_addwaypoint;
_grp setFormDir _dir;

{
	_units pushback _x;
} foreach (units _grp);
_arty allowdammage true;

[_objects, _units, _arty]