private ["_pos", "_side", "_faction", "_type", "_special","_vehicle", "_vehicleType"];

_pos 		= _this select 0;
_side		= _this select 1;
_faction	= _this select 2;
_type 		= _this select 3;
_special	= "CAN_COLLIDE";

if (count _this > 4) then {
	_special = _this select 4;
};

_vehicleType = [_faction, _type] call NTA_fnc_eos_getUnitPool;


_vehicle = [_vehicleType select 0, _pos, (random 360), _side] call NTA_fnc_vehicles_create;
_vehicle spawn {
	_this allowdammage false;
	sleep 10;
	_this allowdammage true;
	_this setdammage 0;
};

[_vehicle, crew _vehicle, group (driver _vehicle)]