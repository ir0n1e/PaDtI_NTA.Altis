_this spawn {
	private ["_waypoints","_findWps","_mkr"];
	_unit = _this select 0;
	_waypoints = _this select 1;
	_mkr = _this select 2;

	_unit setvariable ["OnMission", false];
	_unit setvariable ["mission", "patrol"];

	_findWps = 1 +floor(random 3);
	if (count _waypoints < _findWps) then {_findWps=count _waypoints;};

	_group = group _unit;
	_group setBehaviour "SAFE";
	_group setSpeedMode "LIMITED";

	while {(count (waypoints _group)) > 0} do {
		deleteWaypoint ((waypoints _group) select 0);
	};

	_shuffleWaypoints=_waypoints call BIS_fnc_arrayShuffle;

	for "_i" from 0 to _findWps do {

		_script = [_group, _i, _shuffleWaypoints] spawn {
			_group 	= _this select 0;
			_i 		= _this select 1;
			_s 		= _this select 2;
			_wp 	= _s select _i;

			_wp = _group addWaypoint [_wp, _i];
			_wp setWaypointType "MOVE";
			_wp setWaypointCompletionRadius 10;
		};
		waituntil {scriptDone _script};

		if (_i == _findWps) then {
			_wp = _group addWaypoint [_shuffleWaypoints select 0, _i];
			_wp setWaypointType "CYCLE";
			_wp setWaypointCompletionRadius 20;
		};
		[_group,_i] setWaypointTimeout [0,2,4];
	};
};
