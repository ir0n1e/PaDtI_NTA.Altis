
private["_location","_position","_locaname"];
// =========================================================================================================
//	Define Random Location
// =========================================================================================================

	_location = ["town","city"] call PO3_fnc_getNewPos;

	PO3_TASK__DIF	= PO3_param_missionskill;
	PO3_TASK__POS	= _location select 0;
	PO3_TASK__IDD	= format["%1%2:%3",round(PO3_TASK__POS select 0),round(PO3_TASK__POS select 1),(round random 99)];

	_position = [PO3_TASK__POS,[200,2000],5,0,1] call PO3_fnc_getSafePos;
	_locaname = _location select 1;
	_locRadis = _location select 2;

// =========================================================================================================
//	Create Target
// =========================================================================================================
	PO3_TOTAL_UNITS = [];
	PO3_TOTAL_VEHICLES = [];

	//Create chopper wreck
	_heli = [ PO3_rescue_heliTypes_NTA select (floor (random (count PO3_rescue_heliTypes_NTA))) ,_position,360,WEST] call NTA_fnc_vehicles_create;
		PO3_TOTAL_VEHICLES pushback _heli;

	//_heli setDamage 1;
	//_heli enableSimulation false;
	//_heli setPosASL [getPosASL _heli select 0, getPosASL _heli select 1, 0 - 1.5];
	//_pitch = if(random 1 > 0.5) then{ random 40} else { -1 * random 40};
	//_bank = if(random 1 > 0.5) then{ random 40} else { -1 * random 40};
	//[_heli, _pitch, _bank] call BIS_fnc_setPitchBank;

	_heliFire = "test_EmptyObjectForFireBig" createVehicle position _heli;
	_heliFire attachTo[_heli,[0,1.5,-1]];
	PO3_TOTAL_VEHICLES pushback _heliFire;
// =========================================================================================================
//	Create Target
// =========================================================================================================

	_pilotPosition = [_position,[300,600],1,0,2] call PO3_fnc_getSafePos;

	_pilotGrp = nil;
	_pilotGrp = [ _pilotPosition, (PO3_side_1 select 0), "FR_GroupRescuePilots", 100 ] call PO3_fnc_createGroup;
	if !(isNil "_pilotGrp") then {
		if((0.25 * PO3_TASK__DIF) < random 1) then {(units _pilotGrp select 1) setDamage 1;}; //survivors
		PO3_TOTAL_UNITS = PO3_TOTAL_UNITS + (units _pilotGrp);
		sleep 1;
	};

	_rescueUnits = PO3_TOTAL_UNITS;
	{
		_x setVariable ["PO3_capture",true,true]; //to be replaced with RESCUE option
	}foreach _rescueUnits;
	_rescueUnitsCount = {alive _x} count _rescueUnits;

	[_rescueUnits] spawn {
		_units = _this select 0;
		_leader = _units call PO3_fnc_getArrayRandom;
		_pos =  [getPosASL _leader select 0, getPosASL _leader select 1, 150];
		_posGround =  [getPosASL _leader select 0, getPosASL _leader select 1, getPosASL _leader select 2];
		waitUntil {sleep 1; {_x distance _posGround < 750} count playableUnits > 0 || {!isNil "PO3_force_TASKEND"}};
		if (isNil "PO3_force_TASKEND") then {
			_flare = "F_40mm_Red" createvehicle ((_leader) ModelToWorld [0,100,200]);
			_flare setVelocity [0,0,-0.01];
			sleep 5;
			_flare = "F_40mm_Red" createvehicle ((_leader) ModelToWorld [0,100,200]);
			_flare setVelocity [0,0,-0.01];
		};
		waitUntil {sleep 1; {_x distance _posGround < 350} count playableUnits > 0 || {!isNil "PO3_force_TASKEND"}};
		if (isNil "PO3_force_TASKEND") then {
			_flare = "F_40mm_Red" createvehicle ((_leader) ModelToWorld [0,100,200]);
			_flare setVelocity [0,0,-0.01];
			sleep 5;
			_flare = "F_40mm_Red" createvehicle ((_leader) ModelToWorld [0,100,200]);
			_flare setVelocity [0,0,-0.01];
			{
				_x setdammage 0.65;
			} foreach _rescueUnits;
		};
	};

