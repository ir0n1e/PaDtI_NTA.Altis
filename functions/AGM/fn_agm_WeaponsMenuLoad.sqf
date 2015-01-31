if (!(isClass(configFile/"CfgPatches"/"AGM_Interaction"))) exitwith {};
if (!isServer) exitwith {};
private ["_actions","_count", "_player"];
_player = _this;
_actions = ["Weapons Load Menu", "Load"] call AGM_Interaction_fnc_prepareSelectMenu;


for "_i" from 1 to 2 do {
	_actions = [
		_actions,
		format ["Slot%1 - %2", _i, ([_player, _i, "name"] call NTA_fnc_inidb_readweapon)],
		[_player, _i, "picture"] call NTA_fnc_inidb_readweapon,
		_i
	] call AGM_Interaction_fnc_AddSelectableItem;
};

[
	_actions,
	{
		call AGM_Interaction_fnc_hideMenu;
		[_this, _i] call NTA_fnc_inidb_readweapon;
	},
	{
		call AGM_Interaction_fnc_hideMenu;
		if !(profileNamespace getVariable ["AGM_Interaction_AutoCloseMenu", false]) then {"Default" call AGM_Interaction_fnc_openMenu};
	}
] call AGM_Interaction_fnc_openSelectMenu;