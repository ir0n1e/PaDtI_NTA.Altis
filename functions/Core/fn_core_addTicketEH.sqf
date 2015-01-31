if (!isserver) exitwith {};
NTA_Tickets = 0;
publicvariable "NTA_Tickets";

if (("NTA_Tickets" call bis_fnc_getParamValue) <= 0 || {("NRF_Training" call bis_fnc_getParamValue) > 0}) exitwith {
	"No Ticket System today" call NTA_fnc_log;
};

waituntil {missionNamespace getvariable ["NTA_VehiclesInit", false] && {count playableunits > 0}};

0 spawn {
	_oldTickets = 0;


	//wait for respawn vehicles
	_time = time;

	waituntil{time >= (_time + 5*60)};
	missionNamespace setVariable ["NTA_Tickets", ("NTA_Tickets" call bis_fnc_getParamValue)];
	format ["Ticket System running (%1)", missionNamespace getvariable "NTA_Tickets"] call NTA_fnc_log;
	["Ticketsystem Hot", "NTA_fnc_note"] call bis_fnc_mp;
	NTA_TicketsActive = true;
	publicvariable "NTA_TicketsActive";

	while {true} do {
		if (count playableunits <= 0) then {
			missionNamespace setvariable ["NTA_Tickets", ("NTA_Tickets" call bis_fnc_getParamValue)];
			publicvariable "NTA_Tickets";
			waituntil {count playableunits > 0};
		};

		_tickets = missionNamespace getvariable "NTA_Tickets";

		if (_tickets != _oldTickets) then {
			/*_txt = format [
				"Tickets %1 has been updated to: %2",
				_oldTickets,
				_tickets
			]; */
			_txt = parseText format["<t size='1.3' color='#ffff00'>Tickets:</t><t size='1.2'> %1</t>", _tickets];
			[_txt, "hintsilent"] call bis_fnc_mp;

			_oldTickets = _tickets;


			sleep 4;
			["", "hint"] call bis_fnc_mp;
		};
		if (_tickets <= 0) exitwith {
			NTA_MissionEnd = true;
			Publicvariable "NTA_MissionEnd";

		};
		{
    		if ((_x distance [0,0,0]) < 1) then {
        		deleteVehicle _x;
    		};
		} count (allMissionObjects "EmptyDetector");
		format ["Fuer nic FPS: %1 Time: %2 Units: %3 AllUnits: %4", diag_fps, time, count playableUnits, count allunits] call nta_fnc_log;
		sleep 60;
	};
};