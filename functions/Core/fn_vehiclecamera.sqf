private ["_player","_campos"];

_player = _this select 0;
_campos = _this select 1;

if (_campos == "IN") then {

	_player setVariable ["NTA_Campos_internal",true,true];
	vehicle _player switchCamera "INTERNAL";

	[-1,{hint parseText format["<t size='2' color='#ffff00'>%1<br/>Innenansicht</t>",name player];}] call CBA_fnc_globalExecute;
};
if (_campos == "OUT") then {
	[-1,{hint parseText format["<t size='2' color='#ffff00'>%1<br/>Außenansicht</t>",name player];}] call CBA_fnc_globalExecute;
	_player setVariable ["NTA_Campos_internal",false,true];
	vehicle _player switchCamera "EXTERNAL";



};
