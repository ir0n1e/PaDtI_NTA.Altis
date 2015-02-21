if !(isClass(configFile/"CfgPatches"/"AGM_Core")) exitwith {};
if (isclass (configfile >> "CfgPatches" >> "AGM_Logistics")) then {
	[_this] call AGM_Drag_fnc_makeUndraggable;
};

_this spawn {
	while {true} do {
		_this call NTA_fnc_crate_clear_all;
		_this addItemcargoGlobal ["AGM_cabletie", 20];
		_this addItemcargoGlobal ["AGM_Clacker", 3];
		_this addItemcargoGlobal ["AGM_DefusalKit", 5];
		_this addItemcargoGlobal ["AGM_EarBuds", 10];
		_this addItemcargoGlobal ["AGM_HandFlare_Green", 10];
		_this addItemcargoGlobal ["AGM_HandFlare_Red", 10];
		_this addItemcargoGlobal ["AGM_HandFlare_White", 10];
		_this addItemcargoGlobal ["AGM_HandFlare_Yellow", 10];
		_this addItemcargoGlobal ["AGM_M84", 20];
		_this addItemcargoGlobal ["AGM_MapTools", 10];
		_this addItemcargoGlobal ["AGM_SpareBarrel", 10];
		_this addItemcargoGlobal ["AGM_UAVBattery", 5];
		_this addItemcargoGlobal ["BWA3_IR_Strobe_Item", 10];
		_this addItemCargoGlobal ["AGM_NVG_Gen4", 4];
		_this addItemCargoGlobal ["AGM_NVG_Wide", 4];

		if (isClass(configFile/"CfgPatches"/"AGM_Parachute")) then {
			_this addItemcargoGlobal ["AGM_Altimeter",10];
			_this addBackpackcargoGlobal ["AGM_NonSteerableParachute"];
		};

		if (missionNamespace getvariable ["haveBWplus", false]) then {
			_this addItemcargoGlobal ["BWplus_Shovel", 5];
		};
		sleep 600;
	};
};
