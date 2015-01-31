NTA_P_A10_enabled =isClass(configfile >> "CfgPatches" >> "Peral_A10");
if (!isServer && !NTA_P_A10_enabled) exitWith {};


private ["_pos","_init","_type","_unit"];

	_pos = position Wipe2;
	_dir = getDir Wipe2;
	_type = "Peral_A10C";
	_unitname = vehicleVarName Wipe2;
deleteVehicle Wipe2;


_unit = createVehicle [_type, _pos, [], 0, "CAN_COLLIDE"];
[[netID _unit, _unitname], "NTA_fnc_vehicles_setVarName", true, true] spawn BIS_fnc_MP;
_unit setDir _dir;
_unit setvehiclelock "unlocked";
_unit setVariable ["locked", false,true];
_unit setVariable ["dead", false,true];
//Wipe2 setvariable ["respawn",false,true];

[_unit, 5, 300,0,false,false,"Wipe2 = _this"] call NTA_fnc_vehicles_respawn;
Wipe2=_unit;
