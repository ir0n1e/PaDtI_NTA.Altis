_this spawn {
	private["_interval","_end"];

	_end = _this select 0;
	_interval = [_this,1,0] call BIS_fnc_param;




	while {(date select 3) <= _end} do {

		[0.5,"skiptime",nil,true] call BIS_fnc_MP;
		sleep _interval;

	};
};