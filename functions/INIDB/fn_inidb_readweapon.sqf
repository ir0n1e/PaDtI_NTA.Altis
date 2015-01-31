
//
//	script by loki
//	Oct. 2013
//
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
private ["_unit", "_slot", "_choice", "_puid", "_profileName", "_profileFileName", "_sectionTitle2", "_string", "_picture"];

_unit = _this select 0;
_slot = _this select 1;
_choice = _this select 2;
_puid = getPlayerUID _unit;

if(!isServer || !nta_inidb) exitWith {};
//_unit setvariable [format ["weaponinfo%1", _slot], [["PictureThing", "None"]], true];
// Allow users with multiple profiles to make new profiles and have new lives
// We want to use CRC hashes for the name because some people have spaces, weird characters or some other stuff so it's just better this way.
_profileName = _unit getVariable["profileName", ""];

if(_profileName == "") exitWith {};

_unitFileName = format["%2_%1", _puid, (_profileName call iniDB_CRC32)];

_sectionTitle2 = format["%1 - Slot%2", (call compile format ["%1 getvariable 'CrateFnc'", _unit getvariable "Playerbox"]), _slot];



_weaponadd = [_unitFileName, _sectionTitle2, "weapons", "STRING"] call iniDB_read;


_primaryWeaponItemsadd = [_unitFileName, _sectionTitle2, "primaryWeaponItems", "ARRAY"] call iniDB_read;

if (_choice == "weaponinfo") exitwith {

	if (!isnil "_weaponadd") then {
		_items = [];
		_items pushback _weaponadd;

		if (!isnil "_primaryWeaponItemsadd") then {
			{
				if (_x != "") then {
					_items pushback _x;
				};
			} foreach _primaryWeaponItemsadd;
		};
		_unit setvariable [format ["weaponinfo%1", _slot], _items, true];
	};
};

if (!isnil "_weaponadd") then {
	_unit removeWeaponGlobal (primaryWeapon _unit);
	_unit addweaponGlobal _weaponadd;
};
//for "_k" from 0 to (count _itemsadd) do {_unit additem (_itemsadd select _k)};
//for "_l" from 0 to (count _handgunItemsadd) do {_unit addhandgunitem (_handgunItemsadd select _l)};

//for "_n" from 0 to (count _secondaryWeaponItemsadd) do {_unit addsecondaryWeaponItem (_secondaryWeaponItemsadd select _n)};
//
///////////////////////////////////////////////////////////////////////////////////////////////////



