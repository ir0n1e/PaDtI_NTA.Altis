private ["_positions","_landing_positions","_Spos1","_Spos2","_Lpos1","_Lpos2","_resultS","_resultL","_startpos","_landingpos","_time","_i"];
_positions = [[12482.2,8374.87,0.00151634],
[12384.2,8380.18,0.00144196],
[12468.7,8392.83,0.00170517],
[12410.4,8369.09,0.00144196]]
;

_landing_positions = [[20895,7288.98,0.00158501],
[20914.3,7240.96,0.00144196],
[20880.1,7264.02,0.00134087],

[20931.5,7264.39,0.00153351]];

_Spos1 = _positions select (floor(random(count _positions)));
_Spos2 = _positions select (floor(random(count _positions)));
_resultS = [_Spos1, _Spos2] call BIS_fnc_arrayCompare;

_Lpos1 = _landing_positions select (floor(random(count _landing_positions)));
_Lpos2 = _landing_positions select (floor(random(count _landing_positions)));
_resultL = [_Lpos1, _Lpos2] call BIS_fnc_arrayCompare;


while {_resultS} do {
	_Spos2 = _positions select (floor(random(count _positions)));
	_resultS = [_Spos1, _Spos2] call BIS_fnc_arrayCompare;
};
_startpos = [_Spos1,_Spos2];

while {_resultL} do {
	_Lpos2 = _landing_positions select (floor(random(count _landing_positions)));
	_resultL = [_Lpos1, _Lpos2] call BIS_fnc_arrayCompare;
};
_landingpos = [_Lpos1, _Lpos2];


_time = time;

for "_i" from 0 to 1 step 1 do {
call compile format ["
	heli%1 = ['B_Heli_Attack_01_F',_startpos select _i,'None',WEST] call NTA_fnc_vehicles_create;
	heli%1 flyInHeight 50;
	_wp = [group heli%1,'',[18302.8,7522.81],'NORMAL','MOVE',['true','heli%1 flyInHeight 50']]  call NTA_fnc_vehicles_addwaypoint;
	_wp setWaypointCombatMode ""BLUE"";
	[group heli%1,'',_landingpos select _i,'LIMITED','SCRIPTED',['true','heli%1 flyInHeight 50'],""A3\functions_f\waypoints\fn_wpLand.sqf""] call NTA_fnc_vehicles_addwaypoint;

	[group heli%1,'',[21981,28740,0],'NORMAL','MOVE',['true','heli%1 flyInHeight 50']]  call NTA_fnc_vehicles_addwaypoint;


	heli_tr%1 = createTrigger [""EmptyDetector"", [0,0]];
	waitUntil {!isNil ""heli_tr%1""};
  heli_tr%1	triggerAttachVehicle [heli%1];
	heli_tr%1 setTriggerStatements [
        ""heli%1 distance getmarkerpos 'land' < 150 && (position heli%1 select 2) < 5"",
        ""heli%1 setFuel 0"",''];",
			(_i + floor(random 10))];


        waitUntil {time >= (_time +8)};
};
	//[group _heli,'',[19968.9,7828.4,0.00143814],"NORMAL","MOVE",["true","_heli flyInHeight 20"]]  call NTA_fnc_vehicles_addwaypoint;
