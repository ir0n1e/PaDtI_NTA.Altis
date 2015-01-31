if (local player) then {
	NTA_DEBUG = true;
	_this spawn {

		_mkr1 = createMarkerLocal ["dbgmkr1",getmarkerpos "debug1"];
		_mkr2 = createMarkerLocal ["dbgmkr2",getmarkerpos "debug2"];
		_mkr3 = createMarkerLocal ["dbgmkr3",getmarkerpos "debug3"];

		{
			_mkrpl = createMarkerLocal ["dbgmkrpl",getposASL _x];
			_mkrpl setmarkercolorlocal "ColorRed";
			_mkrpl setMarkerShapelocal "ICON";
			_mkrpl setMarkerTypeLocal "hd_dot";
			[_x, _mkrpl] spawn {
				_p = _this select 0;
				_m = _this select 1;
				_t = time;
				while {alive _p && time < _t + 60} do {
					_m setMarkertextlocal format ["%1 Dammage: %2 Shooted at Base: %3" , name _p, getdammage _p, _p getvariable ["shootingatbase", false]];
					_m setmarkerposlocal [((getposASL _p) select 0) + 10, ((getposASL _p) select 1) + 10, 0];
					sleep 1;
				};
				deletemarkerlocal _m;
			};
		} foreach playableunits;

		{
			_x setmarkercolorlocal "ColorRed";
			_x setMarkerShapelocal "ICON";
			_x setMarkerTypeLocal "hd_dot";
		 } foreach [_mkr1, _mkr2, _mkr3];
		_time = time;

		NTA_Airpatrol_Debug = true;
		DebugCos = true;

		{
			[call compile format ["%1",_x]] call NTA_fnc_vehicles_info;
		} foreach call NTA_fnc_all_vehicles;


		_mkr1 setMarkertextlocal format ["All Players: %1", count playableunits];
		_mkr2 setMarkertextlocal format ["All Units: %1", count allunits];
		_mkr3 setMarkertextlocal format ["Tickets: %1 Active: %2", NTA_Tickets, NTA_TicketsActive];


		waituntil {!alive player || time >= _time + 60};


		{
			deletemarkerlocal _x;
		} foreach [_mkr1, _mkr2, _mkr3];
		NTA_Airpatrol_Debug = false;
		DebugCos = false;
		NTA_DEBUG = false;
	};
};