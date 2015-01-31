if(!isserver) exitwith {};
private ["_gate_Lamps", "_hangar_lamps","_street_lamps", "_shooting_lamps", "_lamp_1", "_lamp_3", "_lamp_2", "_time"];
"Starting Lamps Init" call NTA_fnc_log;
_time = diag_ticktime;


_gate_lamps=[
["EMPTY","Land_LampHalogen_F",[26820.6,24428.3,9.53674e-005],271.345,""],
["EMPTY","Land_LampHalogen_F",[26830.7,24419.9,0.000125885],344.575,""],
["EMPTY","Land_LampHalogen_F",[26882.6,24484.1,-0.000167847],87.3068,";_this setpos [26882.6,24484.1,0];"],
["EMPTY","Land_LampHalogen_F",[26872.4,24492.1,-0.000198364],171.389,";_this setpos [26872.4,24492.1,0];"],
["EMPTY","Land_LampHalogen_F",[26829,24453.1,-0.0001297],171.355,";_this setpos [26829,24453.1,0];"],
["EMPTY","Land_LampHalogen_F",[26851.9,24472.3,0.000221252],338.141,""]];

_hangar_lamps = [["EMPTY","Land_LampHalogen_F",[26787.6,24650.3,-7.62939e-006],244.022,";_this setpos [26787.6,24650.3,0];"],["EMPTY","Land_LampHalogen_F",[26725.5,24579.1,-0.000431061],185.762,";_this setpos [26725.5,24579.1,0];"]];

_street_lamps = [["EMPTY","Land_LampHalogen_F",[26833.1,24486.2,0.000102997],5.20368,";_this setpos [26833.1,24486.2,0];"],["EMPTY","Land_LampHalogen_F",[26778.2,24534.4,3.05176e-005],359.832,";_this setpos [26778.2,24534.4,0];"],["EMPTY","Land_LampHalogen_F",[26703.6,24597.5,0.000278473],5.23176,";_this setpos [26703.6,24597.5,0];"],["EMPTY","Land_LampHalogen_F",[26667.2,24626.5,4.19617e-005],5.0609,";_this setpos [26667.2,24626.5,0];"],["EMPTY","Land_LampHalogen_F",[26620.9,24645.9,-0.000576019],125.0,";_this setpos [26604.2,24622,0.001297];"],["EMPTY","Land_LampHalogen_F",[26592,24670.3,-0.00166702],86.9717,";_this setpos [26592,24670.3,0];"],["EMPTY","Land_LampHalogen_F",[26563.4,24694.5,-0.00126076],87.3912,";_this setpos [26563.4,24694.5,0];"],["EMPTY","Land_LampHalogen_F",[26541.5,24702.1,0.00148392],339.326,";_this setpos [26541.5,24702.1,0];"],["EMPTY","Land_LampHalogen_F",[26749.5,24557.4,9.53674e-005],27.6333,";_this setpos [26749.5,24557.4,0];"]];

_shooting_lamps =[["EMPTY","Land_LampHalogen_F",[26753.5,24783.8,-0.000202179],118.346,";_this setpos [26753.5,24783.8,0];"],["EMPTY","Land_LampHalogen_F",[26768.2,24703.6,-0.000392914],111.987,";_this setpos [26768.2,24703.6,0];"],["EMPTY","Land_LampHalogen_F",[26765.1,24783.3,0.000389099],243.677,";_this setpos [26765.1,24783.3,0];"]];

_lamp_1 = nearestObject [getMarkerPos "lamp_1", "Lamps_base_F"];
_lamp_2 = nearestObject [getMarkerPos "lamp_2", "Lamps_base_F"];
_lamp_3 = nearestObject [getMarkerPos "lamp_3", "Lamps_base_F"];

nta_gateLamps		= [[_gate_lamps,false,""] call NTA_fnc_mcc_createvehicle, "nta_gateLamps_on"];
nta_hangarLamps		= [[_hangar_lamps,false,""] call NTA_fnc_mcc_createvehicle, "nta_hangarLamps_on"];
nta_streetLamps		= [[_street_lamps,false,""] call NTA_fnc_mcc_createvehicle, "nta_streetlamps_on"];
nta_shootingLamps	= [[_shooting_lamps,false,""] call NTA_fnc_mcc_createvehicle, "nta_shootingLamps_on"];
(nta_hangarLamps select 0) pushback _lamp_1;
(nta_hangarLamps select 0) pushback _lamp_2;


publicvariable "nta_shootingLamps";
publicvariable "nta_streetLamps";
publicvariable "nta_hangarLamps";
publicvariable "nta_gateLamps";
publicvariable "nta_mapLamps";

[[false], "NTA_fnc_lamps_LampSwitchAll", nil, true] call bis_fnc_MP;

format ["LampInit Done... %1", diag_ticktime - _time] call NTA_fnc_log;