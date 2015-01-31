if (!(isClass(configFile/"CfgPatches"/"AGM_Interaction"))) exitwith {};
private ["_vec", "_actions", "_tickets", "_picture"];

_actions = ["Player List", "Info >>"] call AGM_Interaction_fnc_prepareSelectMenu;

{
	_picture = "PictureThing";
	if (count squadParams _x > 0) then {
		_picture = (squadParams _x select 0) select 4;
	};

		_actions = [
			_actions,
			format ["%1 %2 %3 %4", name _x, getplayeruid _x, getplayeruid _x in call nta_fnc_players_id],
			_picture,
			_x
		] call AGM_Interaction_fnc_AddSelectableItem;

} foreach playableunits;

[
	_actions,
	{
		call AGM_Interaction_fnc_hideMenu;
		_this call NTA_fnc_agm_openplayermenu;
	},
	{
		call AGM_Interaction_fnc_hideMenu;
		[] call NTA_fnc_agm_openadminmenu;
		//if !(profileNamespace getVariable ["AGM_Interaction_AutoCloseMenu", false]) then {"Default" call AGM_Interaction_fnc_openMenu};
	}
] call AGM_Interaction_fnc_openSelectMenu;