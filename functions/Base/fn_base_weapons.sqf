/*
private["_exp_box","_launcher_box1","_launcher_box2","_weapons","_tf_box","_sf_box"];
"Starting AmmoBox Init..." call NTA_fnc_log;


_exp_box=[["EMPTY","Box_NATO_AmmoOrd_F",[26733.2,24635.9,-0.0249958],61.2715,"_this setpos [26733.2,24635.9,1.5];"]];


_launcher_box1=[["EMPTY","Box_NATO_WpsLaunch_F",[26733.6,24634.3,-0.0250149],41.0766,"_this setpos [26733.6,24634.3,1.5];"]];

_launcher_box2=[["EMPTY","Box_NATO_WpsLaunch_F",[26733.1,24634,-0.024992],41.3754,"_this setpos [26733,24633.9,1.5];"]];

if (isClass(configfile >> "CfgPatches" >> "task_force_radio_items")) then {
	_tf_box=[["EMPTY","TF_NATO_Radio_Crate",[26723.8,24631.9,-0.0249996],41.2359,"_this setpos [26733.8,24636.9,1.5];"]];
};



if (missionNamespace getvariable ["haveBWplus", false]) then {
	_weapons=[["EMPTY","BWA3_Weapon_G82",[26726.2,24637.6,2.55],216.943,""],["EMPTY","BWA3_Weapon_G28_Standard",[26726.3,24637.1,2.55],217.047,""],["EMPTY","BWplus_Weapon_G36K_SF_SD_Tropen",[26728.3,24635.9,2.45],217.047,""],["EMPTY","BWplus_Weapon_G36K_SF_SD_Fleck",[26727.7,24636,2.45],217.047,""]];
	_sf_box=[["EMPTY","BWplus_Box_weapons_SF",[26733.1,24634,-0.024992],41.3754,"_this setpos [26731,24631.9,1.5];"]];
};


[_exp_box,false,"_this allowdamage false;_this call NTA_fnc_crate_expBox"] call NTA_fnc_mcc_createvehicle;
[_launcher_box1, false,"_this allowdamage false;_this call NTA_fnc_crate_launcher"] call NTA_fnc_mcc_createvehicle;
[_launcher_box2, false,"_this allowdamage false;_this call NTA_fnc_crate_launcher"] call NTA_fnc_mcc_createvehicle;

if (missionNamespace getvariable ["haveBWplus", false]) then {
	[_sf_box,false,"_this allowdamage false;_this call NTA_fnc_crate_BWplusWeapons"] call NTA_fnc_mcc_createvehicle;
	[_weapons,false] call NTA_fnc_mcc_createvehicle;
};
if (isClass(configfile >> "CfgPatches" >> "task_force_radio_items")) then {
	[_tf_box,false,"_this allowdamage false"] call NTA_fnc_mcc_createvehicle;
};
"AmmoBox Init Done..." call NTA_fnc_log;
*/


