private ["_player","_result","_vec"];
_player = _this;
_result = false;


{
	_vec = missionNamespace getvariable _x;
	if (_player in _vec) then {
		_result = true
	};
} foreach call NTA_fnc_all_vehicles;
_result
