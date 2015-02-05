if !(isClass(configfile >> "CfgPatches" >> "task_force_radio_items")) exitWith {};
private "_crate";

_crate = _this;

if !(str player in ntamedic) then {
	_crate addBackpackcargo ["tf_rt1523g_big_bwmod", 1];
	_crate addBackpackcargo ["tf_rt1523g_bwmod", 1];
};

_crate addItemcargo ["tf_anprc152", 1];