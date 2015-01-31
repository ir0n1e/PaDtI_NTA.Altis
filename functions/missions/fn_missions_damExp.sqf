_this spawn {
    {
    	sleep 0.3;
        "R_TBG32V_F" createvehicle (getposASL _x);
        sleep 0.5;
        _x setDamage 1;
    } foreach (server getvariable ["DamPipe",[]]);
};