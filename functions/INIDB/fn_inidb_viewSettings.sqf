private ["_unit", "_tarrain", "_puid", "_sectionTitle", "_choice", "_view", "_unitFileName"];

_unit 		= _this select 0;
_tarrain 	= _this select 1;
_view		= _this select 2;
_choice 	= _this select 3;
_puid		= getPlayerUID _unit;

if(!isServer || !nta_inidb) exitWith {};


_profileName = _unit getVariable["profileName", ""];

if(_profileName == "") exitWith {};

_unitFileName = format["%2_%1", _puid, (_profileName call iniDB_CRC32)];
_sectionTitle = format["%1 - ViewSettings", name _unit];


if (_choice) then {
	[_unitFileName, "account", "Profile Name", name _unit] call iniDB_write;
	[_unitFileName, "account", "Player GUID", getPlayerUID _unit] call iniDB_write;
	[_unitFileName, _sectionTitle, "Settings", [_tarrain, _view]] call iniDB_write;
} else {
	_view = [_unitFileName, _sectionTitle, "Settings", "ARRAY"] call iniDB_read;

	if (count _view > 0) then {
		_unit setvariable ["ViewSettings", _view, true];
	};
};