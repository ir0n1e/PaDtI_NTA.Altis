scriptName "fn_airpatrol_callGroup";
/*
	Author: Ir0n1E

	Description:
	Calls defined group

	Parameter(s):
	#0 OBJECT - Side (if side "" call random side)
	#1 ARRAY - Start Position
	#2 ARRAY - End Position
	#3 ARRAY - Target Position
	#4 ARRAY - Type


	Returns:
	None
*/
if (!isServer) exitWith {};
private ["_side", "_airstart", "_airend", "_fnc_array", "_array"];
_array = [];
_side 		= [_this, 0, ""] call BIS_fnc_param;
_airStart 	= [_this, 1, [28713.2,27432.7,0]] call BIS_fnc_param;
_airEnd 	= [_this, 2, [1637.84,13848.8,0]] call BIS_fnc_param;
_airTarget 	= [_this, 3, []] call BIS_fnc_param;
_airType 	= [_this, 4, []] call BIS_fnc_param;


waituntil {NTA_Airpatrolrunning};

switch (_side) do {
    case WEST: {
    	[_airStart, _airEnd, _airTarget, _airType, _side] call NTA_fnc_airpatrol_Create;
    };
    case EAST: {
    	[_airStart, _airEnd, _airTarget, _airType, _side] call NTA_fnc_airpatrol_Create;
	};
    default {
     	[_airStart, _airEnd, _airTarget, _airType] call NTA_fnc_airpatrol_Create;
    };
};