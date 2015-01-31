if (player getvariable ["haveAGM", false]) exitWith {

private "_crate";
	_crate = _this;

	_crate addItemcargo ["AGM_Bandage",10];
	_crate addItemcargo ["AGM_Bloodbag",1];
	_crate addItemcargo ["AGM_EarBuds",1];
	_crate addItemcargo ["AGM_Epipen",1];

	_crate addItemcargo ["AGM_Morphine",4];

};