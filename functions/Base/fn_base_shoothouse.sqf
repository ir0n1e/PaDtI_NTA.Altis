if (("NTA_TRAINING_Shoothouse" call bis_fnc_getParamValue) <= 0) exitwith {};
_this spawn {
"Starting Shoothouse Init..." call NTA_fnc_log;
private ["_Vehicles_list","_type","_pos","_dir","_unitinit"];

_Vehicles_list = [["EMPTY","TargetP_Inf2_F",[26898.6,24325.4,0.0385818],359.54,";_this setpos [26898.6,24325.4,4.45001];"],["EMPTY","TargetP_Inf2_F",[26899,24325.3,-0.0716953],295.908,";_this setpos [26899,24325.3,-0.0749913];"],["EMPTY","TargetP_Inf2_F",[26890.5,24319.1,-0.238829],46.6185,""],["EMPTY","TargetP_Inf2_F",[26871.8,24339.5,-0.122799],46.62,""],["EMPTY","TargetP_Inf2_F",[26838.9,24307.3,-0.12273],218.606,""],["EMPTY","TargetP_Inf2_F",[26876.2,24298.8,-0.108959],118.682,";_this setpos [26876.2,24298.8,0.200009];"],["EMPTY","TargetP_Inf2_F",[26890.8,24271,0.274282],53.5231,";_this setpos [26890.8,24271,0.500009];"],["EMPTY","TargetP_Inf2_F",[26918,24318.3,-0.0345345],62.8078,";_this setpos [26918,24318.3,0.350009];"],["EMPTY","TargetP_Inf2_F",[26911.4,24318.9,-0.0182343],107.173,";_this setpos [26911.4,24318.9,0.150008];"],["EMPTY","TargetP_Inf2_F",[26935.9,24338.9,-0.0689812],34.8967,";_this setpos [26935.9,24338.9,0.100008];"],["EMPTY","TargetP_Inf2_F",[26902.2,24337.2,-0.0152912],308.214,";_this setpos [26902.2,24337.2,0.100008];"],["EMPTY","TargetP_Inf2_F",[26929.4,24303.9,-0.0256786],6.70603,";_this setpos [26929.4,24303.9,-0.0249915];"],["EMPTY","TargetP_Inf2_F",[26886.6,24299.5,-0.0275764],6.58903,";_this setpos [26886.6,24299.5,0.300009];"],["EMPTY","TargetP_Inf2_F",[26906.4,24346,-0.00541878],80.7448,";_this setpos [26906.4,24346,8.49739e-006];"],["EMPTY","TargetP_Inf2_F",[26905.9,24345,-0.0568008],81.1068,";_this setpos [26905.9,24345,-0.0499915];"],["EMPTY","TargetP_Inf2_F",[26906.5,24347.4,-0.0554352],81.0286,";_this setpos [26906.5,24347.4,-0.0499915];"],["EMPTY","TargetP_Inf2_F",[26890.1,24318.9,-0.00548553],359.163,";_this setpos [26890.1,24318.9,0.7];"],["EMPTY","TargetP_Inf2_F",[26896.9,24326.4,0.00391197],108.099,";_this setpos [26896.9,24326.4,4.37501];"],["EMPTY","TargetP_Inf2_F",[26887.9,24326,-0.0340595],108.107,";_this setpos [26887.9,24326,4.37501];"],["EMPTY","TargetP_Inf2_F",[26947.2,24283.3,0.0978317],230.312,";_this setpos [26947.2,24283.3,0.1];"],["EMPTY","TargetP_Inf2_F",[26927.9,24262.8,0.101643],229.972,";_this setpos [26927.9,24262.8,0.1];"]];


Target_Array = [];
_init = "_this setVariable [""nopop"", true,true];";
{

	_type = _x select 1;
	_pos = _x select 2;
	_dir = _x select 3;
	_unitinit = format ["%1 %2", _x select 4,_init];



_veh = createVehicle [_type, _pos, [], 0, "CAN_COLLIDE"];
_veh setDir _dir;
[[netID _veh, _unitinit], "NTA_fnc_vehicles_setInit", true, true] spawn BIS_fnc_MP;
_veh addEventHandler ["HitPart", {_this call NTA_fnc_shoothouse_popup}];

	[Target_Array, _veh] call NTA_fnc_addToarray;

} forEach _Vehicles_list;

publicVariable "Target_Array";
"Shoothouse Init Done..." call NTA_fnc_log;
};