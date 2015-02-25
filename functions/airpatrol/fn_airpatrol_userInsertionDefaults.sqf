private "_player";

_player = _this select 0;

_player setvariable [format ["insert%1", group _player], []];
_player setvariable [format ["ParaDrop%1", group _player], false];
_player setvariable [format ["ParaJumpHeight%1", group _player], 0];
_player setvariable ["Airpatrol_ParaChute", NTA_airpatrol_Parachute, true];

[_player] call NTA_fnc_airpatrol_agmOpenInsertMenu;
