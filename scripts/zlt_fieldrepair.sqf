// Field repair by [STELS]Zealot
// Just add
// [] execVM "zlt_fieldrepair.sqf";
// http://forums.bistudio.com/showthread.php?168714-Realistic-repair-script

#define DEFAULT_FREPAIR_VER "1P"

#define DEFAULT_FIELDREPAIR_EACH_PART_TIME 30
#define DEFAULT_FIELDREPAIR_EACH_HARDPART_TIME 60
#define DEFAULT_FULLREPAIR_LENGTH 120
#define DEFAULT_REPAIR_TRUCK_USES 5
#define DEFAULT_FREE_REPAIRS 1
#define DEFAULT_RELOAD_LENGHT 15


#define STR_FIELD_REPAIR "Reparatur"
#define STR_CANCEL_ACTION "Abbruch"
#define STR_SERIOUS_REPAIR "Volle Reparatur"
#define STR_REPAIR_CONDITIONS "Schlechte Bedingungen für eine Reparatur"
#define STR_ANOTHER_ACTION "Andere Aktion wird asgeführt"
#define STR_NEED_TOOLKIT "Need ToolKit in inventory yours or vehicle."
#define STR_REPAIR_INTERRUPTED "Reparatur unterbrochen"
#define STR_AMMO_INTERRUPTED "Aufmunitionieren unterbrochen"
#define STR_REPAIR_FINISHED "Reparatur abgeschlossen"
#define STR_AMMO_FINISHED "Aufmunitionieren abgeschlossen"
#define STR_REPAIR_MSG_STRING "%2 wird in %1 Sekunden repariert sein"
#define STR_AMMO_MSG_STRING "Lade %1 in %2<br/>%3 Sekunden verbleiben<br/>Noch zu ladende Magazine %4"
#define STR_AMMO_COUNT " %1 Gegenmaßnahmen zu laden"
#define STR_AMMO_COUNT_HI " %1 schwere Magazine zu laden"
#define STR_AMMO_COUNT_LOW " %1 leichte Magazine zu laden"

#define STR_PUSH_APC "Push APC"
#define STR_REPAIR_TRUCK_DEPLETED "Spare parts depleted in repair truck"
#define STR_HELP "Realistic field repair (Author: Zealot) <br/>Script gives each player ability to repair vehicles. <br/>- Repair lasts for 40-400 sec. (Longer for heavy damaged vehicles), it can be interrupted and the continued, time saves.<br/>- Each vehicle could be repaired 1 time for spare parts stored in the vehicle itself.For the next repairs you should have Toolkit in your backpack or in vehicle cargo.<br/>- Field repair fixes only some parts of the vehicle and only to 'Yellow state'.<br/>- Repair from repair trucks lasts 3 min. but completely repairs vehicles. Repair truck can be used 5 times, then spare parts in it will be depleted.<br/>- To use repair truck you should sat on the drivers place of the repair truck then look on damaged vehicle and select 'Full repair' in menu.<br/>"
#define STR_SCRIPTS_NAME "Scripts"
#define STR_SCRIPT_NAME "Field repair"
#define STR_PUSH_APC "Push vehicle"
#define STR_RELOAD_AMMO "Fahrzeug Aufmunitionieren"
#define STR_AMMO_UPDATE "Aufmunitionieren"



zlt_repair_loop = [_this, 0, false] call BIS_fnc_param;

if (isServer) then {
	[] spawn {
		_first = true;
		while {_first or zlt_repair_loop} do {
			{
				if ((getRepairCargo _x > 0) || (getAmmoCargo _x > 0) or _x getVariable "vec_engineer" ) then {
					_x setRepairCargo 0;
					_x setRepairCargo 0;
					_x setVariable ["zlt_repair_cargo", 1, true];
					_x setVariable ["zlt_ammo_cargo", 1, true];
				};
			} foreach vehicles;
			_first = false;
			sleep 26.1;
		};
	};
};

zlt_fnc_partrepair = {
	private "_veh";
	_veh = [_this, 0] call BIS_fnc_param;
	if (isNil {_veh} ) exitWith {};
	{
		_dmg = (_veh getHitPointDamage _x);
		if (not isNil {_dmg}) then {
			if ( _dmg > 0.64 ) then {
				if (_x in zlt_hardRepairParts) then {
					_veh setHitPointDamage [_x,0.64];
				} else {
					_veh setHitPointDamage [_x,0];
				};
			};
		};
	} foreach zlt_repair_hps;
};





