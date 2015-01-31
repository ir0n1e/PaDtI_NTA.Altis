
private ["_csatplane_wp", "_c130", "_infgrp", "_infWP", "_count"];

_csatplane_wp = _this select 0;
_count = _this select 1;

_c130 = ["C130J",_csatplane_wp select 0,180,EAST] call NTA_fnc_vehicles_create;
_c130 flyInHeight 180;
[group _c130,'',_csatplane_wp select 0,"LIMITED","MOVE"] call NTA_fnc_vehicles_addwaypoint;
[group _c130,'',_csatplane_wp select 1,"LIMITED","MOVE"] call NTA_fnc_vehicles_addwaypoint;
[group _c130,'',_csatplane_wp select 2,"LIMITED","MOVE"] call NTA_fnc_vehicles_addwaypoint;
[group _c130,'',_csatplane_wp select 3,"FULL","MOVE",["true","{[_x] call NTA_fnc_vehicles_delete} forEach thislist"]] call NTA_fnc_vehicles_addwaypoint;

_infgrp = createGroup EAST;

for "_i" from 1 to _count do {
	"O_soldier_PG_F" createUnit [ [0,0,0], _infgrp ];
};

{
	_x moveInCargo _c130;
} forEach units _infgrp;

_infWP = AIRFIELD_Markers select (floor(random(count AIRFIELD_Markers)));
[_infgrp,'',getmarkerpos _infWP,"FULL","SAD"] call NTA_fnc_vehicles_addwaypoint;



_return = [_c130, _infgrp];
_return

