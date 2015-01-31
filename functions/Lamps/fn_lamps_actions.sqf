private ["_picture", "_id"];

_picture = "<img size='1.4' color='#ffffff' image='pics\NTA_Logo_G.paa'/> ";

//Runway Lamps
_id = player addAction[_picture + "<t color='#5FB404'>Runway Lamps on</t>",
	'[[true], "NTA_fnc_lamps_runwaySwitch", nil, true] call bis_fnc_mp',
	nil,
	-1,
	false,
	true,
	'',

	'!NTA_RunwayOn && {(player distance Generator <= 3) || {(driver vehicle player)==player && (vehicle player) in ([] call NTA_fnc_all_airunits)}} && {[] call NTA_fnc_core_nightTime || overcast > 0.7};'
];
//player setUserActionText [_id, _picture + "<t color='#5FB404'>Runway Lamps on</t>"];

player addAction[_picture + "<t color='#ff0000'>Runway Lamps off</t>",
	'[[false], "NTA_fnc_lamps_runwaySwitch", nil, true] call bis_fnc_mp',
	nil,
	-1,
	false,
	true,
	'',
	'NTA_RunwayOn && {(player distance Generator <= 3) || {(driver vehicle player)==player && (vehicle player) in ([] call NTA_fnc_all_airunits)}};'
];

//Gate Lamps
Player addAction[_picture + "<t color='#5FB404'>Gate Lamps on</t>",
	'[[nta_gateLamps, true],"NTA_fnc_lamps_LampSwitch",nil,true] call BIS_fnc_MP',
	nil,
	6,
	false,
	true,
	'',
	'!nta_gateLamps_on && {[] call NTA_fnc_core_nightTime || overcast > 0.7} && {(player distance Generator) <= 8 || (player distance Wache1) <= 3};'
];

Player addAction[_picture + "<t color='#ff0000'>Gate Lamps off</t>",
	'[[nta_gateLamps, false],"NTA_fnc_lamps_LampSwitch",nil,true] call BIS_fnc_MP',
	nil,
	6,
	false,
	true,
	'',
	'nta_gateLamps_on && {[] call NTA_fnc_core_nightTime || overcast > 0.7} && {(player distance Generator) <= 8 || (player distance Wache1) <= 3};'
];

// Street Lamps
Player addAction[_picture + "<t color='#5FB404'>Street Lamps on</t>",
	'[[nta_streetLamps, true],"NTA_fnc_lamps_LampSwitch",nil,true] call BIS_fnc_MP',
	nil,
	6,
	false,
	true,
	'',
	'!nta_streetLamps_on && {[] call NTA_fnc_core_nightTime || overcast > 0.7} && {(player distance Generator) <= 8 || (player distance Wache2) <= 3};'
];

Player addAction[_picture + "<t color='#ff0000'>Street Lamps off</t>",
	'[[nta_streetLamps, false],"NTA_fnc_lamps_LampSwitch",nil,true] call BIS_fnc_MP',
	nil,
	6,
	false,
	true,
	'',
	'nta_streetLamps_on && {[] call NTA_fnc_core_nightTime || overcast > 0.7} && {(player distance Generator) <= 8 || (player distance Wache2) <= 3};'
];
//Hangar
Player addAction[_picture + "<t color='#5FB404'>Hangar Lamps on</t>",
	'[[nta_HangarLamps, true],"NTA_fnc_lamps_LampSwitch",nil,true] call BIS_fnc_MP',
	nil,
	6,
	false,
	true,
	'',
	'!nta_HangarLamps_on && {[] call NTA_fnc_core_nightTime || overcast > 0.7} && {(player distance Generator) <= 8};'
];

Player addAction[_picture + "<t color='#ff0000'>Hangar Lamps off</t>",
	'[[nta_HangarLamps, false],"NTA_fnc_lamps_LampSwitch",nil,true] call BIS_fnc_MP',
	nil,
	6,
	false,
	true,
	'',
	'nta_HangarLamps_on && {[] call NTA_fnc_core_nightTime || overcast > 0.7} && {(player distance Generator) <= 8};'
];

//Shootingrange
Player addAction[_picture + "<t color='#5FB404'>Shootingrange Lamps on</t>",
	'[[nta_shootingLamps, true],"NTA_fnc_lamps_LampSwitch",nil,true] call BIS_fnc_MP',
	nil,
	6,
	false,
	true,
	'',
	'!nta_shootingLamps_on && {[] call NTA_fnc_core_nightTime || overcast > 0.7} && {(player distance Generator) <= 8 || (player distance Wache3) <= 3}'

];

Player addAction[_picture + "<t color='#ff0000'>Schootingrange Lamps off</t>",
	'[[nta_shootingLamps, false],"NTA_fnc_lamps_LampSwitch",nil,true] call BIS_fnc_MP',
	nil,
	6,
	false,
	true,
	'',
	'nta_shootingLamps_on && {[] call NTA_fnc_core_nightTime || overcast > 0.7} && {(player distance Generator) <= 8 || (player distance Wache3) <= 3}'
];

// All Lamps
Player addAction[_picture + "<t color='#5FB404'>All Lamps on</t>",
	'[[true],"NTA_fnc_lamps_LampSwitchAll",nil,true] spawn BIS_fnc_MP',
	nil,
	6,
	false,
	true,
	'',
	'(player distance Generator <= 8) && {[] call NTA_fnc_core_nightTime || overcast > 0.7}'
];

Player addAction[_picture + "<t color='#ff0000'>All Lamps off</t>",
	'[[false],"NTA_fnc_lamps_LampSwitchAll",nil,true] spawn BIS_fnc_MP',
	nil,
	6,
	false,
	true,
	'',
	'(player distance Generator <= 3)'
];
