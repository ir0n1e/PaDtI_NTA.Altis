_this spawn {
waituntil{(!popEOS)};

_eosActive 	= _this;
_confArray 	= _eosActive getvariable ["confArray", []];
_mAH		= _eosActive getVariable "EOSmarkerColor" select 0;
_mAN		= _eosActive getVariable "EOSmarkerColor" select 0;

_mkr  		= (_confArray select 0);
_mPos 		= markerpos(_confArray select 0);
_grps 		= _this getvariable ["Groups", []];
_aGrp 		= _grps select 0;
_bGrp 		= _grps select 1;
_cGrp 		= _grps select 2;
_dGrp 		= _grps select 3;
_eGrp 		= _grps select 4;
_fgrp 		= _grps select 5;
_a	    	= (_confArray select 1);
_aGrps		= _a select 0;
_b	    	= (_confArray select 2);
_bGrps		= _b select 0;
_c	    	= (_confArray select 3);
_cGrps		= _c select 0;
_cSize		= _c select 1;
_d			= (_confArray select 4);
_dGrps		= _d select 0;
_eGrps		= _d select 1;
_fGrps		= _d select 2;

_settings   = (_confArray select 5);
_mA	     	= _settings select 1;
_debug 		= if (count _settings > 5) then {_settings select 5} else {false};


if (!isnil "_aGrp") then {
	_n = 0;
	{
		_n	  = _n + 1;
		_units	  = {alive _x} count units _x;
		_cacheGrp = format ["HP%1", _n];

		if (_debug) then {
			player sidechat format ["ID:%1,cache - %2", _cacheGrp, _units];
		};

		_eosActive setvariable [_cacheGrp, _units, true];
		{deleteVehicle _x} foreach units _x;
		deleteGroup _x;
	} foreach _aGrp;
};
// CACHE LIGHT VEHICLES
if (!isnil "_cGrp") then {
	{
		_vehicle = _x select 0;
		_crew	 = _x select 1;
		_grp	 = _x select 2;

		if (!alive _vehicle || {!alive _x} foreach _crew) then {
			_cGrps = _cGrps - 1;
		};

		{deleteVehicle _x} forEach (_crew);

		if (!(vehicle player == _vehicle)) then {
			{deleteVehicle _x} forEach [_vehicle];
		};

		{deleteVehicle _x} foreach units _grp;
		deleteGroup _grp;
	} foreach _cGrp;

	if (_debug) then {
		player sidechat format ["ID:c%1", _cGrps];
	};
};

// CACHE ARMOURED VEHICLES
if (!isnil "_dGrp") then {
	{
		_vehicle = _x select 0;
		_crew	 = _x select 1;
		_grp	 = _x select 2;

		if (!alive _vehicle || {!alive _x} foreach _crew) then {
			_dGrps = _dGrps - 1;
		};

		{deleteVehicle _x} forEach (_crew);

		if (!(vehicle player == _vehicle)) then {
			{deleteVehicle _x} forEach [_vehicle];
		};

		{deleteVehicle _x} foreach units _grp;
		deleteGroup _grp;
	} foreach _dGrp;

	if (_debug) then {
		player sidechat format ["ID:c%1", _dGrps];
	};
};

// CACHE PATROL INFANTRY
if (!isnil "_bGrp") then {
	_n = 0;
	{
		_n	  = _n + 1;
		_units	  = {alive _x} count units _x;
		_cacheGrp = format ["PA%1", _n];

		if (_debug) then {
			player sidechat format ["ID:%1,cache - %2", _cacheGrp, _units];
		};

		_eosActive setvariable [_cacheGrp, _units, true];

		{deleteVehicle _x} foreach units _x;
		deleteGroup _x;
	} foreach _bGrp;
};

// CACHE HOUSE INFANTRY
// CACHE MORTARS
_egrpTMP = [];
if (!isnil "_eGrp") then {
	{
		_vehicle = _x select 0;
		_crew	 = _x select 1;
		_grp	 = _x select 2;
		_pos = getpos (leader _grp);

		if (!alive _vehicle || {!alive _x} foreach _crew) then {
			_eGrps = _eGrps - 1;
		};

		{deleteVehicle _x} forEach (_crew);

		if (!(vehicle player == _vehicle)) then {
			{deleteVehicle _x} forEach [_vehicle];
		};
		{deleteVehicle _x} foreach units _grp;
		deleteGroup _grp;
	} foreach _eGrp;
};

// CACHE HELICOPTER TRANSPORT
if (!isnil "_fGrp") then {
	{
		_vehicle  = _x select 0;
		_crew	  = _x select 1;
		_grp	  = _x select 2;
		_cargoGrp = _x select 3;

		if (!alive _vehicle || {!alive _x} foreach _crew) then {
			_fGrps = _fGrps - 1;
		};

		{deleteVehicle _x} forEach (_crew);

		if (!(vehicle player == _vehicle)) then {
			{deleteVehicle _x} forEach [_vehicle];
		};

		{deleteVehicle _x} foreach units _grp;
		deleteGroup _grp;

		if (!isnil "_cargoGrp") then {
			{deleteVehicle _x} foreach units _cargoGrp;
			deleteGroup _cargoGrp;
		};
	} foreach _fGrp;
};
{
	deletevehicle _x;
} foreach (_this getvariable ["allunits", []]);

_mkr setmarkerAlpha _mAN;

if (_debug) then {
	hint "Zone Cached";
};


{
	if (typeOf _x == "#particlesource") then {
		deleteVehicle _x;
	};
} forEach (getmarkerpos _mkr nearObjects 500);



if (_this getvariable ["eosclear", false]) exitwith {
	// IF ZONE CAPTURED BEGIN CHECKING FOR ENEMIES
	_cGrps = 0;
	_aGrps = 0;
	_bGrps = 0;
	_dGrps = 0;
	_eGrps = 0;
	_fGrps = 0;
	["eos", 100] call NTA_fnc_core_addTickets;

	if (_eosActive getvariable ["missionActive", false]) then {
		{
			deletevehicle _x;
		} foreach (_eosActive getvariable ["missionObjects", []]);
	};

	deletemarker str _mkr;
	_mkr setmarkercolor VictoryColor;
	_mkr setmarkerAlpha _mAN;
	deletevehicle _this;

	if (_debug) then {
		hint "Zone Captured";
	};
};

if (!(getmarkercolor _mkr == "colorblack") && !(getmarkercolor _mkr == bastioncolor)) exitwith {
	_aSize		= _a select 1;
	_bSize		= _b select 1;
	_fSize		= _d select 3;
	deletemarker str _mkr;
	_this setvariable ["confArray", [_mkr, [_aGrps, _aSize], [_bGrps, _bSize], [_cGrps, _cSize], [_dGrps, _eGrps, _fGrps, _fSize], _settings, true], true];
	EOS_ACTIVE = false;
	publicvariable "EOS_ACTIVE";
};




EOS_ACTIVE = false;
publicvariable "EOS_ACTIVE";
};