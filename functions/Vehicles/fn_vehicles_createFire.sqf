_this spawn {

	fnc_killfire = {

	{
		if (typeOf _x == "#particlesource") then {
			deletevehicle _x;
		};
	} forEach (_this nearObjects 10);
};
publicvariable "fnc_killfire";


	_pos = position _this;
	_fire = "test_EmptyObjectForFireBig" createVehicle _pos;
	_fire attachTo[_this, [0, 1.5, -1]];

	_this setvariable ["burning", true];

	sleep 180;
	[_pos, "fnc_killfire",true,true] call bis_fnc_mp;

};