zlt_fnc_fullrepair = {
	private "_veh";
	_veh = [_this, 0] call BIS_fnc_param;
	_veh setDamage 0;
};

zlt_repair_hps = ["HitLFWheel","HitLBWheel","HitLMWheel","HitLF2Wheel","HitRFWheel","HitRBWheel","HitRMWheel","HitRF2Wheel" ,"HitEngine", "HitLTrack","HitRTrack"] + ["HitFuel","HitAvionics","HitVRotor","HitHRotor"];
zlt_hardRepairParts = ["HitEngine", "HitLTrack","HitRTrack"] + ["HitFuel","HitAvionics","HitHRotor"];

if (isDedicated) exitWith {};
waitUntil {player == player};
zlt_mutexAction = false;
zlt_ammo = false;
zlt_fnc_vehicledamaged = {
	private ["_veh","_vehtype","_flag"];
	_veh =  [_this, 0] call BIS_fnc_param;
	if (isNil {_veh}) exitWith {false};
	_vehtype = typeOf _veh;
	_flag = false;
	if (true) then {

		{
			_cdmg = _veh getHitPointDamage (_x);
			if (not isNil {_cdmg} ) then {
				if (_cdmg > 0.64) exitWith {_flag = true};
			};
		}  forEach zlt_repair_hps;


	};
	_flag;
};

zlt_fnc_vehicleammo = {
	private ["_veh","_vehtype","_flag", "_mags"];
	_veh =  [_this, 0] call BIS_fnc_param;
	if (isNil {_veh}) exitWith {false};
	_vehtype = typeOf _veh;
	_flag = false;
	if (true) then {
		_mags = getArray(configFile >> "CfgVehicles" >> _vehtype >> "magazines");

		if (count _mags > 0) exitWith {_flag = true};

		_count = count (configFile >> "CfgVehicles" >> _vehtype >> "Turrets");

		if (_count > 0) exitWith {_flag = true};
	};
	_flag;
};

zlt_frpr_getPartsRepairTime = {
	private ["_veh","_vehtype","_flag"];
	_veh =  [_this, 0] call BIS_fnc_param;
	if (isNil {_veh}) exitWith {1};

	systemchat format ["%1, %2",DEFAULT_FIELDREPAIR_EACH_HARDPART_TIME,DEFAULT_FIELDREPAIR_EACH_PART_TIME];
	_DEFAULT_FIELDREPAIR_EACH_HARDPART_TIME =(DEFAULT_FIELDREPAIR_EACH_HARDPART_TIME);
	_DEFAULT_FIELDREPAIR_EACH_PART_TIME =DEFAULT_FIELDREPAIR_EACH_PART_TIME;
	if  (str player in ([] call NTA_fnc_engineers)) then {
	_DEFAULT_FIELDREPAIR_EACH_HARDPART_TIME =(DEFAULT_FIELDREPAIR_EACH_HARDPART_TIME/2);
	_DEFAULT_FIELDREPAIR_EACH_PART_TIME =(DEFAULT_FIELDREPAIR_EACH_PART_TIME/2);
};
systemchat format ["%1, %2",_DEFAULT_FIELDREPAIR_EACH_HARDPART_TIME,_DEFAULT_FIELDREPAIR_EACH_PART_TIME];
	_rprTime = 0;
	{
		_cdmg = _veh getHitPointDamage (_x);
		if (not isNil {_cdmg} ) then {
			diag_log str ["REPAIR ", _x, _cdmg];
			if (_cdmg > 0.64) exitWith {_rprTime = _rprTime + ( if (_x in zlt_hardRepairParts) then {_DEFAULT_FIELDREPAIR_EACH_HARDPART_TIME} else {_DEFAULT_FIELDREPAIR_EACH_PART_TIME}); };
		};
	}  forEach zlt_repair_hps;
	_rprTime;
};

zlt_fnc_notify = {
	 [ format["<t size='0.75' color='#ffff00'>%1</t>",_this], 0,1,5,0,0,301] spawn bis_fnc_dynamicText;
};

zlt_fnc_hastk = {
	private ["_ret"];
	_ret = 0;
	if ("ToolKit" in (items player)) then {_ret = 1;};
	if ("ToolKit" in (itemCargo _veh)) then {_ret = 2;};
	if ( (_veh getVariable ["zlt_longrepair_times",0] ) < DEFAULT_FREE_REPAIRS) then {_ret = 3;};
	_ret;
};


