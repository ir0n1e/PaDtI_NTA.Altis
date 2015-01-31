 private ["_netID","_unit","_unitinit"];

_netID 		= _this select 0;
_unitinit 	= _this select 1;
_unit 		= objectFromNetID _netID;

_unit call compile format ["%1",_unitinit];