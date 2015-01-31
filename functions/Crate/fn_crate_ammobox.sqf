if (missionNamespace getvariable ["haveBWplus", false]) exitWith {};
private "_crate";

_crate = _this;

_crate call NTA_fnc_crate_clear_all;

_crate addBackpackcargoGlobal ["B_GMG_01_high_weapon_F", 2];
_crate addBackpackcargoGlobal ["B_HMG_01_high_weapon_F", 2];
_crate addBackpackcargoGlobal ["B_HMG_01_support_high_F", 4];
_crate addBackpackcargoGlobal ["B_Kitbag_rgr", 2];
_crate addBackpackcargoGlobal ["B_Mortar_01_support_F", 1];
_crate addBackpackcargoGlobal ["B_Mortar_01_weapon_F", 1];
_crate addItemcargoGlobal ["Chemlight_blue",10];
_crate addItemcargoGlobal ["HandGrenade",10];
_crate addItemcargoGlobal ["SmokeShellBlue",10];

_crate addMagazinecargoGlobal ["1rnd_HE_Grenade_shell", 10];
_crate addMagazinecargoGlobal ["APERSTripMine_Wire_Mag",5];
_crate addMagazinecargoGlobal ["ClaymoreDirectionalMine_Remote_Mag",5];
_crate addMagazinecargoGlobal ["DemoCharge_Remote_Mag",5];
_crate addMagazinecargoGlobal ["SLAMDirectionalMine_Wire_Mag",5];
_crate addMagazinecargoGlobal ["Titan_AA", 5];
_crate addMagazinecargoGlobal ["Titan_AP", 5];
_crate addMagazinecargoGlobal ["Titan_AT", 5];
_crate addMagazinecargoGlobal ["UGL_FlareWhite_F", 10];

if (isClass(configFile/"CfgPatches"/"BWA3_Common")) then {
	_crate addWeaponcargoGlobal ["BWA3_G28_Assault_equipped", 1];
	_crate addWeaponcargoGlobal ["BWA3_G36_equipped", 1];
	_crate addWeaponcargoGlobal ["BWA3_MG4", 1];
	_crate addWeaponcargoGlobal ["BWA3_P8", 2];
	_crate addMagazinecargoGlobal ["BWA3_15Rnd_9x19_P8", 10];
	_crate addMagazinecargoGlobal ["BWA3_200Rnd_556x45",5];
	_crate addMagazinecargoGlobal ["BWA3_20Rnd_762x51_G28",20];
	_crate addMagazinecargoGlobal ["BWA3_30Rnd_556x45_G36",20];
	_crate addItemcargoGlobal ["BWA3_acc_LLM01_irlaser",2];
	_crate addItemcargoGlobal ["BWA3_optic_Shortdot",1];
	_crate addItemcargoGlobal ["BWA3_optic_ZO4x30_NSV",5];
};

_crate call NTA_fnc_crate_xmedsys_medic;
_crate call NTA_fnc_crate_agmmedsys_medic;
_crate call NTA_fnc_crate_tfr;