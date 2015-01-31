_target = _this select 0;

_target spawn {
	private ["_target","_nopop"];
	_target = _this select 0;

	_nopop = _target getVariable "nopop";


	_target setDamage 0;




/*
while {true} do {
	hint format ["%1",(_target animationPhase "terc")];
};
*/
	if (_nopop) then {
		//wait until target is down
		waitUntil {((_target animationPhase "terc") ==1)};
		//wait until target stand up
		waitUntil {((_target animationPhase "terc") <1)};
		nopop=true;
		_target animate["terc", 1];

	};
	nopop=false;
	true

};



