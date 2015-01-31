private ["_unit", "_users", "_puid", "_fileName", "_match", "_tmpUsers"];

_unit = _this select 0;
_choice = _this select 1;
NTA_idlist = [];
publicVariable "NTA_idlist";

if(!isServer || !nta_inidb) exitWith {};

_fileName = "nta_serverData" call iniDB_CRC32;

_users = [_fileName, "Server Data", "NTA Users", "ARRAY"] call iniDB_read;

if (_choice == "write") then {
	_puid = getPlayerUID _unit;
	if (count _users <= 0) exitwith {
		_users = [[name _unit, _puid]];
		[_fileName, "Server Data", "NTA Users", _users] call iniDB_write;
		NTA_idlist = [_puid];
		publicVariable "NTA_idlist";
	};

	_match = false;
	{
		if !(_puid in _x) then {
			_match = true;
		};
	} foreach _users;

	if (_match) then {
		_users pushback [name _unit, _puid];
	};

	[_fileName, "Server Data", "NTA Users", _users] call iniDB_write;
};

if (_choice == "remove") then {
	_puid = getPlayerUID _unit;
	if (!isnil "_users") then {
		_tmpUsers = [];
		{
			if !(name _unit == (_x select 0) && {_puid == (_x select 1)}) then {
				_tmpUsers pushback _x;
			};
		} foreach _users;
	};
	_users = _tmpUsers;
	[_fileName, "Server Data", "NTA Users", _users] call iniDB_write;
};


if (!isnil "_users") then {
	{
		NTA_idlist pushback (_x select 1);
	} foreach _users;
};

publicVariable "NTA_idlist";