/*
 Civilian Occupation System (COS)
 By BangaBob v0.5

 null=[] execVM "cos/cosInit.sqf";

 IMPORTANT: BEFORE PROCEEDING ADD AN OBJECT NAMED server INTO THE EDITOR.

 To edit population of zones browse to line 95
 Open COS/AddScript_Unit.sqf to apply scripts to spawned units.
 Open COS/AddScript_Vehicle.sqf to apply scripts to spawned vehicles.
 To get Array of COS markers use _allMarkers=server getvariable "COSmarkers";
*/
fnc_delete_marker = {
	deleteMarkerLocal _this;
	deleteMarker _this;
};

_this spawn {
	"Starting Civilians Init" call NTA_fnc_log;
	private "_time";
	_time = diag_ticktime;

	COS_distance = 800;//Set spawn distance
	COShardlimit = 15;
	publicvariable "COShardlimit";

	COS_isHC =  ( !(hasInterface) && !(isserver) );

	blackListTowns = [
		"Sagonisi",
		"sagonisi",
		"Kamino Firing Range",
		"Stratis Air Base",
		"Camp Maxwell",
		"Kavala",
		"Aggelochori",
		"Poliakko",
		"Katalaki",
		"Neochori",
		"Stavros",
		"Lakka",
		"Alikampos",
		"Delfinaki",
		"Ioannina",
		"Paros",
		"Kalochori"
	];// Remove towns from COS

	whiteListMkrs = [
		"CIV_Kavala",
		"CIV_Neochori",
		"CIV_Delfinaki",
		"CIV_Paros"
	];// Add Custom Markers for COS to populate

	DefaultSide = Civilian;// Set side of units spawned
	publicvariable "Defaultside";

	_showMarker = false;// Show COS markers on map

	showTownLabel = false;// Show town information when entering COS zones
	publicvariable "showTownLabel";

	debugCOS = false;// Show spawned units on the map
	publicvariable "debugCOS";
	COSpedestrians = true; //Spawn pedestrians
	COScars = true;// Spawn Cars
	COSparked = true;// Spawn parked cars

	// Types of units that will be spawned as civilians.
	COScivPool =["C_man_1","C_man_1_1_F","C_man_1_2_F","C_man_1_3_F","C_man_hunter_1_F","C_man_p_beggar_F","C_man_p_beggar_F_afro","C_man_p_fugitive_F","C_man_p_shorts_1_F","C_man_polo_1_F","C_man_polo_2_F","C_man_polo_3_F","C_man_polo_4_F","C_man_polo_5_F","C_man_polo_6_F","C_man_shorts_1_F","C_man_shorts_2_F","C_man_shorts_3_F","C_man_shorts_4_F","C_man_w_worker_F"];
	COSmotPool =["C_Hatchback_01_F","C_Hatchback_01_sport_F","C_Offroad_01_F","C_SUV_01_F","C_Van_01_box_F","C_Van_01_fuel_F","C_Van_01_transport_F"];
	COSgarbagePool = ["Land_Wreck_Car3_F", "Land_Wreck_CarDismantled_F", "Land_Wreck_Van_F", "Land_MetalBarrel_F", "Land_Tyres_F"];
	publicvariable "COScivPool";
	publicvariable "COSmotPool";
	publicvariable "COSgarbagePool";


	COSmaxGrps = 20;//Set Maximum group limit for COS at any one time (If limit is hit then civilians will be placed into a single group for each town)
	publicvariable "COSmaxGrps";

	// Browse to line 81 to customise number of civilians that spawn.
	private ["_sizeX","_sizeY","_name","_pos","_mSize","_rad","_civilians","_vehicles","_parked","_actCond", "_garbage", "_slack"];

	populatingCOS = true;
	publicvariable "pobulatingCOS";
	cosMkrArray = [];
	server setvariable ["cosGrpCount",0, true];//Set global group count
	_rad = 20;// Radius increase increment for finding minimum spawn points
	_slack = 0;// Additional spawn points

	{
		// Organise towns and markers
		if (_x in whiteListMkrs) then {
			_sizeX = getMarkerSize _x select 0;
			_sizeY = getMarkerSize _x select 1;
			_pos = markerpos _x;
			_name = markerText _x;// Get the markers description
			if (_name == "") then {_name= _x;};
			// If description is empty then use marker name
			_x setMarkerAlpha 0;

			[_x,"fnc_delete_marker",nil,true] call BIS_fnc_MP;
			deletemarker _x;// Delete user placed marker
		} else {
		 	_name = text _x;// Get name
		 	_sizeX = getNumber (configFile >> "CfgWorlds" >> worldName >> "Names" >> (text _x) >> "radiusA");
		 	_sizeY = getNumber (configFile >> "CfgWorlds" >> worldName >> "Names" >> (text _x) >> "radiusB");
			_pos=getpos _x;
		};
		if (({_name==_x} count blackListTowns) == 0 && {_name != ""}) then {


			// Scan for houses around the town area
			if (_sizeX < 50) then {_sizeX=300;};
			if (_sizeY < 50) then {_sizeY=300;};

			_mSize=_sizeX;

			if (_sizeY>_sizeX) then {
				_mSize=_sizeY
			};// Get the largest size
			_houses = (nearestObjects [_pos, ["house"], 400]);// Count number of houses in town
			_Numhouses = count _houses;
			// Customise population by number of houses
			_randomisation = 5;
			if (_Numhouses <= 10) then {
				_civilians = 5 + round(random _randomisation);// Civilians spawned
				_vehicles = 0;// Moving Vehicles Spawned
				_parked = 1;// Parked Vehicles Spawned
				_garbage = 5;
			};
		 	if (_Numhouses <= 30 and _Numhouses > _randomisation) then {
				_civilians = 8 + round(random _randomisation);// Civilians spawned
				_vehicles = 2;// Moving Vehicles Spawned
				_parked = 2;// Parked Vehicles Spawned
				_garbage = 5;
			};

		 	if (_Numhouses <= 70 and _Numhouses > 30) then {
				_civilians = 12+ round(random _randomisation);// Civilians spawned
				_vehicles = 3;// Moving Vehicles Spawned
				_parked = 2;// Parked Vehicles Spawned
				_garbage = 5;
			};

		 	if (_Numhouses <= 140 and _Numhouses > 70) then {
				_civilians = 15 + round(random _randomisation);// Civilians spawned
				_vehicles = 3;// Moving Vehicles Spawned
				_parked = 2;// Parked Vehicles Spawned
				_garbage = 5;
			};
		 	if (_Numhouses > 140) then {
				_civilians = 20 + round(random _randomisation);// Civilians spawned
				_vehicles = 3;// Moving Vehicles Spawned
				_parked = 2;// Parked Vehicles Spawned
				_garbage = 5;
			};

			if (!COSpedestrians) then {_civilians = 0;};	// If pedestrians disabled spawn 0
		 	if (!COScars) then {_vehicles = 0;};// If cars disabled spawn 0
		 	if (!COSparked) then {_parked = 0;};// If parked cars disabled spawn 0

		 	_hostilefactor = floor(random 7);
			// Create marker over town
			_markerID=format ["COSmkrID%1",_name];
			_foo = createmarker [_markerID, [(_pos select 0) + 5, (_pos select 1) + 10, 0]];
			_foo setMarkerShape "ICON";
			_foo setMarkerType "hd_dot";
			_foo setMarkerText format ["%1 Factor %2",_name, _hostilefactor];
			cosMkrArray pushBack _foo;
			if (!_showMarker) then {
				_foo setmarkerAlpha 0;
			} else {
				_foo setmarkerAlpha 0.5;
			};// Show or hide marker

			// Get positions until we have enough for the population
		 	_roadlist = _pos nearRoads _mSize;
		 	_minPositions=(_civilians+_vehicles+_parked+_slack+_garbage);
		 	if (count _roadlist < _minPositions) then {
				while {count _roadlist < _minPositions} do {
					_rad=_rad+_rad;
					_roadlist = _pos nearRoads (_mSize+_rad);
				};
			};

			// Sort a position for each civilian
			_roadPosArray = [];
			_roadPosArray resize _minPositions;
			_roadlist = _roadlist call BIS_fnc_arrayShuffle;

		 	for "_n" from 0 to _minPositions do {
		    	_roadPosArray set [_n, _roadlist select _n];
			};

			// Save all information
			_information = [_civilians, _vehicles, _parked, _roadPosArray, _houses, _garbage];
			_popVar = format["population%1",_foo];
			server setvariable [_popVar,_information, true];
			server setvariable ["civcount",0, true];


			// Create a trigger over town
			_trigger = createTrigger ["EmptyDetector",_pos];
			_trigger setTriggerArea [(COS_distance+_sizeX),(COS_distance+_sizeY),0,FALSE];
			_trigger setTriggerActivation ["ANY","PRESENT",true];
			_trigger setTriggerTimeout [1, 1, 3, true];
			_actCond = "{vehicle _x in thisList && isplayer _x && ((getPosATL _x) select 2) < 15} count playableunits > 0";
			_var = format["trig%1", _markerID];

			_trigAct = format [
				"server setvariable [%2,true, true];
				[%1] call NTA_fnc_civilians_core;",
				str _foo,str _var
			];
			_trigDe = format [
				"server setvariable [%2,false, true];
				[%1] call NTA_fnc_civilians_delete;",
				str _foo, str _var
			];
			_trigger setTriggerStatements [_actCond,_trigAct,_trigDe];
			server setvariable [format ["%1_hostilefactor",_var],_hostilefactor, true];
		};

	} foreach (nearestLocations [getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition"), ["NameCityCapital","NameCity","NameVillage","CityCenter"], 25000]) +whiteListMkrs;

	// All towns have been saved into cos Marker Array.
	server setvariable ["COSmarkers", cosMkrArray,true];
	populatingCOS = false;
	publicvariable "populatingCOS";

	// LOCAL SCRIPTS
	//_mkrs=server getvariable "COSmarkers";// Use this to get all town markers
	null=[] call NTA_fnc_civilians_townInfo; // "COS\localScript.sqf";// This shows messages for players during multiplayer

	format ["Civilians Init Done... %1s isHC: %2 isServer: %3", diag_ticktime - _time, COS_isHC, isserver] call NTA_fnc_log;
};