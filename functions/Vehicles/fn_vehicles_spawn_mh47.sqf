if (!isServer) exitWith {};
private ["_type","_pos","_init","_unit"];

MH1=nil;
_array = call NTA_fnc_all_vehicles;
_type = "kyo_MH47E_HC";

_pos = getMarkerPos "POS_MH1";
_unit = _type createVehicle _pos;
_unit setVehicleVarName "MH1";
_unit setVariable ["dead", false,true];
[_unit] execVM "IgiLoad\IgiLoad.sqf";
[_unit] call NTA_fnc_crate_marshall;
_unit setObjectTexture [0,"images\flagmh47.paa"];
[_unit, 60, 300,0,false,false, "[_this] call NTA_fnc_crate_marshall;[_this] execVM ""IgiLoad\IgiLoad.sqf""; _this setObjectTexture [0,""images\flagmh47.paa""]; "] execVM "Scripts\vehiclerespawn.sqf";


 [[netID _unit, vehicleVarName _unit], "NTA_fnc_vehicles_setVarName", true, true] spawn BIS_fnc_MP;
 /*[[netID _unit, _init], "NTA_fnc_vehicles_setInit", true, true] spawn BIS_fnc_MP;

 */