zlt_fnc_removeitemfromcargo = {
	private ["_veh"];
	_item = [_this,0,""] call BIS_fnc_param;
	_veh = [_this,1] call BIS_fnc_param;
	_allitems = itemcargo _veh;
	clearItemCargoGlobal _veh;
	_allitems = _allitems call BIS_fnc_consolidateArray;
	_n = [_allitems, _item] call BIS_fnc_findInPairs;
	_allitems set [_n, [(_allitems select _n) select 0, ((_allitems select _n) select 1) - 1]];
    { _veh addItemCargoGlobal [_x select 0, _x select 1 ];} foreach _allitems;
};

zlt_prc_repairvehicle = {
	private ["_veh"];
	_veh = (nearestObjects [player,["LandVehicle","Air","Ship"], 7]) select 0;
	if (isNil {_veh}) exitWith {};
	if (zlt_mutexAction) exitWith {
		STR_ANOTHER_ACTION call zlt_fnc_notify;
	};
	if (not alive player or (player distance _veh) > 7 or (vehicle player != player) or speed _veh > 3) exitWith {STR_REPAIR_CONDITIONS call zlt_fnc_notify;};
	_hastk = [] call zlt_fnc_hastk;
	if ( _hastk == 0 ) exitWith {STR_NEED_TOOLKIT call zlt_fnc_notify;};
	_repairFinished = false;
	zlt_mutexAction = true;
	_lastPlayerState = animationState player;
	player playActionNow "medicStartRightSide";
	sleep 0.5;
	_maxlength = _veh getVariable["zlt_longrepair",[_veh] call zlt_frpr_getPartsRepairTime];
	_vehname = getText ( configFile >> "CfgVehicles" >> typeOf(_veh) >> "displayName");
	_length = _maxlength;
	_cycle = 0;
	while {alive player and (player distance _veh) < 7 and (vehicle player == player) and speed _veh < 3 and not _repairFinished and zlt_mutexAction and (_cycle < 3 or (["medic",animationState player] call BIS_fnc_inString))} do {
	//	diag_log ("ANIM STATE = "+str(animationState player));
		(format[STR_REPAIR_MSG_STRING, _length, _vehname] ) call zlt_fnc_notify;
		if (_length <= 0) then {_repairFinished = true;};
		_length = _length - 1;
		sleep 1;
		_hastk = [] call zlt_fnc_hastk;
		if (_hastk <= 0) exitWith {STR_NEED_TOOLKIT call zlt_fnc_notify; sleep 1.;};
		_cycle = _cycle + 1;
	};
	if (_repairFinished) then {
		_hastk = [] call zlt_fnc_hastk;
		if (_hastk == 0) exitWith {STR_NEED_TOOLKIT call zlt_fnc_notify; sleep 1.;};
		STR_REPAIR_FINISHED call zlt_fnc_notify;
		[_veh,"zlt_fnc_partrepair", _veh] call bis_fnc_MP;
		if  (!(str player in ([] call NTA_fnc_engineers))) then {
		if (_hastk == 1) then {player removeItem "ToolKit";};
		};
		if (_hastk == 2) then { ["ToolKit",_veh] call zlt_fnc_removeitemfromcargo;};
		_veh setVariable["zlt_longrepair",nil, true];
		_veh setVariable["zlt_longrepair_times", (_veh getVariable ["zlt_longrepair_times",0]) + 1 , true ];
	} else {
		STR_REPAIR_INTERRUPTED call zlt_fnc_notify;
		_veh setVariable["zlt_longrepair",_length, true];
	};
	zlt_mutexAction = false;
	player playActionNow "medicstop";
};


zlt_fnc_repair_cond = {
	private ["_veh","_ret"];
	_ret = false;
	_veh = (nearestObjects [player,["LandVehicle","Air","Ship"], 7]) select 0;
	if (isNil {_veh}) exitWith {_ret};
	_dmged = _veh call zlt_fnc_vehicledamaged;
	_ret = (alive player and {(player distance _veh) <= 7} and {(vehicle player == player)} and {speed _veh < 3} and {not zlt_mutexAction} and {_dmged} and {alive _veh});
	_ret;
};


