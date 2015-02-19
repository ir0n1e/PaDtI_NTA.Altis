private ["_locs","_target","_count","_bomb","_time"];

_target = [_this, 0, []] call bis_fnc_param;
_count = [_this, 1, [3]] call bis_fnc_param;

_bomb = "R_TBG32V_F";
_locs = [_target, _count] call NTA_fnc_getRandMkrLocs;
_time = time;


for "_i" from 0 to (count _locs)-1 step 1 do {
	waitUntil {time >= (_time + _i)};
	[_bomb, _locs select _i, 180, EAST] call NTA_fnc_vehicles_create;
	if(_target == "Airfield") then {
		"BWplus_Crater" createVehicle (_locs select _i);
	};
};
format["AIRPATROL: Bombs %1 Target: %2 - Done", _count, _target] call NTA_fnc_log;