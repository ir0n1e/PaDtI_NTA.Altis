// SINGLE INFANTRY GROUP
private ["_grp","_unit","_pool","_pos","_faction", "_side", "_grpMin","_grpMax", "_grpSize"];

	_pos		= (_this select 0);
	_grpSize	= (_this select 1);
	_faction	= (_this select 2);
	_side		= (_this select 3);

	_grpMin		= _grpSize select 0;
	_grpMax		= _grpSize select 1;
	_grpSize	= floor ((random (_grpMax - _grpMin)) + _grpMin);

	if (surfaceiswater _pos) then {
		pool = [_faction,1] call NTA_fnc_eos_getunitpool;
	}else{
		pool = [_faction,0] call NTA_fnc_eos_getunitpool;
	};

	grp = createGroup _side;

	for "_x" from 1 to _grpSize do {
		_script = [_pos] spawn {
			_pos = _this select 0;
			_unit = grp createUnit [(pool call NTA_fnc_getRandArraypos), _pos, [], 6, "FORM"];
		};
		waitUntil {scriptdone _script};
	};

grp