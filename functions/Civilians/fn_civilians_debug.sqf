
private ["_unit", "_trigID", "_object"];
_unit 	= _this select 0;
_trigID = _this select 1;
_object = _this select 2;

switch (_object) do {
	case "unit": {
		[_unit, _trigID] spawn {
			_u = _this select 0;
			_txt = format["INF%1", _u];
			_debugMkr = createMarker [_txt, getposASL _u];
			_debugMkr setMarkerShape "ICON";
			_debugMkr setMarkerType "hd_dot";
			while {alive _u && {debugCOS} && {server getvariable [_this select 1, false]}} do {
				_debugMkr setmarkerpos getposASL _u;
				_debugMkr setMarkerColor "ColorYellow";
				if (_u getvariable ["OnMission", false]) then {
					_debugMkr setMarkerColor "ColorRed";
				};
				_debugMkr setMarkerText format["F: %1 S: %5 A: %2 OM: %3 M: %4",
				_u getvariable ["personalhostilefactor",0], _u getvariable ["agent", false], _u getvariable ["OnMission", false], _u getvariable ["Mission", "None"], _u getvariable ["ShotsCount", 0]];
				sleep 1;
			};
			deletemarker _txt;
		};
    };
    case "town": {
    	[_unit] spawn {
    		_mkr = _this select 0;
    		_txt = markertext _mkr;
    		str _mkr call NTA_fnc_log;

    		while {server getvariable [format ["trig%1", _mkr], false] && {debugCOS}} do {
    			_mkr setMarkerText format["%1 Hostilefactor: %2", _txt, server getvariable format["trig%1_hostilefactor", _mkr]];
    			sleep 2;
    		};
    		_mkr setMarkerText format["%1", _txt];
    	};
	};
};