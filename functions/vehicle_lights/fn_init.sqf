/*
	Author: Ir0n1E original Lala14, Tajin

	Description:
	Light init

	Parameter(s):
	None

	Returns:
	None
*/

IL_text_ON 			= "<t color='#FF0000'>Turn Interior Light ON</t>";
IL_text_OFF 		= "<t color='#FF0000'>Turn Interior Light OFF</t>";
IL_Green_Text 		= "<t color='#00FF00'>Change Light to Green</t>";
IL_Red_Text 		= "<t color='#FF0000'>Change Light to Red</t>";
IL_action 			= -1;

IL_lastchange 		= 0;

IL_Debug 			= false; 			//Enable Debug Mode
IL_Balls 			= false; 			//Show the attach points (requires Debug mode)
IL_Crew_Only 		= true; 		//Only allow Pilot/Driver/Co-Pilot/Gunner/Commander (does not include left & right gunners for choppers) to change the light
IL_Red_On_Always 	= false; 	//When true, when light is turned off then on the light will be reset to red else it will never be reset if false
IL_Action_Night 	= true; 	//Only allow the action to come up during the Dark times

IL_Loaded 			= false;

IL_typelist 		= [];
IL_lights 			= [];

// To make all lights brighter or darker, simply adjust the following multiplier.
IL_intensity_mult 	= 1;

call IL_fnc_config;

if (hasinterface) then {
	[] call IL_fnc_actions;

	player addEventHandler ["Respawn", {
		[] call IL_fnc_actions;
	}];
};

IL_Loaded = true;

diag_log "IL ready";
systemChat "Interior Lighting: Initialized";