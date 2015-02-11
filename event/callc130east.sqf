private ["_csatplane_wp", "_c130", "_infgrp", "_infWP", "_count", "_users", "_plane", "_man", "_side"];

_csatplane_wp 	= _this select 0;
_users 			= _this select 1;
_side			= _this select 2;
_count 			= _this select 3;

_plane = "B_Heli_Transport_03_F";
_speed = "FULL";

if (isclass (configfile >> "CfgPatches" >> "sab_C130")) then {
	_plane = "sab_C130_JE";
	_speed = "LIMITED";
};

_man  = "B_soldier_PG_F";
if (isclass (configfile >> "CfgPatches" >> "rhsusf_infantry")) then {
	_man = "rhsusf_army_ocp_riflemanl";
};

_c130 = [_plane, _csatplane_wp select 0, 0, _side] call NTA_fnc_vehicles_create;
_c130 flyInHeight 180;

[group _c130, '', _csatplane_wp select 0, "FULL", "MOVE", "CARELESS", "BLUE"] call NTA_fnc_vehicles_addwaypoint;
[group _c130, '', _csatplane_wp select 1, _speed, "MOVE", "CARELESS", "BLUE", ["true", "{_x flyInHeight 180} forEach thislist"]] call NTA_fnc_vehicles_addwaypoint;
[group _c130, '', _csatplane_wp select 2, _speed, "MOVE", "CARELESS", "BLUE"] call NTA_fnc_vehicles_addwaypoint;
[group _c130, '', _csatplane_wp select 3, "FULL", "MOVE", "CARELESS", "BLUE", ["true", "{[_x] call NTA_fnc_vehicles_delete} forEach thislist"]] call NTA_fnc_vehicles_addwaypoint;


_seats 	= getNumber (configfile >> "CfgVehicles" >> _plane >> "transportsoldier");

_infgrp = createGroup _side;

for "_i" from 0 to (_seats - (count _users) min _count) - 1 do {
	_man createUnit [[0,0,0], _infgrp];
};

{
	systemchat str _foreachIndex;
	[[_x, _c130, _foreachIndex + 1], "NTA_fnc_airpatrol_movein", _x] call bis_fnc_mp;
	removeBackpackGlobal _x;
	_x addBackpackGlobal "B_Parachute";

} foreach _users + (units _infgrp);


//_infWP = AIRFIELD_Markers select (floor(random(count AIRFIELD_Markers)));
[_infgrp,'',getmarkerpos "city","LIMITED","SAD","SAFE","RED"] call NTA_fnc_vehicles_addwaypoint;



_return = [_c130, _infgrp, _users];
_return
