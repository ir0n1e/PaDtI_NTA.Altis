private "_unit";

_unit = _this;

_unit addEventHandler ["FiredNear", {_this call NTA_fnc_civilians_breakPatrol}];

_unit addEventHandler ["Hit", {
	_unit = _this select 0;
	_mkr = (_this select 0) getvariable "marker";
	_hostilefactor = server getvariable format["trig%1_hostilefactor", _mkr];

	if (side _unit == CIVILIAN) then {
		_hostilefactor = _hostilefactor + 1.8;
		server setvariable [format["trig%1_hostilefactor", _mkr], _hostilefactor, true];
		_unit setvariable ["personalhostilefactor", _hostilefactor + 1.8];

		if ((_this select 1) in playableunits) then {
			["CIV Hit",-1] call NTA_fnc_core_addTickets;
		};
	};
}];

_unit addEventHandler ["Killed", {
	_unit = _this select 0;
	_mkr = (_this select 0) getvariable "marker";
	_hostilefactor = server getvariable format["trig%1_hostilefactor", _mkr];


	if (side _unit == CIVILIAN) then {
		_hostilefactor = _hostilefactor + 2.5;
			 server setvariable [format["trig%1_hostilefactor", _mkr], _hostilefactor, true];

		if ((_this select 1) in playableunits) then {
			["CIV dead",-10] call NTA_fnc_core_addTickets;
		};
	};
}];