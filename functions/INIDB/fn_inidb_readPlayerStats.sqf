private ["_unit", "_slot", "_puid", "_profileName", "_unitFileName", "_sectionTitle", "_count", "_weapon"];

_unit = _this select 0;
_choice = _this select 1;
_puid = getPlayerUID _unit;


if(!isServer || !nta_inidb) exitWith {};

// Allow users with multiple profiles to make new profiles and have new lives
// We want to use CRC hashes for the name because some people have spaces, weird characters or some other stuff so it's just better this way.
_profileName = _unit getVariable["profileName", ""];

if(_profileName == "") exitWith {};

_unitFileName = format["%2_%1", _puid, (_profileName call iniDB_CRC32)];

_sectionTitle = format["%1 - playerStats", name _unit];

switch (_choice) do {
	case "death": {
		_unit setvariable ["Death", 0, true];
		_count = [_unitFileName, _sectionTitle, "Player Death", "SCALAR"] call iniDB_read;
		if (!isnil "_count") then {
			_unit setvariable ["Death", _count, true];
		};
	};
	case "weaponstats": {
		_unit setvariable ["WeaponsUsed", [], true];
		_weaponsUsed = [_unitFileName, _sectionTitle, "Player Weapons Used", "ARRAY"] call iniDB_read;
		if (!isnil "_weaponsUsed") then {
			_unit setvariable ["WeaponsUsed", _weaponsUsed, true];
		};
	};
};