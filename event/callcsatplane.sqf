private ["_csat_plane_type","_csatplane_wp","_wp","_target","_count"];

_target = [_this, 0,AIRFIELD_BombMarkers select (floor(random(count AIRFIELD_BombMarkers)))] call bis_fnc_param;
_counter = [_this,1,[3]] call bis_fnc_param;

_csatplane_type = "O_Plane_CAS_02_F";
_csatplane_wp = [[24354,1346,100],[20993.764,7201.9443,0],[13508,27886,0],[21981,28740,0]];
_startPos = _csatplane_wp select 0;

_spawnDistance = 150;
_spawnHeight = 1200;
_spawnPos = [_startPos select 0, _startPos select 1, _spawnHeight];



            _csatplane0 = [_csatplane_type, ([_spawnPos, _spawnDistance, (200 - 90)] call BIS_fnc_relPos),200,EAST] call NTA_fnc_vehicles_create;
            waituntil {alive _csatplane0};

            _spawnPos = getpos _csatplane0;
             _csatplane1 = [_csatplane_type, ([_spawnPos, _spawnDistance, (200 - 90)] call BIS_fnc_relPos),200,EAST] call NTA_fnc_vehicles_create;

{
    _wp = [group _x,'',_startPos, "FULL", "MOVE", "CARELESS", "BLUE", ['true','{_x flyInHeight 50} forEach thislist ;']] call NTA_fnc_vehicles_addwaypoint;

    _wp = [group _x,'',(getMarkerPos _target), "FULL", "MOVE", "CARELESS", "BLUE"] call NTA_fnc_vehicles_addwaypoint;
    _x flyinheight 50;


_wp = [group _x,'',(_csatplane_wp select 2),'FULL','MOVE','CARELESS','BLUE',['true','{[_x] call NTA_fnc_vehicles_delete} forEach thislist']]  call NTA_fnc_vehicles_addwaypoint;
    [_x,_target, _counter] spawn{
        _p = _this select 0;
        _t = _this select 1;
        _c = _this select 2;
        waituntil {(_p distance (getmarkerpos _t) < 350)};
        [_t, _c] spawn AIRFIELD_Bombs;
    };

} foreach [_csatplane0,_csatplane1];


