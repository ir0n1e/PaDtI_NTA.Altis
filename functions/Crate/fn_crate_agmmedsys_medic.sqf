if (player getvariable ["haveAGM", false]) exitWith {

	private "_crate";
	_crate = _this;

	_crate addBackpackcargo ["BWA3_AssaultPack_Medic",1];
	_crate addItemcargo ["AGM_Bandage",10];
	_crate addItemcargo ["AGM_Bloodbag",10];
	_crate addItemcargo ["AGM_EarBuds",5];
	_crate addItemcargo ["AGM_Epipen",10];
	_crate addItemcargo ["AGM_Morphine",10];
};