/*
	Author: Ir0n1E original Lala14, Tajin

	Description:
	Check if we can switch on

	Parameter(s):
	#0 OBJECT - Player

	Returns:
	BOOL
*/

private ["_show", "_veh", "_ison", "_lights", "_timestamp", "_light", "_ball", "_override", "_player"];

_player = _this select 0;
_veh 	= vehicle _player;
_show 	= false;

if ( (_veh != _player) ) then {
	_vehtype = typeOf _veh;
	_i = _veh call IL_fnc_inList;

	if (_i > -1) then {
		_show = true;
		_ison = _veh getVariable ["interiorlight", false];

		if (_ison) then {
			_player setUserActionText [IL_action, IL_text_OFF];

			if ( (cameraView != 'INTERNAL') && {(call IL_fnc_config select _i) select 1} ) then {
				if (IL_Debug) then {_player sideChat 'Lights being removed because in third person'};

				if (count IL_lights > 0) then {
					{
						IL_lights = IL_lights - [_x];
						deleteVehicle _x;
					} forEach IL_lights;
				};
			} else {
				_lights = (call IL_fnc_config select _i) select 2;
				_timestamp = _veh getVariable ['IL_timestamp', IL_lastchange];

				if (count IL_lights == 0) then {

					if (IL_Debug) then {
						_player sideChat 'lights added, hint displayed for the array'; hintSilent str _lights;
					};

					{
						_light = '#lightpoint' createVehicleLocal [0,0,0];
						_light attachTo [_veh, (_x select 0)];
						_light setLightColor (_x select 1);
						_light setLightAttenuation (_x select 2);
						_light setLightIntensity (_x select 3) * IL_intensity_mult;

						if (IL_Debug && IL_Balls) then {

							if (isNil {_veh getVariable 'il_balls'}) then {
								_ball = 'Sign_Sphere10cm_F' createVehicle [0,0,0];
								_ball attachTo [_veh,(_x select 0)];
								_veh setVariable ['il_balls', [_ball], true];
							} else {
								_ball = 'Sign_Sphere10cm_F' createVehicle [0,0,0];
								_ball attachTo [_veh,(_x select 0)];
								_veh setVariable ['il_balls',(_veh getVariable 'il_balls') + [_ball], true];
							};
						};
						IL_lights pushBack _light;
						IL_lastchange = 0;
					} forEach _lights;
				};

				if (_timestamp != IL_lastchange) then {
					_override = _veh getVariable ['IL_override',_lights];

					if (IL_Debug) then {
						_player sideChat format ['light colour changed',str _override];
					};

					{
						_o = _override select _forEachIndex;
						_x attachTo [_veh,(_o select 0)];
						_x setLightColor (_o select 1);
						_x setLightAttenuation (_o select 2);
						_x setLightIntensity (_o select 3) * IL_intensity_mult;
					} forEach IL_lights;

					IL_lastchange = _timestamp;
				};
			};
		} else {

			if (IL_Red_On_Always) then {
				_veh setVariable ['IL_override',nil,true];
			};

			_player setUserActionText[IL_action,IL_text_ON];

			if (count IL_lights > 0) then {

				if (IL_Debug) then {
					_player sideChat format ['removing lights because lights are off %1',str IL_lights];
				};

				{
					IL_lights = IL_lights - [_x];
					deleteVehicle _x;
				} forEach IL_lights;

				if (IL_Debug && {IL_Balls} && {!(isNil {_veh getVariable 'il_balls'})}) then {

					{
						deleteVehicle _x;
					} forEach (_veh getVariable 'il_balls');

					_veh setVariable ['il_balls', nil, true];

					if (IL_Debug) then {
						_player sideChat format ['removing balls because lights are off %1', str IL_lights];
					};
				};
			};
		};
	};
} else {

	if (count IL_lights > 0) then {

		if (IL_Debug) then {
			_player sideChat format ['removing lights because you are not in a vehicle %1',str IL_lights];
		};
		{
			IL_lights = IL_lights - [_x];
			deleteVehicle _x;
		} forEach IL_lights;
	};
};

if (_veh getvariable ["IL_Crew_Only", IL_Crew_Only]) then {
	_show = (_show && {_player == driver _veh || {_player == gunner _veh} || {_player == commander _veh} || {_player in (_veh call IL_fnc_returnTurretUnits)}});
};

if (_veh getVariable ["IL_Action_Night", IL_Action_Night] && {sunOrMoon == 1 || overcast > 0.7}) then {
	_show = (_show && {_veh getVariable ["interiorlight", false]});
};

_show
