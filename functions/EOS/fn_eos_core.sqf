private ["_HPpatrols","_HPgroupProbability","_CHgroupArray","_LVgroupArray","_HPgroupArray","_PAgroupArray","_CHgroupSize","_CHGroups","_SVehGroups","_AVgroupSize","_AVehGroups","_LVehGroups","_LVgroupSize","_PAgroupSize","_PApatrols","_HPpatrols","_HPgroupSize", "_actCond", "_maN", "_maH", "_mA", "_dcon", "_eosActive","_counter"];


_JIPmkr			= (_this select 0);
_HouseInfantry	= (_this select 1);
_HPpatrols		= _HouseInfantry select 0;
_HPgroupSize	= _HouseInfantry select 1;
_HPgroupProbability = if (count _HouseInfantry > 2) then {_HouseInfantry select 2} else {100};
	//diag_log str _JIPmkr;
_infantry		= (_this select 2);
_PApatrols		= _infantry select 0;
_PAgroupSize	= _infantry select 1;
_PAgroupProbability = if (count _infantry > 2) then {_infantry select 2} else {100};

_LVeh 			= (_this select 3);
_LVehGroups		= _LVeh select 0;
_LVgroupSize	= _LVeh select 1;
_LVgroupProbability = if (count _LVeh > 2) then {_LVeh select 2} else {100};

_AVgrp			= (_this select 4);
_AVehGroups		= _AVgrp select 0;
_AVgroupProbability = if (count _AVgrp > 1) then {_AVgrp select 1} else {100};

_SVgrp 			= (_this select 5);
_SVehGroups		= _SVgrp select 0;
_SVgroupProbability = if (count _SVgrp > 1) then {_SVgrp select 1} else {100};

_CHGrp			= (_this select 6);
_CHGroups		= _CHGrp select 0;
_CHgroupSize	= _CHGrp select 1;
_CHgroupProbability = if (count _CHGrp > 2) then {_CHGrp select 2} else {100};

_settings 		= (_this select 7);
_heightLimit 	= if (count _settings > 4) then {_settings select 4} else {false};
_heightLimit	= true;




if (_HPgroupProbability > floor random 100) then {
	switch (_HPgroupSize) do {
	    case 0: {
	    	_HPgroupArray = [1,1];
	    };
	    case 1: {
	    	_HPgroupArray = [2,4];
	    };
	    case 2: {
	    	_HPgroupArray = [4,8];
	    };
	    case 3: {
	    	_HPgroupArray = [8,12];
	    };
	    case 4: {
	    	_HPgroupArray = [12,16];
	    };
	    case 5: {
	    	_HPgroupArray = [16,20];
	    };
	};
} else {
	_HPpatrols 		= 0;
	_HPgroupArray	= [1,1];
};

if (_PAgroupProbability > floor random 100) then {
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
} else {
	_PApatrols 		= 0;
	_PAgroupArray	= [1,1];
};


if (_LVgroupProbability > floor random 100) then {
	switch (_LVgroupSize) do {
	    case 0: {
	    	_LVgroupArray = [0,0];
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
} else {
	_LVehGroups		= 0;
	_LVgroupArray	= [0,0];
};

if (_CHgroupProbability > floor random 100) then {
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
} else {
	_CHGroups		= 0;
	_CHgroupArray	= [0,0];
};

if !(_AVgroupProbability > floor random 100) then {
	_AVehGroups = 0;
};

if !(_SVgroupProbability > floor random 100) then {
	_SVehGroups = 0;
};

_eosMarkers = server getvariable ["EOSmarkers", []];

_counter = 0;
{


	if (floor (random 3) != 0 || {EOScounter >= EOSmax}) then {
		if (!(getmarkercolor _x == VictoryColor)) then {
			_x setmarkercolor hostileColor;
			_x setMarkerBrush "Border";
			_x setmarkerAlpha 0;
		};
	} else {
		EOScounter = EOScounter + 1;
		_eosMarkers pushback _x;

		_mkrX	    = getMarkerSize _x select 0;
		_mkrY	    = getMarkerSize _x select 1;
		_mkrAgl	    = markerDir _x;
		_distance   = _settings select 2;
		_mA			= _settings select 1;
		_side	    = _settings select 3;
		_trig 		= format ["EOSTrigger%1", _x];

		_dCon = "thisTrigger call NTA_fnc_eos_delete";

		if (_heightLimit) then {
			_actCond = "{vehicle _x in thisList && isplayer _x && ((getPosATL _x) select 2) < 15} count playableunits > 0 && {(PO3_TASK__POS distance thistrigger) > 1000}";
		} else {
			_actCond = "{vehicle _x in thisList && isplayer _x} count playableunits > 0 && {(PO3_TASK__POS distance thistrigger) > 1000}";
		};

		_eosActive = createTrigger ["EmptyDetector", getmarkerpos _x];
		_eosActive setTriggerArea [(_distance + _mkrX), (_distance + _mkrY), _mkrAgl, FALSE];
		_eosActive setTriggerActivation ["ANY", "PRESENT", true];
		_eosActive setTriggerTimeout [10, 15, 20, true];
		_eosActive setTriggerStatements [_actCond, "thisTrigger call NTA_fnc_eos_spawn", _dCon];

		server setvariable [_trig, _eosActive, true];
		_eosActive setvariable ["Groups", [[], [], [], [], [], []], true];
	    _eosActive setvariable ["allunits", [], true];
	    _eosActive setvariable ["missionActive", false, true];
		_eosActive setVariable ["confArray", [_x,[_HPpatrols,_HPgroupArray],[_PApatrols,_PAgroupArray],[_LVehGroups,_LVgroupArray],[_AVehGroups,_SVehGroups,_CHGroups,_CHgroupArray],_settings], true];

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
			_x setmarkercolor hostileColor;
			_x setmarkerAlpha (_eosActive getVariable "EOSmarkerColor" select 0);
			_x setMarkerBrush "Border";
		};
	};
} foreach _JIPmkr;

server setvariable ["EOSmarkers", _eosMarkers, true];
