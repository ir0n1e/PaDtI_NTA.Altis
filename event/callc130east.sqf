
private ["_csatplane_wp", "_c130", "_infgrp", "_infWP", "_count", "_users"];

_csatplane_wp 	= _this select 0;
_users 			= _this select 1;
_count 			= _this select 2;


_man  = "B_soldier_PG_F";
if (isclass (configfile >> "CfgPatches" >> "rhsusf_infantry")) then {
	_man = "rhsusf_army_ocp_riflemanl";
};



_c130 = ["sab_C130_JE", _csatplane_wp select 0, 0, WEST] call NTA_fnc_vehicles_create;
_c130 flyInHeight 300;

[group _c130, '', _csatplane_wp select 0, "FULL", "MOVE", "CARELESS", "BLUE"] call NTA_fnc_vehicles_addwaypoint;
[group _c130, '', _csatplane_wp select 1, "FULL", "MOVE", "CARELESS", "BLUE"] call NTA_fnc_vehicles_addwaypoint;
[group _c130, '', _csatplane_wp select 2, "LIMITED", "MOVE", "CARELESS", "BLUE"] call NTA_fnc_vehicles_addwaypoint;
[group _c130, '', _csatplane_wp select 3, "FULL", "MOVE", "CARELESS", "BLUE", ["true", "{[_x] call NTA_fnc_vehicles_delete} forEach thislist"]] call NTA_fnc_vehicles_addwaypoint;
(driver _c130) action ["lightOff", _c130];
_seats 	= getNumber (configfile >> "CfgVehicles" >> "sab_C130_JE" >> "transportsoldier");

_infgrp = createGroup WEST;

for "_i" from 0 to (_seats - (count _users) min _count) - 1 do {
	_man createUnit [[0,0,0], _infgrp];
};
systemchat str (count units _infgrp);
{
	systemchat str _foreachIndex;
	[[_x, _c130, _foreachIndex + 1], "NTA_fnc_airpatrol_movein", _x] call bis_fnc_mp;
	removeBackpackGlobal _x;
	_x addBackpackGlobal "B_Parachute";

} foreach _users + (units _infgrp);


//_infWP = AIRFIELD_Markers select (floor(random(count AIRFIELD_Markers)));
[_infgrp,'',getmarkerpos "city","FULL","SAD","SAFE","RED"] call NTA_fnc_vehicles_addwaypoint;



_return = [_c130, _infgrp, _users];
_return
