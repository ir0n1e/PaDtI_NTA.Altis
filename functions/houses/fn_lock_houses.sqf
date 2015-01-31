scriptName	"NRF\functions\houses\fnc_lock_houses.sqf";
/*
	Author: Tom_48_97

	Description:
	Describe your function

	Parameter(s):
	#0 OBJECT - Description

	Returns:
	BOOL - TRUE when done
*/



private["_house", "_all"];

	_all = [_this, 0, false] call BIS_fnc_param;
	_house = [_this, 1] call BIS_fnc_param;


	if (_all) then {
		{
			_x setVariable ['bis_disabled_Door_1',1,true];
			_x animate ["Door_1_rot", 0];
		} foreach (call NTA_fnc_all_houses);
	} else {
		_house animate ["Door_1_rot", 0];
		//waitUntil {((time - _start) > 5)};
		_house setVariable ['bis_disabled_Door_1',1,true];
		(format ["%1: Tür geschlossen.",_house]) call NTA_fnc_note;
	};
