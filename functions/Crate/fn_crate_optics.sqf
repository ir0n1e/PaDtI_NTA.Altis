if (isclass (configfile >> "CfgPatches" >> "AGM_Logistics")) then {
	[_this] call AGM_Drag_fnc_makeUndraggable;
};

_this spawn {
	while {true} do {
		_this call NTA_fnc_crate_clear_all;
		_this addItemcargoGlobal ["optic_Arco", 5];
		_this addItemcargoGlobal ["optic_Hamr", 5];
		_this addItemcargoGlobal ["optic_Aco", 5];
		_this addItemcargoGlobal ["optic_Holosight", 5];
		_this addItemcargoGlobal ["optic_MRCO", 5];

		sleep 600;
	};
};
