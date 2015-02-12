fnc_getout = {
	_u = _this select 0;
	_move = _this select 1;

	_u switchMove _move;
};
publicVariable "fnc_getout";

_this spawn {
	_veh 		= _this select 0;
	_infgrp 	= _this select 1;
	_users 		= _this select 2;
	_targetPos 	= _this select 3;
	_survivors 	= [_this, 4, count (units _infgrp)] call bis_fnc_param;
	_height		= _this select 5;
	_door 		= "door_rear_source";

	waituntil {alive _veh && {speed _veh > 50}};

	if (typeof _veh iskindof "c130J_base") then {
		_door = "door_2_1";
	};
/*
	[_veh, _targetPos] spawn {
		_veh = _this select 0;
		_targetPos = _this select 1;
		while {true} do {
			hintsilent format ["%1", ((_veh distance [_targetPos select 0, _targetPos select 1, 180]) / (speed _veh) * 3.6)];
			sleep 1;
		};
	};
*/

	waituntil {!alive _veh || {((_veh distance [_targetPos select 0, _targetPos select 1, _height]) / (speed _veh) * 3.6) <= 60}};
	[_veh] call IL_fnc_switchOn;

	waituntil {!alive _veh || {((_veh distance [_targetPos select 0, _targetPos select 1, _height]) / (speed _veh) * 3.6) <= 30}};
	_veh animatedoor [_door, 1];

	waituntil {!alive _veh || {((_veh distance [_targetPos select 0, _targetPos select 1, _height]) / (speed _veh) * 3.6) <= 5}};
	[_veh] call IL_fnc_switchGreen;

	//_dir = (direction _veh) + 180;
	_count = 0;
	_max = (count (units _infgrp)) - (count _users);

	{
		[_x,_count, _survivors, _max] spawn {
			private ["_u","_c","_s","_m"];

			_u = _this select 0;
			_c = (_this select 1) -1;
			_s = _this select 2;
			_m = _this select 3;
			if (!isplayer _u) then {
				_u allowDamage false;
				moveOut _u;
				unassignVehicle _u;
			} else {
				_time = time;
				waituntil {vehicle _u != _veh || {time >= (_time + 90)} || {!alive _u}};
				if (!alive _u) exitwith {_u allowDamage true;};

				if (vehicle _u == _veh) then {
					moveOut _u;
					unassignVehicle _u;
				};
			};
			_u allowDamage true;
			/*
			_dir = (getdir _u) + 180;
			sleep 2;
			_chute = createVehicle ["O_Parachute_02_F", position _u, [], 0, 'NONE'];
			_chute setPos (getPos _u);
			_chute setDir ((_dir)-5+(random 10));
			_u setDir ( direction _chute );
			_chute setPos (getPos _u);
			(vehicle _u) setDir ((_dir)-5+(random 10));
			_chute attachTo [_u, [0, 0, 0]];
			detach _chute;


			[[_u, "Para_pilot"], "fnc_getout", _u] call bis_fnc_MP;
			_u attachTo [_chute, [0, 0, -1.8]];


			[[_u, "getoutpara"], "fnc_getout",_u] call bis_fnc_MP;
			detach _u;

			*/
			waitUntil {((getpos _u) select 2) <= 1.5 || {!alive _u}};

			_item = (assignedItems _u) call nta_fnc_getrandarraypos;
			if (floor (random 3) == 1) then {
				_u unassignItem _item;
				_u removeItem _item;
			};


			if (_c  < (_m - _s) && {!isplayer _u}) then {
				deletevehicle _u;
			};
		};

		if (!isplayer _x) then {
			_count = _count + 1;
		};

		sleep 0.8;

	} forEach _users + (units _infgrp);
};
