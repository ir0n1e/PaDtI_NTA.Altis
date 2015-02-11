/*
	Author: Ir0n1E original Lala14, Tajin

	Description:
	Adds Light action to user

	Parameter(s):
	None

	Returns:
	None
*/

if (IL_action > -1) then {
	player removeAction IL_action;
	if (IL_Debug) then {
		player sideChat 'action removed';
	};
};

IL_action = player addAction [
IL_text_ON,
"[vehicle player] call IL_fnc_switchOn;",
"",
0.999,
false,
false,
"",
"[player] call IL_fnc_switchOnCondition"];

if (IL_Debug) then {
	player sideChat 'action added';
};

if (IL_action2 > -1) then {
	player removeAction IL_action2;
	if (IL_Debug) then {
		player sideChat 'action2 removed';
	};
};

IL_action2 = player addAction [
IL_Green_Text,
"[vehicle player] call IL_fnc_switchGreen;",
"",
0.99,
false,
false,
"",
"[player] call IL_fnc_switchGreenCondition"];
if (IL_Debug) then {
	player sideChat 'action2 added';
};

if (IL_Debug && IL_Crew_Only) then {
	player sideChat "IL_Crew_Only Active";
};

if (IL_Debug && IL_Red_On_Always) then {
	player sideChat "IL_Red_On_Always Active";
};