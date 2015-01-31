/*if (!(isClass(configFile/"CfgPatches"/"AGM_Interaction"))) exitwith {};
_this spawn {


	_actions = ["Player List", "Info >>"] call AGM_Interaction_fnc_prepareSelectMenu;
	[["", "read"], "NTA_fnc_NTAusers", false, false] call bis_fnc_mp;
	sleep 1;


	{
		_picture = "PictureThing";
		if (count squadParams (_x  select 0 )> 0) then {
			_picture = (squadParams _x select 0) select 4;
		};
		_unitName = _x select 0;
			_actions = [
				_actions,
				format ["%1 %2 Online: %3", _x select 0, _x select 1, ({_unitName == (name _x)} count playableUnits > 0)],
				_picture,
				""
			] call AGM_Interaction_fnc_AddSelectableItem;

	} foreach NTA_idlist;

	[
		_actions,
		{
			call AGM_Interaction_fnc_hideMenu;
			if !(profileNamespace getVariable ["AGM_Interaction_AutoCloseMenu", false]) then {"Default" call AGM_Interaction_fnc_openMenu};
		},
		{
			call AGM_Interaction_fnc_hideMenu;
			[] call NTA_fnc_agm_openadminmenu;
			//if !(profileNamespace getVariable ["AGM_Interaction_AutoCloseMenu", false]) then {"Default" call AGM_Interaction_fnc_openMenu};
		}
	] call AGM_Interaction_fnc_openSelectMenu;
};
*/