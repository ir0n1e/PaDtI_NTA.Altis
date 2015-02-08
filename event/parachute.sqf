fnc_getout = {
	_u = _this select 0;
	_move = _this select 1;

	_u switchMove _move;
};
publicVariable "fnc_getout";

_this spawn {
	private ["_dir", "_count", "_chute", "_infgrp", "_veh", "_chutepos", "_survivor"];

	_veh 		= _this select 0;
	_infgrp 	= _this select 1;
	_players 	= _this select 2;
	_chutepos 	= _this select 3;
	_survivor 	= [_this, 4, count (units _infgrp)] call bis_fnc_param;



	waituntil {_veh distance (_chutepos) <= 2000};
	_veh setVariable [IL_varname, true, true];
	{
		_x setvariable ["inParaCargo", true, true];
	} forEach (units _infgrp) + _players;

	waituntil {_veh distance (_chutepos) <= 1500};
	_veh animate ["door_2_1", 1];

	waituntil {_veh distance (_chutepos) <= 650};
	_veh setVariable ["IL_timestamp",time,true];
	_veh setvariable ['IL_override', [[[0,-0.5,-2],IL_c_green,[0.3,0,0,500],50]],true];

	//_dir = (direction _veh) + 180;
	_count = 0;
	_max = (count (units _infgrp)) - (count _players);

	{

		[_x,_count, _survivor, _max] spawn {
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
				waituntil {_u getvariable ["parajump", false] || time >= (_time + 90)};
				_u allowDamage false;
				if !(_u getvariable ["parajump", false]) then {
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
			_u setvariable ["parajump", false, true];
			_u setvariable ["inParaCargo", false, true];

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
		systemchat str _count;
		sleep 0.8;

	} forEach _players + (units _infgrp);
};