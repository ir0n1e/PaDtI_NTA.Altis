//HC Switch
if (isserver) then {

	if (!isnil "HCPresent") exitwith {

		[_this, "NTA_fnc_eos_bastionSpawn", NTAHC] call BIS_fnc_MP;
		"EOS switching to HC" call NTA_fnc_log;
		breakout "main";
	};

	"EOS switching to Server" call NTA_fnc_log;
};

private ["_fGroup","_cargoType","_vehType","_CHside","_mkrAgl","_initialLaunch","_pause","_eosZone","_hints","_waves","_aGroup","_side","_actCond","_enemyFaction","_mAH","_mAN","_distance","_grp","_cGroup","_bGroup","_CHType","_time","_timeout","_faction", "_allunits", "_fGrp", "_agrp", "_bgrp", "_cgrp","_pos", "_mkrX", "_mpos", "_wp", "_vehType", "_cargoType", "_newPos", "_confArray", "_eosActive"];

_eosActive 		= _this;
_confArray 		= _eosActive getvariable "confArray";

_enemyFaction 	= _eosActive getVariable "EOSfaction" select 0;
_civZone      	= _eosActive getVariable "EOSfaction" select 1;
_mAH			= _eosActive getVariable "EOSmarkerColor" select 0;
_mAN			= _eosActive getVariable "EOSmarkerColor" select 1;

_mkr			= (_confArray select 0);
_mPos			= markerpos(_confArray select 0);
_mkrX			= getMarkerSize _mkr select 0;
_mkrY			= getMarkerSize _mkr select 1;
_mkrAgl			= markerDir _mkr;
_infantry		= (_confArray select 1);
_PApatrols		= _infantry select 0;
_PAgroupSize	= _infantry select 1;
_LVeh			= (_confArray select 2);
_LVehGroups		= _LVeh select 0;
_LVgroupSize	= _LVeh select 1;
_AVeh			= (_confArray select 3);
_AVehGroups		= _AVeh select 0;
_SVeh			= (_confArray select 4);
_CHGroups		= _SVeh select 0;
_fSize			= _SVeh select 1;
_settings		= (_confArray select 5);
_side			= _settings select 2;
_faction		= _settings select 0;
_basSettings	= (_confArray select 6);
_pause			= _basSettings select 0;
_waves			= _basSettings select 1;
_timeout		= _basSettings select 2;
_eosZone		= _basSettings select 3;
_hints			= _basSettings select 4;
_initialLaunch	= if (count _confArray > 7) then {_confArray select 7} else {false};
_maindir		= if (count _confArray > 8) then {_confArray select 8} else {random 360};
_debug			= if (count _settings > 5) then {_settings select 5} else {false};
_drift 			= [20, -20];

_Placement = (_mkrX + 800);

_allgrps 		= _eosActive getvariable "Groups";
_allunits 		= _eosActive getvariable "allunits";

_aGrp = _allgrps select 1;
_bGrp = _allgrps select 2;
_cGrp = _allgrps select 3;
popEOS = true;
publicVariable "popEOS";

// SPAWN PATROLS
for "_counter" from 1 to _PApatrols do {
	if ((count allunits - count playableUnits) < EOShardlimit ) then {
		_pos = [_mPos, _Placement, _mainDir + random (_drift call NTA_fnc_getRandArrayPos)] call BIS_fnc_relPos;
		_grp = [[_pos, [10, random 100], 10, 0] call PO3_fnc_getSafePos,_PAgroupSize,_faction,_side] call NTA_fnc_eos_spawnGroup;
		_aGrp pushback _grp;
		_allunits = _allunits + (units _grp);
		0 = [_grp, "INFskill"] call NTA_fnc_eos_setSkill;
	};
};

//SPAWN LIGHT VEHICLES
for "_counter" from 1 to _LVehGroups do {
	if ((count allunits - count playableUnits) < EOShardlimit ) then {
		_pos = [_mPos, (_Placement + 200), _mainDir + random (_drift call NTA_fnc_getRandArrayPos)] call BIS_fnc_relPos;
		_newpos = [_pos, [10, random 100], 10] call PO3_fnc_getSafePos;

		if (surfaceiswater _newpos) then {
			_vehType=8;
			_cargoType=10;
		} else {
			_vehType=7;
			_cargoType=9;
		};

		_bGroup=[_newpos,_side,_faction,_vehType] call NTA_fnc_eos_spawnVehicle;

		if ((_LVgroupSize select 0) > 0) then {
			0 = [(_bGroup select 0),_LVgroupSize,(_bGroup select 2),_faction,_cargoType] call NTA_fnc_eos_setCargo;
			0 = [(_bGroup select 2),"LIGskill"] call NTA_fnc_eos_setSkill;
			_bGrp pushback _bGroup;
			_allunits = _allunits + (units (_bGroup select 2));
		};
	};
};

