private ["_veh", "_name"];

_veh = _this select 0;

if (!(player getvariable ["haveBWplus", false]) && {str _veh == "Wipe1" ||  str _veh == "Wipe2"}) exitwith {
	_name = getText (configfile >> "CfgVehicles" >> typeof _veh >> "displayName");
	format ["Du musst BW.plus installiert haben, um die %1 zu fliegen!", _name] call NTA_fnc_note;
		false
};
true