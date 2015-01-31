NTA_xmedsys_enabeled =isClass(configFile/"CfgPatches"/"X39_MedSys_Items");
if (NTA_Xmedsys_enabeled) exitWith {

private "_crate";
	_crate = _this select 0;
	_crate addItemcargo ["x39_bandage",10];
	_crate addItemcargo ["x39_morphine",5];
	_crate addItemcargo ["x39_epinephrine",5];
	_crate addItemcargo ["x39_tourniquet",1];
	_crate addItemcargo ["x39_medikit",2];
	_crate addItemcargo ["x39_earplug",1];
};