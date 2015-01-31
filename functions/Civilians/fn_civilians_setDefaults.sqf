private ["_unit", "_houses", "_mkr", "_hostilefactor", "_htemp"];
_unit 	= _this select 0;
_houses = _this select 1;
_mkr 	= _this select 2;
_htemp	= [];

_hostilefactor = server getvariable [format["trig%1_hostilefactor", _mkr], 0];

{
	if (_x distance (getmarkerpos _mkr) < 300) then {
		_htemp pushBack _x;
	};
} foreach _houses;

_unit setvariable ["personalhostilefactor", random(_hostilefactor + 2)];
_unit setvariable ["marker", _mkr];
_unit setvariable ["Mission", "patrol"];
_unit setvariable ["OnMission", false];
_unit setvariable ["ShotsCount", 0];
_unit setSkill 0;


if ((count _htemp) > 0) then {
	_pos = ((_htemp call NTA_fnc_getRandArrayPos) call NTA_fnc_getRandHousePos);
	if (!isnil "_pos") then {
		_unit setvariable ["home", _pos];
	};
};

_unit call NTA_fnc_civilians_handleShots;