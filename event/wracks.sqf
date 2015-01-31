private ["_target","_counter","_wracks","_locs"];

_target = [_this, 0,AIRFIELD_BombMarkers select (floor(random(count AIRFIELD_BombMarkers)))] call bis_fnc_param;
_counter = [_this,1,[1]] call bis_fnc_param;
_damage = [_this,2,1] call bis_fnc_param;



_wracks =["B_MRAP_01_gmg_F","B_Truck_01_covered_F","B_Truck_01_fuel_F"];
_locs = [_target,_counter] call NTA_fnc_getRandMkrLocs;
_wrack_array = [];

for "_i" from 0 to (count _locs)-1 step 1 do {
	_type = _wracks select (floor(random(count _wracks)));
	_wrack =	[_type,_locs select _i,'NONE',WEST] call NTA_fnc_vehicles_create;
	_wrack setFuel 0;
	_wrack setdamage _damage;
	_wrack addEventHandler ["handledamage", {

		if ((_this select 4) in ["SatchelCharge_Remote_Ammo","DemoCharge_Remote_Ammo","DemoCharge_Remote_Ammo_Scripted","SatchelCharge_Remote_Ammo_Scripted"]) then {

				deleteVehicle (_this select 0);
				(_this select 3) addRating 1500;
		} else {
			(_this select 0) setDamage ((getDammage (_this select 0)) + (_this select 2))}}];
};
