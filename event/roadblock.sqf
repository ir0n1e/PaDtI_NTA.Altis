private ["_wrack","_wracks"];
_wracks = [];
_wrack = ["Fennek_Flecktarn_pio",[20680.4,7279.36,0.0125599],'NONE',WEST] call NTA_fnc_vehicles_create;
_wrack setdir 335.542;
_wracks = [_wracks, _wrack] call NTA_fnc_addtoarray;

_wrack = ["Fennek_Flecktarn_pio",[20679.6,7271.15,0.0234585],'NONE',WEST] call NTA_fnc_vehicles_create;
_wrack setdir 18.6828;
_wracks = [_wracks, _wrack] call NTA_fnc_addtoarray;

wrackfuel1 = ["B_Truck_01_fuel_F",[20671.3,7257.96,-0.998951],'NONE',WEST] call NTA_fnc_vehicles_create;
wrackfuel1 setdir 36.542;
publicVariable "wrackfuel1";
_wracks = [_wracks, wrackfuel1] call NTA_fnc_addtoarray;


wrackfuel2 = ["B_Truck_01_fuel_F",[20681.2,7253.92,-0.0922852],'NONE',WEST] call NTA_fnc_vehicles_create;
wrackfuel2 setdir 326.542;
publicVariable "wrackfuel2";
_wracks = [_wracks, wrackfuel2] call NTA_fnc_addtoarray;

{
_x setdamage 1;
_x addEventHandler ["handledamage", {

		if ((_this select 4) in ["SatchelCharge_Remote_Ammo","DemoCharge_Remote_Ammo","DemoCharge_Remote_Ammo_Scripted","SatchelCharge_Remote_Ammo_Scripted"]) then {

				deleteVehicle (_this select 0);

				(_this select 3) addRating 1500;

		} else {
			(_this select 0) setDamage ((getDammage (_this select 0)) + (_this select 2))}}];
} forEach _wracks;