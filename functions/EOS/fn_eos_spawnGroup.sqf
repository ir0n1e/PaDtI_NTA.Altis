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
	_pool = [_faction,1] call NTA_fnc_eos_getunitpool;
}else{
	_pool = [_faction,0] call NTA_fnc_eos_getunitpool;
};

_grp = createGroup _side;

for "_x" from 1 to _grpSize do {
	_unit = _grp createUnit [(_pool call NTA_fnc_getRandArraypos), _pos, [], 6, "FORM"];
};

_grp