private ["_crate","_tfr,_clf_mods"];
_crate = _this;
_tfr = isClass(configfile >> "CfgPatches" >> "task_force_radio_items");


if (_tfr) then {

	if !(str player in ntamedic) then {
		_crate addBackpackcargo ["tf_rt1523g_big_bwmod", 1];
		_crate addBackpackcargo ["tf_rt1523g_bwmod", 1];
	};

	_crate addItemcargo ["tf_anprc152", 1];
};