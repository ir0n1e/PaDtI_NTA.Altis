private "_crate";
_crate = _this;

if (str player == "exp1" && {missionNamespace getvariable ["haveBWplus", false]}) then {
	_crate addWeaponcargo ["BWplus_G36K_SF_SD_Fleck", 1];
	_crate addWeaponcargo ["BWplus_G36K_SF_SD_Tropen", 1];
	_crate addItemcargo ["BWplus_optic_ZO4x30_Fleck_IRV",1];
	_crate addItemcargo ["BWplus_optic_ZO4x30_Fleck_NRV",1];
};
if (player getvariable ["havebwplus", false]) then {
	_crate addItemcargo ["BWplus_optic_HWS",1];
	_crate addItemcargo ["BWplus_optic_AIM",1];
	_crate addItemcargo ["BWplus_Item_CamoNet",2];
	_crate addItemcargo ["BWplus_Shovel",1];
};
_crate addWeaponcargo ["BWA3_G36K_equipped", 1];
_crate addItemcargo ["BWA3_muzzle_snds_G36",1];
_crate addBackpackcargo ["B_Carryall_cbr", 1];
_crate addItemcargo ["Binocular", 1];
//_crate addMagazinecargo ["BWA3_DM51A1", 2];
//_crate addMagazinecargo ["BWA3_DM25", 5];
_crate addMagazinecargo ["BWA3_30Rnd_556x45_G36",10];
_crate addItemcargo ["BWA3_Vest_Rifleman1_Fleck",1];
_crate addItemcargo ["BWA3_OpsCore_Fleck",1];
_crate addMagazinecargo ["ClaymoreDirectionalMine_Remote_Mag",2];
_crate addMagazinecargo ["DemoCharge_Remote_Mag",5];
_crate addMagazinecargo ["SLAMDirectionalMine_Wire_Mag",2];
_crate addMagazinecargo ["APERSTripMine_Wire_Mag",5];
_crate addMagazinecargo ["ATMine_Range_Mag",2];
_crate addMagazinecargo ["SatchelCharge_Remote_Mag",2];
_crate addMagazinecargo ["APERSBoundingMine_Range_Mag",5];
_crate addItemcargo ["ToolKit", 1];
_crate addItemcargo ["MineDetector", 1];
_crate addItemcargo ["AGM_DefusalKit",1];
_crate addItemcargo ["BWA3_muzzle_snds_G36",1];
_crate addItemcargo ["AGM_Clacker",1];

_crate call NTA_fnc_crate_all;