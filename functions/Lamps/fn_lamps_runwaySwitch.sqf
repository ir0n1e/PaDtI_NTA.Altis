_this spawn {
	private "_switchOn";

	_switchOn = _this select 0;

	NTA_RunwayOn = _switchOn;
	publicVariable "NTA_RunwayOn";


	if (_switchOn) then {
		_switchOn = false;
	} else {
		_switchOn = true;
	};

	{
		_script = [_x, _switchOn] spawn {
			_obj 		= _this select 0;
			_switchOn 	= _this select 1;

			_obj hideObjectGlobal _switchOn;
		};
		waituntil {scriptDone _script};
	} foreach nta_runway_staticlights + nta_runway_flashlights;

	[_switchOn] call NTA_fnc_lamps_runwayFlash;
};