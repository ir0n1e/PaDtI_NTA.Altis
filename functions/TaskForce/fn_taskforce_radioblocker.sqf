scriptName "fn_taskforce_radioblocker";
/*
	Author: Ir0n1E

	Description:
	Create an object to block radio communication

	Parameter(s):
	#0 OBJECT - Vehicle
	#1 ARRAY - Position
	#2 Number - Radius
	#3OPJECT - SIDE

	Returns:
	none
*/

_this spawn {

	_object = _this select 0;
	_pos = _this select 1;
	_radius = _this select 2;
	_side = _this select 3;


	_object = createVehicle [_object, _pos, [], 0, "None"];
	_net =  createVehicle ["CamoNet_OPFOR_F", _pos, [], 0, "CaN_collide"];
	_net allowdamage false;

	waitUntil {alive _object};

	while {alive _object} do {
		{
			switch (true) do {
				case (side _x == _side && {_x distance _object < _radius}) : {
					_x setVariable ["tf_unable_to_use_radio", true,true];
				};
				case (!(_x getvariable ["AGM_Unconscious",false]) && (side _x == _side) && {_x distance _object > _radius}) : {
					_x setVariable ["tf_unable_to_use_radio", false,true];
				};
			};
		} forEach playableUnits,
		sleep 10;
	};
	{
		if (!(_x getvariable ["AGM_Unconscious",false]) && (side _x == _side)) then {
			_x setVariable ["tf_unable_to_use_radio", false,true];
		};
	} forEach playableUnits;
};

