//stolen Rarek [AW]
server setvariable ["NTA_Arty_TargetPos", [0,0,0], true];
_this spawn {
	_arty   = _this select 0;
	_radius = 350; //Declared here so we can "zero in" gradually

	_arty addEventHandler["Fired", {
		if (!isPlayer (gunner (_this select 0))) then {
			(_this select 0) setVehicleAmmo 0;
			(_this select 0) addMagazine ["32Rnd_155mm_Mo_shells", 1];
		};
	}];

	_arty addEventHandler["GetIn", {
		if (isPlayer (gunner (_this select 0))) then {
			(_this select 0) setVehicleAmmo 0;
		};
	}];
	sleep 20;

	_accepted   = false;
	_unit       = objNull;
	_targetPos  = [0,0,0];
	_debugCount = 1;

	if (str (server getvariable "NTA_Arty_TargetPos") != str (_targetPos)) then {
		_accepted = true;
		_targetPos = server getvariable "NTA_Arty_TargetPos";
	};


	while {!_accepted} do {
		sleep 120;
		waituntil {count playableUnits > 0};
		_unit = (playableUnits select (floor (random (count playableUnits))));
		_targetPos = getPos _unit;

		if ((_targetPos distance (getMarkerPos "west_1")) > 1000 && vehicle _unit == _unit && side _unit == WEST && (_targetPos distance _arty < 5000)) then {
			_accepted = true;
			server setvariable ["NTA_Arty_TargetPos", _targetPos, true];
		} else {
			sleep 10;
		};
	};

	while {alive _arty && count playableUnits > 0} do {
		sleep 5;

		if (alive _arty) then {
			for "_c" from 0 to 1 do {
				_pos = [
					(_targetPos select 0) - _radius + (2 * random _radius),
					(_targetPos select 1) - _radius + (2 * random _radius),
					0
				];
				_arty doArtilleryFire [_pos, "32Rnd_155mm_Mo_shells", 1]; //update so parameter customises mortar rounds?
				str [_arty, _targetPos, _pos, _radius, "fire"] call nta_fnc_log;

			};
		};

		if (_radius > 10) then {
			_radius = _radius - 10;
		}; /* zeroing in */

		sleep (5*60);
	};
};