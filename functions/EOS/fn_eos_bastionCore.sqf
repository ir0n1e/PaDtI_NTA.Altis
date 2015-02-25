private ["_CHgroupArray","_LVgroupArray","_PAgroupArray","_CHGroups","_AVehGroups","_LVehGroups","_PApatrols", "_time","_actCond","_dcon", "_eosmarkers", "_eosActive","_counter"];



_JIPmkr			= (_this select 0);
_infantry		= (_this select 1);
_PApatrols		= _infantry select 0;
_PAgroupSize	= _infantry select 1;
_LVeh			= (_this select 2);
_LVehGroups		= _LVeh select 0;
_LVgroupSize	= _LVeh select 1;
_AVeh			= (_this select 3);
_AVehGroups		= _AVeh select 0;
_SVeh			= (_this select 4);
_CHGroups		= _SVeh select 0;
_CHgroupSize	= _SVeh select 1;
_settings		= (_this select 5);
_basSettings	= (_this select 6);
	//diag_log str _JIPmkr;



switch (_LVgroupSize) do {
    case 0: {
    	_LVgroupArray = [1,1];
    };
    case 1: {
    	_LVgroupArray = [2,4];
    };
    case 2: {
    	_LVgroupArray = [4,8];
    };
    case 3: {
    	_LVgroupArray = [8,12];
    };
    case 4: {
    	_LVgroupArray = [12,16];
    };
    case 5: {
    	_LVgroupArray = [16,20];
    };
};

switch (_PAgroupSize) do {
    case 0: {
    	_PAgroupArray = [1,1];
    };
    case 1: {
    	_PAgroupArray = [2,4];
    };
    case 2: {
    	_PAgroupArray = [4,8];
    };
    case 3: {
    	_PAgroupArray = [8,12];
    };
    case 4: {
    	_PAgroupArray = [12,16];
    };
    case 5: {
    	_PAgroupArray = [16,20];
    };
};

switch (_CHgroupSize) do {
    case 0: {
    	_CHgroupArray = [0,0];
    };
    case 1: {
    	_CHgroupArray = [2,4];
    };
    case 2: {
    	_CHgroupArray = [4,8];
    };
    case 3: {
    	_CHgroupArray = [8,12];
    };
    case 4: {
    	_CHgroupArray = [12,16];
    };
    case 5: {
    	_CHgroupArray = [16,20];
    };
};

_counter = 0;
_eosMarkers = server getvariable ["EOSmarkers", []];
{


    if (floor (random 3) != 0 || {BOScounter >= BOSmax}) then {
        if (!(getmarkercolor _x == VictoryColor)) then {
           _x setmarkercolor bastionColor;
            _x setMarkerBrush "Border";
            _x setmarkerAlpha 0;
        };
    } else {
        BOScounter = BOScounter + 1;
        _eosMarkers pushback _x;


    	_mkrX	    = getMarkerSize _x select 0;
    	_mkrY	    = getMarkerSize _x select 1;
    	_mkrAgl	    = markerDir _x;
    	_mA			= _settings select 1;
    	_side	    = _settings select 3;
    	_trig 		= format ["EOSTrigger%1", _x];





    	_dCon = "thisTrigger call NTA_fnc_eos_delete";


    	_actCond = "{vehicle _x in thisList && isplayer _x && ((getPosATL _x) select 2) < 15} count playableunits > 0 && {(PO3_TASK__POS distance thistrigger) > 1000}";


    	_eosActive = createTrigger ["EmptyDetector", getmarkerpos _x];
    	_eosActive setTriggerArea [_mkrX, _mkrY, _mkrAgl, FALSE];
    	_eosActive setTriggerActivation ["WEST", "PRESENT", true];
    	_eosActive setTriggerTimeout [3, 3, 5, true];
    	_eosActive setTriggerStatements [_actCond, "thisTrigger call NTA_fnc_eos_bastionLoop", _dCon];


    	server setvariable [_trig, _eosActive, true];

        _eosActive setvariable ["Groups", [[], [], [], [], [], []], true];
        _eosActive setvariable ["allunits", [], true];
        _eosActive setVariable ["confArray", [_x,[_PApatrols,_PAgroupArray],[_LVehGroups,_LVgroupArray],[_AVehGroups],[_CHGroups,_CHgroupArray],_settings,_basSettings], true];

        switch (_side) do {
            case EAST: {
                _eosActive setVariable ["EOSfaction",["east", false], true];
            };
            case WEST: {
                _eosActive setVariable ["EOSfaction",["west", false], true];
            };
            default {
                _eosActive setVariable ["EOSfaction",["", false],true];
            };
        };

        switch (_mA) do {
            case 0: {
                _eosActive setVariable ["EOSmarkerColor",[1, 0.3], true];
            };
            case 1: {
                _eosActive setVariable ["EOSmarkerColor",[0, 0], true];
            };
            case 2: {
                _eosActive setVariable ["EOSmarkerColor",[0.000, 0], true];
            };
        };

        if (!(getmarkercolor _x == VictoryColor)) then {
            _x setmarkercolor bastionColor;
            _x setmarkerAlpha (_eosActive getVariable "EOSmarkerColor" select 0);
            _x setMarkerBrush "Border";
        };
    };
} foreach _JIPmkr;

server setvariable ["EOSmarkers", _eosMarkers, true];