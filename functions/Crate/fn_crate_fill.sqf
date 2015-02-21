private ["_pos", "_dir", "_fnc","_boxNew","_boxes", "_localBoxes"];

if (str player == "Zeus3") exitwith {};

waitUntil {!isnil "NTA_PALAYERBOXES" && {alive player}};

_box 	= call compile (player getvariable "Playerbox");
_boxes 	= [_box, player_box];
_fnc 	= call compile (_box getvariable "CrateFnc");

_localBoxes = [];

for "_i" from 0 to (count _boxes) - 1 do {

	_pos 	= position (_boxes select _i);
	_dir 	= getdir (_boxes select _i);
	_type 	= typeof (_boxes select _i);

	if (player getvariable ["haveBWA3", false] && {str (_boxes select _i) == "player_box"}) then {
		_type = "BWA3_Box_All_Net";
	};

	if (player getvariable "respawnBoxes" && {!local (_boxes select _i) || !isDedicated}) then {
		(_boxes select _i) hideObject true;
		_boxNew = _type createvehiclelocal [0,0,0];
		_boxNew allowdammage false;
		_boxNew setposATL [_pos select 0, _pos select 1, (_pos select 2) +0.5];
		_boxNew setdir _dir;

		if (isclass (configfile >> "CfgPatches" >> "AGM_Logistics")) then {
			[_boxNew] call AGM_Drag_fnc_makeUndraggable;
		};

		if (_i == 0) then {
			_boxNew call NTA_fnc_agm_WeaponsActions;
		};

		if !(player getvariable ["haveBWA3", false]) then {
			_boxNew addAction["<t color='#ff1111'>Arsenal Box</t>", "arsenalbox.sqf"];
		};

		_localBoxes pushback _boxNew;

		player setvariable ["LocalBoxes", _localBoxes, true];
	} else {
    	_boxNew = (player getvariable "LocalBoxes") select _i;
	};

	clearWeaponcargo _boxNew;
	clearMagazinecargo _boxNew;
	clearBackpackcargo _boxNew;
	clearItemcargo _boxNew;

	if (player getvariable ["haveBWA3", false]) then {
		_boxNew call _fnc;
	};

	[_boxNew, player] call NTA_fnc_crate_playervariables;
};

player setVariable ["respawnBoxes",false];
[] call NTA_fnc_houseicons;




/* old version
_boxes = [
	[ammo_at1,NTA_fnc_crate_at],
	[ammo_at2,NTA_fnc_crate_at],
	[ammo_at3,NTA_fnc_crate_at],
	[ammo_at4,NTA_fnc_crate_at],
	[ammo_auto1,NTA_fnc_crate_auto],
	[ammo_auto2,NTA_fnc_crate_auto],
	[ammo_auto3,NTA_fnc_crate_auto],
	[ammo_auto4,NTA_fnc_crate_auto],
	[ammo_auto5,NTA_fnc_crate_auto],
	[ammo_crew1,NTA_fnc_crate_crew],
	[ammo_crew2,NTA_fnc_crate_crew],
	[ammo_crew3,NTA_fnc_crate_crew],
	[ammo_crew4,NTA_fnc_crate_crew],
	[ammo_crew5,NTA_fnc_crate_crew],
	[ammo_engineer1,NTA_fnc_crate_engineer],
	[ammo_engineer2,NTA_fnc_crate_engineer],
	[ammo_engineer3,NTA_fnc_crate_engineer],
	[ammo_engineer4,NTA_fnc_crate_engineer],
	[ammo_engineer5,NTA_fnc_crate_engineer],
	[ammo_exp1,NTA_fnc_crate_exp],
	[ammo_gren1,NTA_fnc_crate_gren],
	[ammo_gren2,NTA_fnc_crate_gren],
	[ammo_gren3,NTA_fnc_crate_gren],
	[ammo_gren4,NTA_fnc_crate_gren],
	[ammo_gren5,NTA_fnc_crate_gren],
	[ammo_jtac1,NTA_fnc_crate_jtac],
	[ammo_jtac2,NTA_fnc_crate_jtac],
	[ammo_jtac3,NTA_fnc_crate_jtac],
	[ammo_leader1,NTA_fnc_crate_leader],
	[ammo_leader2,NTA_fnc_crate_leader],
	[ammo_leader3,NTA_fnc_crate_leader],
	[ammo_leader4,NTA_fnc_crate_leader],
	[ammo_leader5,NTA_fnc_crate_leader],
	[ammo_leader6,NTA_fnc_crate_leader],
	[ammo_medic1, NTA_fnc_crate_medic],
	[ammo_medic2, NTA_fnc_crate_medic],
	[ammo_medic3,NTA_fnc_crate_medic],
	[ammo_medic4,NTA_fnc_crate_medic],
	[ammo_sniper1,NTA_fnc_crate_sniper],
	[ammo_sniper2,NTA_fnc_crate_sniper]
];

*/






/*
_boxes_hash = [_boxes,0] call CBA_fnc_hashCreate;
_playerbox = call compile format ['
	_f = ([_boxes_hash, ammo_%1] call CBA_fnc_hashGet);
	[[ammo_%1,player_box], str _f] call fnc_reset_playerBox;
	[ammo_%1, %1] call NTA_fnc_houseicons',
	_player];
	*/




