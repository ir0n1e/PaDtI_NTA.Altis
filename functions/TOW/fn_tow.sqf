// ****************************************************************
// Script file for ArmA II
// Generic Towing script
// Created by: rundll.exe
// Arguments: [Towing object, Towed object]
// Returns: nothing
// ****************************************************************

// usage:
//add functions module on map. and use the following
//waituntil {!isnil "bis_fnc_init"};
//dll_tow = compile preprocessfile "dll_tow\tow.sqf";
//[T, P] spawn dll_tow;
// T is the Towing vehicle
// P is the towed vehcile (orginated from Plane)
_this spawn {


private ["_towfromrear", "_Tspeed", "_aTpos", "_aPpos", "_wheelPpos", "_dx", "_dy", "_dirdeg", "_xP", "_yP", "_P_axis_offset", "_Taxis", "_Paxis", "_Pwheel", "_d_axis", "_dx_axis", "_dy_axis", "_speed", "_dirdeg_axis","_velocity" ,"_speed","_maxspeed"];
//get constants
_T = _this select 0;
_P = _this select 1;
_Pdisplayname = getText (configFile >> "CfgVehicles" >> typeOf(_P) >> "displayName");
_T_axis_offset = (_T getvariable "dll_tow_back_axis_offset") + [0];

_P_axis_offset = (_P getvariable "dll_tow_front_axis_offset") + [0];
_p_axis_offset = [(_P_axis_offset select 0),(_P_axis_offset select 1)+2,_P_axis_offset select 2];
_P_wheel_offset = (_P getvariable "dll_tow_wheel_offset") + [0];
_static = _P getVariable "static";
if(isnil("_static")) then {
	_T setVariable ["static", false];
	_static = false;
};
if(isnil("dll_tow_velocity_impl")) then {
	dll_tow_velocity_impl = false;
};
_towfromrear = ((_P_axis_offset select 1) < 0);

if (dll_tow_debug) then {
	_axisclass = "RoadCone_F";
	_Taxis = _axisclass createvehicle (position _T);
	_Paxis = _axisclass createvehicle (position _T);
	_Pwheel = _axisclass createvehicle (position _T);

	_Taxis attachto [_T,[_T_axis_offset select 0, _T_axis_offset select 1, 1.5]];
// [parent,offset,mempoint,rope,bone,collisions]

	_Paxis attachto [_P,[_P_axis_offset select 0, _P_axis_offset select 1, 1.5]];
	_Pwheel attachto [_P,[_P_wheel_offset select 0, _P_wheel_offset select 1, 1.5]];

	 _base = inheritsFrom (configFile >> "CfgVehicles" >> typeOf(_P));
	titletext [format["%1 (%2) attached,  Base: %3  _p_off: %4", _Pdisplayname, typeof(_P),  configname _base,_P_axis_offset], "PLAIN DOWN"];
};

_rope = "eslinga" createvehicle (position _T);
_rope attachto [_P,[(_P_axis_offset select 0), (_P_axis_offset select 1)-3, -1.5],"",0];
_rope setVectorDirAndUp [[0,0,-1],[0,1,0]];

//add actions to T
// _action_detach = _T addaction ["Detach", "JDG_carrier\scr\dll_tow\action_detach.sqf"];
_action_detach = _T addaction ["Detach", DLL_fnc_action_detach];

_T setVariable ["dll_tow_towing", true];//now we know something is coupled
_P setVariable ["dll_tow_T", _T]; //P should know who is T
//add EH for killing P or T
_P_EHkilledIdx = _P addeventhandler ["Killed", "((_this select 0) getvariable ""dll_tow_T"") setVariable [""dll_tow_towing"", false]"];
_T_EHkilledIdx = _T addeventhandler ["Killed", "(_this select 0) setVariable [""dll_tow_towing"", false]"];

hint format["%1 attached", _Pdisplayname];
//main towing loop





while {_T getvariable "dll_tow_towing"} do {
		//get global coordinates
		_aTpos = _T modelToWorld _T_axis_offset;
		_aPpos = _P modelToWorld _P_axis_offset;
		_wheelPpos = _P modelToWorld _P_wheel_offset;

		//get the x and y length of the difference vector
		_dx_axis = (_aTpos select 0) - (_aPpos select 0);
		_dy_axis = (_aTpos select 1) - (_aPpos select 1);
		_d_axis = sqrt(_dx_axis^2 + _dy_axis^2);//absolute length of diff vector

		//check for max angle
		/*if(abs (direction _T - direction _P) > 90) then {
				_T setVariable ["dll_tow_towing", false];
		};
*/
_maxspeed = 40;
_speed = speed _T;
if (_speed > _maxspeed) then {

	_velocity = velocity _T;
			_T setVelocity [
				(_velocity select 0) * _maxspeed/_speed,
				(_velocity select 1) * _maxspeed/_speed,
				(_velocity select 2) * _maxspeed/_speed
			];

};
		if(_d_axis > 0.05) then {
			//get global distance between the T axis and P wheelpos
			_dx = (_aTpos select 0) - (_wheelPpos select 0);
			_dy = (_aTpos select 1) - (_wheelPpos select 1);
			_dirdeg = _dx atan2 _dy;//convert to direction in deg
			if(_towfromrear) then {
				_dirdeg = _dirdeg + 180;
			};
_ropedir = ((getdir _p) + (getdir _t))/2;
			//set the direction of P, preserving pitch and bank
			//_Ppb = _P call BIS_fnc_getpitchbank;
			//_P setdir _dirdeg;
			//[_P, _Ppb select 0, _Ppb select 1] call BIS_fnc_setpitchbank;

			if (_static) then {
				//setpos implementation (safe but ugly)
				_P setdir _dirdeg;
				_xP = (_aTpos select 0) - (((_P_axis_offset select 1)+1)*sin _dirdeg);
				_yP = (_aTpos select 1) - (((_P_axis_offset select 1)+1)*cos _dirdeg);
				_P setpos [_xP, _yP, 0];
			}
			else{
				if(dll_tow_velocity_impl) then {
					//velocity implementation (smoother but elastic)
					_dirdeg_axis = _dx_axis atan2 _dy_axis;	//get the direction of the difference vector
					_speed = _d_axis*12; //control the speed needed to make this distance smaller TWEAK HERE	Higher value means less elasticty, but more choppy.
					_speed = _speed min 60; //set max speed for safety.
					_Pvel = velocity _P;
					pvel =_Pvel;
		//if(abs (direction _T - direction _P) < 120) then {

		_Pposx = (position _P) select 0;
	_Pposy	= (position _P) select 1;
				_P setVelocity [(sin _dirdeg_axis*_speed),(cos _dirdeg_axis*_speed),(_Pvel select 2)]; //set the velocity in the correct direction

				_P setVectorDir [(sin _dirdeg_axis*_speed),(cos _dirdeg_axis*_speed),(_Pvel select 2)]; //set the velocity in the correct direction
				//_P setpos [(sin _dirdeg_axis*_speed)+_pposx,(cos _dirdeg_axis*_speed)+_pposy,(_Pvel select 2)];

//};
				}
				else{
					//acceleration implementation doesnt work verry well with "trains"
					_Tvel = velocity _T;
					_Pdir = vectordir _P;
					_dot =  [_Pdir, _Tvel] call BIS_fnc_dotProduct;
					_newvel = [_Pdir, _dot] call BIS_fnc_vectorMultiply;
					_dirdeg_axis = _dx_axis atan2 _dy_axis;	//get the direction of the difference vector
					_acc = _d_axis*5; //control the acc to make this distance smaller TWEAK HERE
					_acc = _acc min 5; //set max acc for safety.
					_Pvel = velocity _P;
					_P setVelocity [(_newvel select 0)+(sin _dirdeg_axis*_acc),(_newvel select 1)+(cos _dirdeg_axis*_acc),(_Pvel select 2)-0.1]; //set the velocity in the correct direction

				};
							_Pvel = velocity _P;
					//_P setdir _dirdeg;

				//	_P setVelocity _Pvel;
//			_Ppb = _P call BIS_fnc_getpitchbank;
//			_Tpb = _T call BIS_fnc_getpitchbank;
			//_P setdir _dirdeg;
			_vdiff=((getdir _P) - (getdir _T))/2;
//		_Paxis setdir (getdir _P)-_vdiff;

		//[_Paxis, 90, 0] call BIS_fnc_setpitchbank;
//_Paxis setVectorDirAndUp [[(sin _dirdeg_axis),(cos _dirdeg_axis),-1],[0,0,0]];
//_Paxis setVectorDirAndUp [[0,0,-1],[0,1,0]];
//			[_P, _Ppb select 0, _Ppb select 1] call BIS_fnc_setpitchbank;


_rope setVectorDirAndUp [[0,0,-1],[0,1,0]];
//_P setVelocity _Pvel;



			};
		};

	if (dll_tow_debug) then {
		_Tspeed = speed _T;
		_Ppb = _P call BIS_fnc_getpitchbank;
		hintsilent format["dx: %1\n
dy: %2\ndirdeg: %3\n
d_axis: %4\n
dirdeg: %5\n
_speed: %6\n
speed P: %7\n
speed T: %8\n
pitch: %9\n
bank: %10\n
bla: %11\n
", _dx, _dy, _dirdeg, _d_axis, _dirdeg, _speed, speed _P /3.6, _Tspeed, _Ppb select 0, _Ppb select 1,pvel];
	};
		sleep 0.01;
};

//remove actions when done
_T removeaction _action_detach;
//remove EHs
_T removeEventHandler ["killed", _T_EHkilledIdx];
_P removeEventHandler ["killed", _P_EHkilledIdx];

if (dll_tow_debug) then {
	deletevehicle _Taxis;
	deletevehicle _Paxis;
	deletevehicle _Pwheel;
};
//finally, we are not towing anymore
deleteVehicle _rope;
_T setVariable ["dll_tow_towing", false];
hint format["%1 detached", _Pdisplayname];

//and set T to continue searching (temporary here)
// [_T] execVM "JDG_carrier\scr\dll_tow\searchP.sqf";
[_T] call DLL_fnc_searchP;
};
