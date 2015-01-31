_this spawn {

	_object = _this select 0;
	_true = _this select 1;

	while {_true} do {
		_flare = "F_40mm_White" createvehicle ((_object) ModelToWorld [0,100,200]);
		_flare setVelocity [0,0,-0.01];

		sleep 	((random 60) + 120);
	};
};