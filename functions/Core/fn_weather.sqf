/*
Author: code34 nicolas_boiteux@yahoo.fr
Copyright (C) 2013 Nicolas BOITEUX

Real weather for MP GAMES v 1.2

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

private ["_lastrain", "_rain", "_fog", "_mintime", "_maxtime", "_overcast", "_realtime", "_random", "_skiptime", "_startingdate", "_startingweather", "_timeforecast", "_timeratio", "_timesync", "_wind", "_windextra"];

// Real time vs fast time
// true: Real time is more realistic weather conditions change slowly (ideal for persistent game)
// false: fast time give more different weather conditions (ideal for non persistent game)
_realtime = true;

// Random time before new forecast
// true: forecast happens bewteen mintime and maxtime
// false: forecast happens at mintime
_random = false;

// Min time seconds (real time) before a new weather forecast
_mintime = 60;

// Max time seconds (real time) before a new weather forecast
_maxtime = (10*60);

// If Fastime is on
// Ratio 1 real time second for x game time seconds
// Default: 1 real second = 3.6 second in game
_timeratio = 3.6;

// send sync data across the network each xxx seconds
// 60 seconds by default is a good value
// shortest time do not improve weather sync
_timesync = 60;

// Mission starting date is 25/09/2013 at 12:00
_startingdate = date; //[2013, 09, 25, 12, 00];

// Mission starting weather "CLEAR|CLOUDY|RAIN";
_startingweather = "CLOUDY";

/////////////////////////////////////////////////////////////////
// Do not edit below
/////////////////////////////////////////////////////////////////

if(_mintime > _maxtime) exitwith {hint format["Real weather: Max time: %1 can no be higher than Min time: %2", _maxtime, _mintime];};
_timeforecast = _mintime;

// we check the skiptime for 10 seconds
_skiptime = _timeratio * 0.000278 * 10;

setdate _startingdate;
switch(toUpper(_startingweather)) do {
	case "CLEAR": {
		wcweather = [0, 0, 0, [random 3, random 3, true], date];
	};

	case "CLOUDY": {
		wcweather = [0, 0, 0.6, [random 3, random 3, true], date];
	};

	case "RAIN": {
		wcweather = [1, 0, 1, [random 3, random 3, true], date];
	};

	default {
		// clear
		wcweather = [0, 0, 0, [random 3, random 3, true], date];
		diag_log "Real weather: wrong starting weather";
	};
};

// add handler
if (local player) then {
	wcweatherstart = true;
	"wcweather" addPublicVariableEventHandler {
		// first JIP synchronization
		if(wcweatherstart) then {
			wcweatherstart = false;
			skipTime -24;
			86400 setRain (wcweather select 0);
			86400 setfog (wcweather select 1);
			86400 setOvercast (wcweather select 2);
			skipTime 24;
			simulweatherSync;
			setwind (wcweather select 3);
			setdate (wcweather select 4);
		}else{
			wcweather = _this select 1;
			60 setRain (wcweather select 0);
			60 setfog (wcweather select 1);
			60 setOvercast (wcweather select 2);
			setwind (wcweather select 3);
			setdate (wcweather select 4);
		};
	};
};

// accelerate time
if!(_realtime) then {
	[_skiptime] spawn {
		private["_skiptime"];
		_skiptime = _this select 0;

		while {true} do {
			skiptime _skiptime;
			sleep 10;
		};
	};
};

// SERVER SIDE SCRIPT
if (!isServer) exitWith{};

// apply weather
skipTime -24;
86400 setRain (wcweather select 0);
86400 setfog (wcweather select 1);
86400 setOvercast (wcweather select 2);
skipTime 24;
simulweatherSync;
setwind (wcweather select 3);
setdate (wcweather select 4);

// sync server & client weather & time
[_timesync] spawn {
	private["_timesync"];
	_timesync = _this select 0;

	while { true } do {
		wcweather set [4, date];
		publicvariable "wcweather";
		sleep _timesync;
	};
};

_lastrain = 0;
_rain = 0;
_overcast = 0;
_windextra = 0;
_rainextra = 0;
_lastOvercast = random 1;
while {true} do {
	_overcastExtra = [-0.15, 0.15] call NTA_fnc_getRandArrayPos;
	_overcast = _lastOvercast + _overcastExtra;
	if (_overcast < 0) then {
		_overcast = 0.2;
	};
	if (_overcast > 1) then {
		_overcast = 0.8;
	};

	if((date select 1 > 9) || (date select 1 < 3)) then {
		_windextra = 1.5;
		_rainextra = 0.3;
	};

	if(_overcast > 0.68) then {
		_rain = (random 0.3) + _rainextra;
		if(_rain > 1) then {
			_rain = 1;
		};
	} else {
		_rain = 0;
	};

	if(_overcast > 0.8) then {
		_rain = (random 0.7) + _rainextra;
		if(_rain > 1) then {
			_rain = 1;
		};
	} else {
		_rain = 0;
	};

	if((date select 3 > 2) && (date select 3 <6)) then {
		_fog = 0.2 + (random 0.4);
	} else {
		if((_lastrain > 0.6) and (_rain < 0.2)) then {
			_fog = random 0.3;
		} else {
			_fog = 0;
		};
	};

	if(random 1 > 0.95) then {
		_wind = [_windextra + (random 7) , _windextra + (random 7), true];
	} else {
		_wind = [_windextra + (random 3) , _windextra + (random 3), true];
	};
	_lastrain = _rain;
	_lastOvercast = _overcast;

	wcweather = [_rain, _fog, _overcast, _wind, date];
	60 setRain (wcweather select 0);
	60 setfog (wcweather select 1);
	60 setOvercast (wcweather select 2);
	setwind (wcweather select 3);

	if(_random) then {
		_timeforecast = _mintime + (random (_maxtime - _mintime));
	};
	sleep _timeforecast;

};