_this spawn {

	_vehicles 	= _this select 0;
	_startPos	= _this select 1;
	_targetPos 	= _this select 2;
	_apUser 	= [_this, 3, objnull] call bis_fnc_param;
	_apParaVars	= _this select 4;

	_height		= _apParaVars select 0;
	_troopCount = _apParaVars select 2;
	_survivors	= _apParaVars select 3;

	_side		= side (_vehicles select 0);
	_aiGrps		= [];
	_speed 		= "FULL";
	_man  		= "B_soldier_PG_F";
	_parachute	= _apUser getvariable ["Airpatrol_ParaChute", NTA_airpatrol_Parachute];

	for "_i" from 0 to (count _vehicles) -1 do {

		if (typeof (_vehicles select _i) isKindOf "Plane") then {
			_speed = "LIMITED";
		};

		_dir = [_targetPos, _startPos] call BIS_fnc_dirTo;

		_height = _height + (50 * _i);
		(_vehicles select _i) flyInHeight (_height max NTA_airpatrolParaMinHeight);

		_wp = [group (_vehicles select _i), '', [_startPos, 3500, (_dir + 180)] call BIS_fnc_relPos, _speed, "MOVE", "CARELESS", "BLUE"] call NTA_fnc_vehicles_addwaypoint;
		_wp setWaypointCompletionRadius 1000;

		_wp = [group (_vehicles select _i), '', [_targetPos, 2500, _dir] call BIS_fnc_relPos, _speed, "MOVE", "CARELESS", "BLUE"] call NTA_fnc_vehicles_addwaypoint;
		_wp setWaypointCompletionRadius 500;

		_wp = [group (_vehicles select _i), '', _targetPos, _speed, "MOVE", "CARELESS", "BLUE"] call NTA_fnc_vehicles_addwaypoint;
		_wp setWaypointCompletionRadius 500;

		_wp = [group (_vehicles select _i), '', [_targetPos, 2000, (_dir + 180)] call BIS_fnc_relPos, _speed, "MOVE", "CARELESS", "BLUE"] call NTA_fnc_vehicles_addwaypoint;
		_wp setWaypointCompletionRadius 500;

		_wp = [group (_vehicles select _i), '', (_vehicles select _i) getvariable ["Airpatrol_EndPos", [0,0,0]], "FULL", "MOVE", "CARELESS", "BLUE", ["true", "{[_x] call NTA_fnc_vehicles_delete} forEach thislist"]] call NTA_fnc_vehicles_addwaypoint;
		_wp setWaypointCompletionRadius 500;

		_users 	= [];
		if (_i == 0) then {
			_users = (_apUser getvariable [format ["insert%1", group _apUser],[[]]]) select 0;
		};

		_seats = getNumber (configfile >> "CfgVehicles" >> typeof (_vehicles select _i) >> "transportsoldier") + (count (getarray (configfile >> "CfgVehicles" >> typeof (_vehicles select _i) >> "memoryPointsGetInCargoPrecise")) -1);

		_infgrp = createGroup _side;

		if (_troopCount > 0) then {
			for "_i" from 0 to (_seats - (count _users) min _troopCount) - 1 do {
				_script = [_infgrp, _man] spawn {
					_infgrp = _this select 0;
					_man 	= _this select 1;

					_man createUnit [[0,0,0], _infgrp];
				};
				waitUntil {scriptdone _script};
			};
			_aiGrps pushback _infgrp;
		};

		{
			[[_x, _vehicles select _i, _foreachIndex + 1], "NTA_fnc_airpatrol_movein", _x] call bis_fnc_mp;
			removeBackpackGlobal _x;
			if (isplayer _x) then {
				_x addBackpackGlobal _parachute;
			} else {
				_x addBackpackGlobal "B_Parachute";
			};
		} foreach _users + (units _infgrp);

		[(_vehicles select _i), _infgrp, _users, _targetPos, _survivors, _height] call NTA_fnc_airpatrol_ParaDrop;
	};

	NTA_airpatrolCache setVariable [format ["NTA_Airpatrol_ParaGrp_%1", _side], _aiGrps, true];
};
