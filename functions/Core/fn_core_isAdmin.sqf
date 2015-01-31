private["_return"];

_return = false;

if(!isMultiplayer || {serverCommandAvailable "#kick" && getPlayerUID player in call NTA_fnc_players_id}) then {
	_return = true;
};

_return