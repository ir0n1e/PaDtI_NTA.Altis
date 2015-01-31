if ((count allunits - count playableUnits) > EOShardlimit ) exitwith {};
_this spawn {
	_eosActive 		= _this;
	_confArray 		= _eosActive getvariable ["confArray", []];

	_mAH			= _eosActive getVariable "EOSmarkerColor" select 0;
	_mAN			= _eosActive getVariable "EOSmarkerColor" select 0;

	_mkr			= (_confArray select 0);
	_mkr			= (_confArray select 0);
	_mPos			= markerpos(_confArray select 0);
	_mkrX			= getMarkerSize _mkr select 0;
	_mkrY			= getMarkerSize _mkr select 1;
	_mkrAgl			= markerDir _mkr;
	_infantry		= (_confArray select 1);
	_PApatrols		= _infantry select 0;
	_PAgroupSize	= _infantry select 1;
	_LVeh			= (_confArray select 2);
	_LVehGroups		= _LVeh select 0;
	_LVgroupSize	= _LVeh select 1;
	_AVeh			= (_confArray select 3);
	_AVehGroups		= _AVeh select 0;
	_SVeh			= (_confArray select 4);
	_CHGroups		= _SVeh select 0;
	_fSize			= _SVeh select 1;
	_basSettings	= (_confArray select 6);
	_pause			= _basSettings select 0;
	_waves			= _basSettings select 1;
	_timeout		= _basSettings select 2;
	_eosZone		= _basSettings select 3;
	_hints			= _basSettings select 4;
	_settings		= _confArray select 5;
	_side			= _settings select 2;
	_faction		= _settings select 0;
	_mA	     		= _settings select 1;

	_initialLaunch	= if (count _confArray > 7) then {_confArray select 7} else {false};
	_maindir		= if (count _confArray > 8) then {_confArray select 8} else {random 360};
	popEOS = false;
	publicVariable "popEOS";

	_mkr setmarkercolor bastionColor;
	_mkr setmarkeralpha _mAH;

	_markerstr = createMarker [str _mkr, _mPos];
	_markerstr setMarkerShape "ICON";
	str _mkr setMarkerType "MIL_DOT";
	str _mkr setMarkerColor "ColorBlack";
	_txt = format ["AO %1", _mkr];
	str _mkr setMarkertext _txt;



	EOS_ACTIVE = true;
	publicVariable "EOS_ACTIVE";

	if (triggeractivated _eosActive && {_pause > 0 and !_initialLaunch} && {!(_eosActive getVariable ["eosactive", false])}) then {
		_eosActive setVariable ["eosactive", true, true];
		for "_counter" from 1 to _pause do {

			if (_hints) then  {
				_text = format ["%2 - Attack ETA : %1 Direction: %3", (_pause - _counter), _txt, _mainDir];

				str _mkr setMarkertext _text;
			};
			sleep 1;
		};
	};
	str _mkr setMarkertext _txt;
	if (triggeractivated _eosActive) then {
		_eosActive call NTA_fnc_eos_bastionSpawn;

		if (_hints) then  {
			["Reinforcements inbound","NTA_fnc_note", true, false] call BIS_fnc_MP;
		};
	} else {
		EOS_ACTIVE = false;
		publicVariable "EOS_ACTIVE";
	};


	while {_waves > 0 && triggeractivated _eosActive} do {

		for "_counter" from 1 to _timeout do {

			if (_hints) then  {
				_text = format ["%2 - Next wave ETA : %1",(_timeout - _counter), _txt];
				str _mkr setMarkertext _text;
			};

			sleep 1;
		};
		str _mkr setMarkertext _txt;
		_waves = (_waves - 1);
		if (triggeractivated _eosActive) then {
			_eosActive call NTA_fnc_eos_bastionSpawn;

			if (_hints) then  {
				["Reinforcements inbound","NTA_fnc_note", true, false] call BIS_fnc_MP;
			};

			//airpatrol
			_mpos spawn {
				waituntil {!(isNil "_this")};
				_time = time;

				waituntil {time >= (_time + 5)};
				if (({_x distance _this < 350} count playableunits) > 0) then {
					{
						if (_x distance _this < 350) exitwith {
							_x call NTA_fnc_airpatrol_callRandom;
						};
					} count playableunits;
				};
			};
		} else {
			_waves = 0;
		};
	};


	_allunits = _eosActive getvariable ["allunits", []];

	waituntil {({alive _x} count _allunits < 5) || {!triggeractivated _eosActive}};

	if (!triggeractivated _eosActive || {getmarkercolor _mkr == "colorblack"}) exitwith {
		["Zone lost. You must re-capture it", "NTA_fnc_hint", true, false] call BIS_fnc_MP;

		EOS_ACTIVE = false;
		publicVariable "EOS_ACTIVE";
		if (_eosZone) then {
			//wait for delete
			sleep 5;
			_mkr setmarkercolor hostileColor;
			_mkr setmarkeralpha _mAN;
			deletemarker str _mkr;
			_dCon = "thisTrigger call NTA_fnc_eos_delete";
			_actCond = "{vehicle _x in thisList && isplayer _x && ((getPosATL _x) select 2) < 15} count playableunits > 0 && {(PO3_TASK__POS distance thistrigger) > 1000}";
			_eosActive setTriggerTimeout [20, 15, 20, true];
			_eosActive setTriggerStatements [_actCond, "thisTrigger call NTA_fnc_eos_spawn", _dCon];

			_eosActive setvariable ["confArray", [_mkr,[_PApatrols,_PAgroupSize],[_PApatrols,_PAgroupSize],[_LVehGroups,_LVgroupSize],[_AVehGroups,0,0,0],[_faction, _mA, 800, _side]], true];
			_eosActive setvariable ["Groups", [[], [], [], [], [], []], true];
    		_eosActive setvariable ["allunits", [], true];
    		_eosActive setVariable ["eosactive", false, true];

		};
	};

	if ({alive _x} count _allunits < 5) then {
		_eosActive setvariable ['eosclear', true, true];
		_mkr setmarkercolor VictoryColor;
		_mkr setmarkerAlpha _mAN;
		deletemarker str _mkr;
		EOS_ACTIVE = false;
		publicVariable "EOS_ACTIVE";
	};
};