//returns winter nighttime
private "_return";

_return = false;

if ((date select 3) > 17 || {(date select 3) < 6}) then {
	_return = true;
};

_return