private "_return, _player";
_player = _this select 0;
_return = false;

if (NTA_airpatrolCache getvariable ["NTA_Airpatrol_CASonline_WEST", false] && {leader (group _player) == _player}) then {
	_return = true;
};

_return