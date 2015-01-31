private "_crate";
_crate = _this;

//_crate addBackpackcargoGlobal ["tf_rt1523_fleck", 1];
//_crate addBackpackcargoGlobal ["tf_rt1523_tropen", 1];
//_crate addItemcargoGlobal ["HandGrenade",2];
//_crate addItemcargoGlobal ["SmokeShellBlue",4];
//_crate addBackpackcargo ["B_Kitbag_cbr", 1];
_crate addBackpackcargo ["B_Kitbag_rgr", 1];
_crate addItemcargo ["BWA3_acc_LLM01_irlaser",2];
_crate addItemcargo ["BWA3_DM25",2];
_crate addItemcargo ["BWA3_DM25",2];
_crate addItemcargo ["BWA3_DM32_Orange",2];
_crate addItemcargo ["BWA3_DM32_Yellow",2];
_crate addItemcargo ["BWA3_DM51A1",2];
_crate addItemcargo ["BWA3_G_Combat_Black",1];
_crate addItemcargo ["BWA3_G_Combat_Clear",1];
_crate addItemcargo ["BWA3_G_Combat_Orange",1];
_crate addItemcargo ["BWA3_ItemKestrel",1];
_crate addItemcargo ["BWA3_ItemNavipad",1];
_crate addItemcargo ["BWA3_OpsCore_Fleck_Camera",1];
_crate addItemcargo ["BWA3_optic_Aimpoint",1];
_crate addItemcargo ["BWA3_optic_RSAS",1];
_crate addItemcargo ["BWA3_optic_ZO4x30_NSV",1];
_crate additemcargo ["BWA3_Uniform2_Fleck",1];
_crate additemcargo ["BWA3_Uniform3_Fleck",1];
_crate additemcargo ["BWA3_Uniform_Fleck",1];
_crate addItemcargo ["Chemlight_blue",2];

_crate addItemcargo ["BWA3_Vector",1];
_crate addMagazinecargo ["BWA3_15Rnd_9x19_P8", 4];
_crate addWeaponcargo ["BWA3_P8", 1];
if (player getvariable ["haveBWplus", false]) then {
	_crate addItemcargo ["BWplus_Cap_Green",1];
	_crate addItemcargo ["BWplus_Cap_Sand",1];
	_crate addItemcargo ["BWplus_Shemagh_Green",1];
	_crate addItemcargo ["BWplus_Shemagh_Sand",1];
	_crate addItemcargo ["BWplus_optic_HWS",1];
	_crate addItemcargo ["BWplus_optic_AIM",1];
	_crate addItemcargo ["BWplus_Shovel",1];
};


_crate call NTA_fnc_crate_agmmedsys_all;
_crate call NTA_fnc_crate_tfr;
/*
BWA3_DM51A1
DM25
BWA3_DM25
DM32 (gelb)
BWA3_DM32_Yellow
DM32 (orange)
BWA3_DM32_Orange
Kestrel 4500
BWA3_ItemKestrel
NAVIPAD
BWA3_ItemNavipad
IRV600
BWA3_optic_IRV600
NSV80
BWA3_optic_NSV80
NSA80
BWA3_optic_NSA80
6-24x72
BWA3_optic_24x72
Schalldämpfer G28
BWA3_muzzle_snds_G28
Schalldämpfer G36
BWA3_muzzle_snds_G36
Schalldämpfer MG4
BWA3_muzzle_snds_MG4
Schalldämpfer MG5
BWA3_muzzle_snds_MG5
Schalldämpfer MP7
BWA3_muzzle_snds_MP7
*/
