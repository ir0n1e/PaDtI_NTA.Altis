if (isclass (configfile >> "CfgPatches" >> "AGM_Logistics")) then {
	[_this] call AGM_Drag_fnc_makeUndraggable;
};

_this spawn {
	_crate = _this;

	while {true} do {
		_crate call NTA_fnc_crate_clear_all;
		_crate addMagazinecargoGlobal ["ClaymoreDirectionalMine_Remote_Mag", 10];
		_crate addMagazinecargoGlobal ["DemoCharge_Remote_Mag", 10];
		_crate addMagazinecargoGlobal ["SLAMDirectionalMine_Wire_Mag", 10];
		_crate addMagazinecargoGlobal ["APERSTripMine_Wire_Mag", 10];
		_crate addMagazinecargoGlobal ["ATMine_Range_Mag", 10];
		_crate addMagazinecargoGlobal ["SatchelCharge_Remote_Mag", 15];
		_crate addMagazinecargoGlobal ["APERSBoundingMine_Range_Mag", 10];


		_crate addItemcargoGlobal ["ToolKit", 2];
		_crate addItemcargoGlobal ["MineDetector", 5];

		if (isClass(configFile/"CfgPatches"/"AGM_Explosives")) then {
			_crate addItemcargoGlobal ["AGM_DefusalKit",5];

			_crate addItemcargoGlobal ["AGM_Clacker",5];
		};

		sleep 600;
	};
};