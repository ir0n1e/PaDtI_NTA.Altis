if (("NTA_TRAINING_Shootingrange" call bis_fnc_getParamValue) <= 0) exitwith {};
_this spawn {
"Starting Shootinrange Init" call NTA_fnc_log;

private ["_init","_targets","_targets2","_targets3","_targets4","_targets5"];

_targets = [["EMPTY","TargetP_Inf2_F",[26831.4,24895.7,-0.0951061],50.8735,";_this setpos [26831.4,24895.7,-0.0999997];"],["EMPTY","TargetP_Inf2_F",[26830.8,24896.5,-0.0451469],50.8735,";_this setpos [26830.8,24896.5,-0.0499997];"],["EMPTY","TargetP_Inf2_F",[26830.2,24897.3,-0.0451069],50.8735,";_this setpos [26830.2,24897.3,-0.0499997];"],["EMPTY","TargetP_Inf2_F",[26829.7,24898.1,-0.045105],50.8735,";_this setpos [26829.7,24898.1,-0.0499997];"],["EMPTY","TargetP_Inf2_F",[26835.8,24890.9,-0.0475883],50.8775,";_this setpos [26835.8,24890.9,-0.0499997];"],["EMPTY","TargetP_Inf2_F",[26836.6,24889.8,-0.0726185],50.8895,";_this setpos [26836.6,24889.8,-0.0749997];"],["EMPTY","TargetP_Inf2_F",[26837.5,24888.7,-0.0725861],50.8895,";_this setpos [26837.5,24888.7,-0.0749997];"],["EMPTY","TargetP_Inf2_F",[26838.3,24887.9,-0.0726185],50.8895,";_this setpos [26838.3,24887.9,-0.0749997];"],["EMPTY","TargetP_Inf2_F",[26907.2,24965.3,0.0439205],46.5975,";_this setpos [26907.2,24965.3,0];"]];

_targets2 = [["EMPTY","TargetP_Inf2_F",[26906.2,24965.8,0.0439205],46.5975,";_this setpos [26906.2,24965.8,0];"],["EMPTY","TargetP_Inf2_F",[26905.2,24966.5,0.0441399],46.5975,";_this setpos [26905.2,24966.5,0];"],["EMPTY","TargetP_Inf2_F",[26922.2,24947.9,-0.0723534],46.6124,";_this setpos [26922.2,24947.9,-0.075];"],["EMPTY","TargetP_Inf2_F",[26923,24947.3,-0.0664749],46.6141,";_this setpos [26923,24947.3,-0.075];"],["EMPTY","TargetP_Inf2_F",[26924.1,24946.5,-0.0664177],46.6153,";_this setpos [26924.1,24946.5,-0.075];"],["EMPTY","TargetP_Inf2_F",[26932.5,24967.1,-0.055933],46.8008,";_this setpos [26932.5,24967.1,-0.075];"],["EMPTY","TargetP_Inf2_F",[26936.5,24962.5,-0.0591526],46.7972,";_this setpos [26936.5,24962.5,-0.075];"],["EMPTY","TargetP_Inf2_F",[26929.4,24977.7,-0.0676174],46.6918,";_this setpos [26929.4,24977.7,-0.075];"]];

_targets3 = [["EMPTY","TargetP_Inf2_F",[26946.5,24948.6,-0.0732346],46.7453,";_this setpos [26946.5,24948.6,-0.075];"],["EMPTY","TargetP_Inf2_F",[26943.8,24951.6,-0.0732346],46.7453,";_this setpos [26943.8,24951.6,-0.075];"],["EMPTY","TargetP_Inf2_F",[27004.4,24993.1,-0.00989342],48.8865,";_this setpos [27004.4,24993.1,0];"],["EMPTY","TargetP_Inf2_F",[27003.7,24993.7,-0.00605011],48.9148,";_this setpos [27003.7,24993.7,0];"],["EMPTY","TargetP_Inf2_F",[27002.9,24994.5,-0.00605011],48.9167,";_this setpos [27002.9,24994.5,0];"],["EMPTY","TargetP_Inf2_F",[26989.9,25007.6,0.00131607],48.2967,";_this setpos [26989.9,25007.6,0];"],["EMPTY","TargetP_Inf2_F",[26989,25008.5,0.00131416],48.3226,";_this setpos [26989,25008.5,0];"]];

_targets4 = [["EMPTY","TargetP_Inf2_F",[27007.3,24990.1,-0.00598526],48.7401,";_this setpos [27007.3,24990.1,0];"],["EMPTY","TargetP_Inf2_F",[27008.1,24989.4,0.00668335],48.7622,";_this setpos [27008.1,24989.4,0];"],["EMPTY","TargetP_Inf2_F",[27009.5,24988.5,-0.00438118],48.774,";_this setpos [27009.5,24988.5,0];"],["EMPTY","TargetP_Inf2_F",[27382,25178.5,-0.0937843],39.6267,";_this setpos [27382,25178.5,-0.15];"],["EMPTY","TargetP_Inf2_F",[27377.9,25182.7,-0.0937843],39.6267,";_this setpos [27377.9,25182.7,-0.15];"],["EMPTY","TargetP_Inf2_F",[27374,25185.8,-0.0502319],37.7274,";_this setpos [27374,25185.8,-0.15];"],["EMPTY","TargetP_Inf2_F",[27371.2,25170,-0.0689125],38.8715,";_this setpos [27371.2,25170,-0.15];"]];

_targets5 = [["EMPTY","TargetP_Inf2_F",[27363.4,25174.1,-0.0604172],38.0476,";_this setpos [27363.4,25174.1,-0.15];"],["EMPTY","TargetP_Inf2_F",[25780.5,25949.2,-0.0911894],317.964,";_this setpos [25780.5,25949.2,1.4];"],["EMPTY","TargetP_Inf2_F",[25803.5,25970.2,-0.096199],317.964,";_this setpos [25803.5,25970.2,1.375];"],["EMPTY","TargetP_Inf2_F",[25792.1,25960,-0.298347],317.964,";_this setpos [25792.1,25960,1.375];"],["EMPTY","TargetP_Inf2_F",[26100.3,25566.9,-0.0346856],317.964,";_this setpos [26100.3,25566.9,1.325];"],["EMPTY","TargetP_Inf2_F",[26074.3,25563.3,-0.192443],317.964,";_this setpos [26074.3,25563.3,1.3];"],["EMPTY","TargetP_Inf2_F",[26087.1,25564.2,-0.188434],317.964,";_this setpos [26087.1,25564.2,1.3];"]];


_init = "_this setVariable ['nopop', false, true];_this addEventHandler ['HitPart', {_this call NTA_fnc_shoothouse_popup}];";

[_targets,false,_init] call NTA_fnc_mcc_createvehicle;
[_targets2,false,_init] call NTA_fnc_mcc_createvehicle;
[_targets3,false,_init] call NTA_fnc_mcc_createvehicle;
[_targets4,false,_init] call NTA_fnc_mcc_createvehicle;
[_targets5,false,_init] call NTA_fnc_mcc_createvehicle;

"Shootinrange Init Done" call NTA_fnc_log;
};