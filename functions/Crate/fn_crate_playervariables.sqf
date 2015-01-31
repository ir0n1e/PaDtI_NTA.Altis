private ["_box", "_player"];
_box = _this select 0;
_player = _this select 1;



if ((name _player == "luis") && {_box == ammo_auto1 || _box == ammo_auto2} && {missionNamespace getvariable ["haveBWplus", false]}) then {
	_box addweaponcargo ["BWplus_MG4", 1];
};

/*if ((name _player == "drei.zehn") && {_box == ammo_auto1 || _box == ammo_auto2}) then {


	_box addweaponcargo ["BWplus_MG4",1];
}; */