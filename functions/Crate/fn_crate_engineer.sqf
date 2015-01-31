private "_crate";
_crate = _this;

_crate addItemcargo ["BWA3_muzzle_snds_G36",1];
_crate addBackpackcargo ["B_Carryall_cbr", 1];
_crate addWeaponcargo ["BWA3_G36K_equipped", 1];
_crate addItemcargo ["Binocular", 1];
//_crate addMagazinecargo ["BWA3_DM51A1", 2];
//_crate addMagazinecargo ["BWA3_DM25", 5];
_crate addMagazinecargo ["BWA3_30Rnd_556x45_G36",10];
_crate addItemcargo ["BWA3_optic_ZO4x30_NSV",1];
_crate addItemcargo ["BWA3_Vest_Rifleman1_Fleck",1];
_crate addItemcargo ["BWA3_OpsCore_Fleck",1];
_crate addMagazinecargo ["ClaymoreDirectionalMine_Remote_Mag",5];
_crate addMagazinecargo ["DemoCharge_Remote_Mag",5];
_crate addMagazinecargo ["SLAMDirectionalMine_Wire_Mag",5];
_crate addMagazinecargo ["APERSTripMine_Wire_Mag",5];
_crate addItemcargo ["ToolKit", 1];
_crate addItemcargo ["MineDetector", 1];
_crate addItemcargo ["AGM_DefusalKit",1];
_crate addItemcargo ["AGM_Clacker",1];

if (player getvariable ["haveBWplus", false]) then {
	_crate addItemcargo ["BWplus_Shovel",1];
	_crate addItemcargo ["BWplus_Item_CamoNet",1];
};
_crate call NTA_fnc_crate_all;