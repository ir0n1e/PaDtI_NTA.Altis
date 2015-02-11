if (isserver) then {

	if (!isnil "HCPresent") exitwith {
		[_this, "NTA_fnc_airpatrol_create", NTAHC] call BIS_fnc_mp;
		"Airpatrol switching to HC" call NTA_fnc_log;
		breakout "main";
	};

	"Airpatrol switching to Server" call NTA_fnc_log;
};

str [_this, count _this] call nta_fnc_log;
private ["_count", "_startPos", "_endPos", "_grp", "_targetPos", "_target", "_picture", "_type", "_types", "_spawnPos", "_spawnDistance", "_spawnHeight", "_NTA_Airpatrol_Veh","_NTA_Airpatrol_Crew", "_NTA_Airpatrol_Task", "_briefing", "_grpOld", "_heli", "_dir", "_apUserInsert", "_apinsertTroops", "_apUser", "_flyInHeight", "_counter", "_apParaVars", "_apParaDrop"];

_startPos 		= _this select 0;
_endPos 		= _this select 1;
_givenTarget 	= _this select 2;
_types			= _this select 3;
_side			= _this select 4;
_apUserInsert 	= false;
_apInsertTroops = false;

_apParaDrop		= false;
_apParaVars		= [];
_flyIngHeight	= 50;

if (count _this >= 6) then {
	_apUserInsert = true;
	_apUser = _this select 5;
	if (isnil "_apUser") then {
		_apUserInsert = false;
		_apUser		  = objnull;
	};
};

if (count _this >= 7) then {
	_apParaDrop 	= true;
	_apUserInsert 	= false;
	_apParaVars 	= _this select 6;
	//[_height, _count, _troopcount, _survivors]
};

format ["airpatrol %1", _this] call nta_fnc_log;
waituntil {NTA_Airpatrolrunning};

//if we have no Side make it random
if (isnil "_side") then {
	_side = [WEST, EAST] call NTA_fnc_getRandArrayPos;
};

if (!_apUserInsert || {!_apParaDrop}) then {
	if ((NTA_airpatrolCache getvariable [format ["NTA_Airpatrol_CAS_%1", _side], false] || {NTA_airpatrolCache getvariable [format ["NTA_Airpatrol_Serverside_%1", _side], false]}) && {!_apUserInsert}) exitwith {
		NTA_airpatrolCache setvariable [format ["NTA_Airpatrol_Serverside_%1", _side], false];
		format ["Airpatrol %1 online exiting", _side] call NTA_fnc_log;
		// return empty array for fn_airpatrol_init
		[]
	};

	if (NTA_airpatrolCache getvariable [format ["NTA_Airpatrol_CASonline_%1", _side], false]) then {
		NTA_airpatrolCache setvariable [format ["NTA_Airpatrol_CAS_%1", _side], true, true];
		NTA_airpatrolCache setvariable [format ["NTA_Airpatrol_CASonline_%1",_side], false, true];

	} else {
		//set serverside variable for "SAD WP" in fn_airpatrol_addwaipoints
		//@todo maybe there is another option for this
		NTA_airpatrolCache setvariable [format ["NTA_Airpatrol_Serverside_%1", _side], true];
	};
};

//Random types
if (count _types <= 0) then {
	_type = call compile format ["NTA_Airpatrol_%1 call NTA_fnc_getRandArrayPos;", _side];
} else {
	_type = _types call NTA_fnc_getRandArrayPos;
};

switch (_type) do {
	case "O_Heli_Transport_04_bench_F": {
		_apInsertTroops = true;
		_flyIngHeight	= 30;
	};
	case "O_Heli_Transport_04_covered_F": {
		_apInsertTroops = true;
		_flyIngHeight	= 30;
	};
	case "O_Heli_Light_02_unarmed_F": {
		_apInsertTroops = true;
		_flyIngHeight	= 45;
	};
};

//random target
if (count _givenTarget <= 0) then {
	_targetPos 	= _endPos;
	_target 	= "NoTarget";

	if ((count playableUnits) > 0) then {
		_unit 		= playableUnits call NTA_fnc_getRandArrayPos;
		_targetPos 	= getPos _unit;
		_target 	= _unit;
	};
} else {
	_targetPos 	= _givenTarget;
	_target 	= format ["Given Target: %1", _targetPos];
};

_NTA_Airpatrol_Veh 	= [];
_NTA_Airpatrol_Crew = [];
_NTA_Airpatrol_Task = format["%1%2", _side, floor (time + random(99))];
_spawnDistance 		= 150;
_vehname 			= getText ( configFile >> "CfgVehicles" >> _type >> "displayName");
_picture 			= format ["<img size='3' color='#ffffff' image='%1'/>", getText (configfile >> "CfgVehicles" >> _type >> "picture")];
_spawnHeight 		= 100;
_count 				= 2;
_tickets 			= 0;
_dir				= 200;

if (_type iskindof "plane") then {
	_spawnHeight 	= 600;
	_count 			= 1;
};

