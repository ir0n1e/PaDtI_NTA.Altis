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