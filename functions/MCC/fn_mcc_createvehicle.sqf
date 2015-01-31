

private ["_vehicle_list","_type","_pos","_dir","_unitinit","_veh","_init","_simulation", "_Array"];

_vehicle_list = [_this, 0] call BIS_fnc_param;
_simulation = [_this,1,false] call BIS_fnc_param;
_init = [_this,2,""] call BIS_fnc_param;
_sleep = [_this,3,0] call BIS_fnc_param;
_Array = [];

{

	_type = _x select 1;
	_pos = _x select 2;
	_dir = _x select 3;
	_unitinit = format ["%1 %2", _x select 4,_init];



	_veh = createVehicle [_type, _pos, [], 0, "CAN_COLLIDE"];

	if(_simulation) then {
		_veh enableSimulation false;
		_veh allowDamage false;
	};
	//_veh setDir _dir;
	_veh call compile format ["%1",_unitinit];
	[[netID _veh, _unitinit], "NTA_fnc_vehicles_setInit", true, true] spawn BIS_fnc_MP;
//	sleep 0.354;

	_veh setDir _dir;
	_Array pushback _veh;


} forEach _vehicle_list;

_Array