// =========================================================================================================
//	Create Hostiles
// =========================================================================================================

	PO3_TOTAL_UNITS = [];
	PO3_TOTAL_VEHICLES = [];

	_b = (8*(playersNumber(PO3_side_1 select 0)/40)*PO3_TASK__DIF) max 1;

	for "_i" from 1 to _b do {
		_grp = nil;
		_grp = [ _position, (PO3_side_3 select 0), format["EN_GroupForce_%1",round random 4], 200 ] call PO3_fnc_createGroup;
		if !(isNil "_grp") then {
			[ _position, _grp, (50 * _i) ] spawn PO3_fnc_groupPatrolArea;
			PO3_TOTAL_UNITS = PO3_TOTAL_UNITS + (units _grp);
			sleep 1;
		};
	};

	for "_i" from 1 to 2 do {
		_grp = nil;
		_grp = [ _position, (PO3_side_3 select 0), format["EN_GroupForce_%1",round random 4], 100 ] call PO3_fnc_createGroup;
		if !(isNil "_grp") then {
			[ _position, _grp ] spawn PO3_fnc_groupDefendPos;
			PO3_TOTAL_UNITS = PO3_TOTAL_UNITS + (units _grp);
			sleep 1;
		};
	};

	_vehClass = [];
	if(_b <= 2) then { _vehClass set [count _vehClass,4]; };
	if(_b >= 3)  then { _vehClass set [count _vehClass,5]; };
	if(_b >= 4) then { _vehClass set [count _vehClass,3]; };

	for "_i" from 0 to (_b/2) do {
		if(random 1 > 0.5 || _b >= 8) then {
			_class = [];
			_class = _vehClass call PO3_fnc_getVehicleTypes;
			if(count _class > 0) then {
				_veh = nil;
				_veh = ([ _position,_class call PO3_fnc_getArrayRandom,random 360,100,(PO3_side_3 select 0)] call PO3_fnc_createVehicle) select 0;
				if !(isNil "_veh") then {
					[ _position, _veh, 100 + round(random 300) ] spawn PO3_fnc_groupPatrolArea;
					PO3_TOTAL_UNITS = PO3_TOTAL_UNITS + (units _veh);
					PO3_TOTAL_VEHICLES set [ count PO3_TOTAL_VEHICLES, vehicle (leader _veh) ];
				};
			};
		};
		if(random 1 > 0.7) then {
			_class = [];
			_class = [7] call PO3_fnc_getVehicleTypes;
			if(count _class > 0) then {
				_veh = nil;
				_veh = ([ _position,"O_Heli_Light_02_F",random 360,(750 + random 250),(PO3_side_3 select 0),[],"FLY"] call PO3_fnc_createVehicle) select 0;
				if !(isNil "_veh") then {
					[_position, _veh, 1000] spawn PO3_fnc_groupDefendPos;
					PO3_TOTAL_UNITS = PO3_TOTAL_UNITS + (units _veh);
					PO3_TOTAL_VEHICLES set [ count PO3_TOTAL_VEHICLES, vehicle (leader _veh) ];
				};
			};
			sleep 1;
		};
	};

// =========================================================================================================
//	Create Tasks
// =========================================================================================================

	[ format["TASK%1",PO3_TASK__IDD],
		localize "STR_PO3_M20_TITLE",
		format[localize "STR_PO3_M20_DESCR",PO3_TASK__IDD,[_heli] call PO3_fnc_getCfgText,mapGridPosition _position],
		(PO3_side_1 select 0),
		[format["MRKR%1",PO3_TASK__IDD],_position,"mil_unknown",(PO3_side_1 select 0) call PO3_fnc_getUnitMarkerColour,localize "STR_PO3_M20_MSG_1"],
		"assigned",
		(_position),
		localize "STR_PO3_M20_MSG_1"
	] call PO3_fnc_addTask;







// =========================================================================================================
//	WAIT UNTIL COMPLETE/FAIL
// =========================================================================================================
	_returnPointLoc = "return_point_west" call PO3_fnc_getPos;
	_returnPointLoc_marine = "return_point_west_marine" call PO3_fnc_getPos;

	waitUntil {
		sleep 3;
		(({_x distance _returnPointLoc < 15 && alive _x }count _rescueUnits) + ({_x distance _returnPointLoc_marine < 20 && alive _x }count _rescueUnits)) > 0 || ({alive _x} count _rescueUnits == 0)
	};

	if({alive _x} count _rescueUnits > 0 ) then {
		[format["TASK%1",PO3_TASK__IDD],"succeeded"] call PO3_fnc_updateTask;
	}else{
		[format["TASK%1",PO3_TASK__IDD],"failed"] call PO3_fnc_updateTask;
	};

// =========================================================================================================
//	Cleanup
// =========================================================================================================

	{
		_x action ["eject",vehicle _x]
	} foreach _rescueUnits;

	sleep 2;

	deleteVehicle _heliFire;
	deleteVehicle _heli;

	{
		if(alive _x && !(isPlayer _x) ) then { _x setDamage 1 };
	}forEach PO3_TOTAL_UNITS+PO3_TOTAL_VEHICLES;
{
		deletevehicle _x;
	} foreach _rescueUnits;
if(true) exitWith {};