private ["_unit", "_slot", "_puid", "_profileName", "_unitFileName", "_sectionTitle", "_count", "_weapon"];

_unit = _this select 0;
_weapon = _this select 1;
_puid = getPlayerUID _unit;

if(!isServer || !nta_inidb) exitWith {};

// Allow users with multiple profiles to make new profiles and have new lives
// We want to use CRC hashes for the name because some people have spaces, weird characters or some other stuff so it's just better this way.
_profileName = _unit getVariable["profileName", ""];

if(_profileName == "") exitWith {};

_unitFileName = format["%2_%1", _puid, (_profileName call iniDB_CRC32)];

// this will save to the same file, but use different sections for each side
// i.e. persistent data will carry over _per side player has played.

_sectionTitle = format["%1 - playerStats", name _unit];

[_unitFileName, "account", "Profile Name", name _unit] call iniDB_write;
[_unitFileName, "account", "Player GUID", getPlayerUID _unit] call iniDB_write;

_count = [_unitFileName, _sectionTitle, "Player Death", "SCALAR"] call iniDB_read;

if (!isnil "_count") then {
	_count = _count + 1;
} else {
	_count = 1;
};

[_unitFileName, _sectionTitle, "Player Death", _count] call iniDB_write;

_weaponsUsed = [_unitFileName, _sectionTitle, "Player Weapons Used", "ARRAY"] call iniDB_read;

if (isnil "_weaponsUsed") exitwith {
	_weaponsUsed = [[_weapon, 1]];
	[_unitFileName, _sectionTitle, "Player Weapons Used", _weaponsUsed] call iniDB_write;
	_unit setvariable ["WeaponsUsed", _weaponsUsed, true];
};

_weaponsUsedTMP = [];
_match = false;

{
	if (_weapon == (_x select 0)) then {
		_weaponsUsedTMP pushback [_x select 0, (_x select 1) + 1];
		_match = true;
	} else {
		_weaponsUsedTMP pushback _x;
	};
} foreach _weaponsUsed;

if (!_match) then {
	_weaponsUsed pushback [_weapon, 1];
} else {
	_weaponsUsed = _weaponsUsedTMP;
};


[_unitFileName, _sectionTitle, "Player Weapons Used", _weaponsUsed] call iniDB_write;

_unit setvariable ["WeaponsUsed", _weaponsUsed, true];
_unit setvariable ["Death", _count, true];