private ["_peeps", "_turrets"];

_peeps = [];
_turrets = allTurrets [_this, false];

{
	if (!isNull (_this turretUnit _x)) then {
		_peeps pushBack (_this turretUnit _x);
	};
} forEach _turrets;

_peeps;