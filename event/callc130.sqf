private ["_inf","_c130"];

_c130 = ["C130J",[9663,3533,100],180,WEST] call NTA_fnc_vehicles_create;
_c130 landAt 3;
[group _c130,'',[21129.4,7325.84,0.00144196],"LIMITED","TR UNLOAD"]  call NTA_fnc_vehicles_addwaypoint;
[group _c130,'',[21129.4,7325.84,0.00144196],"NORMAL","GETOUT"]  call NTA_fnc_vehicles_addwaypoint;
[group _c130,'',getMarkerPos "land","FULL","MOVE"]  call NTA_fnc_vehicles_addwaypoint;


_inf = [[0,0,0],WEST,(configfile >> "CfgGroups" >> "West" >> "Bundeswehr" >> "Infantry_Fleck" >> "BWplusRecon")]Call BIS_fnc_spawnGroup;
[_inf,'',[21129.4,7325.84,0.00144196],"FULL","GETOUT"]  call NTA_fnc_vehicles_addwaypoint;
[_inf,'',getMarkerPos "land","FULL","MOVE"] call NTA_fnc_vehicles_addwaypoint;
 {
 _x  moveInCargo _c130;
} forEach units _inf;

_c130