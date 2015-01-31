_this spawn {
	_u = _this select 0;
	_txt = format["AIRPATROL_%1", _u];

	if (_this select 1) then {
		_txt = format["AIRPATROLCrew_%1", _u];
	};

	_color = "ColorBLUE";

	if (side _u == EAST) then {
		_color = "ColorRed";
	};

	_debugMkr = createMarker [_txt, getposASL _u];
	_debugMkr setMarkerShape "ICON";
	_debugMkr setMarkerType "hd_dot";
	_debugMkr setMarkerColor _color;

	_vehname = getText ( configFile >> "CfgVehicles" >> typeof _u >> "displayName");

	while {alive _u && {NTA_Airpatrol_Debug}} do {
		_debugMkr setmarkerpos getposASL _u;

		if (!(_this select 1)) then {
			_debugMkr setMarkerText format["%1 T: %2 D: %3 B: %4 M: %5 C: %6",
				_vehname,
				_u getvariable ["Airpatrol_Target", [0,0,0]],
				_u distance (_u getvariable ["Airpatrol_Target", [0,0,0]]),
				_u getvariable ["NTA_bombsAway", false],
				_u getvariable ["Airpatrol_Mission", ""],
				_u getvariable  ["NTA_Airpatrol_Crash", false]
			];
		} else {
			_debugMkr setMarkerText format["%1 T: %2",
				_vehname,
				_u getvariable  ["NTA_Airpatrol_Crash", false]
				];
		};

		sleep 1;
	};
	deletemarker _txt;
};