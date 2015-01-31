
veh = nil;
publicVariable "veh";

if  ((getPlayerUID player) in ([] call NTA_fnc_players_id)) then {
	if ( (getPlayerUID player) != "1") then {
		player addAction["<t color='#5FB404'>Aufschließen</t>",{veh = cursortarget; call NTA_fnc_vehicles_unlock}, veh, 6, false, true, '','( cursorTarget getVariable "locked") and (alive cursorTarget) and (player distance cursorTarget <= 8) and str cursorTarget in ([] call NTA_fnc_all_vehicles)'];

		player addAction["<t color='#ff0000'>Abschließen</t>",{veh = cursortarget; call NTA_fnc_vehicles_lock}, veh, 6, false, true, '','not (cursorTarget getVariable "locked") and (player distance cursorTarget <= 8) and str cursorTarget in ([] call NTA_fnc_all_vehicles) and (count crew cursorTarget == 0)'];

		player addEventHandler ["Respawn", {veh = nil;
		publicVariable "veh";
			player addAction["<t color='#5FB404'>Aufschließen</t>",{veh = cursortarget; call NTA_fnc_vehicles_unlock}, veh, 6, false, true, '','( cursorTarget getVariable "locked") and (alive cursorTarget) and (player distance cursorTarget <= 8) and str cursorTarget in ([] call NTA_fnc_all_vehicles)'];

			player addAction["<t color='#ff0000'>Abschließen</t>",{veh = cursortarget; call NTA_fnc_vehicles_lock}, veh, 6, false, true, '','not (cursorTarget getVariable "locked") and (player distance cursorTarget <= 8) and str cursorTarget in ([] call NTA_fnc_all_vehicles) and (count crew cursorTarget == 0)'];
		}];
	} else {
		note = "haha geht nicht";
		player addAction["<t color='#5FB404'>Aufschließen</t>",{note call NTA_fnc_note}, [], 6, false, true, '','( cursorTarget getVariable "locked") and (alive cursorTarget) and (player distance cursorTarget <= 8) and str cursorTarget in ([] call NTA_fnc_all_vehicles)'];

		player addAction["<t color='#ff0000'>Abschließen</t>",{note call NTA_fnc_note}, [], 6, false, true, '','not (cursorTarget getVariable "locked") and (player distance cursorTarget <= 8) and str cursorTarget in ([] call NTA_fnc_all_vehicles) and (count crew cursorTarget == 0)'];

		player addEventHandler ["Respawn", {
			player addAction["<t color='#5FB404'>Aufschließen</t>",{note call NTA_fnc_note}, [], 6, false, true, '','(cursorTarget getVariable "locked") and (alive cursorTarget) and (player distance cursorTarget <= 8) and str cursorTarget in ([] call NTA_fnc_all_vehicles)'];

			player addAction["<t color='#ff0000'>Abschließen</t>",{note call NTA_fnc_note}, [], 6, false, true, '','not (cursorTarget getVariable "locked") and (player distance cursorTarget <= 5) and str cursorTarget in ([] call NTA_fnc_all_vehicles) and (count crew cursorTarget == 0)'];
		}];
	};
};
