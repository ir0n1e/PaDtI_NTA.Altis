private "_crate";
_crate = _this;

if (str player == "medic1" && {missionNamespace getvariable ["haveBWplus", false]}) then {
	_crate addWeaponcargo ["BWplus_G36K_SF_SD_Fleck", 1];
	_crate addWeaponcargo ["BWplus_G36K_SF_SD_Tropen", 1];
	_crate addItemcargo ["BWplus_optic_HWS",1];
	_crate addItemcargo ["BWplus_optic_AIM",1];
	_crate addItemcargo ["BWplus_optic_ZO4x30_Fleck_IRV",1];
	_crate addItemcargo ["BWplus_optic_ZO4x30_Fleck_NRV",1];
};

_crate addItemcargo ["SmokeShellBlue",5];
_crate addWeaponcargo ["BWA3_G36k_equipped", 1];
_crate addItemcargo ["Binocular", 1];
//_crate addMagazinecargo ["BWA3_DM25", 10];
//_crate addMagazinecargo ["BWA3_15Rnd_9x19_P8", 5];
_crate addMagazinecargo ["BWA3_30Rnd_556x45_G36",10];

_crate addItemcargo ["BWA3_optic_ZO4x30_NSV",1];
_crate addItemcargo ["BWA3_Vest_Medic_Fleck",1];
_crate addItemcargo ["BWA3_OpsCore_Fleck",1];
_crate addItemcargo ["BWA3_muzzle_snds_G36",1];
_crate call NTA_fnc_crate_all;
//_crate call NTA_fnc_crate_xmedsys_medic;
_crate call NTA_fnc_crate_agmmedsys_medic;