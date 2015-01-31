private ["_time", "_grp"];

_unit = _this select 0;
_grp = group _unit;



{
	if (!isnil "_x") then {
		deletevehicle vehicle _x;
		deleteVehicle _x;
	};
} foreach (units _grp);

if (!isnil "_unit") then {
	deletevehicle _unit;
};
deleteGroup _grp;