zlt_fnc_reloadammo = {
	private ["_caller","_truck","_veh","_type"];
	_caller = player;
	_truck = vehicle _caller;
	_veh = cursorTarget;
	_type = typeOf(_veh);

	if (isNil "_veh" or {isNull _truck} or {isNull _veh}) exitWith {false};


	if (zlt_mutexAction) exitWith
	{
		STR_ANOTHER_ACTION call zlt_fnc_notify;
	};
	if (_truck getVariable ["zlt_repair_cargo", 0] <= 0) then {
		STR_REPAIR_TRUCK_DEPLETED call zlt_fnc_notify;
	};

	if (not alive player or vehicle player == player or speed _veh > 3 or _veh distance _truck > 15 ) exitWith {STR_REPAIR_CONDITIONS call zlt_fnc_notify;};

	_AMMOFinished = false;
	zlt_mutexAction = true;

	_magazines = getArray(configFile >> "CfgVehicles" >> _type >> "magazines");
	_vehname = getText ( configFile >> "CfgVehicles" >> typeOf(_veh) >> "displayName");
	_count = count (configFile >> "CfgVehicles" >> _type >> "Turrets");


	_partFinished = false;
	_partFinished2 = false;
	_partFinished1 =false;
	if (count _magazines > 0) then
	{
		_magcount = (count _magazines) +1;
		(format[STR_AMMO_COUNT, _magcount] ) call zlt_fnc_notify;
		sleep 3;
		_removed = [];
		{
			if (!(_x in _removed)) then
			{
				_partFinished1 = false;
				_length = DEFAULT_RELOAD_LENGHT-10;

				while {alive player and alive _truck and alive _veh and vehicle _caller != _caller and speed _veh <= 3 and zlt_mutexAction and _veh distance _truck <= 15 and not _partFinished1} do
				{

					(format[STR_AMMO_MSG_STRING, _x, _vehname,_length, _magcount] ) call zlt_fnc_notify;
					if (_length <= 0) then {_partFinished1 = true;};
					_length = _length - 1;

					sleep 1;
				};
				if (_partFinished1) then {
					_veh removeMagazine _x;
					_veh addMagazine _x;
					_removed = _removed + [_x]
				};
				_magcount =_magcount -1;


			}; //end inner if
		} forEach _magazines;
		_veh setVehicleAmmoDef 1;
	} else {_partFinished1=true}; //end if



	if (_count > 0) then
	{


		for "_i" from 0 to (_count -1) do
		{
			_config = (configFile >> "CfgVehicles" >> _type >> "Turrets") select _i;
			_magazines = getArray(_config >> "magazines");
			_magcount = count(_magazines);
			(format[STR_AMMO_COUNT_HI, _magcount] ) call zlt_fnc_notify;

			sleep 3;


			_partFinished = false;
			_partFinished2 = false;
			_count_other = count (_config >> "Turrets");
			_magazines2=getArray(_config >> "Turrets");

			{
			_partFinished = false;
				_length = DEFAULT_RELOAD_LENGHT+10;

				while {alive player and alive _truck and alive _veh and vehicle _caller != _caller and speed _veh <= 3 and zlt_mutexAction and _veh distance _truck <= 15 and not _partFinished} do
				{

					(format[STR_AMMO_MSG_STRING, _x, _vehname,_length, _magcount] ) call zlt_fnc_notify;
					if (_length <= 0) then {_partFinished = true;};
					_length = _length - 1;

					sleep 1;
				};
				if (_partFinished) then {
					_veh removeMagazine _x;
					_veh addMagazine _x;
					//_veh setVehicleAmmo 1
				};
				_magcount= _magcount - 1;
			} forEach _magazines;






			_count_other = count (_config >> "Turrets");


			if (_count_other > 0) then
			{
				_magcount_other = _count_other +1;
				(format[STR_AMMO_COUNT_LOW, _magcount_other] ) call zlt_fnc_notify;
				sleep 3;
				for "_i" from 0 to (_count_other - 1) do
				{
					_partFinished2 = false;
					_config2 = (_config >> "Turrets") select _i;
					_magazines = getArray(_config2 >> "magazines");
					{
						_partFinished2 = false;
						_length = DEFAULT_RELOAD_LENGHT;

						while {alive player and alive _truck and alive _veh and vehicle _caller != _caller and speed _veh <= 3 and zlt_mutexAction and _veh distance _truck <= 15 and not _partFinished2} do
						{
							(format[STR_AMMO_MSG_STRING, _x, _vehname,_length,_magcount_other] ) call zlt_fnc_notify;
							if (_length <= 0) then {_partFinished2 = true;};
							_length = _length - 1;
							sleep 1;
						};
						if (_partFinished2) then {
							_veh removeMagazine _x;
							_veh addMagazine _x;
							//_veh setVehicleAmmo 1;
						};
					_magcount_other= _magcount_other - 1;
					} forEach _magazines;
				};//end forloop

			} else {
				_partFinished2 =true;
			};

		};//end for loop

	} else {
		_partFinished2 = true;
		_partFinished = true;
	};

	if (_partFinished and _partFinished1 and _partFinished2) then {
		STR_AMMO_FINISHED call zlt_fnc_notify;

	} else {

		player sidechat format["%1 %2 %3", _partFinished,_partFinished1,_partFinished2];
		STR_AMMO_INTERRUPTED call zlt_fnc_notify;
		zlt_mutexAction = false;
	};
	zlt_mutexAction = false;
	_veh setFuel 1;
}; //endfunction

