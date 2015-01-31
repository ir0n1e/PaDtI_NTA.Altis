_this spawn {
	(_this select 1) allowDamage false;
	//(_this select 0) disableCollisionWith (_this select 1);
	//(_this select 1) disableCollisionWith (_this select 0);
	sleep 10;
	(_this select 0) assignAsCargo (_this select 1);
	(_this select 0) moveincargo [(_this select 1), (_this select 2)];
	sleep 0.25;
	(_this select 1) allowDamage true;
};