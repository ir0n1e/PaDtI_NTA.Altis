private ["_player", "_house"];


	_player = [_this, 0,player] call BIS_fnc_param;
	house = [_player] call NTA_fnc_houses_perplayer;

if (isServer) then {
    doortr = createTrigger ["EmptyDetector", getmarkerpos "Base"];
    publicVariable "doortr";
};

if (!isDedicated) then {
    waitUntil {!isNil "doortr"};
    doortr triggerAttachVehicle [player];
    doortr setTriggerStatements [
        "player distance house < 2.3",
        "[false,house] call NTA_fnc_unlock_houses",
        "[false,house] call NTA_fnc_lock_houses"
        ];

    diag_log  format ["CREATE_DOORTRIGGER player: %1 trigger: %2 house: %3 player_str: %4",_player, doortr,house,_player];

};