zlt_fnc_heavyRepair =
{
	private ["_caller","_truck","_veh"];
	_caller = player;
	_truck = vehicle _caller;
	_veh = cursorTarget;
	if (isNil "_veh" or {isNull _truck} or {isNull _veh}) exitWith {false};
if  (str player in ([] call NTA_fnc_engineers)) then {
	DEFAULT_FULLREPAIR_LENGTH =(DEFAULT_FULLREPAIR_LENGTH/2)
};

	if (zlt_mutexAction) exitWith {
		STR_ANOTHER_ACTION call zlt_fnc_notify;
	};
	if (_truck getVariable ["zlt_repair_cargo", 0] <= 0) then {
		STR_REPAIR_TRUCK_DEPLETED call zlt_fnc_notify;
	};

	if (not alive player or vehicle player == player or speed _veh > 3 or _veh distance _truck > 15 ) exitWith {STR_REPAIR_CONDITIONS call zlt_fnc_notify;};

	_repairFinished = false;
	zlt_mutexAction = true;
	_maxlength = _veh getVariable["zlt_longrepairTruck",DEFAULT_FULLREPAIR_LENGTH];
	_vehname = getText ( configFile >> "CfgVehicles" >> typeOf(_veh) >> "displayName");
	_length = _maxlength;
	while { alive player and alive _truck and alive _veh and vehicle _caller != _caller and speed _veh <= 3 and not _repairFinished and zlt_mutexAction and _veh distance _truck <= 15 } do {
		(format[STR_REPAIR_MSG_STRING, _length, _vehname] ) call zlt_fnc_notify;
		if (_length <= 0) then {_repairFinished = true;};
		_length = _length - 1;
		sleep 1;
	};

	if (_repairFinished) then {
		STR_REPAIR_FINISHED call zlt_fnc_notify;
		[_veh,"zlt_fnc_fullrepair", _veh] call bis_fnc_MP;
		_truck setVariable ["zlt_repair_cargo", ( (_truck getVariable ["zlt_repair_cargo", 0] )- (1 / DEFAULT_REPAIR_TRUCK_USES) ), true] ;

		_veh setVariable["zlt_longrepairTruck", nil, true];
		_veh setVariable["zlt_fullrepair_times", (_veh getVariable ["zlt_fullrepair_times",0]) + 1 , true ];
	} else {
		STR_REPAIR_INTERRUPTED call zlt_fnc_notify;
		_veh setVariable["zlt_longrepairTruck",_length, true];
	};
	zlt_mutexAction = false;
};

zlt_pushapc = {
	private ["_veh","_unit"];
	_veh = vehicle player;

	if (zlt_mutexAction) exitWith {};
	zlt_mutexAction = true;
	sleep 1.;
	_spd = 3;
	_dir = direction _veh;
	_veh setVelocity [(sin _dir)*_spd, (cos _dir)*_spd, 0];
	zlt_mutexAction = false;
};


// obsolete
zlt_fnc_heavyRepairCOnd = {
	_truck = vehicle player;
	_veh = cursorTarget;
	if (isNull _truck or isNull _veh) exitWith {false};
	_isRepair = _truck getVariable ["zlt_repair_cargo", -1];
	if (_isRepair == -1) exitWith {false};

	_res = _veh distance _truck <= 15 and {player == (driver _truck)} and {(_veh isKindOf "LandVehicle" or _veh isKindOf "Ship" or _veh isKindOf "Air")} and {alive _truck} and {alive player} and {alive _veh} and {not zlt_mutexAction} and {speed _veh <= 3} and {(damage _veh != 0)};
	_res;

};


