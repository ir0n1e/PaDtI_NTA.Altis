if (local player) then {
	_this spawn {
		_veh 	= _this select 0;
		_hint 	= _this select 1;

		if (isnil "_veh") exitwith {
			hintsilent "Unknown Vehicle!";
		};

		if (!alive _veh) exitwith {
			hintsilent "Vehicle is not alive!";
		};

		_dammage 	= getdammage _veh;
		_distance 	= _veh distance Server;
		_pos 		= getposASL _veh;
		_vehname 	= getText ( configFile >> "CfgVehicles" >> typeof _veh >> "displayName");
		_picture 	= format ["<img size='3' color='#ffffff' image='%1'/>", getText (configfile >> "CfgVehicles" >> typeof _veh >> "picture")];
		_nearplayer = [_pos, 250, playableunits] call NTA_fnc_core_findnearestobject;

		if ( str _nearplayer != "<NULL-object>") then {
			_nearplayer = name _nearplayer;
		} else {
			_nearplayer = "None";
		};

		_pos2 = _pos;
	    if ((_pos distance getmarkerpos "b1") < 300) then {
	    	_pos2 = "Molos Basis";
	    };

	    if ((_pos distance getmarkerpos "b2") < 150) then {
	     	_pos2 = "Höhe 46";
	    };


		if (!isnil "_hint") then {
			hintsilent parsetext format ["<t align='center' size='2.2'>%1</t><br/><t size='1.5' color='#b60000'>%2</t><br/>____________________<br/>%3<br/><br/><t size='1.2'>Distance: %4<br/>Position: %5<br/>Dammage: %6<br/>Nearest Player: %7<br/>Locked: %8<br/>Tickets %9</t>", _veh, _vehname, _picture, _distance, _pos2, _dammage, _nearplayer, _veh getvariable ["locked", false], _veh getvariable ["nta_tickets", 0] ];
			//[_veh, 20] execvm "test.sqf";
		};

		_time 	= time;
		_mkr 	= createMarkerLocal [format ["dbgmkr%1", _veh], getposASL _veh];
		_mkr setMarkerShapelocal "ICON";
		_mkr setMarkerTypeLocal "hd_dot";

		while {!alive _veh || {time <= (_time + 20)}} do {
			_txt = format ["%1 %2 Nearest Player: %3", _veh, getText ( configFile >> "CfgVehicles" >> typeof _veh >> "displayName"), _nearplayer];
			_mkr setmarkerposLocal (getposASL _veh);
			_mkr setmarkertextlocal _txt;

		};

		deletemarkerlocal _mkr;

		if (!isnil "_hint") then {
			hintsilent "";
		};
	};
};