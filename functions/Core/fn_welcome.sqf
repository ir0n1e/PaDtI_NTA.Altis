_this spawn {
	if (hasInterface) then {
		private ["_cam","_camx","_camy","_camz","_object","_minutes","_houre","_weather","_date","_start","_pdate","_overcast","_weather", "_fog", "_foglevel"];



		if (player getvariable ["NTA_PublicPlayer", false]) then {
			_start = time;
			waituntil {!isnil "PO3_intro_done" && {PO3_intro_done} && {(time - _start) > 3}};
		} else {
			_start = time;
			waituntil {(player getvariable ["alive_sys_player_playerloaded", false]) || ((time - _start) > 10)};
		};

		sleep 10;
		hintsilent parsetext format ["<t size='1.3'>%1 (%2) init in %3 sec done</t>", name player, player, (diag_ticktime - Player_initTime)];
		_h = date select 3;
		_m = date select 4;
		if (_h < 10) then {
			_h = format ["0%1", date select 3];
		};
		if (_m < 10) then {
			_m = format ["0%1", date select 4];
		};


		_pdate 		= format ["Es ist %1:%2 Uhr", _h, _m];
		_overcast 	= overcast;

		switch(true) do {
			case (_overcast == 0): 		{_weather="Sonnig" };
			case (_overcast == 1): 		{_weather="Stürmisch" };
			case (_overcast >= 0.5): 	{_weather="Bewölkt" };
			case (_overcast < 0.5): 	{_weather="Klar" };
		};

		_foglevel = fog;

		switch(true) do {
			case (_foglevel == 0): 		{_fog=" kein Nebel" };
			case (_foglevel == 1): 		{_fog=" dichter Nebel" };
			case (_foglevel >= 0.5): 	{_fog=" nebelig" };
			case (_foglevel < 0.5): 	{_fog=" leichter Nebel" };
		};

		//fuck of: No english Version!! German Server
		if (player getvariable ["NTA_PublicPlayer", false]) then {
			[[["MOIN MOIN","<t size='1.0' font='PuristaMedium'>%1</t><br/>",0],
			["Willkommen auf unserem Public Server","<t size='1.0' font='PuristaMedium'>%1</t><br/>",0],
			[name player,"<t size='1.0' font='PuristaBold'>%1</t><br/>",5],
			["TeamSpeak IP: 146.0.32.91","<t size='1.0' font='PuristaMedium'>%1</t><br/>",0],
			[_pdate,"<t size='0.8' font='PuristaMedium'>%1</t><br/>",0],
			["Wetter: " + _weather + _fog,"<t size='1.0' font='PuristaMedium'>%1</t><br/>",0],
			["drei.zehn 'kickt' und 'bannt' ungefragt!","<t size='0.8' font='PuristaMedium'>%1</t><br/>",0],
			["... ... ... ... ... ...","<t size='0.8' font='PuristaMedium'>%1</t><br/>",0]],
			-safezoneX,0.85,"<t color='#FFFFFFFF' align='right'>%1</t>"] spawn BIS_fnc_typetext;
		} else {
			[[["MOIN MOIN","<t size='1.0' font='PuristaMedium'>%1</t><br/>",0],
			["Willkommen im Camp Molos","<t size='1.0' font='PuristaMedium'>%1</t><br/>",0],
			[name player,"<t size='1.0' font='PuristaBold'>%1</t><br/>",5],
			[_pdate,"<t size='1.0' font='PuristaMedium'>%1</t><br/>",0],
			["Wetter: " + _weather + _fog,"<t size='1.0' font='PuristaMedium'>%1</t><br/>",0],
			["...","<t size='1.0' font='PuristaMedium'>%1</t><br/>",0]],
			-safezoneX,0.85,"<t color='#FFFFFFFF' align='right'>%1</t>"] spawn BIS_fnc_typetext;
		};
	};

	sleep 10;
	if (("NRF_Training" call bis_fnc_getParamValue) > 0) then {
		hint parseText format["<img size='5' color='#ffffff' image='pics\NTA_Logo_G.paa'/><br/><br/><t size='2' color='#ffff00'><br/>" + localize "STR_NTA_Triningmode" + "</t>"];
		sleep 5;
		hint "";
	};
	if (("NTA_Event" call bis_fnc_getParamValue) > 0) then {
		hint parseText format["<img size='5' color='#ffffff' image='pics\NTA_Logo_G.paa'/><br/><br/><t size='2' color='#ffff00'><br/>" + localize "STR_NTA_Eventmode" + "</t><t size='1.5'><br/><br/>" + localize "STR_NTA_noVehicleRespawn" + "</t>"];
		sleep 5;
		hint "";
	};
	if (("NTA_Tickets" call bis_fnc_getParamValue) > 0) then {
		hint parseText format["<img size='5' color='#ffffff' image='pics\NTA_Logo_G.paa'/><br/><br/><t size='1.5' color='#ffff00'><br/> " + localize "STR_NTA_Tickets" + " " + localize "STR_NTA_Active" + ":</t><t size='1.2'><br/><br/>" + localize  "STR_NTA_Tickets" + " " + localize "STR_NTA_Actual" + ": %1</t>", missionnamespace getvariable ["NTA_tickets", 0]];
		sleep 5;
		hint "";
	};

	[] call NTA_fnc_players_modinfo;
	(findDisplay 46) displayAddEventHandler ["KeyDown","_this call NTA_fnc_players_viewDistance"];
	[[player, "","", false], "NTA_fnc_inidb_viewSettings", false, false] call bis_fnc_mp;
	[[player, "death"], "NTA_fnc_inidb_readPlayerStats", false, false] call bis_fnc_mp;
	[[player, "weaponstats"], "NTA_fnc_inidb_readPlayerStats",false, false] call bis_fnc_mp;



	sleep 10;
	_viewsettings = player getvariable ["viewSettings", []];
	if (count _viewsettings > 0) then {
		setTerrainGrid (_viewsettings select 0);
		setviewdistance (_viewsettings select 1);
		hint parseText format ["<img size='4' color='#ffffff' image='pics\NTA_Logo_G.paa'/><br/><br/><t size='1.5'>Tarrain: %1 ViewDistance: %2 Loaded</t>", (_viewsettings select 0), (_viewsettings select 1)];
	} else {
		setTerrainGrid 25;
		setviewdistance 2000;
		hint parseText format ["<img size='4' color='#ffffff' image='pics\NTA_Logo_G.paa'/><br/><br/><t size='1.5'>Tarrain: %1 ViewDistance: %2 Loaded</t><br/>Defaults<br>", 25, 2000];

	};
	[] call NTA_fnc_core_diary;

};
