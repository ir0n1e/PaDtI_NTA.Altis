
	if (isClass(configFile/"CfgPatches"/"AGM_Interaction")) then {
		/*
		NTA_Airpatrol_MoveGroupHome = ["AIRPATROL RTB", {call NTA_fnc_airpatrol_movehomeCondition}, {call NTA_fnc_airpatrol_movegrouphome}, false] call AGM_Interaction_fnc_addInteractionSelf;

		NTA_Airpatrol_callCAS = ["Call CAS", {call NTA_fnc_airpatrol_callCAScondition},
		{[[[28713.2, 27432.7, 0], [1637.84, 13848.8, 0], getpos (_this select 1), [(NTA_airpatrolCache getvariable "NTA_Airpatrol_CASunit_West")], WEST], "NTA_fnc_airpatrol_Create"] call BIS_fnc_mp;["AP CAS",-(NTA_airpatrolCache getvariable "NTA_Airpatrol_CAStickets_WEST")] call NTA_fnc_core_addTickets;}, false] call AGM_Interaction_fnc_addInteractionSelf;
		*/
	} else {
		player addAction["<t color='#5FB404'>Airpatrol RTB</t>",
				{call NTA_fnc_airpatrol_movegrouphome}, nil, 6, false, true, '', "call NTA_fnc_airpatrol_movehomeCondition"];
	};
