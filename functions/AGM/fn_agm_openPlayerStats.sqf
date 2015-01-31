if (!(isClass(configFile/"CfgPatches"/"AGM_Interaction"))) exitwith {};

private ["_actions", "_array", "_picture", "_displayname", "_items"];

[[player, "death"], "NTA_fnc_inidb_readPlayerStats", false, false] call bis_fnc_mp;
[[player, "weaponstats"], "NTA_fnc_inidb_readPlayerStats",false, false] call bis_fnc_mp;

_actions = [format ["Statistics %1 DeathCount: %2", name player, player getvariable "death"], "Exit"] call AGM_Interaction_fnc_prepareSelectMenu;

	{
		_actions = [
			_actions,
			 format [getText (ConfigFile >> "CfgWeapons" >> (_x select 0) >> "displayname") + " Used: %1",(_x select 1)],
			 getText (ConfigFile >> "CfgWeapons" >> (_x select 0) >> "picture"),
			""
		] call AGM_Interaction_fnc_AddSelectableItem;

	} foreach (player getvariable "WeaponsUsed");

[
	_actions,
	{
		call AGM_Interaction_fnc_hideMenu;
		if !(profileNamespace getVariable ["AGM_Interaction_AutoCloseMenu", false]) then {"Default" call AGM_Interaction_fnc_openMenu};
	},
	{
		call AGM_Interaction_fnc_hideMenu;
		if !(profileNamespace getVariable ["AGM_Interaction_AutoCloseMenu", false]) then {"Default" call AGM_Interaction_fnc_openMenu};
	}
] call AGM_Interaction_fnc_openSelectMenu;