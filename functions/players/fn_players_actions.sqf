
call NTA_fnc_lamps_actions;

if (("NRF_Training" call bis_fnc_getParamValue) > 0) then {
	player addAction["<t color='#5FB404'>Third Person view</t>",
		{ [player,"OUT"] call NTA_fnc_vehiclecamera},nil,6,false,true,'',"(player call NTA_fnc_playerinvehicle) and (player getvariable 'NTA_campos_internal')"];

	player addAction["<t color='#5FB404'>First Person view</t>",
		{ [player,"IN"] call NTA_fnc_vehiclecamera},nil,6,false,true,'',"(player call NTA_fnc_playerinvehicle) and not (player getvariable 'NTA_campos_internal')"];
	};

/*


if (("NTA_EVENT" call bis_fnc_getParamValue) == 0) then {
// Lock
player addAction["<t color='#5FB404'>Unlock</t>",
	{veh=cursorTarget; call NTA_fnc_vehicles_unlock},
	veh,
	6,
	false,
	true,
	'',
	'( cursorTarget getVariable "locked") and {alive cursorTarget} and {player distance cursorTarget <= 8} and {str cursorTarget in ([] call NTA_fnc_all_vehicles)} and {[cursortarget] call NTA_fnc_BWplus_checkVehicleRights} and {[cursortarget] call NTA_fnc_core_checkVehicleRights}'];

		player addAction["<t color='#ff0000'>Lock</t>",{veh=cursorTarget; call NTA_fnc_vehicles_lock}, veh, 6, false, true, '','not (cursorTarget getVariable "locked") and {player distance cursorTarget <= 8} and {str cursorTarget in ([] call NTA_fnc_all_vehicles)} and {[cursortarget] call NTA_fnc_BWplus_checkVehicleRights} and {[cursortarget] call NTA_fnc_core_checkVehicleRights} && {count crew cursorTarget == 0}'];
};


*/



