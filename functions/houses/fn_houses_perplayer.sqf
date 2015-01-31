
private ["_houses_hash", "_houses_players","_houses","_players","_player"];

_player = _this select 0;
_houses = call NTA_fnc_all_houses;
_players = call NTA_fnc_allplayers;

_houses_players = [
	[_players select 7, _houses select 0],
	[_players select 8, _houses select 0],

	[_players select 15, _houses select 1],
	[_players select 0, _houses select 1],

	[_players select 12, _houses select 2],
	[_players select 13, _houses select 2],

	[_players select 16, _houses select 3],
	[_players select 11, _houses select 3],

	[_players select 2, _houses select 4],
	[_players select 1, _houses select 4],

	[_players select 4, _houses select 5],
	[_players select 14, _houses select 5],

	[_players select 9, _houses select 6],
	[_players select 3, _houses select 6],

	[_players select 17, _houses select 7],
	[_players select 10, _houses select 7],

	[_players select 19, _houses select 8],
	[_players select 18, _houses select 8],

	[_players select 5, _houses select 9],
	[_players select 6, _houses select 9],

	[_players select 20, _houses select 10],
	[_players select 21, _houses select 10]


];

_houses_hash = [_houses_players, 0] call CBA_fnc_hashCreate;

[_houses_hash, str(_player)] call CBA_fnc_hashGet;
