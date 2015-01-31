if(!isserver || isnil "Sand1") exitwith {};
0 spawn {
private ["_i", "_count"];
"Starting AGM_Logistics init..." call NTA_fnc_log;
if (!(isClass(configFile/"CfgPatches"/"AGM_Logistics"))) exitwith {
	"No AGM_Logistics done..." call NTA_fnc_log;
};
_count = 0;
for "_i" from 1 to 12 do {
	call compile format ["
		_pos = getposASL Sand%1;
		_dir = getdir Sand%1;
		deletevehicle Sand%1;
		Sand%1 = 'AGM_SandbagBarrier_Crate' createvehicle [0,0,0];
		Sand%1 setposASL _pos;
		Sand%1 setdir _dir;",
		_i
	];
	_count = _count + 1;
};

for "_i" from 1 to 6 do {

	call compile format ["
		_pos = getposASL Razor%1;
		_dir = getdir Razor%1;
		deletevehicle Razor%1;
		_Razor%1 = 'AGM_RazorWire_Crate' createvehicle [0,0,0];
		_Razor%1 setposASL _pos;
		_Razor%1 setdir _dir;",
		_i
	];
	_count = _count + 1;
};

for "_i" from 1 to 10 do {
	call compile format ["
		_pos = getposASL Track%1;
		_dir = getdir Track%1;
		deletevehicle Track%1;
		_Track%1 = 'AGM_SpareTrack' createvehicle [0,0,0];
		_Track%1 setposASL _pos;
		_Track%1 setdir _dir;",
		_i
	];
	_count = _count + 1;
};
for "_i" from 1 to 10 do {
	call compile format ["
		_pos = getposASL Wheel%1;
		_dir = getdir Wheel%1;
		deletevehicle Wheel%1;
		_Wheel = 'AGM_SpareWheel' createvehicle [0,0,0];
		_Wheel setposASL _pos;
		_Wheel setdir _dir;
		",
		_i
	];
	_count = _count + 1;
};

for "_i" from 1 to 8 do {
	call compile format ["
		_pos = getposASL Can%1;
		_dir = getdir Can%1;
		deletevehicle Can%1;
		_Can%1 = 'AGM_JerryCan' createvehicle [0,0,0];
		_Can%1 setposASL _pos;
		_Can%1 setdir _dir;",
		_i
	];
	_count = _count + 1;
};

format ["%1 Objects replaced - AGM_Logistics done...", _count] call NTA_fnc_log;
};