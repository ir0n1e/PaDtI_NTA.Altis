private ["_lamps", "_switchOn"];

_switchOn 	= _this select 0;
_lamps 	= [
	nta_hangarLamps,
	nta_streetLamps,
	nta_gateLamps,
	nta_shootingLamps
];

{
	[_x, _switchOn] call NTA_fnc_lamps_LampSwitch;

} foreach _lamps;

[_switchOn] call NTA_fnc_lamps_runwaySwitch;