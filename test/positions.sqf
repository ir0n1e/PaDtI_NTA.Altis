//LZ [7387.53,11132.1,0.00155544]

//wp last [6127.45,1356.09,-2.00182]
//insert [21730.8,1347.9,-1.93579]
//wp delete [4544.92,27506.8,-2.04726]


private ["_units", "_count"];


_units 	= _this select 0;
_side	= _this select 1;
_count 	= _this select 2;

_u 		= [];
call nta_fnc_missions_dam;

//LZ [7387.53,11132.1,0.00155544]
_c130eastWP = [[6127.45,1356.09,0],[6127.45,1356.09,0],[7332.15,11525.1,0],[4544.92,27506.8,0]];
MISSIONACTIVE = true;
publicvariable "missionactive";



for "_i" from 1 to _count do {

	if (_i == 1) then {
		_u = _units;
	};

	_vehicle = [_c130eastWP , _u, _side, 10] call AIRFIELD_call_c130east;
	[_vehicle select 0,_vehicle select 1, _vehicle select 2, _c130eastWP select 2, 5] call AIRFIELD_Parachute;
	_wp = _c130eastWP select 0;
	_wp2 = _c130eastWP select 1;
	_wp3 = _c130eastWP select 2;
	_c130eastWP = [[(_wp select 0) + 300,(_wp select 1)+100, _wp select 2], [(_wp2 select 0) + 150,(_wp2 select 1)+150,0],[(_wp3 select 0) + 300,(_wp3 select 1)+300,0], _c130eastWP select 3 ];
};
