private ["_obj", "_pos", "_unit", "_newpos", "_units", "_objects", "_grp"];
//"Land_WIP_F"

_house = NTA_targetHouse select 0;
_pos = getposASL _house;
_dir = getdir _house;
_objects = [];
_units = [];
createCenter EAST;
str _type call nta_fnc_log;
//_house hideObjectGlobal true;
_house allowdammage false;
//_house = _type createVehicle [0,0,0];
//_house setposASL _pos;
//_house setdir _dir;
//_house allowdammage false;
//_objects pushback _house;
PO3_TASK__POS	= position _house;
PO3_TASK__IDD	= format["%1%2:%3",round(PO3_TASK__POS select 0),round(PO3_TASK__POS select 1),(round random 99)];
PO3_TOTAL_UNITS = [];
PO3_TOTAL_VEHICLES = [];


_grp = createGroup EAST;

_newpos = [_pos, -19, 91 ] call BIS_fnc_relPos;
_type = ["O_MBT_02_cannon_F", "O_APC_Tracked_02_AA_F"] call NTA_fnc_getRandArrayPos;
_hight = 0.2;
if (_type ==  "O_APC_Tracked_02_AA_F") then {
	_hight = 0.4;
};




//_unit = "O_MBT_02_cannon_F" createVehicle [0,0,0];
_unit = createvehicle [_type, [0,0,0], [], 0, "CAN_COLLIDE"];
_unit allowdammage false;
_units = _units + ([_unit, _grp] call BIS_fnc_spawnCrew);
//[_grp, '', position _unit, "LIMITED", "SAD", "COMBAT"] call NTA_fnc_vehicles_addwaypoint;

{
	_x setskill 1;
	_x setCombatMode "RED";
} foreach (units _grp);

_unit setpos [_newpos select 0, _newpos select 1, 0];
_unit setdir _dir+90;
_unit setFuel 0;

[_unit] joinSilent _grp;
_grp setFormDir _dir;
_units pushBack _unit;



_unit allowdammage true;
_unit setdammage 0;



_newpos = [getposASL _house, -19, 91 ] call BIS_fnc_relPos;
for "_o" from 0 to 1 do {
	_pos = [[_newpos select 0, _newpos select 1, (_newpos select 2) + (_o*_hight)] , -6, -24 ] call BIS_fnc_relPos;

	for "_i" from 1 to 4 do {
		_obj = "Land_HBarrier_3_F" createVehicle [0,0,0];

	    _obj setposASL _pos;
	    _obj setdir (getdir _obj)+30;
	    _pos = [getposASL _obj, -2.8, 120  ] call BIS_fnc_relPos;
	    _objects pushBack _obj;
	};

	_pos = [getposASL _obj, -1, 180 ] call BIS_fnc_relPos;
	for "_i" from 1 to 3 do {
		_obj = "Land_HBarrier_3_F" createVehicle [0,0,0];

	    _obj setposASL _pos;
	    _obj setdir (getdir _obj)+120;
	    _pos = [getposASL _obj, 2.8, 30  ] call BIS_fnc_relPos;
	    _objects pushBack _obj;
	};
};


_pos = getposASL _house;
_pos = [getposATL _house, 15, 90 ] call BIS_fnc_relPos;
_dir = (getdir _house);
_array = [[_pos select 0, _pos select 1, (_pos select 2) + 12], "O_static_AA_F", EAST, _dir, true] call NTA_fnc_vehicles_createStatic;

_objects = _objects + (_array select 0);
_units = _units + (_array select 1);


_pos = [getposATL _house, -2, 90 ] call BIS_fnc_relPos;
_dir = (getdir _house) + 180;
_array = [[_pos select 0, _pos select 1, (_pos select 2)+12], "O_static_AA_F", EAST, _dir, true] call NTA_fnc_vehicles_createStatic;

_objects = _objects + (_array select 0);
_units = _units + (_array select 1);




