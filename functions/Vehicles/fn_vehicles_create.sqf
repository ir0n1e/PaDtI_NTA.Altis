private ["_type","_pos","_grp","_special","_vehicle","_side", "_veharray"];

_type 	= _this select 0;
_pos 	= _this select 1;
_dir 	= [_this, 2, 360] call bis_fnc_param;
_side 	= _this select 3;

_grp 	= createGroup _side;


/*if (count _this > 5) then {
	_vehicle = createVehicle [_type, _pos, [], 0, _this select 4];
	[_vehicle, _grp] call BIS_fnc_spawnCrew;
	_vehicle setdir _dir;
} else {

};*/

_veharray = [_pos, _dir, _type, _side] call BIS_fnc_spawnVehicle;
_vehicle = _veharray select 0;

_vehicle
