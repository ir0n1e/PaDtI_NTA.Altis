private ["_return", "_grp", "_veh"];
_return = false;
_grp 	= NTA_airpatrolCache getvariable["NTA_Airpatrol_Group_West", grpnull];
_veh 	= vehicle (leader _grp);
_target = _veh getvariable ["Airpatrol_Target", []];

if (!alive _veh || {(_veh getvariable "airpatrol_mission") == "MovingHome"}) exitwith {_return};
{
	if ( getPlayerUID (leader (group _x)) in call NTA_fnc_players_id && {(leader (group _x) distance _target) < 800} && {leader (group _x) == player})  then {
		_return = true;
	};
} foreach playableunits;

_return