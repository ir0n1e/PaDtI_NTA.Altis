if(!isserver) exitwith {};
_this spawn {
	if (isclass (configfile >> "CfgPatches" >> "AGM_Logistics")) then {
		[_this] call AGM_Drag_fnc_makeUndraggable;
	};

	while {true} do {
		_this call NTA_fnc_crate_clear_all;

		_this addWeaponcargoGlobal ["launch_NLAW_F",2];
		_this addmagazinecargoGlobal ["NLAW_F",4];
		_this addWeaponcargoGlobal ["launch_B_Titan_short_F",2];
		_this addmagazinecargoGlobal ["Titan_AT",4];
		_this addmagazinecargoGlobal ["Titan_AP",4];
		_this addWeaponcargoGlobal ["launch_B_Titan_F",2];
		_this addmagazinecargoGlobal ["Titan_AA",4];
		sleep 600;
	};
};