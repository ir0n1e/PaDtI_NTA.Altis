

	private ["_house", "_all"];

	_all = [_this, 0,false] call BIS_fnc_param;
	_house = [_this, 1] call BIS_fnc_param;

	if (_all) then {
		{
			_x setVariable ['bis_disabled_Door_1',0,true];
			systemChat format ["%1 open",_x];
		} forEach (call NTA_fnc_all_houses);
	} else {

	_house setVariable ['bis_disabled_Door_1',0,true];
	(format ["%1: Tür offen.",_house]) call NTA_fnc_note;
	};