_this spawn {
	private ["_dir", "_count", "_chute", "_infgrp", "_vec", "_chutepos", "_survivor"];

	_vec = _this select 0;
	_infgrp = _this select 1;
	_chutepos = _this select 2;
	_survivor = [_this, 3, count (units _infgrp)] call bis_fnc_param;

	waituntil {_this select 0 distance (_this select 2) <= 350};

	_dir = (direction (_this select 0)) + 180;
	_count = 0;
	_max = count units (_this select 1);
	{
		_x allowDamage false;
		unassignVehicle _x;
		_x action ["Eject", vehicle _x];

		_chute = createVehicle ["O_Parachute_02_F", position _x, [], 0, 'NONE'];
		_chute setPos (getPos _x);
		_chute setDir ((_dir)-5+(random 10));
		_x setDir ( direction _chute );
		_chute setPos (getPos _x);
		(vehicle _x) setDir ((_dir)-5+(random 10));
		_chute attachTo [_x, [0, 0, 0]];
		detach _chute;
		_x switchmove "Para_pilot";
		_x attachTo [_chute, [0, 0, -1.8]];
		_x allowDamage true;


		[_x,_count, _survivor, _max] spawn {
			private ["_u","_c","_s","_m"];

			_u = _this select 0;
			_c = _this select 1;
			_s = _this select 2;
			_m = _this select 3;
			waitUntil {sleep 0.1; position _u select 2 < 1};

			detach _u;
			_u switchmove "getoutpara";

			if (_c  < (_m - _s)) then {
				deletevehicle _u;
			};
		};

		_count = _count + 1;
		sleep 0.8;

	} forEach units (_this select 1);
};