_pos = [[getposASL _house select 0, getposASL _house select 1, (getposASL _house select 2) + 4.8] , 21.1, 155 ] call BIS_fnc_relPos;
for "_i" from 1 to 2 /* step +1 */ do {
	_obj = "Land_Pallet_F" createVehicle [0,0,0];
	_obj setPosasl ([_pos, 1.5, 0 ] call BIS_fnc_relPos);
	_obj setdir (getdir _obj)+30 ;
	_objects pushBack _obj;
};

_array = [getposATL _obj, "O_HMG_01_high_F", EAST, (getdir _house)] call NTA_fnc_vehicles_createStatic;

_objects = _objects + (_array select 0);
_units = _units + (_array select 1);

for "_i" from 1 to 8 do {
		_obj = "Land_BagFence_Long_F" createVehicle [0,0,0];

	    _obj setposASL _pos;
	    _obj setdir (getdir _obj)+30;
	    _pos = [getposASL _obj, -2.8, 120  ] call BIS_fnc_relPos;
	    _objects pushBack _obj;
	};


_pos = [[getposASL _house select 0, getposASL _house select 1, (getposASL _house select 2) + 9] , 21.1, 155] call BIS_fnc_relPos;


for "_i" from 1 to 8 do {
		_obj = "Land_BagFence_Long_F" createVehicle [0,0,0];

	    _obj setposASL _pos;
	    _obj setdir (getdir _obj)+30;
	    _pos = [getposASL _obj, -2.8, 120  ] call BIS_fnc_relPos;
	    _objects pushBack _obj;

	    _grp = createGroup EAST;
	    _wppos = (_house call NTA_fnc_getRandHousePos);
	    _unit = _grp createUnit ["O_support_MG_F",_wppos, [], 0, "NONE"];

		//[_grp, '', _wppos, "LIMITED", "HOLD", "SAFE"] call NTA_fnc_vehicles_addwaypoint;
		_unit domove _wppos;

		_units pushBack _unit;
	};
//O_MBT_02_cannon_F Land_BagBunker_Small_F
_pos = [[getposASL _house select 0, getposASL _house select 1, (getposASL _house select 2) + 4.27] , -22, 96] call BIS_fnc_relPos;

_obj = "Land_BagBunker_Small_F" createVehicle [0,0,0];

_obj setposASL _pos;
_obj setdir (getdir _obj)+30;

_objects pushBack _obj;

_array = [[getposATL _obj select 0, getposATL _obj select 1, (getposATL _obj select 2) -1] , "O_HMG_01_high_F", EAST, (getdir _obj) +180] call NTA_fnc_vehicles_createStatic;

_objects = _objects + (_array select 0);
_units = _units + (_array select 1);

_pos = [[getposATL _house select 0, getposATL _house select 1, (getposATL _house select 2) + 4.8] , -22, 145 ] call BIS_fnc_relPos;


_array = [[_pos, 1.5, 0 ] call BIS_fnc_relPos, "O_HMG_01_high_F", EAST, (getdir _house) + 180 ] call NTA_fnc_vehicles_createStatic;
_objects = _objects + (_array select 0);
_units = _units + (_array select 1);

_pos = [[getposASL _house select 0, getposASL _house select 1, (getposASL _house select 2) + 4.2] , -24.2, 138 ] call BIS_fnc_relPos;

for "_i" from 1 to 2 do {
	_obj = "Land_BagFence_Long_F" createVehicle [0,0,0];
    _obj setposASL _pos;
    _obj setdir (getdir _obj)+120;
    _pos = [getposASL _obj, 2.8, 30  ] call BIS_fnc_relPos;
    _objects pushBack _obj;
};

_array = [[getposATL _house, 40, 30] call BIS_fnc_relPos, "O_Mortar_01_F", EAST, (getdir _house ) +180, true] call NTA_fnc_vehicles_createStatic;

_objects = _objects + (_array select 0);
_units = _units + (_array select 1);
0 = [(_array select 1) select 0] execVM "scripts\UPSMON\MON_artillery_add.sqf";


_m = [];
_pos = [getpos _house, 100, 30] call BIS_fnc_relPos;
_marker = createmarker ["Garrison", _pos];
_marker setMarkerShape "RECTANGLE";
_marker setMarkerDir (getdir _house) +90 ;
_marker setMarkerSize [20, 50];
_marker setMarkerColor "ColorBlack";
_marker setMarkerBrush "DIAGGRID";
_m pushback _marker;

