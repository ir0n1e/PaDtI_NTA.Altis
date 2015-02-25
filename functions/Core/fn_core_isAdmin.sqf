private ["_return", "_player"];

_player = _this select 0;
_return = false;


if(!isMultiplayer || {serverCommandAvailable "#kick" && getPlayerUID _player in call NTA_fnc_players_id}) then {
	_return = true;
};

_return