scriptName "fn_crate_jtac";
/*
	Author: Tom_48_97

	Description:
	Describe your function

	Parameter(s):
	#0 OBJECT - Description

	Returns:
	BOOL - TRUE when done
*/





private ["_crate","_raven"];
_crate = _this;

_raven =  isClass(configFile/"CfgPatches"/"MicroAirVehicles");

if (_raven) then {
	_crate addBackpackcargo ["B_MAV_B_BACKPACK",1];
};
	if (str player == "jtac2") then {
		if (missionNamespace getvariable ["haveBWplus", false]) then {
			_crate addWeaponcargo ["BWplus_G36K_AG_SF_SD_Fleck", 1];
			_crate addWeaponcargo ["BWplus_G36K_AG_SF_SD_Tropen", 1];

			_crate addItemcargo ["BWplus_optic_HWS",1];
			_crate addItemcargo ["BWplus_optic_AIM",1];
			_crate addItemcargo ["BWplus_optic_ZO4x30_Fleck_IRV",1];
			_crate addItemcargo ["BWplus_optic_ZO4x30_Fleck_NRV",1];

	};
		_crate addMagazinecargo ["BWA3_30Rnd_556x45_G36",10];
		_crate addWeaponcargo ["BWA3_G36K_AG_equipped", 1];

	} else {

		_crate addWeaponcargo ["BWA3_G27_AG", 1];
		_crate addItemcargo ["BWA3_optic_Shortdot",1];
		_crate addMagazinecargo ["BWA3_20Rnd_762x51_G28",15];
		_crate addItemcargo ["optic_tws",1];
	};
	_crate addMagazinecargo["1rnd_SmokeRed_Grenade_shell", 2];
	_crate addMagazinecargo ["UGL_FlareWhite_F", 2];
	_crate addMagazinecargo ["1rnd_HE_Grenade_shell",5];
	_crate addItemcargo ["Laserdesignator", 1];


	//_crate addMagazinecargo ["BWA3_DM51A1", 2];
	//_crate addMagazinecargo ["BWA3_DM25", 5];


	_crate addItemcargo ["BWA3_Vest_Marksman_Fleck",1];
	_crate addItemcargo ["BWA3_Uniform_Fleck"];
	_crate addMagazinecargo ["Laserbatteries", 1];
	_crate call NTA_fnc_crate_all;