//SPAWN ARMOURED VEHICLES
for "_counter" from 1 to _AVehGroups do {
	if ((count allunits - count playableUnits) < EOShardlimit ) then {
		_pos = [_mPos, (_Placement+1000), _mainDir + random (_drift call NTA_fnc_getRandArrayPos)] call BIS_fnc_relPos;
		_newpos = [_pos, [10, random 100], 10] call PO3_fnc_getSafePos;

		if (surfaceiswater _newpos) then {
			_vehType=8;
		} else {
			_vehType=2;
		};

		_cGroup = [_newpos,_side,_faction,_vehType] call NTA_fnc_eos_spawnVehicle;

		0 = [(_cGroup select 2),"ARMskill"] call NTA_fnc_eos_setSkill;
		_cGrp pushback _cGroup;
		_allunits = _allunits + (units (_cGroup select 2));
	};
};
_this setvariable ["allunits", _allunits, true];
_this setvariable ["Groups", [[], _aGrp, _bGrp, _cGrp, [], []], true];
//SPAWN HELICOPTERS
/*
for "_counter" from 1 to _CHGroups do {

	if ((_fSize select 0) > 0) then {
		_vehType=4;
	} else {
		_vehType=3;
	};
	_pos = [(markerpos _mkr), 4000, random 360] call BIS_fnc_relPos;
	_fGroup=[_pos,_side,_faction,_vehType,"fly"] call EOS_fnc_spawnvehicle;
	_CHside=_side;
	_fGrp set [count _fGrp,_fGroup];

	if ((_fSize select 0) > 0) then {
		_cargoGrp = createGroup _side;
		0=[(_fGroup select 0),_fSize,_cargoGrp,_faction,9] call eos_fnc_setcargo;
		0=[_cargoGrp,"INFskill"] call eos_fnc_grouphandlers;

		_fGroup set [count _fGroup,_cargoGrp];
		null = [_mkr,_fGroup,_counter] execvm "eos\functions\TransportUnload_fnc.sqf";

	} else {
		_wp1 = (_fGroup select 2) addWaypoint [(markerpos _mkr), 0];
		_wp1 setWaypointSpeed "FULL";
		_wp1 setWaypointType "SAD";};

		if (_debug) then {player sidechat format ["Chopper:%1",_counter];
			0= [_mkr,_counter,"Chopper",(getpos leader (_fGroup select 2))] call EOS_debug;
		};
	};
*/
// ADD WAYPOINTS
{
	_wp = _x addWaypoint [_mPos, 0];
	_wp setWaypointType "SAD";
	_wp setWaypointSpeed "NORMAL";
	_wp setWaypointBehaviour "AWARE";
	_wp setWaypointFormation "NO CHANGE";
} foreach _aGrp;

{
	_wp = (_x select 2) addWaypoint [_mPos, 0];
	_wp setWaypointType "SAD";
	_wp setWaypointSpeed "NORMAL";
	_wp setWaypointBehaviour "AWARE";
	_wp setWaypointFormation "NO CHANGE";
} foreach _cGrp;

{
	_pos = [_mPos, (_mkrX + 50), random 360] call BIS_fnc_relPos;
	_wp = (_x select 2) addWaypoint [_pos, 0];
	_wp setWaypointType "TR UNLOAD";
	_wp setWaypointSpeed "NORMAL";
	_wp setWaypointBehaviour "AWARE";
	_wp setWaypointFormation "NO CHANGE";

	_wp = (_x select 2) addWaypoint [_mPos, 1];
	_wp setWaypointType "SAD";
	_wp setWaypointSpeed "NORMAL";
	_wp setWaypointBehaviour "AWARE";
	_wp setWaypointFormation "NO CHANGE";
} foreach _bGrp;

popEOS = false;
publicVariable "popEOS";



