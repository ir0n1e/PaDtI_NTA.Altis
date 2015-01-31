if(!isserver) exitwith {};
if (!(missionNamespace getvariable ["haveBWplus", false])) exitwith {};
_this spawn {

	while {true} do {
		_this call NTA_fnc_crate_clear_all;

		_this addItemcargoGlobal ["BWplus_optic_HWS",4];
		_this addItemcargoGlobal ["BWplus_optic_AIM",4];
		_this addItemcargoGlobal ["BWplus_optic_ZO4x30_Fleck",4];
		_this addItemcargoGlobal ["BWplus_optic_ZO4x30_Tropen",4];
		_this addItemcargoGlobal ["BWplus_optic_RSAS_Fleck",4];
		_this addItemcargoGlobal ["BWplus_optic_RSAS_Tropen",4];
		_this addItemcargoGlobal ["BWplus_optic_ZO4x30_Fleck_NSV",4];
		_this addItemcargoGlobal ["BWplus_optic_ZO4x30_Tropen_NSV",4];
		_this addItemcargoGlobal ["BWplus_optic_ZO4x30_Fleck_IRV",4];
		_this addItemcargoGlobal ["BWplus_optic_ZO4x30_Tropen_IRV",4];
		_this addWeaponcargoGlobal ["BWplus_G36K_AG_SF_Fleck",2];
		_this addWeaponcargoGlobal ["BWplus_G36K_AG_SF_Tropen",2];
		_this addWeaponcargoGlobal ["BWplus_G36K_SF_Fleck",2];
		_this addWeaponcargoGlobal ["BWplus_G36K_SF_Tropen",2];

		sleep 3600;
	};
};
