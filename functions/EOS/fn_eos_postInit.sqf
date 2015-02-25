private "_trigger";

EOS_active_fnc = {
	private ["_settings", "_trig", "_mkr", "_mPos", "_pos", "_dir"];
	_settings 	= server getvariable ["EOS_ACTIVE_SETTINGS", []];
	_trig 		= _settings select 0;
	_mkr 		= _settings select 1;
	_mPos 		= _settings select 2;

	{
		if ( _x != _mkr && {MarkerAlpha _x != 0 || {getmarkercolor _mkr != VictoryColor} || {MarkerAlpha _x != 0.0001}}) then {
			_x setmarkerAlpha 0.0001;
		};
	} foreach (server getvariable ["EOSmarkers", []]);

	_pos = [_mPos, [1000, 3000], 10, 0] call PO3_fnc_getSafePos;
	_dir = [_mPos, _pos] call BIS_fnc_dirTo;

	if (floor (random 3) == 0) then {
		[[_Pos select 0, _Pos select 1, 0], _dir] execvm "test\arty.sqf";
	};

	//airpatrol
	[_mpos, _trig] spawn {
		_mpos 		= _this select 0;
		_trig 		= _this select 1;
		_time 		= time;
		_mission	= [NTA_fnc_missions_compFuel, NTA_fnc_missions_compCommand] call NTA_fnc_getRandArrayPos;
		waituntil {time >= (_time + 120) || {!triggeractivated _trig} || {{_x distance _mpos < 350} count playableunits > 0}};

		if (!triggeractivated _trig) exitwith {};


		if ((({_x distance _mpos < 500} count playableunits) > 0) && {!(_trig getvariable ["SideMissionActive", false])}) then {
			_objects = [[_mPos select 0, _mPos select 1, 0]] call _mission;
			_trig setvariable ["SideMissionActive", true, true];
			_trig setvariable ["missionObjects", _objects, true];
		};

		if (({_x distance _mpos < 350} count playableunits) > 0) then {
			{
				if (_x distance _mpos < 350) exitwith {
					_x call NTA_fnc_airpatrol_callRandom;
				};
			} count playableunits;
		};
	};
};

EOS_nonactive_fnc = {
	private ["_settings", "_trig", "_mkr", "_mPos"];
	_settings 	= server getvariable ["EOS_ACTIVE_SETTINGS", []];
	if (count _settings <= 0) exitWith {};

	_trig 		= _settings select 0;
	_mkr 		= _settings select 1;
	_mPos 		= _settings select 2;

	{
		str (MarkerAlpha _x) call nta_fnc_log;
		if (getmarkercolor _x != VictoryColor && {MarkerAlpha _x == 0.0001}) then {
			_x setmarkerAlpha (_trig getVariable "EOSmarkerColor" select 0);
		};
	} foreach (server getvariable ["EOSmarkers", []]);
};

publicVariable "EOS_nonactive_fnc";
_trigger = createTrigger ["EmptyDetector", getpos server];
_trigger setTriggerActivation ["ANY", "PRESENT", true];
_trigger setTriggerStatements ["EOS_ACTIVE", "call EOS_active_fnc", "call EOS_nonactive_fnc"];