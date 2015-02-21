if (isclass (configfile >> "CfgPatches" >> "AGM_Logistics")) then {
	//[_this] call AGM_Drag_fnc_makeUndraggable;
	_this setVariable ["AGM_disableDrag", true, true]
};
if !(isClass(configFile/"CfgPatches"/"AGM_Medical")) exitwith {};

_this spawn {

	while {true} do {
		_this call NTA_fnc_crate_clear_all;
		_this addItemcargoGlobal ["AGM_Bandage",100];
		_this addItemcargoGlobal ["AGM_Morphine",100];
		_this addItemcargoGlobal ["AGM_Epipen",100];
		_this addItemcargoGlobal ["AGM_Bloodbag",100];
		_this addItemcargoGlobal ["AGM_EarBuds",100];

		if (isClass(configFile/"CfgPatches"/"BWA3_Common")) then {
			_this addBackpackcargoGlobal["BWA3_AssaultPack_Medic",10];
		};
	sleep 1000;
	};
};

