private ["_mkr","_num","_obj","_grd","_mkrsiz","_mkrszx","_mkrszy","_mkrpos","_minx","_miny","_mkrdir",
         "_locs","_flatpt","_colr","_i","_ranx","_rany","_mrkr","_m","_stepx","_stepy","_newx","_newy"];

//Findflat function
_fnFindFlat = {

    private ["_pos2chec","_objsize","_maxigrad","_flatpt"];

    _pos2chec = _this select 0;
    _obj2plac = _this select 1;
    _maxigrad = _this select 2;
    //_pos2chec = getPos _obj2chec;
    _flatpt = (_pos2chec) isflatempty [(sizeof typeof _obj2plac) / 2,0,_maxigrad,(sizeof typeof _obj2plac),0,false,_obj2plac];
    //_flatpt = (_pos2chec) isflatempty [(_objsize) / 2,0,_maxigrad,(_objsize),0,false];
    _flatpt

};

_mkr = _this select 0;    //marker name
_num = _this select 1;    //an array with either one parameter for random points...or two parametrs for grid points
_obj = if (count _this >2) then {_this select 2};    //the object to find size of area needed
_grd = if (count _this >3) then {_this select 3};    //the allowable gradient of the point checked.. 0-1

_mkrsiz = markersize _mkr;

_mkrszx = _mkrsiz select 0;
_mkrszy = _mkrsiz select 1;

_mkrpos = getmarkerpos _mkr;

_minx =  0 - (_mkrszx/2);
_miny =  0 - (_mkrszy/2);

_mkrdir    = (markerDir _mkr) * -1;
_mkrdir    = _mkrdir mod 360;

_locs = [];

_flatpt =[0,0,0];
_colr = "colorYELLOW";

//one parameter supplied...therefore do x random points
if ((count _num) ==1) then {

    _cnt = _num select 0;

    //for [{_i=0},{_i<_cnt},{_i=_i+1}] do {
    for "_i" from 0 to (_cnt-1) do {

        //random x,y around zero
        _ranx = _minx + random _mkrszx;
        _rany = _miny + random _mkrszy;

        //rotate it
        _newx = 2 * ((_ranx * cos(_mkrdir)) - (_rany * sin(_mkrdir)));
        _newy = 2 * ((_ranx * sin(_mkrdir)) + (_rany * cos(_mkrdir)));

        //add it to map coords
        _newx = (_mkrpos select 0) + (_newx);
        _newy = (_mkrpos select 1) + (_newy);

        if (count _this >2) then {
            _flatpt = [[_newx,_newy],_obj,_grd] call _fnFindFlat;
            _colr = "colorRED";
        };

        if ((not surfaceiswater [_newx,_newy]) and (count _flatpt >0)) then {

            //_locs = _locs + [[_newx,_newy]];
            _locs set [count _locs,[_newx,_newy]];

            /*
            _mrkr = format ["mkr_%1_%2", diag_ticktime,_i];

            _m = createMarkerLocal [_mrkr, [_newx,_newy]];
            _m setMarkerShape "ICON";
            _m setMarkerColorLocal _colr;
            _m setMarkerTypeLocal "mil_dot";
            _m setMarkerSizeLocal [1, 1];
            _m setMarkerAlphaLocal 0.2;
            */
        };

        //hint format ["_i: %1",_i];
    };
};

//two parameters supplied...therefore do [stepx,stepy] grid
if ((count _num) ==2) then {

    _stepx = (_mkrszx/(_num select 0));
    _stepy = (_mkrszy/(_num select 1));

    for [{_i=_minx},{_i<=(_minx+_mkrszx)},{_i=_i+_stepx}] do {

        for [{_j=_miny},{_j<=(_miny+_mkrszy)},{_j=_j+_stepy}] do {

            //rotate it
            _newx = 2 * ((_i * cos(_mkrdir)) - (_j * sin(_mkrdir)));
            _newy = 2 * ((_i * sin(_mkrdir)) + (_j * cos(_mkrdir)));

            //add it to map coords
            _newx = (_mkrpos select 0) + (_newx);
            _newy = (_mkrpos select 1) + (_newy);

            if (count _this >2) then {
                _flatpt = [[_newx,_newy],_obj,_grd] call _fnFindFlat;
                _colr = "colorRED";
            };

            if ((not surfaceiswater [_newx,_newy]) and (count _flatpt >0)) then {

                //_locs = _locs + [[_newx,_newy]];
                _locs set [count _locs,[_newx,_newy]];

/*
                _mrkr = format ["mkr_%1", diag_ticktime];

                _m = createMarkerLocal [_mrkr, [_newx,_newy]];
                _m setMarkerShape "ICON";
                _m setMarkerColorLocal _colr;
                _m setMarkerTypeLocal "mil_dot";
                _m setMarkerSizeLocal [1, 1];
                _m setMarkerAlphaLocal 0.2;
*/
            };

            //hint format ["_i,_j: %1,%2",_i,_j];

         };
    };
};

_locs