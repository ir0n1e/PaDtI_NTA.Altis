private "_unit";
_unit = _this select 0;


{
	if (str _x == "Zeus1" || {isserver}) then {
		_x addCuratorEditableObjects [[_unit], true];
	} else {
		if (_unit in playableunits || {str _unit in call NTA_fnc_all_vehicles}) then {
			_x addCuratorEditableObjects [[_unit], true];
		};
	};
} foreach allCurators;


{
	_x addEventHandler ["CuratorGroupPlaced", {[_this,"NTA_fnc_grpPlaced",false] spawn BIS_fnc_MP}];
    _x addEventHandler ["CuratorObjectPlaced", {[_this,"NTA_fnc_objPlaced",false] spawn BIS_fnc_MP}];
} forEach allCurators;