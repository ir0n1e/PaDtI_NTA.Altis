private ["_veh", "_name"];

_veh = _this select 0;

if (!((getPlayerUID player) in (call NTA_fnc_players_id)) && {str _veh == "Wipe1" || str _veh == "Wipe2" || str _veh == "Black1"}) exitwith {
	_name = getText (configfile >> "CfgVehicles" >> typeof _veh >> "displayName");
	format [localize "STR_NTA_NO_VehicleRights", _name] call NTA_fnc_note;
		false
};

true