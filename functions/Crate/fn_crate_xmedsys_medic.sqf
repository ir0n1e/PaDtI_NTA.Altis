NTA_xmedsys_enabeled =isClass(configFile/"CfgPatches"/"X39_MedSys_Items");
if (NTA_Xmedsys_enabeled) exitWith {
	private "_crate";
	_crate = _this;

	_crate addItemcargo ["x39_bandage",25];
	_crate addItemcargo ["x39_morphine",10];
	_crate addItemcargo ["x39_epinephrine",10];
	_crate addItemcargo ["x39_tourniquet",1];
	_crate addItemcargo ["x39_bloodbag",6];
	_crate addItemcargo ["x39_medikit",13];
	_crate addItemcargo ["x39_defibrillator",1];
	_crate addItemcargo ["x39_earplug",10];
};