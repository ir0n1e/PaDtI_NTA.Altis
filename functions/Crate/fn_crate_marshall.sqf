if (!isServer) exitWith {};
private "_crate";
_crate = _this;



//Clear Box
_crate call NTA_fnc_crate_clear_all;
_crate addBackpackcargoGlobal ["B_UAV_01_backpack_F", 1];
_crate addItemcargoGlobal ["B_UavTerminal", 1];
_crate addWeaponcargoGlobal ["MineDetector", 1];
_crate addItemcargoGlobal ["ToolKit", 1];
_crate addMagazinecargoGlobal ["1rnd_HE_Grenade_shell", 10];
_crate addMagazinecargoGlobal ["Titan_AA", 2];
_crate addMagazinecargoGlobal ["Titan_AT",2];
_crate addmagazinecargoGlobal ["SatchelCharge_Remote_Mag", 2];
_crate addmagazinecargoGlobal ["DemoCharge_Remote_Mag", 4];
_crate addMagazinecargoGlobal ["BWA3_30Rnd_556x45_G36",20];
_crate addMagazinecargoGlobal ["BWA3_200Rnd_556x45", 5];
_crate addMagazinecargoGlobal ["BWA3_20Rnd_762x51_G28", 5];
_crate addMagazinecargoGlobal ["BWA3_10Rnd_762x51_G28", 5];
_crate addMagazinecargoGlobal ["BWA3_120Rnd_762x51", 5];
_crate addWeaponcargoGlobal ["BWA3_Pzf3_Loaded",2];
_crate addBackpackcargoGlobal ["BWA3_AssaultPack_Medic",1];


