private ["_grp", "_skillArray", "_skillset","_unit", "_skillvalue"];

_grp 		= (_this select 0);
_skillArray = (_this select 1);

_skillset = server getvariable _skillArray;

{
	_unit = _x;
	if (!isNil "asr_ai3_sysaiskill_fnc_setUnitSkill") then {
		[_unit] call asr_ai3_sysaiskill_fnc_setUnitSkill;
	} else {
		{
			_skillvalue = (_skillset select _forEachIndex) + (random 0.2) - (random 0.2);
			_unit setSkill [_x,_skillvalue];
		} forEach ['aimingAccuracy','aimingShake','aimingSpeed','spotDistance','spotTime','courage','reloadSpeed','commanding','general'];
	};
} forEach (units _grp);