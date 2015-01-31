private ["_airfield","_landingzone","_rollway","_field1","_field2","_time","_grp"];

_airfield = createMarker ["Airfield", [21118.875,7322.1602,0]];
_airfield setMarkerShape "RECTANGLE";
_airfield setMarkerSize [250, 20];
_airfield setMarkerDir -258.68756;
//_airfield setMarkerColor "ColorBlack";
//_airfield setMarkerBrush "DIAGGRID";


_landingzone= createMarker ["landingzone", [20904.594,7264.9771,0]];
_landingzone setMarkerShape "RECTANGLE";
_landingzone setMarkerSize [30, 30];
_landingzone setMarkerDir 129;
//_landingzone setMarkerColor "ColorBlack";
//_landingzone setMarkerBrush "DIAGGRID";

_rollway = createMarker ["rollway",[20993.764,7201.9443,0]];
_rollway setMarkerShape "RECTANGLE";
_rollway setMarkerSize [15, 100];
_rollway setMarkerDir -53;
//_rollway setMarkerColor "ColorBlack";
//_rollway setMarkerBrush "DIAGGRID";

_field1 = createMarker ["field1",[21043.131,7324.332,0]];
_field1 setMarkerShape "RECTANGLE";
_field1 setMarkerSize [100, 50];
_field1 setMarkerDir -79;
//_field1 setMarkerColor "ColorBlack";
//_field1 setMarkerBrush "DIAGGRID";

_field2 = createMarker ["field2",[21171.832,7221.1851,0]];
_field2 setMarkerShape "RECTANGLE";
_field2 setMarkerSize [100, 50];
_field2 setMarkerDir -79;
//_field2 setMarkerColor "ColorBlack";
//_field2 setMarkerBrush "DIAGGRID";

_hoehe101 = createMarker ["hoehe101",[20083.3,6727.33,0]];
_hoehe101 setMarkerShape "RECTANGLE";
_hoehe101 setMarkerSize [40, 40];
_hoehe101 setMarkerDir 0;

_bomb_hoehe101 = createMarker ["bomb_hoehe101",[20082.1,6665.11,0]];
_bomb_hoehe101 setMarkerShape "RECTANGLE";
_bomb_hoehe101 setMarkerSize [20, 100];
_bomb_hoehe101 setMarkerDir -90;

_selakano = createMarker ["selakano",[20802.6,6729.61,0]];
_selakano setMarkerShape "RECTANGLE";
_selakano setMarkerSize [200, 200];
_selakano setMarkerDir 0;

_feres = createMarker ["feres",[21685.5,7539.4,0]];
_feres setMarkerShape "RECTANGLE";
_feres setMarkerSize [200, 200];
_feres setMarkerDir 0;





_c130eastWP = [[24354,1346,300],[21676.2,6587.5,0],[21880.7,8480.68,0.00104904],[21981,28740,0]];

AIRFIELD_bombMarkers = ["Airfield","rollway","field1","field2","bomb_hoehe101"];
publicVariable "AIRFIELD_bombMarkers";

AIRFIELD_Markers = ["Airfield","rollway","field1","field2","bomb_hoehe101","feres", "selakano", "hoehe101", "landingzone"];
publicVariable "AIRFIELD_Markers";


wrackfuel1 = "";
wrackfuel2 = "";
AIRFIELD_call_csatplane  = compile preprocessFileLineNumbers "event\callcsatplane.sqf";
AIRFIELD_call_c130 = compile preprocessFileLineNumbers "event\callc130.sqf";
AIRFIELD_Bombs = compile preprocessFileLineNumbers "event\bombs.sqf";
AIRFIELD_Wracks = compile preprocessFileLineNumbers "event\wracks.sqf";
AIRFIELD_Roadblock = compile preprocessFileLineNumbers "event\roadblock.sqf";
AIRFIELD_call_blackhawk = compile preprocessFileLineNumbers "event\callblackhawk.sqf";
AIRFIELD_call_c130east = compile preprocessFileLineNumbers "event\callc130east.sqf";
AIRFIELD_Parachute = compile preprocessFileLineNumbers "event\parachute.sqf";

mainTrigger = createTrigger ["EmptyDetector", [20549,7973.7427,33.284595]];
mainTrigger setTriggerArea [2000,50,-17.3901,true];
mainTrigger setTriggerActivation ["WEST", "PRESENT", false];
mainTrigger setTriggerStatements ["this && position player select 2 < 10",
	"['landingzone',[5],0] spawn AIRFIELD_Wracks;

	",""];

for "_i" from 1 to 3 step +1  do {

	_vehicle = [_c130eastWP, 20] call AIRFIELD_call_c130east;
	[_vehicle select 0,_vehicle select 1, _c130eastWP select 1, 6] call AIRFIELD_Parachute;
	_wp = _c130eastWP select 0;
	_wp2 = _c130eastWP select 1;
	_wp3 = _c130eastWP select 2;
	_c130eastWP = [[(_wp select 0) + 300,(_wp select 1)+100, _wp select 2], [(_wp2 select 0) + 150,(_wp2 select 1)+150,0],[(_wp3 select 0) + 300,(_wp3 select 1)+300,0], _c130eastWP select 3 ];



};
/*
[] spawn AIRFIELD_Roadblock;

waitUntil {(str(wrackfuel1) == "<NULL-object>") or (str(wrackfuel2) == "<NULL-object>")};
 	systemchat "true attack";
['landingzone',[5]] spawn AIRFIELD_call_csatplane;
['Airfield',[3],0.7] spawn AIRFIELD_Wracks;

_time = time;
waituntil {time >= _time + 30};
['Airfield',[10]] spawn AIRFIELD_Bombs;
['rollway',[2]] spawn AIRFIELD_Bombs;
*/




//["landingzone",[5],0] spawn AIRFIELD_Wracks;
//["Airfield",[3]] spawn AIRFIELD_Wracks;


//["landingzone",[5]] spawn AIRFIELD_call_csatplane;
//[] spawn AIRFIELD_call_blackhawk;
//c130 = [] spawn AIRFIELD_call_c130;





