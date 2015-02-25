private ["_return", "_grp", "_veh", "_player"];
_player = _this select 0;
_return = false;
_grp 	= NTA_airpatrolCache getvariable["NTA_Airpatrol_Group_West", grpnull];
_veh 	= vehicle (leader _grp);
_target = _veh getvariable ["Airpatrol_Target", []];

if (!alive _veh || {(_veh getvariable "airpatrol_mission") == "MovingHome"} || {leader (group _player) != _player}) exitwith {_return};

if ((_player distance _target) < 800)  then {
	_return = true;
};

_return
