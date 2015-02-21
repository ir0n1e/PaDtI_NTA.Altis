
if (!(isClass(configFile/"CfgPatches"/"AGM_Interaction"))) exitwith {};
_this spawn {
	save = _this select 0;

	_actions = ["Weapons Load Menu", "Load"] call AGM_Interaction_fnc_prepareSelectMenu;

	if (save) then {
		_actions = ["Weapons Save Menu", "Save"] call AGM_Interaction_fnc_prepareSelectMenu;
	};

	for "_i" from 1 to 2 do {
		[[player, _i, "weaponinfo"], "NTA_fnc_inidb_readweapon", false, false] call bis_fnc_mp;
		sleep 1;
		{
			_actions = [
				_actions,
				 format ["Slot%1 - %2",_i, getText (ConfigFile >> "CfgWeapons" >> _x >> "displayname")],
				getText (ConfigFile >> "CfgWeapons" >> _x >> "picture"),
				[player, _i]
			] call AGM_Interaction_fnc_AddSelectableItem;

		} foreach (player getvariable format ["weaponinfo%1", _i]);
	};

	[
		_actions,
		{
			call AGM_Interaction_fnc_hideMenu;

			if(save) then {
				_this pushback primaryweapon player;
				_this pushback primaryWeaponItems player;
				[_this, "NTA_fnc_inidb_writeweapon", false, false] call bis_fnc_mp;
			} else {
				_this pushback "";
				[_this, "NTA_fnc_inidb_readweapon", false, false] call bis_fnc_mp;

			};

			for "_i" from 1 to 2 do {
				[[player, _i, "weaponinfo"], "NTA_fnc_inidb_readweapon", false, false] call bis_fnc_mp;
			};

			_this spawn {
				sleep 2;
				_string  = "<img size='4' color='#ffffff' image='pics\NTA_Logo_G.paa'/><br/><br/>";

				{
					_string = _string + format ["<t align='left'><img size='2' color='#ffffff' image='%1'/> %2<br/></t>", getText (ConfigFile >> "CfgWeapons" >> _x >> "picture"), getText (ConfigFile >> "CfgWeapons" >> _x >> "displayname")];

				 } foreach (player getvariable format ["weaponinfo%1", _this select 1]);

				if(save) then {
					_string = _string + format ["<br/><t size='1.5'>Slot%1 Saved</t>", _this select 1];
				} else {
					_string = _string + format ["<br/><t size='1.5'>Slot%1 Loaded</t>", _this select 1];

					_items = player getvariable format ["weaponinfo%1", _this select 1];
					player removeWeapon (primaryWeapon player);
					if ((_items select 0) != "") then {
						player addweapon (_items select 0);
					};

					removeAllPrimaryWeaponItems player;

					for "_m" from 1 to (count _items ) do {
						if ((_items select _m) != "") then {
							player addprimaryWeaponItem (_items select _m);
						};
					};
				};

				hintsilent parsetext _string;
			};
		},
		{
			call AGM_Interaction_fnc_hideMenu;
			if !(profileNamespace getVariable ["AGM_Interaction_AutoCloseMenu", false]) then {"Default" call AGM_Interaction_fnc_openMenu};
		}
	] call AGM_Interaction_fnc_openSelectMenu;
};