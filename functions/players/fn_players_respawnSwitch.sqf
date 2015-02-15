_this spawn {

	_player = _this select 0;
	_gear	= _this select 1;
	waitUntil {alive _player};
	if (_player distance (getmarkerpos "respawn_west_4") <= 5) exitwith {
		[_player, _gear] spawn NTA_fnc_players_loadGear;
	};

	if (_player distance (getmarkerpos "respawn_west_3") <= 5) exitwith {
		[_player, _gear] spawn NTA_fnc_players_loadGearSmall;
	};

	_player call NTA_fnc_standardItems_player;
};
