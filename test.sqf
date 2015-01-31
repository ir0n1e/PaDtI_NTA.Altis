private ["_object", "_time","_wp","_handler"];
	_object = _this select 0;
	_time = _this select 1;

	_pos = getposasl NTA_Admin_Board; //
	NTA_Admin_Board hideobject true;
	_dir = getdir NTA_Admin_Board;

	_board = (typeof NTA_Admin_Board) createVehicle [0,0,0];
	_board setposASL _pos;
	_board setdir _dir;
	_board setObjectTexture [0, "#(argb,512,512,1)r2t(uavrtt,1)"];

	if (player getvariable ["camactive", false]) exitwith {
		hint "Cam Active";
	};
	player setvariable ["camactive", true];
	if ((missionNamespace getVariable [format ["handlercam_%1",player],0]) > 0) then {
	removeMissionEventHandler ["Draw3d",(missionNamespace getVariable [format ["handlercam_%1",player],0])];
};


	/* create uav and make it fly */
	uav = createVehicle ["B_UAV_01_F", _object modelToWorld [0,100,100], [], 0, "FLY"];
	createVehicleCrew uav;
	uav lockCameraTo [_object, [0]];
	uav flyInHeight 100;

	/* add loiter waypoint */
	_wp = group uav addWaypoint [position _object, 0];
	_wp setWaypointType "LOITER";
	_wp setWaypointLoiterType "CIRCLE_L";
	_wp setWaypointLoiterRadius 100;

	/* create camera and stream to render surface */
	cam = "camera" camCreate [0,0,0];
	cam cameraEffect ["Internal", "Back", "uavrtt"];

	/* attach cam to gunner cam position */
	cam attachTo [uav, [0,0,0], "PiP0_pos"];

	/* make it zoom in a little */
	cam camSetFov 0.1;


	//uav hideobject true;
	/* switch cam to thermal */
	//"uavrtt" setPiPEffect [2];

	/* adjust cam orientation */
	missionNamespace setVariable [ format ["handlercam_%1",player],
	addMissionEventHandler ["Draw3D", {
	    _dir =
	        (uav selectionPosition "PiP0_pos")
	            vectorFromTo
	        (uav selectionPosition "PiP0_dir");
	    cam setVectorDirAndUp [
	        _dir,
	        _dir vectorCrossProduct [-(_dir select 1), _dir select 0, 0]
	    ];
	}]];


	sleep _time;
if ((missionNamespace getVariable [format ["handlercam_%1",player],0]) > 0) then {
	removeMissionEventHandler ["Draw3d",(missionNamespace getVariable [format ["handlercam_%1",player],0])];
};
	cam cameraEffect ["terminate", "back", "uavrtt"];
	camdestroy cam;
	deletevehicle cam;
	cam = nil;
	//removeMissionEventHandler  ["Draw3D", _handler];
	deletevehicle uav;
	uav = nil;
	deletevehicle _board;
	NTA_Admin_Board hideobject false;
	NTA_Admin_Board setObjectTexture [0, "\A3\Structures_F\Civ\InfoBoards\Data\MapBoard_Altis_CO.paa"];
	player setvariable ["camactive", false];



