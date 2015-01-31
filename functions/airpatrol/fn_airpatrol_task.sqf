_this spawn {
	_NTA_Airpatrol_Task = _this select 0;
	_NTA_Airpatrol_Veh 	= _this select 1;
	_NTA_Airpatrol_Crew = _this select 2;
	_briefing 			= _this select 3;
	_tickets			= _this select 4;

	_grp				= group (_NTA_Airpatrol_Crew select 0);
	_leaderGrp 			= leader _grp;
	_side 				= side _leaderGrp;
	_endPos 			= vehicle _leaderGrp getvariable ["Airpatrol_EndPos", [0,0,0]];
	_mission			= vehicle _leaderGrp getvariable ["Airpatrol_Mission", "None"];
	_vehCount 			= (count _NTA_Airpatrol_Veh);
	_SAD				= false;
	NTA_globalTaskEast		= 0;
	NTA_CrashGroup      = [];
	NTA_globalTaskWest		= 0;

	{
		//Crash Monitor
		_x addeventhandler ["Engine", {
			_this spawn {
				_veh 	= _this select 0;
				_crew 	= crew _veh;

				if (!(_this select 1))  then {
					(_this select 0) setvariable ["NTA_Airpatrol_Crash", true, true];
					_side = side (leader (group _veh));
					_crashgroup = creategroup (side (leader (group _veh)));
					_crashGroup setGroupId [format["%1_crashed", str (group _veh)]];


					[(_this select 0)] joinsilent _crashgroup;
					if (_side == WEST) then {
						NTA_CrashGroup pushback _veh;
					};

					{
						[_x] joinsilent _crashgroup;
						_x setvariable ["NTA_Airpatrol_Crash", true, true];
						_x setVariable ["AGM_AllowUnconscious", true, true];
					} foreach _crew;

					_true = true;
					"starting monitor" call Nta_fnc_log;

					while {_true} do {
						 if ((getposATL (_this select 0) select 2) <= 1.5) then {
							sleep 2;
							{
								[_x] allowGetIn false;
								_x action ["getout", vehicle _x];
								if (NTA_Airpatrol_Debug) then {
		    						[_x, true] call NTA_fnc_Airpatrol_Debug;
								};
							} foreach crew (_this select 0);
							_true = false;
						};
					};

					(_this select 0) setvariable ["NTA_Airpatrol_CrashGroup", _crashgroup, true];

					[[_veh, 2], "lock", _veh] call BIS_fnc_MP;
					_veh setVariable ["locked", true,true];

					//fireup vehicle delete in fn_airpatrol_CreateEast
					_time = time;
					waituntil {time >= (_time + 30)};
					_count = 0;
					{
						if (alive _x) then {
							_count = _count + 1;
						};
					} foreach _crew;
					//fire up West Task
					if(_side == WEST && { _count > 0 || {alive _veh}}) then {
						NTA_globalTaskWest = NTA_globalTaskWest + 1;
					} else {
						_veh setvariable ["NTA_Airpatrol_Crash", false, true];
					};

					format ["monitor done - crew alive: %1 - veh alive: %2", _count, alive _veh] call nta_fnc_log;
				};
			};
		}];

		//TaskState Monitor
		[_x, _vehCount] spawn {
			_veh 		= _this select 0;
			_endPos 	= _veh getvariable ["Airpatrol_EndPos", [0,0,0]];
			_movingHome = false;
			_localTask 	= false;
			_crashed 	= false;
			_side		= side (leader (group _veh));

			while {!_localTask && {!_movingHome}} do {
				sleep 2;
				_mission 	= _veh getvariable ["Airpatrol_Mission", "None"];
				_crashed 	= _veh getvariable ["NTA_Airpatrol_Crash", false];
				_movingHome = call {_mission == "MovingHome" && {(_veh distance _endPos) <= 1000}};

				if (_crashed) then {
					_localTask = true;
					if (_side == EAST) then {
						NTA_globalTaskEast = NTA_globalTaskEast + 1;

					};
				};
				if (!alive _veh) exitwith {
				};
			};

			str ([_crashed, _movingHome, _veh, NTA_globalTaskWest, NTA_globalTaskEast]) call nta_fnc_log;
		};
	} foreach _NTA_Airpatrol_Veh;

	switch (_side) do {
		case EAST: {
			_taskName 	= "Airstrike";
			_taskName2 	= "Seek and Destroy";
			_Task2 		= format [_NTA_Airpatrol_Task + "SAD"];

			[parseText _briefing, "hint"] call bis_fnc_mp;


				[_NTA_Airpatrol_Task, _taskName , _briefing] call SHK_Taskmaster_add;


				waituntil { NTA_globalTaskEast >= _vehCount || {str _grp == "<NULL-group>"}};

				_time = time;

				waituntil {time >= (_time + 10)};

				_briefing2 = format [localize "STR_NTA_AP_Briefing_EAST2", ({alive _x}) count _NTA_Airpatrol_Veh, (_tickets*({alive _x} count _NTA_Airpatrol_Veh)*0.5), 40];

				switch (NTA_globalTaskEast) do {
					case 0: {
						[_NTA_Airpatrol_Task, "failed"] call SHK_Taskmaster_upd;
					};
					case 1: {
						if (({alive _x} count _NTA_Airpatrol_Veh) == (count _NTA_Airpatrol_Veh)) then {
							[_NTA_Airpatrol_Task, "failed"] call SHK_Taskmaster_upd;
						} else {
							[_NTA_Airpatrol_Task, "succeeded"] call SHK_Taskmaster_upd;
							["AP", _tickets] call NTA_fnc_core_addTickets;
						};
					};
					default {
						if ({alive _x} count _NTA_Airpatrol_Veh > 0) then {
							[_NTA_Airpatrol_Task, "canceled", [_Task2, _taskName2, _briefing2]] call SHK_Taskmaster_upd;
							[parseText _briefing2, "hint"] call bis_fnc_mp;
							_SAD = true;
						} else {
							[_NTA_Airpatrol_Task, "succeeded"] call SHK_Taskmaster_upd;
							["AP", _tickets] call NTA_fnc_core_addTickets;
						};
					};
				};

				if (_SAD) then {
					_time = time;
					str ({alive _x} count _NTA_Airpatrol_Veh) call nta_fnc_log;
					waituntil {(({alive _x} count _NTA_Airpatrol_Veh) <= 0) || {time >= (_time + 40*60)}};

					if (({alive _x} count _NTA_Airpatrol_Veh) <= 0) then {
						[_Task2, "succeeded"] call SHK_Taskmaster_upd;
						["AP", (_tickets*({!alive _x} count _NTA_Airpatrol_Veh)*0.5)] call NTA_fnc_core_addTickets;

					} else {
						[_Task2, "failed"] call SHK_Taskmaster_upd;
						{
							_x setvariable ["NTA_Airpatrol_Crash", false, true];
							_x setdammage 1;
						} foreach _NTA_Airpatrol_Veh;
					};
				};
		};
		case WEST: {


			[parseText _briefing, "hint"] call bis_fnc_mp;

			waituntil {NTA_globalTaskWest >= 1 || {_mission == "MovingHome" && (_leaderGrp distance _endPos) <= 1000} || {{alive _x} count _NTA_Airpatrol_Veh  <= 0}};


			if (NTA_globalTaskWest > 0) then {
				_taskName 		= "Search and Rescue";
				_returnPointLoc = getmarkerpos "return_point_west";
				_briefing 		= format [localize "STR_NTA_AP_Briefing_WEST2", NTA_globalTaskWest, 120, 60];

				[_NTA_Airpatrol_Task, _taskName , _briefing] call SHK_Taskmaster_add;
				[parseText _briefing, "hint"] call bis_fnc_mp;

				//check if we have alive veh/crew
				_crashVeh 	= (NTA_CrashGroup select 0);
				_crashGroup = _crashVeh getvariable "NTA_Airpatrol_CrashGroup";
				_aliveCrew 	= false;
				_aliveVeh 	= false;

				if (({alive _x} count (units _crashGroup)) > 0) then {
					_aliveCrew = true;
				};

				if (alive _crashVeh) then {
					_aliveVeh = true;
				};
				if (!_aliveVeh && {!_aliveCrew}) exitwith {
					"no west task" call nta_fnc_log;
					NTA_airpatrolCache setvariable [format ["NTA_Airpatrol_%1", _side], grpnull, true];
					NTA_airpatrolCache setvariable [format ["NTA_Airpatrol_CAS_%1", _side], false, true];

					//remove serverside variable for "SAD WP" in fn_airpatrol_addwaipoints

					NTA_airpatrolCache setvariable [format ["NTA_Airpatrol_Serverside_%1", _side], false, true];
				};

				if (_aliveCrew) then {
					_crashgroup spawn {
						waitUntil {sleep 1; {_x distance (leader _this) < 750} count playableUnits > 0};
						_flare = "F_40mm_Red" createvehicle ((leader _this) ModelToWorld [0,100,200]);
						_flare setVelocity [0,0,-0.01];
						sleep 5;
						_flare = "F_40mm_Red" createvehicle ((leader _this) ModelToWorld [0,100,200]);
						_flare setVelocity [0,0,-0.01];
						waitUntil {sleep 1; {_x distance (leader _this) < 350} count playableUnits > 0};
						_flare = "F_40mm_Red" createvehicle ((leader _this) ModelToWorld [0,100,200]);
						_flare setVelocity [0,0,-0.01];
						 "SmokeShellBlue" createvehicle position (leader _this);
						sleep 5;
						_flare = "F_40mm_Red" createvehicle ((leader _this) ModelToWorld [0,100,200]);
						_flare setVelocity [0,0,-0.01];
					};
				};

				_time = time;
				waituntil {({(_x distance _returnPointLoc) < 15 && (alive _x)} count (units _crashGroup)) > 0 || {time >= (_time + 3600)} || {{alive _x} count (units _crashGroup) <= 0 && !alive _crashVeh}};

				if (time >= (_time + 3600) || {{alive _x} count (units _crashGroup) <= 0 && !alive _crashVeh}) exitwith {
					[_NTA_Airpatrol_Task, "failed"] call SHK_Taskmaster_upd;
					[parsetext format[localize "STR_NTA_AP_Idiots"], "hint"] call bis_fnc_mp;
					["AP", -50] call NTA_fnc_core_addTickets;

					{
						if (_x getvariable ["NTA_Airpatrol_Crash", false]) then {
							_x setvariable ["NTA_Airpatrol_Crash", false, true];
							if (_x iskindof "Man") then {
								deletevehicle _x;
							} else {
								_x setdammage 1;
							};
						};
					} foreach _NTA_Airpatrol_Veh + _NTA_Airpatrol_Crew;
					NTA_airpatrolCache setvariable [format ["NTA_Airpatrol_%1", _side], grpnull, true];
					NTA_airpatrolCache setvariable [format ["NTA_Airpatrol_CAS_%1", _side], false, true];

					//remove serverside variable for "SAD WP" in fn_airpatrol_addwaipoints

					NTA_airpatrolCache setvariable [format ["NTA_Airpatrol_Serverside_%1", _side], false, true];
				};

				if (_aliveCrew) then {
					if (!alive _crashVeh && {({(_x distance _returnPointLoc) < 15 && (alive _x)} count (units _crashGroup)) > 0}) then {
						[_NTA_Airpatrol_Task, "succeeded"] call SHK_Taskmaster_upd;
						["AP",120] call NTA_fnc_core_addTickets;
					};

					if(({(_x distance _returnPointLoc) < 15 && (alive _x)} count (units _crashGroup)) > 0 && {alive _crashVeh}) then {
						[_NTA_Airpatrol_Task, "succeeded"] call SHK_Taskmaster_upd;
						[90] call NTA_fnc_core_addTickets;
					};
				};

				if(_aliveVeh && !_aliverew) then {
					if (!alive _crashVeh) then {
						[_NTA_Airpatrol_Task, "succeeded"] call SHK_Taskmaster_upd;
						["AP", 60] call NTA_fnc_core_addTickets;
					};
				};

				{
					if (_x getvariable ["NTA_Airpatrol_Crash", false]) then {
						_x setvariable ["NTA_Airpatrol_Crash", false, true];
						if (_x iskindof "Man") then {
							deletevehicle _x;
						} else {
							_x setdammage 1;
						};
					};
				} foreach _NTA_Airpatrol_Veh + _NTA_Airpatrol_Crew;
			};
		};
	};

	NTA_airpatrolCache setvariable [format ["NTA_Airpatrol_%1", _side], grpnull, true];
	NTA_airpatrolCache setvariable [format ["NTA_Airpatrol_CAS_%1", _side], false, true];

	//remove serverside variable for "SAD WP" in fn_airpatrol_addwaipoints

	NTA_airpatrolCache setvariable [format ["NTA_Airpatrol_Serverside_%1", _side], false, true];
	"task done" call nta_fnc_log;

};


//[NTA_fnc_airpatrol_CreateEast, NTA_fnc_airpatrol_CreateWest];
// [[28713.2,27432.7,0],[25712.3,23039.9,0.00143242],[], []] call NTA_fnc_airpatrol_CreateEast
// [[28713.2,27432.7,0],[25712.3,23039.9,0.00143242],[], []] call NTA_fnc_airpatrol_CreateWest
//p1[26741.9,24617.5,22]
//p2[26746.8,24611.6,22]
