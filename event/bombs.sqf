private ["_locs","_location","_count","_bomb","_time"];

_location = [_this, 0,AIRFIELD_BombMarkers select (floor(random(count AIRFIELD_BombMarkers)))] call bis_fnc_param;
_count = [_this,1,[3]] call bis_fnc_param;

_bomb= "M_Titan_AA_long";
_locs = [_location, _count] call NTA_fnc_getRandMkrLocs;
_time = time;


for "_i" from 0 to (count _locs)-1 step 1 do {
	waitUntil {time >= (_time + _i)};
	[_bomb,_locs select _i,180,EAST] call NTA_fnc_vehicles_create;
	if(_location == "Airfied") then {
		"BWplus_Crater" createVehicle (_locs select _i);
	};
};
