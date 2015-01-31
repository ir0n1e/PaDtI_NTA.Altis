// INFANTRY SKILL
_InfskillSet = [
0.25,        // aimingAccuracy
0.45,        // aimingShake
0.6,        // aimingSpeed
0.4,         // spotDistance
0.4,        // spotTime
0.7,        // courage
0.7,        // reloadSpeed
0.7,        // commanding
0.7       // general
];


// ARMOUR SKILL
_ArmSkillSet = [
0.25,        // aimingAccuracy
0.45,        // aimingShake
0.6,        // aimingSpeed
0.4,         // spotDistance
0.4,        // spotTime
0.7,        // courage
0.7,        // reloadSpeed
0.7,        // commanding
0.7      // general
];


// LIGHT VEHICLE skill
_LigSkillSet = [
0.25,        // aimingAccuracy
0.45,        // aimingShake
0.6,        // aimingSpeed
0.4,         // spotDistance
0.4,        // spotTime
0.7,        // courage
0.7,        // reloadSpeed
0.7,        // commanding
0.7       // general
];


// HELICOPTER SKILL
_AIRskillSet = [
0.25,        // aimingAccuracy
0.45,        // aimingShake
0.6,        // aimingSpeed
0.4,         // spotDistance
0.4,        // spotTime
0.7,        // courage
0.7,        // reloadSpeed
0.7,        // commanding
0.7        // general
];


// STATIC SKILL
_STAskillSet = [
1,        // aimingAccuracy
1,        // aimingShake
1,        // aimingSpeed
1,         // spotDistance
1,        // spotTime
1,        // courage
1,        // reloadSpeed
1,        // commanding
1        // general
];

server setvariable ["INFskill",_InfskillSet, true];
server setvariable ["ARMskill",_ArmSkillSet, true];
server setvariable ["LIGskill",_LigSkillSet, true];
server setvariable ["AIRskill",_AIRskillSet, true];
server setvariable ["STAskill",_STAskillSet, true];