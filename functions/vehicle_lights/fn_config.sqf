/*
	Author: Ir0n1E original Lala14, Tajin

	Description:
	Returns config Array

	Parameter(s):
	None

	Returns:
	ARRAY
*/

private "_il_config";

// light colors:
IL_c_white 	= [255,255,255];
IL_c_red 	= [255,0,0];
IL_c_green 	= [0,255,0];
IL_c_blue 	= [0,0,255];
IL_c_yellow = [255,200,0];
IL_c_orange = [255,75,0];

// predefined default values used in the config below
IL_attenuation 	= [0.3,0,0,500];
IL_att_soft 	= [0,10,10,10];
IL_att_tiny 	= [0,0,0,0,0.2,0.4];
IL_intensity 	= 50;


// config ["kindOf classnames","First person only",[["position in modelspace","lightcolor","attentuation","intensity"],[..],"Allow Colour Change",(optional - if not present but there is 2 it will change it) which lights to be able to change to green *first to number* ] ]


_il_config = [
	[["Heli_Light_01_base_F"], false, [
		 [ [0,1,0.5], IL_c_red, IL_attenuation, IL_intensity ]
	],true],
	[["Heli_Light_02_base_F"], false, [
		 [ [0,1.7,-0.1], IL_c_red, IL_attenuation, IL_intensity ]
	],true],
	[["Heli_Transport_01_base_F"], false, [
		 [ [0,2,0], IL_c_red, IL_attenuation, IL_intensity ]
	],true],
	[["I_Heli_light_03_unarmed_base_F","I_Heli_light_03_base_F","I_Heli_light_03_F","I_Heli_light_03_unarmed_F"], false, [
		 [ [0,2.5,0.5], IL_c_red, IL_attenuation, IL_intensity ]
	],true],
	[["Heli_Transport_02_base_F"], false, [
		 [ [0,1.5,-0.4], IL_c_red, IL_attenuation, IL_intensity ]
	],true],
	[["B_Heli_Transport_03_base_F"], false, [
		[ [0,-2,0.3], IL_c_red, IL_att_soft, 0.5 ],
		[ [0,4,0.3], IL_c_red, IL_att_soft, 0.5 ]
	],true,2],
	[["O_Heli_Transport_04_covered_F","O_Heli_Transport_04_medevac_F"],false, [
		[ [0.2,-1.95,-0.1], IL_c_red, IL_att_soft, 0.5 ],
		[ [-0.4,-1.95,-0.1], IL_c_red, IL_att_soft, 0.5 ],
		[ [0.2,0.93,-0.1], IL_c_red, IL_att_soft, 0.5 ],
		[ [-0.4,0.93,-0.1], IL_c_red, IL_att_soft, 0.5 ],
		[ [-0.13,3.13,0.35], IL_c_red, IL_att_soft, 0.5 ]
	],true,5],
	[["Land_Pod_Heli_Transport_04_covered_F","Land_Pod_Heli_Transport_04_medevac_F"],false, [
		[ [0.3,-0.86,0.5], IL_c_red, IL_att_soft, 0.5 ],
		[ [-0.3,-0.86,0.5], IL_c_red, IL_att_soft, 0.5 ],
		[ [0.3,2.02,0.5], IL_c_red, IL_att_soft, 0.5 ],
		[ [-0.3,2.02,0.5], IL_c_red, IL_att_soft, 0.5 ]
	],true,4],
	[["Heli_Transport_04_base_F"],false, [
		[ [-0.13,3.13,0.1], IL_c_red, IL_att_soft, 0.5 ]
	],true],
	[["Heli_Attack_01_base_F"], false, [
		[ [-0.04,4.3,-0.3], IL_c_green, [0,0,0,0,0.2,0.4], 0.05 ],
		[ [-0.04,2.89,0.15], IL_c_green, [0,0,0,0,0.2,0.4], 0.05 ]
	],false],
	[["Heli_Attack_02_base_F"], false, [
		 [ [0,1.5,-1.5], IL_c_red, IL_attenuation, 5 ],
		 [ [0,0.5,-1.5], IL_c_red, IL_attenuation, 5 ],
		 [ [0.07,3.4,-0.05], IL_c_green, [0,0,0,0,0.2,0.4], 0.05 ],
		 [ [0,4.4,-0.3], IL_c_green, [0,0,0,0,0.2,0.4], 0.05 ]
	],true,2],
	[["c130J_base"], false, [
		 [ [0,6,-2], IL_c_red, IL_attenuation, IL_intensity ]
	],true],
	[["kyo_MH47E_base"], false, [
		 [ [0,2,-0.07], IL_c_red, IL_attenuation, IL_intensity ]
	],true],
	[["globemaster_c17"], false, [
		 [ [0,8,2.44], IL_c_red, IL_attenuation, IL_intensity ]
	],true],
	[["APC_Wheeled_01_base_F"], true, [
		 [ [0,-3,-0.4], IL_c_red, IL_attenuation, IL_intensity ]
	],true],
	[["APC_Wheeled_02_base_F"], true, [
		 [ [0.3,-2.7,-0.2], IL_c_red, IL_attenuation, IL_intensity ]
	],true],
	[["APC_Wheeled_03_base_F"], true, [
		 [ [0.5,-2.6,-0.7], IL_c_red, IL_attenuation, IL_intensity ]
	],true],
	[["MBT_01_base_F"], true, [
		 [ [0,-2.7,-0.9], IL_c_red, IL_attenuation, IL_intensity ]
	],true],
	[["APC_Tracked_01_base_F"], true, [
		 [ [0,-2.4,-0.7], IL_c_red, IL_attenuation, IL_intensity ]
	],true],
	[["APC_Tracked_02_base_F"], true, [
		 [ [0,-3.1,-0.6], IL_c_red, IL_attenuation, IL_intensity ]
	],true],
	[["APC_Tracked_03_base_F"], true, [
		 [ [0,-2,-0.6], IL_c_red, IL_attenuation, IL_intensity ]
	],true],
	[["B_Truck_01_mover_F"],false, [
		 [ [0,3.6,0.71], IL_c_orange, IL_att_soft, 10]
	], false],
	[["B_Truck_01_covered_F","B_Truck_01_medical_F"], false, [
		 [ [0,0,1], IL_c_orange, IL_att_soft, 10 ],
		 [ [0,4,0.42], IL_c_orange, IL_att_soft, 10]
	],false],
	[["B_Truck_01_transport_F","Truck_01_base_F"], false, [
		[ [0,4,0.42], IL_c_orange, IL_att_soft, 10]
	],false],
	[["O_Truck_03_covered_F","O_Truck_03_medical_F"], false, [
		 [ [0,-2,1.2], IL_c_orange, IL_att_soft, 10 ],
		 [ [0,2.7,0.85], IL_c_orange, IL_att_soft, 10]
	],false],
	[["Truck_03_base_F"], false, [
		 [ [0,2.7,0.85], IL_c_orange, IL_att_soft, 10]
	],false],
	[["I_Truck_02_covered_F","I_Truck_02_medical_F","O_Truck_02_covered_F","O_Truck_02_medical_F"], false, [
		 [ [0,-0.5,0.89], IL_c_orange, IL_att_soft, 10 ],
		 [ [0,1.5,0.41], IL_c_orange, IL_att_soft, 10]
	],false],
	[["I_Truck_02_box_F","I_Truck_02_fuel_F","I_Truck_02_ammo_F","O_Truck_02_box_F","O_Truck_02_fuel_F","O_Truck_02_ammo_F"], false,[
		 [ [0,1.5,0.41], IL_c_orange, IL_att_soft, 10]
	],false],
	[["Truck_02_base_F"], false,[
		 [ [0,3,0.41], IL_c_orange, IL_att_soft, 10]
	],false],
	[["MRAP_01_base_F"], false, [
		 [ [0,-2.3,0.3], IL_c_orange, IL_att_soft, 0.5]
	],false],
	[["MRAP_02_base_F"], false, [
		 [ [0,0,1], IL_c_orange, IL_att_soft, 0.5 ]
	],false],
	[["MRAP_03_base_F"], false, [
		 [ [0,0,0.3], IL_c_orange, IL_att_soft, 0.5 ]
	],false],
	[["Offroad_01_base_F"], false, [
		 [ [0,0,0.3], IL_c_orange, IL_att_soft, 0.5 ]
	],false],
	[["SUV_01_base_F"], false, [
		 [ [0,-0.7,0], IL_c_orange, IL_att_soft, 0.5 ]
	],false],
	[["VAN_01_base_F"], false, [
		 [ [0,0,0.6], IL_c_orange, IL_att_soft, 0.5 ]
	],false],
	[["Hatchback_01_base_F"], false, [
		 [ [0,0,0.3], IL_c_orange, IL_att_soft, 0.5 ]
	],false],
	[["UH60_Base"], false, [
		 [ [0,1.5,-0.7], IL_c_red, IL_att_soft, 0.5 ]
	],true],
	[["UH1H_base"], false, [
		 [ [0,0.7,-0.25], IL_c_red, IL_att_soft, 0.5 ]
	],true],
	[["UH1_Base"], false, [
		 [ [0,0,-0.1], IL_c_red, IL_att_soft, 0.5 ]
	],true],
	[["CH_47F_base"], false, [
		 [ [0,-2,-1], IL_c_red, IL_att_soft, 0.5 ],
		 [ [0,3,-0.83], IL_c_red, IL_att_soft, 0.5 ]
	],true,2]
];

_il_config