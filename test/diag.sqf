if (isserver) then {

	while {true} do {
		_oldfps = diag_fps;
		sleep 1;
		if !((diag_fps + 15) >= _oldfps ) then {
			str [time, diag_fps] call nta_fnc_log;

		};


	};
};