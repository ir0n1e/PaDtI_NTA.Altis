scriptName "fn_lamps_LampSwitch";
/*
	Author: Ir0n1E

	Description:
	Switch Lamps ON/OFF

	Parameter(s):
	#0 ARRAY - Lamps Array
	#1 BOOL	 - true = on

	Returns:
	BOOL - TRUE when done
*/

_this spawn {
	_lamps		= _this select 0;
	_switchOn 	= _this select 1;
	call compile format ["%1=%2; publicvariable str %1", _lamps select 1, _switchOn];
	{
		_reflectors = getarray (configfile >> "CfgVehicles" >> typeof _x >> "aggregateReflectors");

		if (count _reflectors <= 0) then {
			_reflectors = ["Light_1"];
		} else {
			_reflectors = _reflectors select 0;
		};

		if (_switchOn) then {
			_x enableSimulationGlobal true;
			for "_i" from 0 to (count _reflectors) -1 do {
				_r = gettext (configfile >> "CfgVehicles" >> typeof _x >> "Reflectors" >> (_reflectors select _i) >> "hitpoint");
				//Flash first reflector
				switch (_i) do {
				    case 0: {
						_x setHit [_r, 0];
						sleep 0.05;
						_x setHit [_r, 0.97];
						sleep 0.05;
						_x setHit [_r, 0];
						sleep 0.05;
						_x setHit [_r, 0.97];
						sleep 0.752;
						_x setHit [_r, 0];
				    };
				    case 1: {
				    	sleep 0.25;
				    	_x setHit [_r, 0];
				    };
				    case 2: {
				    	sleep 0.5;
				    	_x setHit [_r, 0];
					};
					default {
						sleep 0.15;
				    	_x setHit [_r, 0];
					};
				};
			};
		} else {
			for "_i" from 0 to (count _reflectors) -1 do {
				_r = gettext (configfile >> "CfgVehicles" >> typeof _x >> "Reflectors" >> (_reflectors select _i) >> "hitpoint");
				_x setHit [_r, 0.97];
			};
			_x enableSimulationGlobal false;
		};
	} foreach (_lamps select 0);
};