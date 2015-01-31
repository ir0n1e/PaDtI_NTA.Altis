if (("NTA_haveAGMBWA3" call bis_fnc_getParamValue) == 0) exitwith {};
if (local player) then {
	0 spawn {

		while {NTA_DEBUG} do {
			[ format["<t size='1' color='#ffff00'>DEVELOPMENT Mission - Not for public use!</t>"], -0.5,-1,5,0,0,301] spawn bis_fnc_dynamicText;
			[ format["<t size='1' color='#ffff00'>DEVELOPMENT Mission - Not for public use!</t>"], -0.5,-1,5,0,0,301] spawn bis_fnc_dynamicText;

			sleep 10;
		};

		_haveBWA3 = player getvariable ["haveBWA3", false];
		_haveAGM = player getvariable ["haveAGM", false];
		_text = "";
		if (!_haveBWA3) then {
			_text = localize "STR_NTA_NO_BWA3_1";
		};
		if (!_haveAGM) then {
			_text = localize "STR_NTA_NO_AGM_1";
		};
		if (!_haveAGM && !_haveBWA3) then {
			_text = localize "STR_NTA_NO_AGM_BWA3_1";
		};

		while {!_haveBWA3 || !_haveAGM} do {
			[ format["<t size='1' color='#ffff00'>%1</t>", _text + " " + localize "STR_NTA_NO_AGM_2"], -0.5,-1,5,0,0,301] spawn bis_fnc_dynamicText;
			[ format["<t size='1' color='#ffff00'>%1</t>", _text + " " + localize "STR_NTA_NO_AGM_2"], -0.5,-1,5,0,0,301] spawn bis_fnc_dynamicText;

			sleep 10;
		};

	};
};