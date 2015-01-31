private "_crate";
	_crate = _this;

	if (str player == "leader4" && {missionNamespace getvariable ["haveBWplus", false]}) then {
		_crate addWeaponcargo ["BWplus_G36K_AG_SF_SD_Fleck", 1];
		_crate addWeaponcargo ["BWplus_G36K_AG_SF_SD_Tropen", 1];
		_crate addItemcargo ["BWplus_optic_HWS",1];
		_crate addItemcargo ["BWplus_optic_AIM",1];
		_crate addItemcargo ["BWplus_optic_ZO4x30_Fleck_IRV",1];
		_crate addItemcargo ["BWplus_optic_ZO4x30_Fleck_NRV",1];
	};
	_crate addMagazinecargo["1rnd_SmokeRed_Grenade_shell", 2];
	_crate addMagazinecargo ["UGL_FlareWhite_F", 2];
	_crate addMagazinecargo ["1rnd_HE_Grenade_shell", 6];
	_crate addWeaponcargo ["BWA3_G36_AG_equipped", 1];
	//_crate addItemcargo ["Laserdesignator", 1];
	//_crate addMagazinecargo ["Laserbatteries", 1];
	//_crate addMagazinecargo ["BWA3_DM51A1", 2];
	//_crate addMagazinecargo ["BWA3_DM25", 5];
	_crate addMagazinecargo ["BWA3_30Rnd_556x45_G36",10];
	_crate addItemcargo ["BWA3_Vest_Leader_Fleck",1];
	_crate addItemcargo ["BWA3_OpsCore_Fleck",1];
	_crate addItemcargo ["Chemlight_green",6];
	_crate addItemcargo ["BWA3_muzzle_snds_G36",1];
	_crate addItemcargo ["alive_tablet",1];
	_crate call NTA_fnc_crate_all;