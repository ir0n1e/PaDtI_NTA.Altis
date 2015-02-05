if (!isserver) exitwith {};

0 spawn {
	_date = date;
	PO3_force_TASKEND = true;
	publicVariable "PO3_force_TASKEND";

	[[date select 0, date select 1, date select 2, 23, 0],"NTA_fnc_setDate",true,false] spawn BIS_fnc_MP;
	_briefing 	= format [localize "STR_NTA_Missions_Dam", date, 100];

	[parseText _briefing, "hint"] call bis_fnc_mp;
	["DestroyDam", "Destroy Dam", _briefing] call SHK_Taskmaster_add;

 	[[9121.4,13742.2,1], 1.2, "Land_nav_pier_m_F", 5, 39, 0, 0] call NTA_fnc_missions_DamCreate;


	sleep 5;

	waituntil {sleep 5; DamActive && {!alive DamVent}};
	call NTA_fnc_missions_damExp;

	["DestroyDam", "succeeded"] call SHK_Taskmaster_upd;
	["TaskDam", 100] call NTA_fnc_core_addTickets;
	_houses	= server getvariable ["DamHouses", []];
	if (({alive _x} count _houses) == 0) then {
		["TaskDam", 60] call NTA_fnc_core_addTickets;
	};


	waituntil {({_x distance damtrigger > 500} count playableunits) > 0 };

	{
		deletevehicle _x;
	} foreach ((server getvariable "DamUnits") + (server getvariable "DamObjects"));

	deleteVehicle DamTrigger;
	DAMACTIVE = false;
	publicVariable "EOS_ACTIVE";
	[_date, "NTA_fnc_setDate", true, false] spawn BIS_fnc_MP;
};