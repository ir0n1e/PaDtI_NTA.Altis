{
	_mkrpl = createMarker [format ["dbgmkrpl%1",_foreachindex], getposASL (leader _x)];
	_mkrpl setmarkercolor "ColorRed";
	_mkrpl setMarkerShape "ICON";
	_mkrpl setMarkerType "hd_dot";

	[leader _x, _mkrpl] spawn {
		_p = _this select 0;
		_m = _this select 1;
		_t = time;

		if (_p getvariable ["isHC", false]) then {
			_m setmarkercolor "ColorGreen";
		};
		if (_p getvariable ["isServer", false]) then {
			_m setmarkercolor "ColorRed";
		};
		if (_p getvariable ["isLocal", false]) then {
			_m setmarkercolor "ColorYellow";
		};


		while {time < _t + 120} do {
			_m setMarkertext format ["Unit: %4 isHC: %1 isServer: %2 isLocal %3" ,_p getvariable ["isHC", false], _p getvariable ["isServer", false], _p getvariable ["isLocal", false], _p];
			_m setmarkerpos (getposASL _p);

			sleep 2;
		};
		deletemarker _m;
	};
} foreach allgroups;

