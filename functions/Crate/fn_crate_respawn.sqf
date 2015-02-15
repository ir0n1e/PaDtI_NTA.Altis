
private ["_player","_strp"];

_player = [_this, 0, player] call BIS_fnc_param;

_strp = str(player);

if (_strp == "engineer1" or _strp == "engineer2" or _strp == "engineer3" or _strp == "engineer4" or _strp == "exp1") then {
	_player setvariable ["AGM_IsEngineer", true,true];
};
if (_strp == "crew1" or _strp == "crew2" or _strp == "crew3" or _strp == "crew4" or _strp == "crew5") then {
	_player setVariable ["AGM_GForceCoef", 0.75];
};

[_player] call NTA_fnc_crate_fill;
