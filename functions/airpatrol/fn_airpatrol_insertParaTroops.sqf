private ["_wp", "_vehicles", "_startPos", "_targetPos", "_apUser", "_apParaVars", "_height", "_troopCount", "_survivors", "_side", "_users", "_aiGrps", "_speed", "_man", "_dir", "_infgrp", "_parachute"];

_vehicles 	= _this select 0;
_startPos	= _this select 1;
_targetPos 	= _this select 2;
_apUser 	= [_this, 3, objnull] call bis_fnc_param;
_apParaVars	= _this select 4;

_height		= _apParaVars select 0;
_troopCount = _apParaVars select 2;
_survivors	= _apParaVars select 3;

_side		= side (_vehicles select 0);
_users 		= [];
_aiGrps		= [];
_speed 		= "FULL";
_man  		= "B_soldier_PG_F";
_parachute	= _apUser getvariable ["Airpatrol_ParaChute", NTA_airpatrol_Parachute];

for "_i" from 0 to (count _vehicles) -1 do {

	if (typeof (_vehicles select _i) isKindOf "Plane") then {
		_speed = "LIMITED";
	};

	_dir = [_targetPos, _startPos] call BIS_fnc_dirTo;

	(_vehicles select _i) flyInHeight (_height max NTA_airpatrolParaMinHeight);

	_wp = [group (_vehicles select _i), '', [_startPos, 3500, (_dir + 180)] call BIS_fnc_relPos, "FULL", "MOVE", "CARELESS", "BLUE"] call NTA_fnc_vehicles_addwaypoint;
	_wp setWaypointCompletionRadius 1000;

	_wp = [group (_vehicles select _i), '', [_targetPos, 2500, _dir] call BIS_fnc_relPos, _speed, "MOVE", "CARELESS", "BLUE"] call NTA_fnc_vehicles_addwaypoint;
	_wp setWaypointCompletionRadius 200;

	_wp =[group (_vehicles select _i), '', _targetPos, _speed, "MOVE", "CARELESS", "BLUE"] call NTA_fnc_vehicles_addwaypoint;
	_wp setWaypointCompletionRadius 200;

	_wp = [group (_vehicles select _i), '', [_targetPos, 2000, (_dir + 180)] call BIS_fnc_relPos, _speed, "MOVE", "CARELESS", "BLUE"] call NTA_fnc_vehicles_addwaypoint;
	_wp setWaypointCompletionRadius 200;

	_wp = [group (_vehicles select _i), '', (_vehicles select _i) getvariable ["Airpatrol_EndPos", [0,0,0]], "FULL", "MOVE", "CARELESS", "BLUE", ["true", "{[_x] call NTA_fnc_vehicles_delete} forEach thislist"]] call NTA_fnc_vehicles_addwaypoint;
	_wp setWaypointCompletionRadius 200;

	if (!isnull _apUser) then {
		_users = (_apUser getvariable [format ["insert%1", group _apUser],[[]]]) select 0;
	};

	_seats 	= getNumber (configfile >> "CfgVehicles" >> typeof (_vehicles select _i) >> "transportsoldier");

	_infgrp = createGroup _side;

	if (_troopCount > 0) then {
		for "_i" from 0 to (_seats - (count _users) min _troopCount) - 1 do {
			_man createUnit [[0,0,0], _infgrp];
		};
		_aiGrps pushback _infgrp;
	};

	{
		[[_x, _vehicles select _i, _foreachIndex + 1], "NTA_fnc_airpatrol_movein", _x] call bis_fnc_mp;
		removeBackpackGlobal _x;
		_x addBackpackGlobal _parachute;
	} foreach _users + (units _infgrp);

	//_infWP = AIRFIELD_Markers select (floor(random(count AIRFIELD_Markers)));
	//[_infgrp,'',getmarkerpos "city","LIMITED","SAD","SAFE","RED"] call NTA_fnc_vehicles_addwaypoint;
	[(_vehicles select _i), _infgrp, _users, _targetPos, _survivors, _height] call NTA_fnc_airpatrol_ParaDrop;
};

NTA_airpatrolCache setVariable [format ["NTA_Airpatrol_ParaGrp_%1", _side], _aiGrps, true];

//_return = [_c130, _infgrp, _users];
//_return
// [[22254.2,20295.1,0.00145817], [0,0,0], getmarkerpos "west_1", ["B_Heli_Transport_03_F"],west,player, [180,2,2,2]] call nta_fnc_airpatrol_create