if(!isserver) exitwith {};
"Starting RunwayLamps Init" call NTA_fnc_log;
_time = diag_ticktime;

nta_runway_flashlights= [];

for "_i" from 1 to 33 /* step +1 */ do {
 	nta_runway_flashlights pushback (call compile format ["rlamp_flash%1",_i]);
};

publicvariable "nta_runway_flashlights";

nta_runway_staticlights = rlamp;
publicvariable "nta_runway_staticlights";

[[false], "NTA_fnc_lamps_runwaySwitch", nil, true] call bis_fnc_mp;

format ["RunwayInit Done... %1", diag_ticktime - _time] call NTA_fnc_log;

/*
objects1=[
["EMPTY","Land_runway_edgelight_blue_F",[27182.2,24900.1,0],359.786,";_this setpos [27182.2,24900.1,0];"],
["EMPTY","Land_runway_edgelight_blue_F",[27145.2,24932.3,0],359.596,";_this setpos [27145.2,24932.3,0];"]];

objects2=[
["EMPTY","Land_runway_edgelight_blue_F",[27129.1,24839.6,5.91278e-005],359.77,";_this setpos [27129.1,24839.6,0];"],
["EMPTY","Land_runway_edgelight_blue_F",[27093.5,24870.5,4.3869e-005],359.578,";_this setpos [27093.5,24870.5,0];"]];

objects3=[
["EMPTY","Land_runway_edgelight_blue_F",[27041.1,24810.3,0],359.605,";_this setpos [27041.1,24810.3,0];"],
["EMPTY","Land_runway_edgelight_blue_F",[27076.8,24779.3,5.72205e-005],359.85,";_this setpos [27076.8,24779.3,0];"]];

objects4=[
["EMPTY","Land_runway_edgelight_blue_F",[26988.7,24750,0],359.634,";_this setpos [26988.7,24750,0];"],
["EMPTY","Land_runway_edgelight_blue_F",[27024.3,24719.2,0],359.786,";_this setpos [27024.3,24719.2,0];"]];

objects5=[
["EMPTY","Land_runway_edgelight_blue_F",[26936,24689.5,6.10352e-005],359.685,";_this setpos [26936,24689.5,0];"],
["EMPTY","Land_runway_edgelight_blue_F",[26971.6,24658.6,8.58307e-005],359.724,";_this setpos [26971.6,24658.6,0];"]];

objects6=[
["EMPTY","Land_runway_edgelight_blue_F",[26883.4,24629.1,4.3869e-005],359.715,";_this setpos [26883.4,24629.1,0];"],
["EMPTY","Land_runway_edgelight_blue_F",[26919,24598.3,5.34058e-005],359.76,";_this setpos [26919,24598.3,0];"]];

objects7=[
["EMPTY","Land_runway_edgelight_blue_F",[26830.2,24569.1,0],359.741,";_this setpos [26830.2,24569.1,0];"],
["EMPTY","Land_runway_edgelight_blue_F",[26867.3,24536.7,0],359.751,";_this setpos [26867.3,24536.7,0];"]];


objects8 =[["EMPTY","Land_Flush_Light_yellow_F",[26867.2,24577.2,0.0249996],358.696,";_this setpos [26867.2,24577.2,0.025];"],["EMPTY","Land_Flush_Light_yellow_F",[26861.5,24570.7,0.0249996],358.691,";_this setpos [26861.5,24570.7,0.025];"],["EMPTY","Land_Flush_Light_yellow_F",[26855.6,24564.1,0.0249996],358.705,";_this setpos [26855.6,24564.1,0.025];"],["EMPTY","Land_Flush_Light_yellow_F",[26849.8,24557.5,0.0249996],358.697,";_this setpos [26849.8,24557.5,0.025];"],["EMPTY","Land_Flush_Light_yellow_F",[26842.7,24549.4,0.0249996],358.698,";_this setpos [26842.7,24549.4,0.025];"],["EMPTY","Land_Flush_Light_yellow_F",[26837.9,24544,0.0249996],358.698,";_this setpos [26837.9,24544,0.025];"]];
objects80=[["EMPTY","Land_Flush_Light_yellow_F",[26828.9,24541.4,0.0249996],358.694,";_this setpos [26828.9,24541.4,0.025];"],["EMPTY","Land_Flush_Light_yellow_F",[26820.3,24539.7,0.0249996],358.676,";_this setpos [26820.3,24539.7,0.025];"],["EMPTY","Land_Flush_Light_yellow_F",[26812.5,24538.4,0.0249996],358.678,";_this setpos [26812.5,24538.4,0.025];"],["EMPTY","Land_Flush_Light_yellow_F",[26804.1,24538.7,0.0249996],358.683,";_this setpos [26804.1,24538.7,0.025];"],["EMPTY","Land_Flush_Light_yellow_F",[26799.4,24541,0.0249996],358.679,";_this setpos [26799.4,24541,0.025];"],["EMPTY","Land_Flush_Light_yellow_F",[26795.2,24544.4,0.0249996],358.708,";_this setpos [26795.2,24544.4,0.025];"]];

objects8_0=[["EMPTY","Land_Flush_Light_yellow_F",[26790.9,24548.6,0],358.714,";_this setpos [26790.9,24548.6,-3.72529e-009];"],["EMPTY","Land_Flush_Light_yellow_F",[26787.1,24553.5,0],358.743,";_this setpos [26787.1,24553.5,-3.72529e-009];"],["EMPTY","Land_Flush_Light_yellow_F",[26783.9,24558.7,0],358.683,";_this setpos [26783.9,24558.7,-3.72529e-009];"],["EMPTY","Land_Flush_Light_yellow_F",[26782.2,24564,0],358.672,";_this setpos [26782.2,24564,-3.72529e-009];"],["EMPTY","Land_Flush_Light_yellow_F",[26780.3,24569.3,0],358.672,";_this setpos [26780.3,24569.3,-3.72529e-009];"],["EMPTY","Land_Flush_Light_yellow_F",[26778.8,24575,0],358.689,";_this setpos [26778.8,24575,-3.72529e-009];"],["EMPTY","Land_Flush_Light_yellow_F",[26778.8,24581.2,0],358.737,";_this setpos [26778.8,24581.2,-3.72529e-009];"],["EMPTY","Land_Flush_Light_yellow_F",[26780,24587.8,0],358.708,";_this setpos [26780,24587.8,-3.72529e-009];"],["EMPTY","Land_Flush_Light_yellow_F",[26782.1,24594,0],358.702,";_this setpos [26782.1,24594,-3.72529e-009];"],["EMPTY","Land_Flush_Light_yellow_F",[26785.3,24599.4,0],358.708,";_this setpos [26785.3,24599.4,-3.72529e-009];"]];

objects8_1=[["EMPTY","Land_Flush_Light_yellow_F",[26838.6,24662.8,0],358.65,";_this setpos [26838.6,24662.8,-3.72529e-009];"],["EMPTY","Land_Flush_Light_yellow_F",[26845.8,24667,0],358.649,";_this setpos [26845.8,24667,-3.72529e-009];"],["EMPTY","Land_Flush_Light_yellow_F",[26851.6,24670.3,0],358.651,";_this setpos [26851.6,24670.3,-3.72529e-009];"],["EMPTY","Land_Flush_Light_yellow_F",[26858.8,24674.2,0],358.648,";_this setpos [26858.8,24674.2,-3.72529e-009];"],["EMPTY","Land_Flush_Light_yellow_F",[26867,24678.7,0],358.644,";_this setpos [26867,24678.7,-3.72529e-009];"],["EMPTY","Land_Flush_Light_yellow_F",[26874.6,24682.4,0],358.644,";_this setpos [26874.6,24682.4,-3.72529e-009];"],["EMPTY","Land_Flush_Light_yellow_F",[26882.8,24686.5,0],358.641,";_this setpos [26882.8,24686.5,-3.72529e-009];"],["EMPTY","Land_Flush_Light_yellow_F",[26889.3,24690,0],358.63,";_this setpos [26889.3,24690,-3.72529e-009];"],["EMPTY","Land_Flush_Light_yellow_F",[26895.7,24695.9,0],358.633,";_this setpos [26895.7,24695.9,-3.72529e-009];"],["EMPTY","Land_Flush_Light_yellow_F",[26902.2,24702.9,0],358.634,";_this setpos [26902.2,24702.9,-3.72529e-009];"],["EMPTY","Land_Flush_Light_yellow_F",[26908.2,24709.7,0],358.59,";_this setpos [26908.2,24709.7,-3.72529e-009];"]];

objects8_11=[["EMPTY","Land_Flush_Light_yellow_F",[26933.1,24737.3,0],358.582,";_this setpos [26933.1,24737.3,-3.72529e-009];"],["EMPTY","Land_Flush_Light_yellow_F",[26940.5,24745.3,0],358.568,";_this setpos [26940.5,24745.3,-3.72529e-009];"],["EMPTY","Land_Flush_Light_yellow_F",[26946.9,24752.2,0],358.577,";_this setpos [26946.9,24752.2,-3.72529e-009];"],["EMPTY","Land_Flush_Light_yellow_F",[26953.6,24759.8,0],358.571,";_this setpos [26953.6,24759.8,-3.72529e-009];"],["EMPTY","Land_Flush_Light_yellow_F",[26960.2,24767.1,0],358.569,";_this setpos [26960.2,24767.1,-3.72529e-009];"],["EMPTY","Land_Flush_Light_yellow_F",[26966.7,24774.3,0],358.567,";_this setpos [26966.7,24774.3,-3.72529e-009];"],["EMPTY","Land_Flush_Light_yellow_F",[26974.1,24782.7,0],358.572,";_this setpos [26974.1,24782.7,-3.72529e-009];"],["EMPTY","Land_Flush_Light_yellow_F",[26981.6,24791,0],358.562,";_this setpos [26981.6,24791,-3.72529e-009];"],["EMPTY","Land_Flush_Light_yellow_F",[26988.8,24799.1,0],358.546,";_this setpos [26988.8,24799.1,-3.72529e-009];"],["EMPTY","Land_Flush_Light_yellow_F",[26996.4,24807.5,0],358.528,";_this setpos [26996.4,24807.5,-3.72529e-009];"],["EMPTY","Land_Flush_Light_yellow_F",[27003.4,24815.4,0],358.53,";_this setpos [27003.4,24815.4,-3.72529e-009];"],["EMPTY","Land_Flush_Light_yellow_F",[27011.2,24824.1,0],358.5,";_this setpos [27011.2,24824.1,-3.72529e-009];"]];

objects8_3=[["EMPTY","Land_Flush_Light_yellow_F",[27018.8,24832.6,0],358.451,";_this setpos [27018.8,24832.6,-3.72529e-009];"],["EMPTY","Land_Flush_Light_yellow_F",[27027,24841.3,0],358.442,";_this setpos [27027,24841.3,-3.72529e-009];"],["EMPTY","Land_Flush_Light_yellow_F",[27035.3,24850.5,0],358.478,";_this setpos [27035.3,24850.5,-3.72529e-009];"],["EMPTY","Land_Flush_Light_yellow_F",[27043.9,24860,0],358.432,";_this setpos [27043.9,24860,-3.72529e-009];"],["EMPTY","Land_Flush_Light_yellow_F",[27051.9,24868.8,0],358.47,";_this setpos [27051.9,24868.8,-3.72529e-009];"],["EMPTY","Land_Flush_Light_yellow_F",[27059.9,24877.7,0],358.474,";_this setpos [27059.9,24877.7,-3.72529e-009];"],["EMPTY","Land_Flush_Light_yellow_F",[27067.4,24886.3,0],358.472,";_this setpos [27067.4,24886.3,-3.72529e-009];"],["EMPTY","Land_Flush_Light_yellow_F",[27075.2,24895.5,0],358.452,";_this setpos [27075.2,24895.5,-3.72529e-009];"],["EMPTY","Land_Flush_Light_yellow_F",[27084.5,24906,0],358.47,";_this setpos [27084.5,24906,-3.72529e-009];"],["EMPTY","Land_Flush_Light_yellow_F",[27093.8,24916.7,0],358.469,";_this setpos [27093.8,24916.7,-3.72529e-009];"],["EMPTY","Land_Flush_Light_yellow_F",[27105.9,24917.1,0],358.461,";_this setpos [27105.9,24917.1,-3.72529e-009];"]];

objects8_33=[["EMPTY","Land_Flush_Light_yellow_F",[27121.3,24916.8,0],358.476,";_this setpos [27121.3,24916.8,-3.72529e-009];"],["EMPTY","Land_Flush_Light_yellow_F",[27137.9,24916.5,0],358.471,";_this setpos [27137.9,24916.5,-3.72529e-009];"],["EMPTY","Land_Flush_Light_yellow_F",[27154.3,24916.5,0],358.47,";_this setpos [27154.3,24916.5,-3.72529e-009];"],["EMPTY","Land_Flush_Light_yellow_F",[27163.4,24912.6,0],358.468,";_this setpos [27163.4,24912.6,-3.72529e-009];"],["EMPTY","Land_Flush_Light_yellow_F",[27155.8,24903.7,0],358.472,";_this setpos [27155.8,24903.7,-3.72529e-009];"],["EMPTY","Land_Flush_Light_yellow_F",[27147,24893.5,0],358.475,";_this setpos [27147,24893.5,-3.72529e-009];"],["EMPTY","Land_Flush_Light_yellow_F",[27138.4,24883.4,0],358.464,";_this setpos [27138.4,24883.4,-3.72529e-009];"],["EMPTY","Land_Flush_Light_yellow_F",[26884.6,24546.1,0],358.486,";_this setpos [26884.6,24546.1,-3.72529e-009];"],["EMPTY","Land_Flush_Light_yellow_F",[26872,24556.7,0],358.404,";_this setpos [26872,24556.7,-3.72529e-009];"]];

objects8_2=[["EMPTY","Land_Flush_Light_yellow_F",[26862.2,24565,0],358.403,";_this setpos [26862.2,24565,-3.72529e-009];"],["EMPTY","Land_Flush_Light_yellow_F",[26867.9,24527.1,0],358.442,";_this setpos [26867.9,24527.1,-3.72529e-009];"],["EMPTY","Land_Flush_Light_yellow_F",[26854.7,24538.4,0],358.392,";_this setpos [26854.7,24538.4,-3.72529e-009];"],["EMPTY","Land_Flush_Light_yellow_F",[26846.4,24545.4,0],358.38,";_this setpos [26846.4,24545.4,-3.72529e-009];"],["EMPTY","Land_Flush_Light_yellow_F",[26901.1,24565,0],358.384,";_this setpos [26901.1,24565,-3.72529e-009];"],["EMPTY","Land_Flush_Light_yellow_F",[26888.4,24573.4,0],1.8192,";_this setpos [26888.4,24573.4,-3.72529e-009];"],["EMPTY","Land_Flush_Light_yellow_F",[26876.9,24582.3,0],1.81732,";_this setpos [26876.9,24582.3,-3.72529e-009];"],["EMPTY","Land_Flush_Light_yellow_F",[26871.6,24582.7,0],1.81671,";_this setpos [26871.6,24582.7,-3.72529e-009];"]];

objects8_222=[["EMPTY","Land_Flush_Light_yellow_F",[26876.8,24588.1,0],1.81732,";_this setpos [26876.8,24588.1,-3.72529e-009];"],["EMPTY","Land_Flush_Light_yellow_F",[26880.9,24592.8,0],1.80188,";_this setpos [26880.9,24592.8,-3.72529e-009];"],["EMPTY","Land_Flush_Light_yellow_F",[26790.5,24607,0],1.80674,";_this setpos [26790.5,24607,-3.72529e-009];"],["EMPTY","Land_Flush_Light_yellow_F",[26796,24613.7,0],1.78562,";_this setpos [26796,24613.7,-3.72529e-009];"],["EMPTY","Land_Flush_Light_yellow_F",[26801.9,24620.7,0],1.76995,";_this setpos [26801.9,24620.7,-3.72529e-009];"],["EMPTY","Land_Flush_Light_yellow_F",[26810,24630,0],1.77524,";_this setpos [26810,24630,-3.72529e-009];"]];

objects8_22=[["EMPTY","Land_Flush_Light_yellow_F",[26816.9,24638.4,0],1.77479,";_this setpos [26816.9,24638.4,-3.72529e-009];"],["EMPTY","Land_Flush_Light_yellow_F",[26823.4,24646.4,0],1.75282,";_this setpos [26823.4,24646.4,-3.72529e-009];"],["EMPTY","Land_Flush_Light_yellow_F",[26830.7,24655.1,0],1.74657,";_this setpos [26830.7,24655.1,-3.72529e-009];"],["EMPTY","Land_Flush_Light_red_F",[26809.9,24635.3,0],1.61757,";_this setpos [26809.9,24635.3,-3.72529e-009];"],["EMPTY","Land_Flush_Light_red_F",[26802.7,24626.7,0],1.59803,";_this setpos [26802.7,24626.7,-3.72529e-009];"],["EMPTY","Land_Flush_Light_red_F",[26794,24633.8,0],1.62868,";_this setpos [26794,24633.8,-3.72529e-009];"],["EMPTY","Land_Flush_Light_red_F",[26801.2,24642.5,0],1.63723,";_this setpos [26801.2,24642.5,-3.72529e-009];"],["EMPTY","Land_Flush_Light_red_F",[26797.7,24638.3,0],1.63454,";_this setpos [26797.7,24638.3,-3.72529e-009];"]];

objects8_55=[["EMPTY","Land_Flush_Light_red_F",[26806.1,24630.8,0],1.5942,";_this setpos [26806.1,24630.8,-3.72529e-009];"],["EMPTY","Land_Flush_Light_red_F",[26798.2,24630.4,0],1.59987,";_this setpos [26798.2,24630.4,-3.72529e-009];"],["EMPTY","Land_Flush_Light_red_F",[26805.5,24639,0],1.57909,";_this setpos [26805.5,24639,-3.72529e-009];"],["EMPTY","Land_Flush_Light_red_F",[26802.2,24638.8,0],1.62246,";_this setpos [26802.2,24638.8,-3.72529e-009];"],["EMPTY","Land_Flush_Light_red_F",[26804.5,24632.5,0],1.59084,";_this setpos [26804.5,24632.5,-3.72529e-009];"],["EMPTY","Land_Flush_Light_red_F",[26797.9,24633.7,0],1.58786,";_this setpos [26797.9,24633.7,-3.72529e-009];"]];



objects9=[["EMPTY","Land_Flush_Light_green_F",[26837.8,24562.8,0.0249996],359.873,";_this setpos [26837.8,24562.8,0.025];"],["EMPTY","Land_Flush_Light_green_F",[26846.3,24555.2,0.0249996],359.875,";_this setpos [26846.3,24555.2,0.025];"],["EMPTY","Land_Flush_Light_green_F",[26853.5,24548.7,0.0249996],359.869,";_this setpos [26853.5,24548.7,0.025];"],["EMPTY","Land_Flush_Light_green_F",[26860.9,24542.4,0.0249996],359.875,";_this setpos [26860.9,24542.4,0.025];"],["EMPTY","Land_Flush_Light_green_F",[26864.5,24539.2,0.0249996],359.885,";_this setpos [26864.5,24539.2,0.025];"],["EMPTY","Land_Flush_Light_green_F",[26857.2,24545.7,0.0249996],359.875,";_this setpos [26857.2,24545.7,0.025];"],["EMPTY","Land_Flush_Light_green_F",[26849.6,24552.2,0.0249996],359.87,";_this setpos [26849.6,24552.2,0.025];"],["EMPTY","Land_Flush_Light_green_F",[26841.8,24559.3,0.0249996],359.873,";_this setpos [26841.8,24559.3,0.025];"],["EMPTY","Land_Flush_Light_green_F",[26834.6,24565.8,0.0249996],359.874,";_this setpos [26834.6,24565.8,0.025];"],["EMPTY","Land_Flush_Light_green_F",[26831.8,24568.3,0.0249996],359.874,";_this setpos [26831.8,24568.3,0.025];"]];

objects9_0=[["EMPTY","Land_Flush_Light_red_F",[26828.6,24557.8,0.0249996],359.851,";_this setpos [26828.6,24557.8,0.025];"],["EMPTY","Land_Flush_Light_red_F",[26831,24555.7,0.0249996],359.851,";_this setpos [26831,24555.7,0.025];"],["EMPTY","Land_Flush_Light_red_F",[26833.6,24553.5,0.0249996],359.852,";_this setpos [26833.6,24553.5,0.025];"],["EMPTY","Land_Flush_Light_red_F",[26853.5,24536,0.0249996],357.97,";_this setpos [26853.5,24536,0.025];"],["EMPTY","Land_Flush_Light_red_F",[26851.2,24538,0.0249996],357.969,";_this setpos [26851.2,24538,0.025];"],["EMPTY","Land_Flush_Light_red_F",[26848.5,24540.6,0.0249996],357.97,";_this setpos [26848.5,24540.6,0.025];"],["EMPTY","Land_Flush_Light_red_F",[26844.4,24536.1,0.0249996],357.92,";_this setpos [26844.4,24536.1,0.025];"],["EMPTY","Land_Flush_Light_red_F",[26847.5,24533.5,0.0249996],357.912,";_this setpos [26847.5,24533.5,0.025];"],["EMPTY","Land_Flush_Light_red_F",[26849.5,24531,0.0249996],357.914,";_this setpos [26849.5,24531,0.025];"]];

objects9_1=[["EMPTY","Land_Flush_Light_red_F",[26830.7,24549.9,0.0249996],357.903,";_this setpos [26830.7,24549.9,0.025];"],["EMPTY","Land_Flush_Light_red_F",[26828.1,24552.4,0.0249996],357.903,";_this setpos [26828.1,24552.4,0.025];"],["EMPTY","Land_Flush_Light_red_F",[26825.9,24554.8,0.0249996],357.902,";_this setpos [26825.9,24554.8,0.025];"],["EMPTY","Land_Flush_Light_red_F",[26823,24551.3,0.0249996],357.883,";_this setpos [26823,24551.3,0.025];"],["EMPTY","Land_Flush_Light_red_F",[26825.4,24549.1,0.0249996],357.881,";_this setpos [26825.4,24549.1,0.025];"],["EMPTY","Land_Flush_Light_red_F",[26828.2,24546.9,0.0249996],357.885,";_this setpos [26828.2,24546.9,0.025];"],["EMPTY","Land_Flush_Light_red_F",[26841.5,24532.3,0.0249996],357.889,";_this setpos [26841.5,24532.3,0.025];"],["EMPTY","Land_Flush_Light_red_F",[26844.6,24529.7,0.0249996],357.89,";_this setpos [26844.6,24529.7,0.025];"],["EMPTY","Land_Flush_Light_red_F",[26846.8,24527.5,0.0249996],357.89,";_this setpos [26846.8,24527.5,0.025];"],["EMPTY","Land_Flush_Light_red_F",[26831.6,24561.6,0.0249996],357.862,";_this setpos [26831.6,24561.6,0.025];"],["EMPTY","Land_Flush_Light_red_F",[26834.1,24559.2,0.0249996],357.862,";_this setpos [26834.1,24559.2,0.025];"],["EMPTY","Land_Flush_Light_red_F",[26836.5,24556.9,0.0249996],357.863,";_this setpos [26836.5,24556.9,0.025];"],["EMPTY","Land_Flush_Light_red_F",[26851.1,24543.9,0.0249996],357.864,";_this setpos [26851.1,24543.9,0.025];"]];


objects9_2= [["EMPTY","Land_Flush_Light_red_F",[26853.6,24541.4,0.0249996],357.864,";_this setpos [26853.6,24541.4,0.025];"],["EMPTY","Land_Flush_Light_red_F",[26856,24539.5,0.0249996],357.866,";_this setpos [26856,24539.5,0.025];"],["EMPTY","Land_Flush_Light_green_F",[26840.7,24551.5,0.0249996],357.832,";_this setpos [26840.7,24551.5,0.025];"],["EMPTY","Land_Flush_Light_green_F",[26844.7,24547.5,0.0249996],357.831,";_this setpos [26844.7,24547.5,0.025];"],["EMPTY","Land_Flush_Light_green_F",[26836.2,24545.9,0.0249996],358.113,";_this setpos [26836.2,24545.9,0.025];"],["EMPTY","Land_Flush_Light_green_F",[26839.9,24542.1,0.0249996],358.111,";_this setpos [26839.9,24542.1,0.025];"],["EMPTY","Land_Flush_Light_green_F",[26833,24542.1,0.0249996],358.092,";_this setpos [26833,24542.1,0.025];"],["EMPTY","Land_Flush_Light_green_F",[26836.6,24538.4,0.0249996],358.095,";_this setpos [26836.6,24538.4,0.025];"],["EMPTY","Land_Flush_Light_green_F",[26829.6,24538.3,0.0249996],358.091,";_this setpos [26829.6,24538.3,0.025];"],["EMPTY","Land_Flush_Light_green_F",[26833.5,24534.4,0.0249996],358.091,";_this setpos [26833.5,24534.4,0.025];"],["EMPTY","Land_Flush_Light_green_F",[26826,24534.2,0.0249996],358.073,";_this setpos [26826,24534.2,0.025];"],["EMPTY","Land_Flush_Light_green_F",[26829.8,24530.4,0.0249996],358.075,";_this setpos [26829.8,24530.4,0.025];"]];


objects10=[["EMPTY","Land_Flush_Light_green_F",[27179,24902.7,0],1.12766,";_this setpos [27179,24902.7,0];"],["EMPTY","Land_Flush_Light_green_F",[27175,24906.1,0],1.12766,";_this setpos [27175,24906.1,0];"],["EMPTY","Land_Flush_Light_green_F",[27170.5,24909.8,0],1.12363,";_this setpos [27170.5,24909.8,0];"],["EMPTY","Land_Flush_Light_green_F",[27166.7,24912.9,0],1.12596,";_this setpos [27166.7,24912.9,0];"],["EMPTY","Land_Flush_Light_green_F",[27162.5,24916.4,0],1.12602,";_this setpos [27162.5,24916.4,0];"],["EMPTY","Land_Flush_Light_green_F",[27158.9,24919.5,0],1.12602,";_this setpos [27158.9,24919.5,0];"],["EMPTY","Land_Flush_Light_green_F",[27155.2,24922.5,0],1.13,";_this setpos [27155.2,24922.5,0];"],["EMPTY","Land_Flush_Light_green_F",[27151.2,24925.7,0],1.13,";_this setpos [27151.2,24925.7,0];"],["EMPTY","Land_Flush_Light_green_F",[27146.7,24929.4,0],1.13064,";_this setpos [27146.7,24929.4,0];"],["EMPTY","Land_Flush_Light_green_F",[27170.7,24921.3,0],1.10143,";_this setpos [27170.7,24921.3,0];"],["EMPTY","Land_Flush_Light_green_F",[27177.9,24929.8,0],1.09942,";_this setpos [27177.9,24929.8,0];"]];

objects10_0=[["EMPTY","Land_Flush_Light_green_F",[27185.3,24938.5,0],1.11522,";_this setpos [27185.3,24938.5,0];"],["EMPTY","Land_Flush_Light_green_F",[27192,24946.4,0],1.12075,";_this setpos [27192,24946.4,0];"],["EMPTY","Land_Flush_Light_green_F",[27197.2,24952.6,0],1.12619,";_this setpos [27197.2,24952.6,0];"],["EMPTY","Land_Flush_Light_green_F",[27204.1,24960.7,0],1.1224,";_this setpos [27204.1,24960.7,0];"],["EMPTY","Land_Flush_Light_green_F",[27212.2,24970.2,0],1.09613,";_this setpos [27212.2,24970.2,0];"],["EMPTY","Land_Flush_Light_green_F",[27220.6,24980.1,0],1.14377,";_this setpos [27220.6,24980.1,0];"],["EMPTY","Land_Flush_Light_green_F",[27229.3,24990.4,0],1.33714,";_this setpos [27229.3,24990.4,0];"],["EMPTY","Land_Flush_Light_green_F",[27237.7,25000.3,0],1.33597,";_this setpos [27237.7,25000.3,0];"],["EMPTY","Land_Flush_Light_green_F",[27244.2,25008,0],1.41374,";_this setpos [27244.2,25008,0];"],["EMPTY","Land_Flush_Light_yellow_F",[26914.1,24716.5,0],358.613,";_this setpos [26914.1,24716.5,-3.72529e-009];"],["EMPTY","Land_Flush_Light_yellow_F",[26919.9,24722.7,0],358.58,";_this setpos [26919.9,24722.7,-3.72529e-009];"],["EMPTY","Land_Flush_Light_yellow_F",[26926.2,24729.6,0],358.582,";_this setpos [26926.2,24729.6,-3.72529e-009];"]];

objects10_1=[["EMPTY","Land_Flush_Light_green_F",[27175.7,24913.6,0],0.637199,";_this setpos [27175.7,24913.6,0];"],["EMPTY","Land_Flush_Light_green_F",[27171.9,24916.9,0],0.630644,";_this setpos [27171.9,24916.9,0];"],["EMPTY","Land_Flush_Light_green_F",[27175.7,24921.5,0],0.632722,";_this setpos [27175.7,24921.5,0];"],["EMPTY","Land_Flush_Light_green_F",[27180.1,24926.6,0],0.62895,";_this setpos [27180.1,24926.6,0];"],["EMPTY","Land_Flush_Light_green_F",[27185.1,24932.4,0],0.633623,";_this setpos [27185.1,24932.4,0];"],["EMPTY","Land_Flush_Light_green_F",[27179.3,24918.1,0],0.630231,";_this setpos [27179.3,24918.1,0];"],["EMPTY","Land_Flush_Light_green_F",[27183.7,24923.5,0],0.628904,";_this setpos [27183.7,24923.5,0];"],["EMPTY","Land_Flush_Light_green_F",[27188.2,24928.8,0],0.626215,";_this setpos [27188.2,24928.8,0];"],["EMPTY","Land_Flush_Light_green_F",[27171.5,24908.7,0],0.616723,";_this setpos [27171.5,24908.7,0];"],["EMPTY","Land_Flush_Light_green_F",[27168,24912.3,0],0.616621,";_this setpos [27168,24912.3,0];"]];

objects10_2=[["EMPTY","Land_Flush_Light_green_F",[27159.3,24912.8,0],0.621099,";_this setpos [27159.3,24912.8,0];"],["EMPTY","Land_Flush_Light_green_F",[27155.6,24908.2,0],0.619161,";_this setpos [27155.6,24908.2,0];"],["EMPTY","Land_Flush_Light_green_F",[27151.6,24911.5,0],0.619161,";_this setpos [27151.6,24911.5,0];"],["EMPTY","Land_Flush_Light_green_F",[27156,24916.2,0],0.617401,";_this setpos [27156,24916.2,0];"],["EMPTY","Land_Flush_Light_green_F",[27163.2,24924.6,0],0.628137,";_this setpos [27163.2,24924.6,0];"],["EMPTY","Land_Flush_Light_green_F",[27167.4,24929.9,0],0.62742,";_this setpos [27167.4,24929.9,0];"],["EMPTY","Land_Flush_Light_green_F",[27174.3,24931.8,0],0.628306,";_this setpos [27174.3,24931.8,0];"],["EMPTY","Land_Flush_Light_green_F",[27171.4,24934.5,0],0.627577,";_this setpos [27171.4,24934.5,0];"],["EMPTY","Land_Flush_Light_green_F",[27179.8,24938.3,0],0.631653,";_this setpos [27179.8,24938.3,0];"],["EMPTY","Land_Flush_Light_green_F",[27176.7,24940.8,0],0.630179,";_this setpos [27176.7,24940.8,0];"]];

objects10_3=[["EMPTY","Land_Flush_Light_green_F",[27164.5,24908.1,0],0.617275,";_this setpos [27164.5,24908.1,0];"],["EMPTY","Land_Flush_Light_green_F",[27168.1,24904.8,0],0.618955,";_this setpos [27168.1,24904.8,0];"],["EMPTY","Land_Flush_Light_green_F",[27164.1,24899.9,0],0.623241,";_this setpos [27164.1,24899.9,0];"],["EMPTY","Land_Flush_Light_green_F",[27160.5,24903.7,0],0.624839,";_this setpos [27160.5,24903.7,0];"],["EMPTY","Land_Flush_Light_green_F",[27170.4,24927.2,0],0.630464,";_this setpos [27170.4,24927.2,0];"],["EMPTY","Land_Flush_Light_green_F",[27166.4,24922.1,0],0.622997,";_this setpos [27166.4,24922.1,0];"],["EMPTY","Land_Flush_Light_green_F",[26827.8,24532.2,0.0249996],358.065,";_this setpos [26827.8,24532.2,0.025];"],["EMPTY","Land_Flush_Light_green_F",[26822.7,24526.4,0.0249996],358.042,";_this setpos [26822.7,24526.4,0.025];"],["EMPTY","Land_Flush_Light_green_F",[26817.6,24520.4,0.0249996],358.057,";_this setpos [26817.6,24520.4,0.025];"],["EMPTY","Land_Flush_Light_green_F",[26812.7,24514.3,0.0249996],358.036,";_this setpos [26812.7,24514.3,0.025];"],["EMPTY","Land_Flush_Light_green_F",[26806.5,24507,0.0249996],358.052,";_this setpos [26806.5,24507,0.025];"]];


objects11=[["EMPTY","Land_runway_edgelight",[26838.7,24579.5,0],351.147,""],["EMPTY","Land_runway_edgelight",[26862.5,24606.5,0],351.161,""],["EMPTY","Land_runway_edgelight",[26897,24646.3,5.53131e-005],351.113,""],["EMPTY","Land_runway_edgelight",[26918.6,24671,0],351.096,""],["EMPTY","Land_runway_edgelight",[26951.1,24707.8,0.000108719],350.742,""],["EMPTY","Land_runway_edgelight",[26971.4,24730.7,0],350.658,""],["EMPTY","Land_runway_edgelight",[27004.1,24769,0],350.635,""],["EMPTY","Land_runway_edgelight",[27022.3,24789.7,4.19617e-005],350.631,""],["EMPTY","Land_runway_edgelight",[27053,24824.6,8.7738e-005],350.602,""],["EMPTY","Land_runway_edgelight",[27074.8,24849.4,0],350.606,""],["EMPTY","Land_runway_edgelight",[27109.2,24889.7,7.05719e-005],350.583,""],["EMPTY","Land_runway_edgelight",[27134.8,24919.4,0],350.607,""]];


right = [
	["EMPTY","Land_runway_edgelight",[27181.2,24901,0],352.311,";_this setpos [27181.2,24901,0];"],
	["EMPTY","Land_runway_edgelight",[27148.4,24862.1,5.91278e-005],352.287,";_this setpos [27148.4,24862.1,0];"],
	["EMPTY","Land_runway_edgelight",[27128.6,24839.9,5.91278e-005],352.324,";_this setpos [27128.6,24839.9,0];"],
	["EMPTY","Land_runway_edgelight",[27097.3,24803.1,0],352.341,";_this setpos [27097.3,24803.1,0];"],
	["EMPTY","Land_runway_edgelight",[27076.3,24779.6,5.91278e-005],352.444,";_this setpos [27076.3,24779.6,0];"],
	["EMPTY","Land_runway_edgelight",[27046.6,24745.8,7.82013e-005],352.59,";_this setpos [27046.6,24745.8,0];"],
	["EMPTY","Land_runway_edgelight",[27023.8,24719.4,0],352.643,";_this setpos [27023.8,24719.4,0];"],
	["EMPTY","Land_runway_edgelight",[26992.8,24683,0],352.641,";_this setpos [26992.8,24683,0];"],
	["EMPTY","Land_runway_edgelight",[26971.3,24659,8.7738e-005],352.598,";_this setpos [26971.3,24659,0];"],
	["EMPTY","Land_runway_edgelight",[26941.8,24624.7,6.29425e-005],352.603,";_this setpos [26941.8,24624.7,0];"],
	["EMPTY","Land_runway_edgelight",[26918.5,24598.6,5.34058e-005],352.649,";_this setpos [26918.5,24598.6,0];"],
	["EMPTY","Land_runway_edgelight",[26884.9,24559.6,4.95911e-005],352.736,";_this setpos [26884.9,24559.6,0];"],
	["EMPTY","Land_runway_edgelight",[26866.1,24537.9,0],352.772,";_this setpos [26866.1,24537.9,0];"]
];
flash = [


	["EMPTY","Land_Flush_Light_yellow_F",[27123.7,24868.1,-0.0259781],0.284832,""],
	["EMPTY","Land_Flush_Light_yellow_F",[27102.2,24843.5,-0.0265522],0.286868,""],
	["EMPTY","Land_Flush_Light_yellow_F",[27080.2,24818.2,-0.0267181],0.284032,""],
	["EMPTY","Land_Flush_Light_yellow_F",[27059.4,24794.2,-0.00868034],0.298852,""],
	["EMPTY","Land_Flush_Light_yellow_F",[27038.8,24770.4,-0.00434685],0.301402,""],
	["EMPTY","Land_Flush_Light_yellow_F",[27018.9,24747.7,-4.76837e-005],0.302115,""],
	["EMPTY","Land_Flush_Light_yellow_F",[27000.1,24726.6,0.00211716],0.30263,""],
	["EMPTY","Land_Flush_Light_yellow_F",[26981.1,24705.2,0.0123043],0.311096,""],
	["EMPTY","Land_Flush_Light_yellow_F",[26962,24683.3,0.0477867],0.30282,""],
	["EMPTY","Land_Flush_Light_yellow_F",[26940.4,24659.9,0.0250378],0.318207,""],
	["EMPTY","Land_Flush_Light_yellow_F",[26921.2,24639,0.0519581],0.31173,""],
	["EMPTY","Land_Flush_Light_yellow_F",[26903.4,24618.8,0.0346279],0.336133,""],
	["EMPTY","Land_Flush_Light_yellow_F",[26889.9,24604,0.0130081],0.362694,""]



];

	private["_lights1","_lights2","_lights3","_lights4","_lights5","_lights6","_lights7", "_lights_100", "_l"];

	_sleep = 0;
	_lights1 = [objects1,false,"_this hideobjectglobal true",_sleep] call NTA_fnc_mcc_createvehicle;

	_lights2=[objects2,false,"_this hideobjectglobal true",_sleep] call NTA_fnc_mcc_createvehicle;

	_lights3=[objects3,false,"_this hideobjectglobal true",_sleep] call NTA_fnc_mcc_createvehicle;

	_lights4=[objects4,false,"_this hideobjectglobal true",_sleep] call NTA_fnc_mcc_createvehicle;

	_lights5=[objects5,false,"_this hideobjectglobal true",_sleep] call NTA_fnc_mcc_createvehicle;

	_lights6= [objects6,false,"_this hideobjectglobal true",_sleep] call NTA_fnc_mcc_createvehicle;

	_lights7=[objects7,false,"_this hideobjectglobal true",_sleep] call NTA_fnc_mcc_createvehicle;



	_lights8=[objects8,false,"_this hideobjectglobal true",_sleep] call NTA_fnc_mcc_createvehicle;
	_lights80=[objects80,false,"_this hideobjectglobal true",_sleep] call NTA_fnc_mcc_createvehicle;

	_lights8_1=[objects8_1,false,"_this hideobjectglobal true",_sleep] call NTA_fnc_mcc_createvehicle;

	_lights8_2=[objects8_2,false,"_this hideobjectglobal true",_sleep] call NTA_fnc_mcc_createvehicle;

	_lights8_22=[objects8_22,false,"_this hideobjectglobal true",_sleep] call NTA_fnc_mcc_createvehicle;

	_lights8_3=[objects8_3,false,"_this hideobjectglobal true",_sleep] call NTA_fnc_mcc_createvehicle;

	_lights8_33=[objects8_33,false,"_this hideobjectglobal true",_sleep] call NTA_fnc_mcc_createvehicle;

	_lights8_0=[objects8_0,false,"_this hideobjectglobal true",_sleep] call NTA_fnc_mcc_createvehicle;

	_lights8_11=[objects8_11,false,"_this hideobjectglobal true",_sleep] call NTA_fnc_mcc_createvehicle;

	_lights8_222=[objects8_222,false,"_this hideobjectglobal true",_sleep] call NTA_fnc_mcc_createvehicle;

	_lights8_55=[objects8_55,false,"_this hideobjectglobal true",_sleep] call NTA_fnc_mcc_createvehicle;

	_lights9=[objects9,false,"_this hideobjectglobal true",_sleep] call NTA_fnc_mcc_createvehicle;

	_lights9_1=[objects9_1,false,"_this hideobjectglobal true",_sleep] call NTA_fnc_mcc_createvehicle;

	_lights9_2=[objects9_2,false,"_this hideobjectglobal true",_sleep] call NTA_fnc_mcc_createvehicle;

	_lights10=[objects10,false,"_this hideobjectglobal true",_sleep] call NTA_fnc_mcc_createvehicle;

	_lights10_1=[objects10_1,false,"_this hideobjectglobal true",_sleep] call NTA_fnc_mcc_createvehicle;

	_lights10_0=[objects10_0,false,"_this hideobjectglobal true",_sleep] call NTA_fnc_mcc_createvehicle;

	_lights10_2=[objects10_2,false,"_this hideobjectglobal true",_sleep] call NTA_fnc_mcc_createvehicle;

	_lights10_3=[objects10_3,false,"_this hideobjectglobal true",_sleep] call NTA_fnc_mcc_createvehicle;

	_lights11=[objects11,false,"_this hideobjectglobal true",_sleep] call NTA_fnc_mcc_createvehicle;

	_lights9_0=[objects9_0,false,"_this hideobjectglobal true",_sleep] call NTA_fnc_mcc_createvehicle;
	 _lights_100=[right,false,"_this hideobjectglobal true",_sleep] call NTA_fnc_mcc_createvehicle;

*/






