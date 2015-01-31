//
//	script by loki
//	Oct. 2013
//"SCALAR"
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
private ["_unit", "_slot", "_puid", "_profileName", "_unitFileName", "_sectionTitle"];

_unit = _this select 0;
_slot = _this select 1;
_weapon = _this select 2;
_items = _this select 3;

_puid = getPlayerUID _unit;

if(!isServer || !nta_inidb) exitWith {};

// Allow users with multiple profiles to make new profiles and have new lives
// We want to use CRC hashes for the name because some people have spaces, weird characters or some other stuff so it's just better this way.
_profileName = _unit getVariable["profileName", ""];

if(_profileName == "") exitWith {};

_unitFileName = format["%2_%1", _puid, (_profileName call iniDB_CRC32)];

// this will save to the same file, but use different sections for each side
// i.e. persistent data will carry over _per side player has played.


_sectionTitle = format["%1 - Slot%2", (call compile format ["%1 getvariable 'CrateFnc'", _unit getvariable "Playerbox"]), _slot];

//main header



[_unitFileName, _sectionTitle, "weapons", _weapon] call iniDB_write;
[_unitFileName, _sectionTitle, "primaryWeaponItems", _items] call iniDB_write;
[_unit, _slot, "weaponinfo"] call NTA_fnc_inidb_readweapon;
