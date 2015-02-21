//Land_Mil_WiredFence_F

fnc_hangarTable = {
	private ["_pos, _obj","_objects"];
	_pos 		= _this;
	_objects 	= [];

	_obj = "Land_CampingTable_F" createVehicle [0,0,0];
	_obj setPosASL _pos;
	_obj setdir (getdir _obj) +10;
	_objects pushBack _obj;

	_pos = [getposASL _obj, -1.2, 35] call BIS_fnc_relPos;
	_obj = "Land_CampingChair_V2_F" createVehicle [0,0,0];
	_obj setPosASL _pos;
	_obj setdir (getdir _obj) + 150;
	_objects pushBack _obj;

	_pos = [getposASL _obj, 2, 35] call BIS_fnc_relPos;
	_obj = "Land_CampingChair_V2_F" createVehicle [0,0,0];
	_obj setPosASL _pos;
	_obj setdir (getdir _obj) - 90;
	_objects pushBack _obj;

	_objects
};



_objects = [];
_posHangar = [26739.4,24626.5,21.3814];
Hangar1 setposasl _posHangar;




_newpos = [_posHangar, -12, 90] call BIS_fnc_relPos;
for "_i" from 1 to 2 /* step +1 */ do {
	_obj = "Land_Cargo20_military_green_F" createVehicle [0,0,0];
	_obj setPosASL _newpos;
	_obj setdir (getdir _obj) -55 +180;
	_newpos = [getposASL _obj, -5, (getdir _obj)] call BIS_fnc_relPos;

	_objects pushBack _obj;
};

_newpos = [_posHangar, -18, 125] call BIS_fnc_relPos;
_objects = _objects + (_newpos call fnc_hangarTable);

_newpos = [_posHangar, -15, 125] call BIS_fnc_relPos;
_objects = _objects + (_newpos call fnc_hangarTable);




_obj = "Land_New_WiredFence_5m_F" createVehicle [0,0,0];
_newpos = [_posHangar, -14.5, 65  ] call BIS_fnc_relPos;
_obj setPosASL _newpos;
_obj setdir (getdir _obj) -55 +180;
_objects pushBack _obj;

_dir = getdir _obj;
_pos = [getposASL _obj, 5, 35] call BIS_fnc_relPos;
for "_i" from 1 to 3 do {
	_obj = "Land_New_WiredFence_5m_F" createVehicle [0,0,0];

	_obj setPosASL _pos;
	_pos = [getposASL _obj, 5,  35 ] call BIS_fnc_relPos;
	_obj setdir _dir;
	_objects pushBack _obj;
};

_pos = [getposASL _obj, 4, -10] call BIS_fnc_relPos;
for "_i" from 1 to 1 do {
	_obj = "Land_New_WiredFence_5m_F" createVehicle [0,0,0];

	_obj setPosASL _pos;
	_obj setdir _dir-90;

	_objects pushBack _obj;
};

_pos = [getposASL _obj, -2, -10] call BIS_fnc_relPos;

for "_i" from 1 to 2 do {
	_obj = "Box_NATO_WpsLaunch_F" createVehicle [0,0,0];
	_obj setPosASL _pos;
	_obj setdir (getdir _obj) +45;
	_obj call NTA_fnc_crate_launcher;
	_pos = [getposASL _obj, -1, 35] call BIS_fnc_relPos;
	_objects pushBack _obj;
};
_pos = [getposASL _obj, -1, 35] call BIS_fnc_relPos;
_obj = "Box_NATO_AmmoOrd_F" createVehicle [0,0,0];
_obj setPosASL _pos;
_obj call NTA_fnc_crate_expBox;
_objects pushBack _obj;


_pos = [getposASL _obj, -1, 35] call BIS_fnc_relPos;
_obj = "Box_NATO_AmmoOrd_F" createVehicle [0,0,0];
_obj setPosASL _pos;
_obj call NTA_fnc_crate_agm;
_objects pushBack _obj;

_pos = [getposASL _obj, -1, 35] call BIS_fnc_relPos;
_obj = "Box_NATO_AmmoOrd_F" createVehicle [0,0,0];
_obj setPosASL _pos;
_obj call NTA_fnc_crate_optics;
_objects pushBack _obj;

if (isClass(configfile >> "CfgPatches" >> "task_force_radio_items")) then {
	_pos = [getposASL _obj, -1, 35] call BIS_fnc_relPos;
	_obj = "TF_NATO_Radio_Crate" createVehicle [0,0,0];
	_obj setPosASL _pos;
	if (isclass (configfile >> "CfgPatches" >> "AGM_Logistics")) then {
		//not working at this time
		//[_obj] call AGM_Drag_fnc_makeUndraggable;
		_obj setVariable ["AGM_disableDrag", true, true];
	};
	_objects pushBack _obj;
};

if (missionNamespace getvariable ["haveBWplus", false] && {("params_NTA_Bwplus" call bis_fnc_getParamValue) > 0}) then {
	_pos = [getposASL _obj, -1, 35] call BIS_fnc_relPos;
	_obj = "BWplus_Box_weapons_SF" createVehicle [0,0,0];
	_obj setPosASL _pos;
	if (isclass (configfile >> "CfgPatches" >> "AGM_Logistics")) then {
		//not working at this time
		//[_obj] call AGM_Drag_fnc_makeUndraggable;
		_obj setVariable ["AGM_disableDrag", true, true];
	};
	_objects pushBack _obj;
};






//Land_Cargo20_military_green_F Land_CampingTable_F Land_CampingChair_V2_F

{
	_x allowdammage false;
	if !(typeof _x iskindof "ReammoBox_F") then {
		_x enableSimulationGlobal false;
	};
} foreach _objects;



