if (isserver) then {

	if (!isnil "HCPresent") exitwith {
		[_this, "NTA_fnc_civilians_core", NTAHC] call BIS_fnc_mp;
		"Civilians switching to HC" call NTA_fnc_log;
		breakout "main";
	};

	"Civilians switching to Server" call NTA_fnc_log;
};

_this spawn {
	private ["_weapon", "_groupCount","_localGrpCount","_grp","_rdCount","_n","_r","_tempUnit","_tempVeh","_civscount","_i","_trigger","_garbage", "_patrolArray"];

	_mkr = _this select 0;
	// Get trigger status
	_trigID = format["trig%1", _mkr];

	server setvariable [format["%1_civcount", _trigID], 0, true];
	_isActive = server getvariable _trigID;

	// Get stored town variables
	_popVar 		= format["population%1", _mkr];
	_information 	= server getvariable _popVar;
	_civilians 		= _information select 0;
	_vehicles 		= _information select 1;
	_parked 		= _information select 2;
	_roadPosArray 	= _information select 3;
	_houses 		= _information select 4;
	_garbage 		= _information select 5;

	if (debugCOS) then {
		COSGlobalSideChat = [_civilians, _vehicles, _parked, _mkr,server getvariable [format["trig%1_hostilefactor", _mkr], 0]];
		publicvariable "COSGlobalSideChat";
		player groupChat (format ["Town:%4 .Factor:%5 .Civilians:%1 .Vehicles:%2 .Parked:%3",
			_civilians, _vehicles, _parked, _mkr, server getvariable [format["trig%1_hostilefactor", _mkr], 0]]);//for singleplayer
		[_mkr, nil, "town"] call NTA_fnc_civilians_debug;
	};

	_showRoads = false;
	if (_showRoads) then {
		{
			_txt = format["roadMkr%1",_x];
			_debugMkr = createMarker [_txt, getpos _x];
			_debugMkr setMarkerShape "ICON";
			_debugMkr setMarkerType "hd_dot";
		} foreach _roadPosArray;
	};

	_glbGrps 	= server getvariable "cosGrpCount";
	_townGrp 	= createGroup DefaultSide;
	_localGrps 	= 1;

	waituntil {!populatingCOS};
	populatingCOS = true;
	publicvariable "pobulatingCOS";
	_glbGrps = server getvariable "cosGrpCount";

	//SPAWN CIVILIANS NOW
	_civilianArray 	= [];
	_vehicleArray 	= [];
	_PatrolVehArray = [];
	_ParkedArray 	= [];
	_garbageArray 	= [];
	_fireArray 		= [];
	_patrolArray 	= [];

	_roadPosArray 	= _roadPosArray call BIS_fnc_arrayShuffle;
	_UnitList 		= COScivPool call BIS_fnc_arrayShuffle;
	_vehList 		= COSmotPool call BIS_fnc_arrayShuffle;
	_countVehPool 	= count _vehList;
	_countPool 		= count _UnitList;
	_v 				= 0;
	_n 				= 0;
	_rdCount 		= 0;

	_patrolArray = [[getmarkerpos _mkr select 0, getMarkerPos _mkr select 1, 0], 500] call NTA_fnc_vehicles_createPatrol;

	// SPAWN PEDESTRIANS
	_civscount = (server getvariable "civcount");

	for "_i" from 1 to _civilians do {
		if (!(server getvariable _trigID)) exitwith {_isActive=false;};

		if (_i >= _countPool) then {
			if (_n >= _countPool) then {_n=0;};
			_tempUnit =_UnitList select _n;
			_n = _n + 1;
		};

		if (_i < _countPool) then {
			_tempUnit = _UnitList select _i;
		};

		_tempPos = _roadPosArray select _rdCount;
		_rdCount = _rdCount+1;

		if (COSmaxGrps < (_glbGrps + _localGrps + 1)) then {
			_grp = _townGrp;
		} else {
			_grp = createGroup DefaultSide;
			_localGrps = _localGrps + 1;
		};

		if ((server getvariable "civcount") < COShardlimit) then {

			_script = [_grp, _tempUnit, _tempPos] spawn {
				_grp 		= _this select 0;
				_tempUnit 	= _this select 1;
				_tempPos 	= _this select 2;

				SpawnUnit = _grp createUnit [_tempUnit, _tempPos, [], 0, "NONE"];
			};

			waituntil {scriptDone _script};

			_unit = SpawnUnit;
			SpawnUnit = nil;
			_civilianArray pushback _grp;

			if  (_i < 3) then {
				_unit setvariable ["agent", true];
			};

			[_unit, _houses, _mkr] call NTA_fnc_civilians_setDefaults;
			[_unit, _roadPosArray, _mkr] call NTA_fnc_civilians_patrol;
			server setvariable ["civcount", _civscount + _i, true];


			if (debugCOS) then {
				[_unit, _trigID, "unit"] call NTA_fnc_civilians_debug;
			};
		};
	};

	server setvariable [format["%1_civcount", _trigID], count _civilianArray, true];
	_i = 1;
	// SPAWN VEHICLES
	for "_i" from 1 to _vehicles do {
		if (!(server getvariable _trigID)) exitwith {_isActive=false;};

		if (_i >= _countVehPool) then {
			if (_v >= _countVehPool) then {_v = 0;};
				_tempVeh = _vehList select _v;
				_v = _v + 1;
			};
		if (_i < _countVehPool) then {
			_tempVeh = _vehList select _i;
		};

		if (_i >= _countPool) then {
			if (_n >= _countPool) then {_n=0;};
				_tempUnit=_UnitList select _n;
				_n=_n+1;
			};
		if (_i < _countPool) then {
			_tempUnit=_UnitList select _i;
		};

		_tempPos = _roadPosArray select _rdCount;
		_rdCount = _rdCount + 1;
		_roadConnectedTo = roadsConnectedTo _tempPos;
		_connectedRoad = _roadConnectedTo select 0;
		_direction = [_tempPos, _connectedRoad] call BIS_fnc_DirTo;

		if (COSmaxGrps < (_glbGrps + _localGrps + 1)) then {
			_grp = _townGrp;
		} else {
			_grp = createGroup DefaultSide;
			_localGrps = _localGrps+1;
		};

		_script = [_grp, _tempVeh, _tempPos, _tempUnit] spawn {
			_grp 		= _this select 0;
			_tempVeh 	= _this select 1;
			_tempPos 	= _this select 2;
			_tempUnit 	= _this select 3;

			SpawnVeh = createVehicle [_tempVeh, _tempPos, [], 0, "NONE"];
			SpawnUnit = _grp createUnit [_tempUnit, getpos SpawnVeh, [], 0, "CAN_COLLIDE"];
		};

		waituntil{scriptDone _script};

		_unit 		= SpawnUnit;
		_veh 		= SpawnVeh;
		SpawnUnit 	= nil;
		SpawnVeh 	= nil;

		_unit assignAsDriver _veh;
		_unit moveInDriver _veh;
		[_unit, _roadPosArray, _mkr] call NTA_fnc_civilians_patrol;
		[_unit, _houses, _mkr] call NTA_fnc_civilians_setDefaults;

		_vehPack = [_veh, _unit, _grp];
		_PatrolVehArray pushBack _grp;
		_vehicleArray  pushBack _vehPack;

		if (debugCOS) then {
			[_unit, _trigID, "unit"] call NTA_fnc_civilians_debug;
		};
	};

	// SPAWN PARKED VEHICLES
	for "_i" from 1 to _parked do {
		if (!(server getvariable _trigID)) exitwith {_isActive=false;};
		if (_i >= _countVehPool) then {
			if (_v >= _countVehPool) then {
				_v = 0;
			};
				_tempVeh=_vehList select _v;
				_v = _v + 1;
			};
		if (_i < _countVehPool) then {
			_tempVeh = _vehList select _i;
		};

		_tempPos = _roadPosArray select _rdCount;
		_rdCount = _rdCount+1;
		_roadConnectedTo = roadsConnectedTo _tempPos;
		_connectedRoad = _roadConnectedTo select 0;
		_direction = [_tempPos, _connectedRoad] call BIS_fnc_DirTo;

		_script = [_tempVeh, _tempPos] spawn {
			_tempVeh = _this select 0;
			_tempPos = _this select 1;

			SpawnVeh = createVehicle [_tempVeh, _tempPos, [], 0, "NONE"];
			SpawnVeh setPos [(getPos SpawnVeh select 0)-6, getPos SpawnVeh select 1, getPos SpawnVeh select 2];
		};
		waitUntil {scriptDone _script};
		_veh = SpawnVeh;
		SpawnVeh = nil;
		_veh setdir _direction;


		_ParkedArray pushback _veh;
		if (debugCOS) then {
			_txt=format["Park%1,mkr%2",_i,_mkr];
			_debugMkr=createMarker [_txt,getpos _veh];
			_debugMkr setMarkerShape "ICON";
			_debugMkr setMarkerType "hd_dot";
			_debugMkr setMarkerText "Park Spawn";
		};
	};

	_oldpos = [0,0,0];
	for "_i" from 1 to _garbage do {
		if (!(server getvariable _trigID)) exitwith {_isActive=false;};

		_tempPos = _roadPosArray call NTA_fnc_getRandArrayPos;

		_roadConnectedTo = roadsConnectedTo _tempPos;
		_connectedRoad = _roadConnectedTo select 0;
		_direction = [_tempPos, _connectedRoad] call BIS_fnc_DirTo;

		_script = [_tempPos] spawn {
			_tempPos = _this select 0;
			SpawnVeh = createVehicle [COSgarbagePool call NTA_fnc_getRandArrayPos, _tempPos, [], 0, "CAN_COLLIDE"];
			SpawnVeh setPos [(getPos SpawnVeh select 0) - 8, getPos SpawnVeh select 1, getPos SpawnVeh select 2];
		};
		waitUntil {scriptDone _script};
		_veh = SpawnVeh;
		SpawnVeh = nil;
		_veh setdir _direction;

		_veh setvariable ["burning", false];

		 if ((server getvariable format ["%1_hostilefactor",_trigID]) > 4 && {_i < 3}) then {
		 	_fire = _veh call NTA_fnc_vehicles_createFire;
		 	_fireArray pushback _fire;
		 };
		_garbageArray pushback _veh;

		_oldpos = _tempPos;
		IF (debugCOS) then {
			_txt = format["Garbage%1,mkr%2", _i, _mkr];
			_debugMkr = createMarker [_txt, getpos _veh];
			_debugMkr setMarkerShape "ICON";
			_debugMkr setMarkerType "hd_dot";
			_debugMkr setMarkerColor "ColorRed";
			_debugMkr setMarkerText "Garbage Spawn";
		};
	};

	//null =[_veh] execVM "cos\addScript_Vehicle.sqf";

	// Apply Patrol script to all units
	//[_civilianArray,_PatrolVehArray,_roadPosArray,_mkr] call NTA_fnc_civilians_patrol;

	if (debugCOS) then {player sidechat  (format ["Roads used:%1. Roads Stored %2",_rdCount,count _roadPosArray])};

	// Count groups
	_glbGrps = server getvariable "cosGrpCount";
	_glbGrps = _glbGrps + _localGrps;
	server setvariable ["cosGrpCount", _glbGrps,true];
	server setvariable [format["%1_units", _trigID], [_civilianArray, _vehicleArray, _ParkedArray,_garbageArray,_fireArray, _patrolArray],true];

	populatingCOS = false;
	publicvariable "populatingCOS";
	// Show town label if town still active
	if (showTownLabel and (server getvariable _trigID)) then {
		_factor = (server getvariable format ["%1_hostilefactor",_trigID]);
		COSTownLabel=[(_civilians + _vehicles), _mkr, _factor];
		PUBLICVARIABLE "COSTownLabel";

		_population = format ["Population: %1",_civilians+_vehicles];
		0 = [markerText _mkr,_population,format["RiotFactor: %1",_factor]] spawn BIS_fnc_infoText;// FOR USE IN SINGLEPLAYER
	};
};