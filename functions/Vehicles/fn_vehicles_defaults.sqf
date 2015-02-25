private "_veh";
_veh = _this select 0;
_veh setvariable ["respawnnow", false, true];
_veh setvariable ["burning", false, false];
_veh setvariable ["respawn", false, true];
_veh setVariable ["dead", false, true];
_veh setVariable ["UnitType", typeOf _veh];
_veh setVariable ["timeout", false];
_veh setVariable ["time", time];
_veh setvariable ["defultlocked", true];

if (NTA_VehiclesFirstrun) then {
   _veh setVariable ["RespawnPos", [getPosASL _veh, getDir _veh]];
};

if (missionNamespace getvariable ["havebwplus", false] && {("params_NTA_Bwplus" call bis_fnc_getParamValue) > 0} && {NTA_VehiclesFirstrun}) then {
    switch (str _veh) do {
        case "Strider1": {
            _veh setvariable ["UnitType", "Fennek_Flecktarn_gmg"];
            _veh setvariable ["respawnnow", true];
        };
        case "Strider2": {
            _veh setvariable ["UnitType", "Fennek_Flecktarn_mg"];
            _veh setvariable ["respawnnow", true];
        };
        case "Strider3": {
            _veh setvariable ["UnitType", "Fennek_Flecktarn_mg"];
            _veh setvariable ["respawnnow", true];
        };
        case "Strider4": {
            _veh setvariable ["UnitType", "Fennek_Flecktarn_gmg"];
            _veh setvariable ["respawnnow", true];
        };
        case "Strider5": {
            _veh setvariable ["UnitType", "Fennek_Flecktarn_mg"];
            _veh setvariable ["respawnnow", true];
        };
        case "Strider6": {
            _veh setvariable ["UnitType", "Fennek_Flecktarn_mg"];
            _veh setvariable ["respawnnow", true];
        };
        case "Strider9": {
            _veh setvariable ["UnitType", "Fennek_Flecktarn_mg"];
            _veh setvariable ["respawnnow", true];
        };
        case "StriderCheck1": {
            _veh setvariable ["UnitType", "Fennek_Flecktarn_mg"];
            _veh setvariable ["defaultlocked", false];
            _veh setvariable ["respawnnow", true];
            _veh setvariable ["defultlocked", true];
        };
        case "StriderCheck2": {
            _veh setvariable ["UnitType", "Fennek_Flecktarn_mg"];
            _veh setvariable ["respawnnow", true];
            _veh setvariable ["defaultlocked", false];
            _veh setvariable ["defultlocked", true];
        };
        case "Med1": {
            _veh setvariable ["UnitType", "Fennek_Flecktarn_san"];
            _veh setvariable ["respawnnow", true];
        };
        case "Vec_engineer": {
            _veh setvariable ["UnitType", "Fennek_Flecktarn_pio"];
            _veh setvariable ["respawnnow", true];
        };
        case "Vec_engineer2": {
            _veh setvariable ["UnitType", "Fennek_Flecktarn_pio"];
            _veh setvariable ["respawnnow", true];
        };
        case "Moe2": {
            _veh setvariable ["UnitType", "BWplus_Merlin"];
            _veh setvariable ["respawnnow", true];
        };
         case "Supp1": {
            _veh setvariable ["UnitType", "BWplus_Box_Cargo"];
            _veh setvariable ["respawnnow", true];
        };
         case "Supp2": {
            _veh setvariable ["UnitType", "BWplus_Box_Cargo"];
            _veh setvariable ["respawnnow", true];
        };
         case "Supp3": {
            _veh setvariable ["UnitType", "BWplus_Box_Cargo"];
            _veh setvariable ["respawnnow", true];
        };
         case "Supp4": {
            _veh setvariable ["UnitType", "BWplus_Box_Cargo"];
            _veh setvariable ["respawnnow", true];
        };
         case "Supp5": {
            _veh setvariable ["UnitType", "BWplus_Box_Cargo"];
            _veh setvariable ["respawnnow", true];
        };
         case "Supp6": {
            _veh setvariable ["UnitType", "BWplus_Box_Cargo"];
            _veh setvariable ["respawnnow", true];
        };
    };
};

if (isClass(configFile/"CfgPatches"/"BWA3_Common")) then {
    switch (str _veh) do {
        case "Puma1": {
            _veh setvariable ["UnitType", "BWA3_Puma_Fleck"];
            _veh setvariable ["respawnnow", true];
        };
        case "Puma2": {
            _veh setvariable ["UnitType", "BWA3_Puma_Fleck"];
            _veh setvariable ["respawnnow", true];
        };
        case "Leo1": {
            _veh setvariable ["UnitType", "BWA3_Leopard2A6M_Fleck"];
            _veh setvariable ["respawnnow", true];
        };
        case "Leo2": {
            _veh setvariable ["UnitType", "BWA3_Leopard2A6M_Fleck"];
            _veh setvariable ["respawnnow", true];
        };
        case "bw_demo1": {
            _veh setvariable ["UnitType", "BWA3_Box_All"];
            _veh setvariable ["respawnnow", true];
            //_position = [ getposASL _veh select 0, getposASL _veh select 1,( getposASL _veh select 2) +3];
        };
        case "bw_demo2": {
            _veh setvariable ["UnitType", "BWA3_Box_All_Net"];
            _veh setvariable ["respawnnow", true];
        };
         case "bw_demo3": {
            _veh setvariable ["UnitType", "BWA3_Box_All"];
            _veh setvariable ["respawnnow", true];
        };
    };
};
/*
if (("NTA_EVENT" call bis_fnc_getParamValue) == 0 && {missionNamespace getVariable ["haveAGM", false]}) then {
    [
        _veh,
        "Unlock", 8, {
        (_this select 0) getVariable "locked" && {alive (_this select 0)} && {[(_this select 0)] call NTA_fnc_BWplus_checkVehicleRights} && {[(_this select 0)] call NTA_fnc_core_checkVehicleRights}},
        {[(_this select 0)] call NTA_fnc_vehicles_unlock},
        false
    ] call AGM_Interaction_fnc_addInteraction;

    [
        _veh,
        "Lock", 8, {
        !((_this select 0) getVariable "locked") && {[(_this select 0)] call NTA_fnc_BWplus_checkVehicleRights} && {[(_this select 0)] call NTA_fnc_core_checkVehicleRights} && {count crew (_this select 0) == 0}},
        {[(_this select 0)] call NTA_fnc_vehicles_lock},
        false
    ] call AGM_Interaction_fnc_addInteraction;
};
*/