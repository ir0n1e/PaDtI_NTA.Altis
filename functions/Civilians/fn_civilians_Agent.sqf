 private ["_unit", "_mkr", "_object", "_index", "_groupnew"];

_unit = _this select 0;
_mkr = _this select 1;
_unit setvariable ["OnMission", true];
_unit setvariable ["Mission", "kill"];
_groupnew = createGroup east;

[_unit] joinSilent _groupnew;
_unit allowfleeing 0;
_unit setskill ["courage",1];
group _unit setCombatMode "RED";
group _unit setBehaviour "CARELESS";
_unit addweapon "hgun_Rook40_F";
_unit addmagazine "16Rnd_9x21_Mag";
_unit addmagazine "16Rnd_9x21_Mag";
_index = currentWaypoint group _unit;
deleteWaypoint [(group _unit), _index];
_object = [(getposASL _unit), 200, playableunits] call NTA_fnc_core_findnearestobject;

if (str _object != "<NULL-object>") then {
    _unit domove (position _object);
} else {
     _wp = [group _unit, '',getmarkerpos _mkr , "NORMAL", "SAD","COMBAT","RED"] call NTA_fnc_vehicles_addwaypoint;
};

 deleteGroup (group _unit);
