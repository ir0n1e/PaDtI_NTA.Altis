if (!(isClass(configFile/"CfgPatches"/"AGM_Interaction"))) exitwith {};
private ["_actions", "_array"];

NTA_player = _this;
_actions = [format ["%1 %2", name _this, getplayeruid _this], "Do it"] call AGM_Interaction_fnc_prepareSelectMenu;

_array = [name NTA_player, NTA_player, format ["Shooted at Base: %1", NTA_player getvariable ["shootingatbase", false]],  "Add to TMP NTA Players", /*"Copy to Clipboard", not working in mp*/ "KICK"];

if (getplayeruid player in call NTA_fnc_players_id && {name player == "nic" || name player == "drei.zehn"}) then {
	_array pushback "(!!)Add to NTA Players(!!)";
	_array pushback "(!!)Remove from NTA Players(!!)";

};


{
	_actions = [
		_actions,
		_x,
		"",
		_x
	] call AGM_Interaction_fnc_AddSelectableItem;
} foreach _array;

[
	_actions,
	{
		call AGM_Interaction_fnc_hideMenu;
		switch (_this) do {
		    case "Add to TMP NTA Players": {
		    	NTA_TMPplayers pushback  (getplayeruid NTA_Player);
		    	publicvariable "NTA_TMPplayers";
		    };
		    case "(!!)Add to NTA Players(!!)": {
		    	[[NTA_player, "write"], "NTA_fnc_inidb_NTAusers", false, false] call bis_fnc_mp;
		    };
		    case "(!!)Remove from NTA Players(!!)": {
		    	[[NTA_player, "remove"], "NTA_fnc_inidb_NTAusers", false, false] call bis_fnc_mp;
		    };

		    case "KICK": {
		    	[name NTA_Player, "{serverCommand format['#kick %1', _this]}"] call AGM_Core_fnc_execRemoteFnc;
		    };
		    case "Copy to Clipboard": {
		    	copyToClipboard format ["%1 %2 %3", name NTA_Player, NTA_Player, (getplayeruid NTA_Player)];
			};
		};
	},
	{
		call AGM_Interaction_fnc_hideMenu;
		[] call NTA_fnc_agm_openplayerlist;
		//if !(profileNamespace getVariable ["AGM_Interaction_AutoCloseMenu", false]) then {"Default" call AGM_Interaction_fnc_openMenu};
	}
] call AGM_Interaction_fnc_openSelectMenu;