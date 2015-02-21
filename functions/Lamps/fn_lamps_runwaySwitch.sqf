_this spawn {
	private ["_switchOn", "_simulation"];

	_switchOn = _this select 0;

	NTA_RunwayOn = _switchOn;
	publicVariable "NTA_RunwayOn";


	if (_switchOn) then {
		_switchOn = false;
		_simulation = true;

	} else {
		_switchOn = true;
		_simulation = false;
	};

	{
		_script = [_x, _switchOn, _simulation] spawn {
			_obj 		= _this select 0;
			_switchOn 	= _this select 1;
			_simulation = _this select 2;

			_obj enableSimulationGlobal _simulation;
			_obj hideObjectGlobal _switchOn;
		};
		waituntil {scriptDone _script};
	} foreach nta_runway_staticlights + nta_runway_flashlights;

	[_switchOn] call NTA_fnc_lamps_runwayFlash;
};