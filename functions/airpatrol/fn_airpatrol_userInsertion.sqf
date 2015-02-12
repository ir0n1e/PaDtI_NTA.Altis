
_this spawn {
	_player 		= _this select 1;
	_chopper 		= _this select 0;
	_apusers		= (_this select 2);
	_choppercount 	= count (_player getvariable format ["insert%1", group _player]);
	_seats 			= getNumber (configfile >> "CfgVehicles" >> _chopper >> "transportsoldier") * _chopperCount;
	_tickets 		= ((_seats - count _apusers) * 10) + (_choppercount * 20);

	sleep 2;

	openMap true;
	Airpatrol_Jump_mapclick = false;
	Airpatrol_angel_mapclick = false;


	onMapSingleClick {
		Airpatrol_Jump_clickpos = _pos;
		Airpatrol_Jump_mapclick = true;
		onMapSingleClick '';
		true;
	};

	waitUntil {Airpatrol_Jump_mapclick or !(visiblemap)};
	if (!visibleMap) exitwith {
		"User Insertion Canceled!" call NTA_fnc_note;
		breakOut "main";
	};

	if (Airpatrol_Jump_mapclick) then {
		_mkr_halo = createmarker ["mkr_halo", Airpatrol_Jump_Clickpos];
		"mkr_halo" setMarkerTypeLocal "hd_dot";
		"mkr_halo" setMarkerColorLocal "ColorGreen";
		"mkr_halo" setMarkerTextLocal "LZ";
	};

	onMapSingleClick {
		Airpatrol_angel_clickpos = _pos;
		Airpatrol_angel_mapclick = true;
		onMapSingleClick '';
		true;
	};

	waitUntil {Airpatrol_angel_mapclick or !(visiblemap)};

	if (!visibleMap) exitwith {
		"User Insertion Canceled!" call NTA_fnc_note;
		breakOut "main";
	};

	if (Airpatrol_angel_mapclick) then {
		_mkr_angel = createmarker ["mkr_angel", Airpatrol_Angel_Clickpos];
		"mkr_angel" setMarkerTypeLocal "hd_dot";
		"mkr_angel" setMarkerColorLocal "ColorGreen";
		"mkr_angel" setMarkerTextLocal "Dir";
	};

	_dir = [Airpatrol_Jump_clickpos, Airpatrol_angel_clickpos] call BIS_fnc_dirTo;
	"mkr_halo" setMarkerTextLocal str _dir;

	sleep 2;
	deletemarker "mkr_halo";
	deletemarker "mkr_angel";
	openMap false;

	{
		if (isplayer _x && {!NTA_airpatrol_DEBUG}) then {
			["", "NTA_fnc_airpatrol_UserInsertCam", _x, false] call bis_fnc_mp;
		};
	} foreach _apusers;


	["AP User", -(_tickets)] call NTA_fnc_core_addTickets;

	if !( _player getVariable [format ["ParaDrop%1", group _player], false]) then {
		[[[Airpatrol_Jump_clickpos, 3500, _dir] call BIS_fnc_relPos, [1637.84, 13848.8, 0], Airpatrol_Jump_clickpos, [_chopper], side _player, _player], "NTA_fnc_airpatrol_Create", false, false] call bis_fnc_mp;
	} else {
		_height = NTA_airpatrolParaMinHeight + (_player getvariable [format ["ParaJumpHeight%1", (group _player)], 0]);
		[[[Airpatrol_Jump_clickpos, 8000, _dir] call BIS_fnc_relPos, [1637.84, 13848.8, 0], Airpatrol_Jump_clickpos, [_chopper], side _player, _player, [_height, 2, 20, 0]], "nta_fnc_airpatrol_create", false, false] call bis_fnc_mp;
	};
};
