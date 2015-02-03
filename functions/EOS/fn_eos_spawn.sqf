if (EOS_ACTIVE) exitwith {};
if ((count allunits - count playableUnits) > EOShardlimit ) exitwith {};
//HC Switch
if (isserver) then {

	if (!isnil "HCPresent") exitwith {

		[_this, "NTA_fnc_eos_spawn", NTAHC] call BIS_fnc_MP;
		"EOS switching to HC" call NTA_fnc_log;
		breakout "main";
	};

	"EOS switching to Server" call NTA_fnc_log;
};
_this spawn {

	_eosActive 		= _this;
	_confArray 		= _eosActive getvariable ["confArray", []];

	_enemyFaction 	= _eosActive getVariable "EOSfaction" select 0;
	_civZone      	= _eosActive getVariable "EOSfaction" select 1;
	_mAH			= _eosActive getVariable "EOSmarkerColor" select 0;
	_mAN			= _eosActive getVariable "EOSmarkerColor" select 0;

	_mkr  			= (_confArray select 0);
	_mPos 			= markerpos(_confArray select 0);

	_mkrX	     	= getMarkerSize _mkr select 0;
	_mkrY	     	= getMarkerSize _mkr select 1;
	_mkrAgl	     	= markerDir _mkr;
	_a	     		= (_confArray select 1);
	_aGrps	     	= _a select 0;
	_aSize	     	= _a select 1;
	_aMin	     	= _aSize select 0;
	_b	     		= (_confArray select 2);
	_bGrps	     	= _b select 0;
	_bSize	     	= _b select 1;
	_bMin	     	= _bSize select 0;
	_c	     		= (_confArray select 3);
	_cGrps	     	= _c select 0;
	_cSize	     	= _c select 1;
	_d	     		= (_confArray select 4);
	_dGrps	    	= _d select 0;
	_eGrps	     	= _d select 1;
	_fGrps	     	= _d select 2;
	_fSize	     	= _d select 3;
	_settings    	= (_confArray select 5);
	_faction     	= _settings select 0;
	_mA	     		= _settings select 1;
	_distance    	= _settings select 2;
	_side	     	= _settings select 3;
	_debug 			= if (count _settings > 5) then {_settings select 5} else {false};
	_cache 			= if (count _confArray > 6) then {_confArray select 6} else {false};

	_aGrp 			= [];
	_bGrp 			= [];
	_cGrp 			= [];
	_dGrp 			= [];
	_eGrp 			= [];
	_fgrp 			= [];
	_allunits 		= [];


	EOS_ACTIVE = true;
	publicVariable "EOS_ACTIVE";
	popEOS = true;
	publicVariable "popEOS";

	if (getmarkercolor _mkr == "colorblack") exitwith {};
	if !(getmarkercolor _mkr == VictoryColor)then {
		{
			if (MarkerAlpha _x != 0) then {
				_x setmarkerAlpha 0.0001;
			};
		} foreach (server getvariable ["EOSmarkers", []]);
		// AO marker (String)
		_markerstr = createMarker [str _mkr, _mPos];
		_markerstr setMarkerShape "ICON";
		_markerstr setMarkerType "MIL_DOT";
		_markerstr setMarkerColor "ColorBlack";
		_markerstr setMarkertext format ["AO %1", _mkr];
		_mkr setmarkerAlpha _mAH;
	};

	_pos = [_mPos, [1000, 3000], 10, 0] call PO3_fnc_getSafePos;
	_dir = [_mPos, _pos] call BIS_fnc_dirTo;

	if (floor (random 3) == 0) then {
		[[_Pos select 0, _Pos select 1, 0], _dir] execvm "test\arty.sqf";
	};

	//airpatrol
	[_mpos, _eosActive] spawn {
		_mpos 		= _this select 0;
		_trig 		= _this select 1;
		_time 		= time;
		_mission	= [NTA_fnc_missions_compFuel, NTA_fnc_missions_compCommand] call NTA_fnc_getRandArrayPos;
		waituntil {time >= (_time + 120) || {!triggeractivated _trig} || {{_x distance _mpos < 350} count playableunits > 0}};

		if (!triggeractivated _trig) exitwith {};


		if ((({_x distance _mpos < 500} count playableunits) > 0) && {!(_trig getvariable ["SideMissionActive", false])}) then {
			_objects = [[_mPos select 0, _mPos select 1, 0]] call _mission;
			_trig setvariable ["SideMissionActive", true, true];
			_trig setvariable ["missionObjects", _objects, true];
		};

		if (({_x distance _mpos < 350} count playableunits) > 0) then {
			{
				if (_x distance _mpos < 350) exitwith {
					_x call NTA_fnc_airpatrol_callRandom;
				};
			} count playableunits;
		};
	};

	// SPAWN STATIC PLACEMENTS
	for "_counter" from 1 to _eGrps do {
		if ((count allunits - count playableUnits) < EOShardlimit ) then {
			if (surfaceiswater _mPos) exitwith {};


			_script = [_mkr, _side, _faction] spawn {
				_mkr 		= _this select 0;
				_side 		= _this select 1;
				_faction 	= _this select 2;
				_newpos 	= [_mkr, [100, 120], 10, 0] call PO3_fnc_getSafePos;

				eGroup = [_newpos, _side, _faction, 5] call NTA_fnc_eos_spawnVehicle;
			};
			waituntil {scriptDone _script};

			_eGroup = eGroup;

			0 = [(_eGroup select 2), "STAskill"] call NTA_fnc_eos_setSkill;
			_eGrp pushback _eGroup;
			_allunits = _allunits + (units (_eGroup select 2));

			0 = [leader (_eGroup select 2)] execVM "scripts\UPSMON\MON_artillery_add.sqf";
			eGroup = nil;
		};
	};

	// SPAWN LIGHT VEHICLES
	for "_counter" from 1 to _cGrps do {
		if ((count allunits - count playableUnits) < EOShardlimit ) then {


			_script = [_mkr, _side, _faction, _cSize] spawn {
				_mkr 		= _this select 0;
				_side 		= _this select 1;
				_faction 	= _this select 2;
				_cSize 		= _this select 3;
				_newpos 	= [_mkr, [50, 120], 10] call PO3_fnc_getSafePos;
				_vehType   	= 7;
				_cargoType 	= 9;

				if (surfaceiswater _newpos) then {
					_vehType   = 8;
					_cargoType = 10;
				};

				cGroup = [_newpos, _side, _faction, _vehType] call NTA_fnc_eos_spawnVehicle;

				if ((_cSize select 0) > 0) then {
					0 = [(cGroup select 0), _cSize, (cGroup select 2), _faction, _cargoType] call NTA_fnc_eos_setcargo;
				};
			};

			waitUntil {scriptDone _script};
			_cGroup 	= cGroup;
			0 = [(_cGroup select 2), "LIGskill"] call NTA_fnc_eos_setSkill;
			// 0 = [(_cGroup select 2),_mkr] call EOS_fnc_taskpatrol;
			_cGrp pushback _cGroup;
			_allunits = _allunits + (units (_cGroup select 2));

			0 = [leader (_cGroup select 2), _mkr, "SHOWMARKER", "SPAWNED", "AWARE", "LIMITED"] execVM "scripts\UPSMON.sqf";
			cGroup 		= nil;
		};
	};


	_houses = (nearestObjects [_mPos, ["house"], 200]);// Count number of houses in town
	// SPAWN PATROLS
	for "_counter" from 1 to _bGrps do {
		if ((count allunits - count playableUnits) < EOShardlimit ) then {

			if (_cache) then {
				_cacheGrp = format ["PA%1", _counter];
				_units	  = _eosActive getvariable _cacheGrp;
				_bSize	  = [_units, _units];
				_bMin	  = _bSize select 0;
				if (_debug) then {
					player sidechat format ["ID:%1,restore - %2", _cacheGrp, _units];
				};
			};
			if (_bMin > 0) then {

				_pos = [_mkr, [random 100, random 550], 10, 0] call PO3_fnc_getSafePos;

				_script = [_pos, _bSize, _faction, _side] spawn {
					private ["_pos", "_bSize", "_faction", "_side"];
					_pos 		= _this select 0;
					_bSize 		= _this select 1;
					_faction 	= _this select 2;
					_side 		= _this select 3;

					bGroup = [_pos, _bSize, _faction, _side] call NTA_fnc_eos_spawnGroup;
				};
				waituntil {scriptDone _script};

				_bGroup = bGroup;

				// 0 = [_bGroup,_mkr] call EOS_fnc_taskpatrol;
				_bGrp pushback _bGroup;
				_allunits = _allunits + (units _bGroup);
				0 = [_bGroup, "INFskill"] call NTA_fnc_eos_setSkill;

				if (_counter == _bGrps) then {

					0 = [leader _bGroup, _mkr, "SHOWMARKER", "AMBUSH","RANDOM","SPAWNED", "LIMITED"] execVM "scripts\UPSMON.sqf";
				} else {
					0 = [leader _bGroup, _mkr, "SHOWMARKER", "SPAWNED", "SAFE", "LIMITED"] execVM "scripts\UPSMON.sqf";
				};
				bGroup = nil;
			};
		};
	};

	// SPAWN HOUSE PATROLS
	for "_counter" from 1 to _aGrps do {
		if ((count allunits - count playableUnits) < EOShardlimit ) then {

			if (_cache) then {
				_cacheGrp = format ["HP%1", _counter];
				_units	  = _eosActive getvariable _cacheGrp;
				_aSize	  = [_units, _units];
				_aMin	  = _aSize select 0;
			};

			if (_aMin > 0) then {
				_pos = [_mkr, [10, 100], 5, 0] call PO3_fnc_getSafePos;

				_script = [_pos, _aSize, _faction, _side] spawn {
					private ["_pos", "_aSize", "_faction", "_side"];
					_pos 		= _this select 0;
					_aSize 		= _this select 1;
					_faction 	= _this select 2;
					_side 		= _this select 3;

					aGroup = [_pos, _aSize, _faction, _side] call NTA_fnc_eos_spawnGroup;
				};
				waitUntil {scriptDone _script};

				_aGroup = aGroup;

				_aGrp pushback _aGroup;
				_allunits = _allunits + (units _aGroup);

				0 = [_aGroup, "INFskill"] call NTA_fnc_eos_setSkill;
				if (count _houses > 10) then {
					0 = [leader _aGroup, _mkr, "SHOWMARKER", "RANDOMA","SPAWNED", "FORTIFY","NOWP", "SAFE", "LIMITED"] execVM "scripts\UPSMON.sqf";
				} else {
					0 = [leader _aGroup, _mkr, "SHOWMARKER","SPAWNED", "LIMITED", "SAFE"] execVM "scripts\UPSMON.sqf";
				};
				aGroup = nil;
			};
		};
	};

	// SPAWN ARMOURED VEHICLES
	for "_counter" from 1 to _dGrps do {
		if ((count allunits - count playableUnits) < EOShardlimit ) then {

			_newPos = [_mkr, [50, 120], 10] call PO3_fnc_getSafePos;

			_script = [_newPos, _side, _faction] spawn {
				_newPos 	= _this select 0;
				_side 		= _this select 1;
				_faction 	= _this select 2;
				_vehType 	= 2;

				if (surfaceiswater _newPos) then {
					_vehType = 8;
				};

				dGroup = [_newPos, _side, _faction, _vehType] call NTA_fnc_eos_spawnVehicle;
			};
			waituntil {scriptdone _script};
			_dGroup = dGroup;

			0 = [(_dGroup select 2), "ARMskill"] call NTA_fnc_eos_setSkill;
			// 0 = [(_dGroup select 2),_mkr] call EOS_fnc_taskpatrol;
			_dGrp pushback _dGroup;
			_allunits = _allunits + (units (_dGroup select 2));

			0 = [leader (_dGroup select 2), _mkr, "SHOWMARKER","SPAWNED", "LIMITED", "SAFE"] execVM "scripts\UPSMON.sqf";
			dGroup = nil;
		};
	};

	// cause of Airpatrol wie dont need this
	// SPAWN CHOPPER
	/*
	for "_counter" from 1 to _fGrps do {

		if ((_fSize select 0) > 0) then {_vehType = 4} else {_vehType = 3};
		_newpos = [(markerpos _mkr), 1500, random 360] call BIS_fnc_relPos;
		_fGroup = [_newpos, _side, _faction, _vehType, "fly"] call NTA_fnc_eos_spawnVehicle;
		_fGrp set [count _fGrp, _fGroup];
		_allunits = _allunits + (units (_fGroup select 2));

		if ((_fSize select 0) > 0) then {
			_cargoGrp = createGroup _side;
			0	  = [(_fGroup select 0), _fSize, _cargoGrp, _faction, 9] call NTA_fnc_eos_setcargo;
			0	  = [_cargoGrp, "INFskill"] call NTA_fnc_eos_setSkill;
			_fGroup set [count _fGroup, _cargoGrp];
			_allunits = _allunits + (units _cargoGrp);
			null = [_mkr, _fGroup, _counter] execvm "eos\functions\TransportUnload_fnc.sqf";
		} else {
			_wp1 = (_fGroup select 2)addWaypoint [(markerpos _mkr), 0];
			_wp1 setWaypointSpeed "FULL";
			_wp1 setWaypointType "SAD";
		};

		0 = [(_fGroup select 2), "AIRskill"] call NTA_fnc_eos_setSkill;

		if (_debug) then {
			player sidechat format ["Chopper:%1", _counter];
			0 = [_mkr, _counter, "Chopper", (getpos leader (_fGroup select 2))] call EOS_debug;
		};
	};
	*/
	_this setvariable ["Groups", [_aGrp, _bGrp, _cGrp, _dGrp, _eGrp, _fgrp], true];
	_this setvariable ["allunits", _allunits, true];


	[_this, _allunits, _mkr, _maN] spawn {
		_trig 		= _this select 0;
		_allunit 	= _trig getvariable ["allunits", []];
		_mkr 		= _this select 2;
		_maN 		= _this select 3;
		sleep 10;

		// give upsmon some time
		popEOS = false;
		publicVariable "popEOS";

		waituntil {({alive _x} count _allunit < 5) || !triggeractivated _trig};

		if (EOS_ACTIVE && {{alive _x} count _allunit < 5}) then {
			_trig setvariable ['eosclear', true, true];
			_mkr setmarkercolor VictoryColor;
			_mkr setmarkerAlpha _mAN;
			deletemarker str _mkr;

		};
		{
			if (!(getmarkercolor _x == VictoryColor) && {MarkerAlpha _x == 0.0001}) then {
				_x setmarkerAlpha (_trig getVariable "EOSmarkerColor" select 0);
			};
		} foreach (server getvariable ["EOSmarkers", []]);
	};
};