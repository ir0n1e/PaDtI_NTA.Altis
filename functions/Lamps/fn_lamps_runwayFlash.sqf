_this spawn {
	_switchOn = _this select 0;
	sleep 2;
	while {NTA_RunwayOn} do {
		sleep 2;
		{
			 _x hideObjectGlobal true;
		 	sleep 0.38;

		} foreach nta_runway_flashlights;
		sleep 0.25;
		{
			_x hideObjectGlobal false;

		} foreach nta_runway_flashlights;
	};

	{
		_x hideObjectGlobal _switchOn
	} foreach nta_runway_flashlights;
};