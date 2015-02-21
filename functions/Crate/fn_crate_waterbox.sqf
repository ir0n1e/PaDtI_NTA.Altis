if (isclass (configfile >> "CfgPatches" >> "AGM_Logistics")) then {
	_this setVariable ["AGM_disableDrag", true, true];
	//[_this] call AGM_Drag_fnc_makeUndraggable;
};
_this spawn {
	_crate = _this;

	while {true} do {
		_crate call NTA_fnc_crate_clear_all;
		_crate addItemCargoGlobal ["U_B_Wetsuit", 8];
		_crate addItemCargoGlobal ["g_diving", 8];
		_crate addItemCargoGlobal ["V_RebreatherB", 8];

		sleep 1000;
	};
};