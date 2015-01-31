scriptName "fnc_players_id";
/*
	Author: Ir0n1E

	Description:
	Returns player ids

	Parameter(s):
	none

	Returns:
	Array
*/

private "_players";
//NTA_idlist = [];
[["", "read"], "NTA_fnc_inidb_NTAusers", false, false] spawn bis_fnc_mp;


_players = [];

_players + NTA_idlist + NTA_TMPplayers
