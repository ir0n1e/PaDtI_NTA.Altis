[] spawn {
	if (hasInterface) then {
		private ["_cam","_camx","_camy","_camz","_object","_minutes","_houre","_weather","_date","_start","_pdate","_overcast","_weather"];

		_date = date;
		_start = time;

		waituntil {((time - _start) > 3)};
		sleep 0.5;

	/*_object = player;
	_camx = getposATL player select 0;
	_camy = getposATL player select 1;
	_camz = getposATL player select 2;

	_cam = "camera" CamCreate [_camx -300 ,_camy + 300,_camz+100];

	_cam CamSetTarget player;
	_cam CameraEffect ["Internal","Back"];
	_cam CamCommit 0;

	_cam camsetpos [_camx -15 ,_camy + 15,_camz+3];
	_cam CamCommit 15;
	sleep 5;
titleText ["Die NATO Response Force Präsentiert...", "BLACK IN",9999];
sleep 5;
	titleText ["*N R F* O p e r a t i o n s | A L i V E", "BLACK IN",10];

	sleep 5;

	_cam CameraEffect ["Terminate","Back"];
	CamDestroy _cam;
sleep 2;*/

		_pdate = format ["Es ist %1:%2 Uhr",_date select 3,date select 4];
		_overcast = overcast;
		switch(true) do {
			case (_overcast == 0): {_weather="Wetter: Sonnig" };
			case (_overcast == 1): {_weather="Wetter: Stürmisch" };
			case (_overcast >= 0.5): {_weather="Wetter: Bewölkt" };
			case (_overcast <= 0.5): {_weather="Wetter: Klar" };
		};

		[[["MOIN MOIN","<t size='1.0' font='PuristaMedium'>%1</t><br/>",0],
		["Willkommen auf unserem Public Server","<t size='1.0' font='PuristaMedium'>%1</t><br/>",0],
		[name player,"<t size='1.0' font='PuristaBold'>%1</t><br/>",5],
		["TeamSpeak IP: 146.0.32.91","<t size='1.0' font='PuristaMedium'>%1</t><br/>",0],
		[_pdate,"<t size='0.8' font='PuristaMedium'>%1</t><br/>",0],
		[_weather,"<t size='0.8' font='PuristaMedium'>%1</t><br/>",0],
		["drei.zehn 'kickt' und 'bannt' ungefragt!","<t size='0.8' font='PuristaMedium'>%1</t><br/>",0],
		["... ... ... ... ... ...","<t size='0.8' font='PuristaMedium'>%1</t><br/>",0]],
		-safezoneX,0.85,"<t color='#FFFFFFFF' align='right'>%1</t>"] spawn BIS_fnc_typetext;
	};
	[] call NTA_fnc_players_modinfo;
};
