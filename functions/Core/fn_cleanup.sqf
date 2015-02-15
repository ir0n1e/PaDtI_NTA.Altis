/*
if (_this in playableUnits) exitwith {};
_this addEventHandler ["killed",{
	(_this select 0) spawn {
		sleep (5*60);
		_time = time;

		waitUntil {sleep 10; !({_x distance _this > 500} count playableUnits == 0) || {time >= (_time + (10*60))}};

		if (!(_this getvariable ["NTA_Airpatrol_Crash", false]) && {!alive _this } && {!(_this in call NTA_fnc_all_vehicles)}) then {
			deletevehicle _this;
		};
	};
}];
*/

_this spawn {

	while {true} do {
		sleep (2*60);

		{
			_unit = _x;

			if (!(_unit getvariable ["NTA_Airpatrol_Crash", false]) && {!alive _unit} && {!(_unit in call NTA_fnc_all_vehicles)} && {{_x distance _unit < 500} count playableUnits == 0}) then {
				deletevehicle _unit;
			};
		} foreach vehicles + allunits;
	};
};
