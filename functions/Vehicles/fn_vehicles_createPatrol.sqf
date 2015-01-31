private ["_pos", "_radius", "_unit", "_newPos", "_units", "_grp", "_dir"];
_pos 	= _this select 0;
_radius = _this select 1;
_units  = [];

_grp = createGroup EAST;
_newPos = [_pos , _radius, random 360 ] call BIS_fnc_relPos;
_grp = [ _newPos, EAST, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam")] call BIS_fnc_spawnGroup;

{
	_units pushback _x;
} foreach (units _grp);

_dir = 0;

for "_i" from 0 to 9 do {
    _newpos = [_pos, _radius, _dir ] call BIS_fnc_relPos;
    [_grp, '', _newpos, "LIMITED", "MOVE", "SAFE"] call NTA_fnc_vehicles_addwaypoint;
    _dir = _dir + 36;
};

 _newpos = [_Pos, _radius, _dir ] call BIS_fnc_relPos;
[_grp, '', _newpos, "LIMITED", "CYCLE"] call NTA_fnc_vehicles_addwaypoint;

_units