if (isNil "zlt_cancelActionId") then {

	zlt_cancelActionId = player addAction["<t color='#0000ff'>"+STR_CANCEL_ACTION+"</t>", {zlt_mutexAction = false}, [], 10, false, true, '',' zlt_mutexAction  '];

/*	player addAction["<t color='#ff0000'>"+STR_FIELD_REPAIR+"</t>", zlt_prc_repairvehicle, [], -1, false, true, '','[] call zlt_fnc_repair_cond'];

	player addAction["<t color='#ff0000'>"+STR_SERIOUS_REPAIR+ "</t>",zlt_fnc_heavyRepair, [], -1, false, true, '','_truck=(vehicle player);_truck getVariable ["zlt_repair_cargo", -1] != -1 and {alive cursorTarget} and {_truck distance cursorTarget <= 15} and {(cursorTarget isKindOf "LandVehicle" or cursorTarget isKindOf "Ship" or cursorTarget isKindOf "Air")} and {not zlt_mutexAction} and {speed cursorTarget <= 5} and {(damage cursorTarget != 0)}'];
*/
player addAction["<t color='#ff0000'>"+STR_RELOAD_AMMO+ "</t>", zlt_fnc_reloadammo, [], -1, false, true, '','_truck=(vehicle player);_truck getVariable ["zlt_repair_cargo", -1] != -1 and {alive cursorTarget} and {_truck distance cursorTarget <= 15} and {(cursorTarget isKindOf "LandVehicle" or cursorTarget isKindOf "Ship" or cursorTarget isKindOf "Air")} and {not zlt_mutexAction} and {speed cursorTarget <= 5} and {[cursorTarget] call zlt_fnc_vehicleammo}'];

/*
	player addAction["<t color='#FF9900'>"+STR_PUSH_APC+"</t>",zlt_pushapc,[],5,false,true,"","canMove (vehicle player) and ((vehicle player) isKindOf 'Wheeled_APC_F') and player == driver (vehicle player) and surfaceIsWater getpos (vehicle player)  and abs(speed (vehicle player) ) < 5 and not zlt_mutexAction"];
*/
	player createDiarySubject [STR_SCRIPTS_NAME,STR_SCRIPTS_NAME];
	player createDiaryRecord [STR_SCRIPTS_NAME,[STR_SCRIPT_NAME, STR_HELP]];

};

player addEventHandler ["Respawn", {
	zlt_cancelActionId = player addAction["<t color='#0000ff'>"+STR_CANCEL_ACTION+"</t>", {zlt_mutexAction = false}, [], 10, false, true, '',' zlt_mutexAction  '];

	/*player addAction["<t color='#ff0000'>"+STR_FIELD_REPAIR+"</t>", zlt_prc_repairvehicle, [], -1, false, true, '','[] call zlt_fnc_repair_cond'];
	player addAction["<t color='#ff0000'>"+STR_SERIOUS_REPAIR+ "</t>", zlt_fnc_heavyRepair, [], -1, false, true, '','_truck=(vehicle player);_truck getVariable ["zlt_repair_cargo", -1] != -1 and {alive cursorTarget} and {_truck distance cursorTarget <= 15} and {(cursorTarget isKindOf "LandVehicle" or cursorTarget isKindOf "Ship" or cursorTarget isKindOf "Air")} and {not zlt_mutexAction} and {speed cursorTarget <= 5} and {(damage cursorTarget != 0) or (cursorTarget call zlt_fnc_vehicleammo)}'];
	player addAction["<t color='#FF9900'>"+STR_PUSH_APC+"</t>",zlt_pushapc,[],5,false,true,"","canMove (vehicle player) and ((vehicle player) isKindOf 'Wheeled_APC_F') and player == driver (vehicle player) and surfaceIsWater getpos (vehicle player)  and abs(speed (vehicle player) ) < 5 and not zlt_mutexAction"];
*/
player addAction["<t color='#ff0000'>"+STR_RELOAD_AMMO+ "</t>", zlt_fnc_reloadammo, [], -1, false, true, '','_truck=(vehicle player);_truck getVariable ["zlt_repair_cargo", -1] != -1 and {alive cursorTarget} and {_truck distance cursorTarget <= 15} and {(cursorTarget isKindOf "LandVehicle" or cursorTarget isKindOf "Ship" or cursorTarget isKindOf "Air")} and {not zlt_mutexAction} and {speed cursorTarget <= 5} and {[cursorTarget] call zlt_fnc_vehicleammo}'];


}];





