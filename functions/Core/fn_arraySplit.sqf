/*
	Author: Ir0n1E

	Description:
	Describe your function

	Parameter(s):
	#0 ARRAY - Array to split
	#1 SCALAR - Times to split

	Returns:
	ARRAY

	EXAMPLE:

	[["foo", "bar", "baz"],2] call function;
	return = [["foo", "bar"]["baz"]];
*/

private ["_array", "_times", "_count", "_return", "_i", "_o"];
_array = _this select 0;
_times = _this select 1;

_count = round (count _array / _times);

_return = [];

for "_i" from 0 to (_times - 1)  do {
	_return pushback [];
};

_i = 0;
_o = 0;
{
	if (_i <= _count) then {
		(_return select _o) pushback _x;
		_i = _i + 1;
		if (_i == _count) then {
			_i = 0;
			_o = _o + 1;
		};
	};
} foreach _array;

_return