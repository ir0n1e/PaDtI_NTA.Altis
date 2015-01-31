private ["_key", "_handled"];

_key = _this select 1;

if (_this select 2) then {_key = _key + 0.1};
if (_this select 3) then {_key = _key + 0.2};
if (_this select 4) then {_key = _key + 0.4};

_handled = false;

switch (_key) do {
	case 22.2: {
		setViewDistance (viewDistance - 100);
		format ["Viewdistance: %1", viewdistance] call NTA_fnc_note;
     	_handled = true;
	};
	case 22: {
		setViewDistance (viewDistance + 100);
		format ["Viewdistance: %1", viewdistance] call NTA_fnc_note;
     	_handled = true;
	};
    default {
    	_handled = false;
    };
};

_handled