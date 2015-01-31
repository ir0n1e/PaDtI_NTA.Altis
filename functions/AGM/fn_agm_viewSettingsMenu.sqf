if (!(isClass(configFile/"CfgPatches"/"AGM_Interaction"))) exitwith {};

_actions = [format ["Settings ViewDistance %1", viewdistance], "Do it >>"] call AGM_Interaction_fnc_prepareSelectMenu;

{
	_actions = [
		_actions,
		format ["Tarrain %1", _x],
		"",
		_x
	] call AGM_Interaction_fnc_AddSelectableItem;
} foreach ["Normal", "High", "VeryHigh", "Ultra"];

[
	_actions,
	{
		call AGM_Interaction_fnc_hideMenu;
		switch (_this) do {
		    case "Normal": {
		    	setTerrainGrid 25;
		    	[[player, 25, viewdistance, true], "NTA_fnc_inidb_viewSettings", false, false] call bis_fnc_mp;
		    };
		    case "High": {
		    	setTerrainGrid 12.5;
		    	[[player, 12.5, viewdistance, true], "NTA_fnc_inidb_viewSettings", false, false] call bis_fnc_mp;
		    };
		    case "VeryHigh": {
		    	setTerrainGrid 6.25;
		    	[[player, 6.25, viewdistance, true], "NTA_fnc_inidb_viewSettings", false, false] call bis_fnc_mp;
			};
			case "Ultra": {
		    	setTerrainGrid 3.125;
		    	[[player, 3.125, viewdistance, true], "NTA_fnc_inidb_viewSettings", false, false] call bis_fnc_mp;
			};
		};
		hint parseText format ["<img size='4' color='#ffffff' image='pics\NTA_Logo_G.paa'/><br/><br/><t size='1.5'>Tarrain: %1 ViewDistance: %2 Saved</t><t size='1.6' color='#ffff00'><br/><br/>Will be loaded at next reconnect!</t>", _this, viewdistance];
	},
	{
		call AGM_Interaction_fnc_hideMenu;
		if !(profileNamespace getVariable ["AGM_Interaction_AutoCloseMenu", false]) then {"Default" call AGM_Interaction_fnc_openMenu};
	}
] call AGM_Interaction_fnc_openSelectMenu;
