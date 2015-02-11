private ["_csatplane_wp", "_c130", "_infgrp", "_infWP", "_count", "_users", "_plane", "_man", "_side"];
//[_height, _count, _troopcount, _survivors]

_vehicles 	= _this select 0;
_startPos	= _this select 1;
_targetPos 	= _this select 2;
_apUser 	= _this select 3;
_apParaVars	= _this select 4;

_height		= _apParaVars select 0;
_troopCount = _apParaVars select 2;
_survivors	= _apParaVars select 3;

_side		= side (_vehicles select 0);
_count 		= _this select 3;
_users 		= [];
_speed 		= "FULL";
_man  		= "B_soldier_PG_F";
str _apUser call nta_fnc_log;
for "_i" from 0 to (count _vehicles) -1 do {


	if (typeof (_vehicles select _i) isKindOf "Plane") then {
		_speed = "LIMITED";
	};

	_dir = [_targetPos, _startPos] call BIS_fnc_dirTo;

	(_vehicles select _i) flyInHeight _height;

	[group (_vehicles select _i), '', _startPos, "FULL", "MOVE", "CARELESS", "BLUE"] call NTA_fnc_vehicles_addwaypoint;
	[group (_vehicles select _i), '', [_targetPos, 6000, _dir] call BIS_fnc_relPos, _speed, "MOVE", "CARELESS", "BLUE"] call NTA_fnc_vehicles_addwaypoint;
	[group (_vehicles select _i), '', _targetPos, _speed, "MOVE", "CARELESS", "BLUE"] call NTA_fnc_vehicles_addwaypoint;
	[group (_vehicles select _i), '', (_vehicles select _i) getvariable ["Airpatrol_EndPos", [0,0,0]], "FULL", "MOVE", "CARELESS", "BLUE", ["true", "{[_x] call NTA_fnc_vehicles_delete} forEach thislist"]] call NTA_fnc_vehicles_addwaypoint;

	if (!isnull _apUser) then {
		_users = (_apUser getvariable [format ["insert%1", group _apUser],[[_apuser]]]) select 0;
	};

	_seats 	= getNumber (configfile >> "CfgVehicles" >> typeof (_vehicles select _i) >> "transportsoldier");

	_infgrp = createGroup _side;

	for "_i" from 0 to (_seats - (count _users) min _troopCount) - 1 do {
		_man createUnit [[0,0,0], _infgrp];
	};

	{
		systemchat str _foreachIndex;
		[[_x, _vehicles select _i, _foreachIndex + 1], "NTA_fnc_airpatrol_movein", _x] call bis_fnc_mp;
		removeBackpackGlobal _x;
		_x addBackpackGlobal "B_Parachute";

	} foreach _users + (units _infgrp);


	//_infWP = AIRFIELD_Markers select (floor(random(count AIRFIELD_Markers)));
	//[_infgrp,'',getmarkerpos "city","LIMITED","SAD","SAFE","RED"] call NTA_fnc_vehicles_addwaypoint;


};
//_return = [_c130, _infgrp, _users];
//_return
// [[22254.2,20295.1,0.00145817], [0,0,0], getmarkerpos "west_1", ["B_Heli_Transport_03_F"],west,player, [180,2,2,2]] call nta_fnc_airpatrol_create