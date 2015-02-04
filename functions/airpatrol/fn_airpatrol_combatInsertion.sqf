/*
 * combat_insertion.sqf: This file is part of Combat Insertion
 * Version: Beta 0.815
 *
 * Copyright (C) 2010 Sacha Bartuweit 'Ir0n1E' <ir0n1e@freenet.de>
 *
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program; if not, write to the Free Software Foundation, Inc.,
 * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 *
 * Discription:
 * null = [_group, _vehicle, _debug] execvm "combat_insertion.sqf";
 **/
_this spawn {
	_units	 		= _this select 0;	/* Named group of units */
	_vehicle 		= _this select 1;		/* Named Vehicle/Chopper */
	_pad	 		= _this select 2;
	_apUserInsert 	= _this select 3;
	_debug	 		= _this select 4;		/* Debug true/false */

	_cntgroup 		= count _units;
	_emppos	  		= _vehicle emptypositions "cargo";
	_count	  		= _emppos + _cntgroup;
	_height 		= (getpos _vehicle) select 2;
	/* Main loop. */
	_pospad = getpos _pad;
	while {(_vehicle getvariable "airpatrol_mission") != "MovingHome"} do {

		_height = (getpos _vehicle) select 2;

		if (!alive _vehicle) exitwith {
				deletevehicle _pad;
		};

		waituntil {(_vehicle distance _pospad) < 250};
		_vehicle setvariable ["airpatrol_mission", "UnloadingTroops"];

		if (_height < 20) then {
				_vehicle animateDoor ['door_L', 1];
				_vehicle animateDoor ['door_R', 1];
				_vehicle animateDoor ['Door_rear_source', 1];
				_vehicle land "LAND";
				_vehicle allowDammage false;
		};

		/* Drop units if height < 3.0. */
		if (_height <= 1.8) then {
			{
				/* Disable animation and autotarget, so units get out faster. */
			 	_x allowDamage false;

				/* Disable firering. AI will shoot your units. */
				_vehicle setCombatMode "BLUE";
				//_x action ["getout", _vehicle];
				moveOut _x;
				unassignVehicle _x;

				sleep 0.5;

			} foreach _units;

			if (alive _vehicle) then {
				_vehicle land "NONE";
				_vehicle allowdammage true;
				_vehicle setvariable ["airpatrol_mission", "MovingHome"];
				_vehicle domove (_vehicle getvariable "Airpatrol_EndPos");
			};

			sleep 1;
			deletevehicle _pad;

			{ _x allowDamage true } foreach _units;
		};
	};

	_vehicle animateDoor ['door_L', 0];
	_vehicle animateDoor ['door_R', 0];
	_vehicle animateDoor ['Door_rear_source', 0];

	/* Exit the script. */
	if (true) exitwith {
		sleep 0.8;
		_vehicle setCombatMode "RED";

	};
};
/* vi:ts=4:sw=4:wrap:ai:expandtab */