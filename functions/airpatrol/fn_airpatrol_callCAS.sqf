#define TIMEOUT 	30*60
#define DELETETIME 	10*60
#define TICKETS 	80

_this spawn {
	while {NTA_Airpatrolrunning} do {
		_time = time;

		waituntil {time >= (_time + TIMEOUT) && {!(NTA_airpatrolCache getvariable["NTA_Airpatrol_CAS_West", false])} && {!(NTA_airpatrolCache getvariable ["NTA_Airpatrol_Serverside_WEST", false])}};

		if (floor(random 3) == 0) then {
			_unit 		= NTA_Airpatrol_WEST call NTA_fnc_getRandarrayPos;

			_vehname 	= getText ( configFile >> "CfgVehicles" >> _unit  >> "displayName");
			_picture 	= format ["<img size='3' color='#ffffff' image='%1'/>", getText (configfile >> "CfgVehicles" >> _unit >> "picture")];
			NTA_airpatrolCache setvariable ["NTA_Airpatrol_CASonline_WEST", true, true];
			NTA_airpatrolCache setvariable ["NTA_Airpatrol_CASunit_WEST", _unit, true];
			NTA_airpatrolCache setvariable ["NTA_Airpatrol_CAStickets_WEST", TICKETS, true];


			[parseText format[localize "STR_NTA_AP_CASwest",_vehname, _picture, (DELETETIME / 60), TICKETS], "hint",true] call bis_fnc_mp;
			_time = time;
			waituntil {(NTA_airpatrolCache getvariable["NTA_Airpatrol_CAS_West", false]) || {time >= (_time + DELETETIME)}};
			if (NTA_airpatrolCache getvariable ["NTA_Airpatrol_CASonline_WEST", false]) then {
				NTA_airpatrolCache setvariable ["NTA_Airpatrol_CASonline_WEST", false, true];
				[parseText localize "STR_NTA_AP_CASwestCanceled", "hint"] call bis_fnc_mp;
			};
		};
	};
};