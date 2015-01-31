if (!(isClass(configFile/"CfgPatches"/"AGM_Interaction"))) exitwith {};
private ["_vec", "_actions", "_tickets"];

_actions = ["Vehicle List", "Info >>"] call AGM_Interaction_fnc_prepareSelectMenu;

{
	_vec_format = format ["NTA_%1",_x];


		_vec = call compile format ["typeof %1",_x];

		_tickets = call compile format ["%1 getvariable ['nta_tickets', 0]", _x];
		_actions = [
			_actions,
			format [getText (ConfigFile >> "CfgVehicles" >> _vec >> "displayName") + " (%1) %2",  _x, _tickets],
			getText (ConfigFile >> "CfgVehicles" >> _vec >> "picture"),
			[call compile format ["%1", _x], getText (ConfigFile >> "CfgVehicles" >> _vec >> "displayName")]
		] call AGM_Interaction_fnc_AddSelectableItem;

} foreach (call NTA_fnc_all_vehicles);

[
	_actions,
	{
		call AGM_Interaction_fnc_hideMenu;
		_this call NTA_fnc_agmopenvehiclesinfo;
	},
	{
		call AGM_Interaction_fnc_hideMenu;
		if !(profileNamespace getVariable ["AGM_Interaction_AutoCloseMenu", false]) then {"Default" call AGM_Interaction_fnc_openMenu};
	}
] call AGM_Interaction_fnc_openSelectMenu;