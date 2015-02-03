#define TASK_TIME_SHORT 	60*60
#define TASK_TIME_LONG		75*60
_this spawn {

	fn_taskDestroy = {
		private ["_task", "_objects", "_time", "_tickets", "_briefing", "_pos", "_taskName", "_objectsArray", "allObjects"];
		_task 		= _this select 0;
		_objectsArray 	= _this select 1;
		_pos		= _this select 2;
		_taskName 	= _this select 3;
		_objects	= _objectsArray select 0;
		_Dam		= _objectsArray select 1;
		_time 		= time;
		_tickets	= (count _objects) * 15;
		_briefing	= format [localize "STR_NTA_Missions_Destroy", date, TASK_TIME_SHORT/60, _tickets, _taskName];
		_allObjects = server getvariable [_task, []];

		[parseText _briefing, "hint"] call bis_fnc_mp;
		[_task, format ["Destroy %1", _taskName] , _briefing] call SHK_Taskmaster_add;
		if (!_dam) then {
			waituntil {{alive _x} count _objects <= 0 || {time >= (_time + TASK_TIME_SHORT)}};

			if (time >= (_time + TASK_TIME_SHORT)) then {
				[_Task, "failed"] call SHK_Taskmaster_upd;
			} else {
				[_Task, "succeeded"] call SHK_Taskmaster_upd;
				["Task", _tickets] call NTA_fnc_core_addTickets;
			};
		} else {
			waituntil {{alive _x} count _objects <= 0};
			[_Task, "succeeded"] call SHK_Taskmaster_upd;
			["Task", _tickets] call NTA_fnc_core_addTickets;
		};

		_time = time;
		waitUntil {sleep 10; !({_x distance _this > 500} count playableUnits == 0) || {time >= (_time + (10*60))}};
		{
			deletevehicle _x;
		} foreach _allObjects;

	};

	fn_taskKill = {
		private ["_task", "_objects", "_time", "_tickets", "_briefing", "_pos", "_taskName", "_allObjects"];
		_task 		= _this select 0;
		_objects 	= _this select 1;
		_pos		= _this select 2;
		_taskName 	= _this select 3;
		_time 		= time;
		_tickets	= (count _objects) * 60;
		_briefing	= format [localize "STR_NTA_Missions_Kill", date, name (_objects select 0), TASK_TIME_SHORT/60, _tickets];
		_allObjects = server getvariable [_task, []];

		[parseText _briefing, "hint"] call bis_fnc_mp;
		[_task, "Kill Objective" , _briefing] call SHK_Taskmaster_add;
		sleep 4;
		waituntil {{alive _x} count _objects <= 0 || {time >= (_time + TASK_TIME_SHORT)}};

		if (time >= (_time + TASK_TIME_SHORT)) then {
			[_Task, "failed"] call SHK_Taskmaster_upd;
		} else {
			[_Task, "succeeded"] call SHK_Taskmaster_upd;
			["Task", _tickets] call NTA_fnc_core_addTickets;
		};

		_time = time;
		waitUntil {sleep 10; !({_x distance _this > 500} count playableUnits == 0) || {time >= (_time + (10*60))}};
		{
			deletevehicle _x;
		} foreach _allObjects;

	};


	fn_taskIntel = {
		private ["_task", "_object", "_time", "_tickets", "_briefing", "_pos", "_taskName", "_cacheType", "_allObjects"];
		_task 		= _this select 0;
		_object 	= _this select 1;
		_pos		= _this select 2;
		_taskName 	= _this select 3;
		_time 		= time;
		_tickets	= 50;
		_briefing	= format [localize "STR_NTA_Missions_Intel", date, TASK_TIME_SHORT/60, _tickets];
		_cacheType 	= PO3_target_cache_types select ([west,east,resistance] find (PO3_side_3 select 0));
		_allObjects = server getvariable [_task, []];

		[parseText _briefing, "hint"] call bis_fnc_mp;
		[_task, "Find Intel" , _briefing] call SHK_Taskmaster_add;

		_object addAction ["Take Intel", {deletevehicle (_this select 0);}, _task];

		waituntil {!alive _object || {(time >= _time + TASK_TIME_SHORT)}};

		if (time >= (_time + TASK_TIME_SHORT)) exitwith {
			[_Task, "failed"] call SHK_Taskmaster_upd;
		};

		_object = createVehicle [_cacheType,[0,0,0],[],0,"NONE"];
		_object allowdammage false;
		_object setpos ([ [_pos, [50, 200], random 360, false],15,5,0,0.3] call PO3_fnc_getSafePos);
		_time = time;
		_object allowdammage true;

		["Task", _tickets] call NTA_fnc_core_addTickets;
		[_task, "succeeded"] call SHK_Taskmaster_upd;
		[parseText format [localize "STR_NTA_Missions_DestroyCaches", date, TASK_TIME_SHORT/60, _tickets], "hint"] call bis_fnc_mp;
		[format ["%1C", _task], 'Destroy Caches', format [localize "STR_NTA_Missions_DestroyCaches", date, TASK_TIME_SHORT/60, _tickets]] call SHK_Taskmaster_add;

		sleep 5;
		waituntil {!alive _object || {time >= _time + TASK_TIME_SHORT}};

		if (time >= (_time + TASK_TIME_SHORT)) then {
			[format ["%1C", _task], "failed"] call SHK_Taskmaster_upd;
		} else {
			[format ["%1C", _task], "succeeded"] call SHK_Taskmaster_upd;
			["Task", _tickets] call NTA_fnc_core_addTickets;
		};

		_time = time;
		waitUntil {sleep 10; !({_x distance _this > 500} count playableUnits == 0) || {time >= (_time + (10*60))}};
		{
			deletevehicle _x;
		} foreach _allObjects;

	};

	publicVariableServer "fn_taskIntel";
	publicVariableServer "fn_taskKill";
	publicVariableServer "fn_taskDestroy";



	_task 			= _this select 0;
	_pos			= _this select 1;
	_TaskName		= _this select 2;
	_objTargets 	= _this select 3;
	_taskArray		= [];
	_dam 			= false;
	_taskArray pushback _objTargets;

	if (count _this > 4) then {
		_taskArray pushback (_this select 4);

	};

	if (count _this > 5) then {
		_taskArray pushback (_this select 5);
	};
	if (count _this > 6) then {
		_dam = _this select 6;
	};

	_taskNum = floor (random (count _taskArray));

	switch (_taskNum) do {
	    case 0: {

	   		[[_task, (_taskArray select _taskNum), _pos, _TaskName], "fn_taskDestroy", false, false] call BIS_fnc_MP;
	    };
	    case 1: {
	   		[[_task, (_taskArray select _taskNum), _pos, _TaskName], "fn_taskKill", false, false] call BIS_fnc_MP;
		};
	    case 2: {
	   		[[_task, (_taskArray select _taskNum), _pos, _TaskName], "fn_taskIntel", false, false] call BIS_fnc_MP;
	    };
	};
};