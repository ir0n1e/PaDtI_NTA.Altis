private "_return";
_return = false;

{
	if (getPlayerUID (leader (group _x)) in call NTA_fnc_players_id && {NTA_airpatrolCache getvariable ["NTA_Airpatrol_CASonline_WEST", false]} && {leader (group _x) == player}) then {
		_return = true;
	};
} foreach playableunits;

_return