_wirepos = [_marker, [10]] call NTA_fnc_getRandMkrLocs;
{

	_obj = "Land_Razorwire_F" createvehicle [0,0,0];
	_obj setpos _x;
	_obj setdir (getdir _house);
	_objects pushBack _obj;
} foreach _wirepos;


_mines = ["Garrison", WEST,"apmine", 20] call PO3_fnc_createMinefield;


_marker = createmarker ["GarrisonHouse", position _house];
_marker setMarkerShape "RECTANGLE";
_marker setMarkerSize [50, 50];
_marker setMarkerColor "ColorBlack";
_marker setMarkerBrush "DIAGGRID";
_m pushback _marker;




_pos = [getpos _house, 100, 120] call BIS_fnc_relPos;
_marker = createmarker ["Garrison2", _pos];
_marker setMarkerShape "RECTANGLE";
_marker setMarkerDir (getdir _house);
_marker setMarkerSize [20, 80];
_marker setMarkerColor "ColorBlack";
_marker setMarkerBrush "DIAGGRID";
_mines = _mines + (["Garrison2", WEST,"apmine", 20] call PO3_fnc_createMinefield);
_m pushback _marker;

_wirepos = [_marker, [10]] call NTA_fnc_getRandMkrLocs;
{

	_obj = "Land_Razorwire_F" createvehicle [0,0,0];
	_obj setpos _x;
	_obj setdir (getdir _house) + 90;
	_objects pushBack _obj;
} foreach _wirepos;



_pos = [getpos _house, -50, 30] call BIS_fnc_relPos;
_marker = createmarker ["Garrison3", _pos];
_marker setMarkerShape "RECTANGLE";
_marker setMarkerDir (getdir _house) +90 ;
_marker setMarkerSize [20, 50];
_marker setMarkerColor "ColorBlack";
_marker setMarkerBrush "DIAGGRID";
_m pushback _marker;

{
	_x setMarkerAlpha 0;
} foreach _m;

_wirepos = [_marker, [10]] call NTA_fnc_getRandMkrLocs;
{

	_obj = "Land_Razorwire_F" createvehicle [0,0,0];
	_obj setpos _x;
	_obj setdir (getdir _house);
	_objects pushBack _obj;
} foreach _wirepos;

PO3_TOTAL_UNITS 	= _units;
PO3_TOTAL_VEHICLES 	= _objects + _mines;

[ format["TASK%1",PO3_TASK__IDD],
		localize "STR_PO3_M21_TITLE",
		format[ localize "STR_PO3_M21_DESCR",PO3_TASK__IDD,(PO3_side_3 select 2)],
		(PO3_side_1 select 0),
		[format["MRKR%1",PO3_TASK__IDD],PO3_TASK__POS,"mil_objective",(PO3_side_3 select 0) call PO3_fnc_getUnitMarkerColour,localize "STR_PO3_M21_TITLE"],
		"assigned",
		PO3_TASK__POS,
		localize "STR_PO3_M21_TITLE"
	] call PO3_fnc_addTask;

waitUntil {{alive _x} count _units <= 5};
sleep 1;
	[format["TASK%1",PO3_TASK__IDD],"succeeded"] call PO3_fnc_updateTask;

sleep 5;

[_pos,PO3_TOTAL_UNITS, PO3_TOTAL_VEHICLES] spawn {
	private["_target","_units","_vehicles"];

	_target = _this select 0;
	_units = _this select 1;
	_vehicles = _this select 2;

	waitUntil { count ([_target,500,(PO3_side_1 select 0),["CAManBase"]] call PO3_fnc_getNearbyPlayers) == 0 };

	{ if(alive _x) then { deletevehicle _x }; }forEach _units;
	{ if( {isPlayer _x} count (crew _x) == 0 ) then { deletevehicle _x }; }forEach _vehicles;
};
{
	deletemarker _x;
} foreach _m;

if(true) exitWith {};