if (_apUserInsert) then {
	_count = count (_apUser getvariable format ["insert%1", group _apUser]);
	_spawnHeight 	= 100;
	_flyIngHeight	= 35;
	_endPos = [_targetPos, 3000, random 360 ] call BIS_fnc_relPos;
};

if (_apParaDrop) then {
	_count 			= _apParaVars select 1;
	_flyIngHeight	= _apParaVars select 0;
	_endPos = [_targetPos, 5000, random 360 ] call BIS_fnc_relPos;
};


_spawnPos 	= [_startPos select 0, _startPos select 1, _spawnHeight];
_grp 		= creategroup _side;

_grp setgroupID [format ["AP_" + _NTA_Airpatrol_Task]];

//create units
for "_counter" from 1 to _count step 1 do {
	_heli = [_type, ([_spawnPos, _spawnDistance , (_dir - 90)] call BIS_fnc_relPos), 200, _side, "FLY"] call NTA_fnc_vehicles_create;

	_grpOld = group _heli;

	_heli flyInHeight _flyIngHeight;

	//make some noise at target position
	{
 		_x setUnitAbility 1;
		_x setskill 1;
		_x setSkill ['spotDistance', 1];
		_x setSkill ['spotTime', 1];
		_x setCombatMode 'GREEN';

		_NTA_Airpatrol_Crew pushback _x;
	} foreach units group _Heli;
	_heli removeAllEventHandlers "Killed";
	_heli removeAllEventHandlers "Engine";
	//Add killed EH
	_heli addeventhandler ["Killed", {
	 	(_this select 0) spawn {
			_time = time;

			waituntil {time >= (_time + (5*60))};
			{
				if (!alive _x) then {
					deletevehicle _x;
				};
			} foreach crew (_this);

			if !(_this getvariable ["NTA_Airpatrol_Crash", false]) then {
				deletevehicle _this;
			};
		};
	}];

	_heli addeventhandler ["Engine", {
	 	if !(_this select 1) then {
		 	(_this select 0) spawn {
				_time = time;
				waituntil {time >= (_time + (5*60)) && {{isPlayer _x} count (crew _this) == 0}};

				if !(_this getvariable ["NTA_Airpatrol_Crash", false]) then {
					{
						deletevehicle _x;
					} foreach crew (_this);
					deletevehicle _this;
				};
			};
		};
	}];

	_NTA_Airpatrol_Veh pushback _Heli;

	if (!_apinsertTroops && {!_apUserInsert} && {!_apParaDrop}) then {
		{
			[_x] joinsilent _grp;
		} foreach units group _Heli;
		deletegroup _grpOld;
	};

	_spawnPos 	= getpos _heli;
	_dir 		= getdir _heli;

	if (typeof _heli iskindof "Helicopter") then {
		_heli setvariable ["NTA_Tickets", 60, true];
		if (_side == WEST) then {
			_heli call NTA_fnc_crate_Ghost;
		};
	};

	if (typeof _heli iskindof "Plane") then {
		_heli setvariable ["NTA_Tickets", 80, true];
	};

	_heli setvariable ["Airpatrol_Mission", "FlyingIn"];
	_heli setvariable ["Airpatrol_Target", _targetPos, true];
	_heli setvariable ["Airpatrol_EndPos", _endPos, true];
	_tickets = _tickets + (_heli getvariable ["NTA_Tickets", 0]);

	if (NTA_Airpatrol_Debug) then {
    	[_heli, false] call NTA_fnc_Airpatrol_Debug;
	};
};

//Set some variables
_grp setFormation "ECH RIGHT";

NTA_airpatrolCache setvariable[ format ["NTA_Airpatrol_Group_%1", _side], _grp, true];

//create briefing
if (_side == WEST) then {

	_briefing = format [localize "STR_NTA_AP_Briefing_WEST1",_vehname,  _targetPos distance (leader _grp), _picture, _count];
} else {
	_briefing = format [localize "STR_NTA_AP_Briefing_EAST1",_vehname,  _targetPos distance (leader _grp),_picture, _tickets, _count];
};

//fire it up

switch (true) do {
    case (_apParaDrop): {
    	[_NTA_Airpatrol_Veh, _startPos, _targetPos, _apUser, _apParaVars] call NTA_fnc_airpatrol_insertParaTroops;
    };
    case (_apinsertTroops || {_apUserInsert}): {
    	[_NTA_Airpatrol_Veh, _targetPos, _apUserInsert, _apUser] call NTA_fnc_airpatrol_insertTroops;
		NTA_airpatrolCache setvariable [format ["NTA_Airpatrol_Serverside_%1", _side], false];
	};
    default {
     	[_grp, _startPos, _endPos, _targetPos] call NTA_fnc_airpatrol_addwaypoints;
		[[_NTA_Airpatrol_Task, _NTA_Airpatrol_Veh, _NTA_Airpatrol_Crew, _briefing, _tickets], "NTA_fnc_airpatrol_task", false, false] call bis_fnc_mp;
    };
};

format["AIRPATROL: %1 Target: %2 - CREATE", _NTA_Airpatrol_Veh, _target] call NTA_fnc_log;

[_grp, _NTA_Airpatrol_Veh, _NTA_Airpatrol_Crew]