
_this spawn {
	_player 	= _this select 1;
	_chopper 	= _this select 0;
	_apusers	= (_this select 2);
	_choppercount = count (_player getvariable format ["insert%1", group _player]);

	_seats = getNumber (configfile >> "CfgVehicles" >> _chopper >> "transportsoldier") * _chopperCount;

	_tickets = ((_seats - count _apusers) * 10) + (_choppercount * 20);

	//if (true) exitwith {systemchat str _tickets};


	sleep 2;

	openMap true;
	ATM_Jump_mapclick = false;
	ATM_angel_mapclick = false;


	onMapSingleClick {
			ATM_Jump_clickpos = _pos;
			ATM_Jump_mapclick = true;
			onMapSingleClick '';
			true;
		};


	//onMapSingleClick "ATM_Jump_clickpos = _pos; ATM_Jump_mapclick = true; onMapSingleClick ''; true;";
	waitUntil {ATM_Jump_mapclick or !(visiblemap)};
	if (!visibleMap) exitwith {
		"User Insertion Canceled!" call NTA_fnc_note;
		breakOut "main";
	};
	//_posA = ATM_Jump_clickpos;
	if (ATM_Jump_mapclick) then {
		_mkr_halo = createmarker ["mkr_halo", ATM_Jump_Clickpos];
		"mkr_halo" setMarkerTypeLocal "hd_dot";
		"mkr_halo" setMarkerColorLocal "ColorGreen";
		"mkr_halo" setMarkerTextLocal "LZ";
	};

	onMapSingleClick {
		ATM_angel_clickpos = _pos;
		ATM_angel_mapclick = true;
		onMapSingleClick '';
		true;
	};

	waitUntil {ATM_angel_mapclick or !(visiblemap)};
	if (!visibleMap) exitwith {
		"User Insertion Canceled!" call NTA_fnc_note;
		breakOut "main";
	};
	//_posB = ATM_angel_clickpos;
	if (ATM_angel_mapclick) then {
		_mkr_angel = createmarker ["mkr_angel", ATM_Angel_Clickpos];
		"mkr_angel" setMarkerTypeLocal "hd_dot";
		"mkr_angel" setMarkerColorLocal "ColorGreen";
		"mkr_angel" setMarkerTextLocal "Dir";
	};

	_dir = [ATM_Jump_clickpos, ATM_angel_clickpos] call BIS_fnc_dirTo;
	"mkr_halo" setMarkerTextLocal str _dir;

	sleep 2;
	deletemarker "mkr_halo";
	deletemarker "mkr_angel";
	openMap false;

	{
		if (isplayer _x) then {
			["", "NTA_fnc_airpatrol_UserInsertCam", _x, false] call bis_fnc_mp;
		};
	} foreach _apusers;


	["AP User", -(_tickets)] call NTA_fnc_core_addTickets;

	[[[ATM_Jump_clickpos, 3500, _dir] call BIS_fnc_relPos, [1637.84, 13848.8, 0], ATM_Jump_clickpos, [_chopper], side _player, true, _player], "NTA_fnc_airpatrol_Create", false, false] call bis_fnc_mp;
};
