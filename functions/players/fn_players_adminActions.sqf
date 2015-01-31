if (!(isClass(configFile/"CfgPatches"/"AGM_Interaction"))) exitwith {};
_time = diag_ticktime;


[NTA_Admin_Board, "Vehicle List", 10, {true}, {[_this select 1] call NTA_fnc_agmopenvehicleslist;}, false] call AGM_Interaction_fnc_addInteraction;



if (!NTA_PUBLIC) exitwith {};

	[NTA_Admin_Board, "Task Menu", 10, { !isnil "PO3_missions" && {(getPlayerUID player) in (call NTA_fnc_players_id)}}, {[]call NTA_fnc_agmopentaskmenu}, false] call AGM_Interaction_fnc_addInteraction;


format ["AGM Actions %1 sec Completed...", (diag_ticktime - _time)] call NTA_fnc_log;