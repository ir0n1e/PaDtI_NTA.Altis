if (!isServer)  exitWith {};
//null = this execVM "Crate1.sqf";
private "_crate";
_crate = _this;

//Clear Box
_crate call NTA_fnc_crate_clear_all;
_crate addBackpackcargoGlobal ["B_Mortar_01_support_F", 1];
_crate addBackpackcargoGlobal ["B_Mortar_01_weapon_F", 1];
_crate addWeaponcargoGlobal ["MineDetector", 1];
_crate addItemcargoGlobal ["ToolKit", 1];
//_crate addItemcargoGlobal ["FirstAidKit", 10];
//_crate addMagazinecargoGlobal ["20Rnd_762x51_Mag", 10];
//_crate addMagazinecargoGlobal ["150Rnd_762x51_Box_Tracer", 5];
//_crate addMagazinecargoGlobal ["30Rnd_65x39_caseless_mag", 20];
_crate addMagazinecargoGlobal ["1Rnd_HE_Grenade_shell", 10];
_crate addMagazinecargoGlobal ["Titan_AA", 2];
_crate addMagazinecargoGlobal ["Titan_AT",2];
_crate addMagazinecargoGlobal ["BWA3_30Rnd_556x45_G36",10];
_crate addMagazinecargoGlobal ["BWA3_200Rnd_556x45", 2];
_crate addMagazinecargoGlobal ["BWA3_20Rnd_762x51_G28", 2];
_crate addMagazinecargoGlobal ["BWA3_10Rnd_762x51_G28", 2];
_crate addmagazinecargoGlobal ["DemoCharge_Remote_Mag", 2];
_crate addMagazinecargoGlobal ["BWA3_120Rnd_762x51", 2];
_crate addBackpackcargoGlobal ["BWA3_AssaultPack_Medic",1];
_crate addWeaponcargoGlobal ["BWA3_Pzf3_Loaded",2];
_crate addBackpackCargoGlobal ["BWA3_AssaultPack_Medic",1];