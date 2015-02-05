/*
if (isserver) then {

	if (!isnil "HCPresent") exitwith {

		[[_this,"eos\openme.sqf"],"BIS_fnc_execVM",NTAHC,true] call BIS_fnc_MP;
		"EOS switching to HC" call NTA_fnc_log;
		breakout "main";
	};

	"EOS switching to Server" call NTA_fnc_log;
};
*/


private ["_time", "_static"];
//null = [0,0] execVM "eos\core\spawn_fnc.sqf";
//Kinch_lootReward = compile preprocessfilelinenumbers "support\scripts\LootReward.sqf";
//Kinch_BastionReward = compile preprocessfilelinenumbers "support\scripts\BastionReward.sqf";
/*
onplayerConnected {
	{
		_x setMarkerAlpha (MarkerAlpha _x);
		_x setMarkercolor (getMarkercolor _x);
	} foreach (server getvariable ["EOSmarkers", []]);
};
*/
"Starting EOS Init..." call NTA_fnc_log;
/* EOS 1.98 by BangaBob
	GROUP SIZES
	0 = 1
	1 = 2,4
	2 = 4,8
	3 = 8,12
	4 = 12,16
	5 = 16,20

	EXAMPLE CALL - EOS
	null = [["MARKERNAME","MARKERNAME2"],[2,1,70],[0,1],[1,2,30],[2,60],[2],[1,0,10],[1,0,250,WEST]] call NTA_fnc_eos_core;
	null=[["M1","M2","M3"],[HOUSE GROUPS,SIZE OF GROUPS,PROBABILITY],[PATROL GROUPS,SIZE OF GROUPS,PROBABILITY],[LIGHT VEHICLES,SIZE OF CARGO,PROBABILITY],[ARMOURED VEHICLES,PROBABILITY],[STATIC VEHICLES,PROBABILITY],[HELICOPTERS,SIZE OF HELICOPTER CARGO,PROBABILITY],[FACTION,MARKERTYPE,DISTANCE,SIDE,HEIGHTLIMIT,DEBUG]] call NTA_fnc_eos_core;

	EXAMPLE CALL - BASTION
	null = [["BAS_zone_1"],[3,1],[2,1],[2],[0,0],[0,0,EAST,false],[10,2,120,FALSE,FALSE]] call NTA_fnc_eos_bastionCore;
	null=[["M1","M2","M3"],[PATROL GROUPS,SIZE OF GROUPS],[LIGHT VEHICLES,SIZE OF CARGO],[ARMOURED VEHICLES],[HELICOPTERS,SIZE OF HELICOPTER CARGO],[FACTION,MARKERTYPE,SIDE,HEIGHTLIMIT,DEBUG],[INITIAL PAUSE, NUMBER OF WAVES, DELAY BETWEEN WAVES, INTEGRATE EOS, SHOW HINTS]] call NTA_fnc_eos_bastionCore;
*/

VictoryColor = "colorGreen";	// Colour of marker after completion
hostileColor = "colorRed";		// Default colour when enemies active
bastionColor = "colorOrange";	// Colour for bastion marker

EOShardlimit = 110;
EOS_ACTIVE = false;
EOScounter = 0;
BOScounter = 0;


publicvariable "EOShardlimit";
publicvariable "bastionColor";
publicvariable "hostileColor";
publicvariable "VictoryColor";
publicvariable "EOS_ACTIVE";

_time = time;
_static = random 3;
call NTA_fnc_eos_postInit;

/*---------------------------------------------- DEFENSE --------------------------------------------------------*/

null = [["DEF_1"],[3,1],[2,0],[1],[0,0],[0,0,EAST,TRUE,FALSE],[360,1 + floor floor (random 2),100 + (random 300),TRUE,TRUE]] call NTA_fnc_eos_bastionCore; //moyen
null = [["DEF_2"],[2,2],[2,0],[1],[0,0],[0,0,EAST,TRUE,FALSE],[360,1 + floor (random 2),100 + (random 300),TRUE,TRUE]] call NTA_fnc_eos_bastionCore; //moyen
null = [["DEF_3"],[2,1],[2,0],[1],[0,0],[0,0,EAST,TRUE,FALSE],[360,1 + floor (random 2),100 + (random 300),TRUE,TRUE]] call NTA_fnc_eos_bastionCore; //moyen
null = [["DEF_4"],[3,1],[1,0],[1],[0,0],[0,0,EAST,TRUE,FALSE],[360,1 + floor (random 2),100 + (random 300),TRUE,TRUE]] call NTA_fnc_eos_bastionCore; //petit
null = [["DEF_5"],[3,1],[1,0],[1],[0,0],[0,0,EAST,TRUE,FALSE],[360,1 + floor (random 2),100 + (random 300),TRUE,TRUE]] call NTA_fnc_eos_bastionCore; //petit
null = [["DEF_6"],[4,2],[1,0],[1],[0,0],[0,0,EAST,TRUE,FALSE],[360,1 + floor (random 2),100 + (random 300),TRUE,TRUE]] call NTA_fnc_eos_bastionCore; //grand
null = [["DEF_7"],[4,2],[2,0],[1],[0,0],[0,0,EAST,TRUE,FALSE],[360,1 + floor (random 2),100 + (random 300),TRUE,TRUE]] call NTA_fnc_eos_bastionCore; //grand
null = [["DEF_8"],[3,1],[1,0],[1],[0,0],[0,0,EAST,TRUE,FALSE],[360,1 + floor (random 2),100 + (random 300),TRUE,TRUE]] call NTA_fnc_eos_bastionCore; //petit
null = [["DEF_9"],[4,2],[2,0],[1],[0,0],[0,0,EAST,TRUE,FALSE],[360,1 + floor (random 2),100 + (random 300),TRUE,TRUE]] call NTA_fnc_eos_bastionCore; //grand
null = [["DEF_10"],[2,1],[2,0],[1],[0,0],[0,0,EAST,TRUE,FALSE],[360,1 + floor (random 2),100 + (random 300),TRUE,TRUE]] call NTA_fnc_eos_bastionCore; //moyen
null = [["DEF_11"],[2,1],[2,0],[1],[0,0],[0,0,EAST,TRUE,FALSE],[360,1 + floor (random 2),100 + (random 300),TRUE,TRUE]] call NTA_fnc_eos_bastionCore; //moyen
null = [["DEF_12"],[4,2],[2,0],[1],[0,0],[0,0,EAST,TRUE,FALSE],[360,1 + floor (random 2),100 + (random 300),TRUE,TRUE]] call NTA_fnc_eos_bastionCore; //grand
null = [["DEF_13"],[4,2],[2,0],[1],[0,0],[0,0,EAST,TRUE,FALSE],[360,1 + floor (random 2),100 + (random 300),TRUE,TRUE]] call NTA_fnc_eos_bastionCore; //grand
null = [["DEF_14"],[4,2],[2,0],[1],[0,0],[0,0,EAST,TRUE,FALSE],[360,1 + floor (random 2),100 + (random 300),TRUE,TRUE]] call NTA_fnc_eos_bastionCore; //grand
null = [["DEF_15"],[2,1],[2,0],[1],[0,0],[0,0,EAST,TRUE,FALSE],[360,1 + floor (random 2),100 + (random 300),TRUE,TRUE]] call NTA_fnc_eos_bastionCore; //moyen
null = [["DEF_16"],[3,1],[1,0],[1],[0,0],[0,0,EAST,TRUE,FALSE],[360,1 + floor (random 2),100 + (random 300),TRUE,TRUE]] call NTA_fnc_eos_bastionCore; //petit



/*---------------------------------------------- ATTAQUE --------------------------------------------------------*/
// Orino 104172 22batiments

null = [["city_35"],[4,1],[2,0],[1],[0,0],[0,0,EAST,TRUE,FALSE],[360,1 + floor (random 2),100 + (random 300),TRUE,TRUE]] call NTA_fnc_eos_bastionCore; //petit

// Ifestiona 128196 21batiments
null = [["city_36"],[4,1],[2,0],[1],[0,0],[0,0,EAST,TRUE,FALSE],[360,1 + floor (random 2),100 + (random 300),TRUE,TRUE]] call NTA_fnc_eos_bastionCore; //petit

// Syrta
null = [["city_29"],[5,1],[2,0],[1],[0,0],[0,0,EAST,TRUE,FALSE],[360,1 + floor (random 2),100 + (random 300),TRUE,TRUE]] call NTA_fnc_eos_bastionCore; //moyenne ville

// Dorida
null = [["city_32"],[5,1],[2,0],[2],[0,0],[0,0,EAST,TRUE,FALSE],[360,1 + floor (random 2),100 + (random 300),TRUE,TRUE]] call NTA_fnc_eos_bastionCore; //moyenne ville

/*---------------------------------------------- ATTAQUE --------------------------------------------------------*/
/*--------------------------------------- TRES GRANDES VILLES --------------------------------------------------------*/
// Kavala
null = [["city_1"],[0,0],[8,1],[4,1],[3],[_static],[0,0],[0,0,1500,EAST]] call NTA_fnc_eos_core; 		//tres grande ville


null = [["city_3"],[0,0],[8,1],[4,1],[3],[_static],[0,0],[0,0,1500,EAST]] call NTA_fnc_eos_core; 		//tres grande ville
null = [["Pyrgos"],[10,1],[8,1],[4,1],[3],[_static],[0,0],[0,0,1500,EAST]] call NTA_fnc_eos_core; 		//tres grande ville


/*------------------------------------------- GRANDES VILLES ---------------------------------------------------------*/
// Abdera
null = [["city_37"],[0,0],[10,1],[1,1],[3],[_static],[0,0],[0,0,1500,EAST]] call NTA_fnc_eos_core; 	//grande ville

// Agios Dionysos
null = [["city_21"],[3,1],[10,1],[1,1],[3],[_static],[0,0],[0,0,1500,EAST]] call NTA_fnc_eos_core; 	//grande ville

// Agios Konstantinos
null = [["city_38"],[0,0],[10,1],[1,1],[3],[_static],[0,0],[0,0,1500,EAST]] call NTA_fnc_eos_core; 	//grande ville

// Depot Nord-Ouest
//null = [["city_2"],[0,0],[10,1],[1,1],[3],[5],[0,0],[0,0,1500,EAST]] call NTA_fnc_eos_core; 	//grande ville déactivée

// Iraklia
null = [["city_47"],[8,0],[10,1],[1,1],[3],[_static],[0,0],[0,0,1500,EAST]] call NTA_fnc_eos_core;  //grande ville

// Molos
null = [["city_13"],[4,0],[8,1],[0,0],[0],[0],[0,0],[0,0,800,EAST]] call NTA_fnc_eos_core; 	//grande ville

// Montagne Sud-Ouest
null = [["city_20"],[0,0],[10,1],[1,1],[3],[_static],[0,0],[0,0,1500,EAST]] call NTA_fnc_eos_core;  //grande ville

// Neochori
null = [["city_17"],[0,0],[10,1],[1,1],[3],[_static],[0,0],[0,0,1500,EAST]] call NTA_fnc_eos_core; 	//grande ville

// Panochori
null = [["city_25"],[0,0],[10,1],[1,1],[3],[_static],[0,0],[0,0,1500,EAST]] call NTA_fnc_eos_core;	//grande ville

// Paros
null = [["city_10"],[0,0],[10,1],[1,1],[3],[_static],[0,0],[0,0,1500,EAST]] call NTA_fnc_eos_core; 	//grande ville

// Rodopoli
//null = [["city_4"],[0,0],[10,1],[1,1],[3],[5],[0,0],[0,0,1500,EAST]] call NTA_fnc_eos_core; 	//grande ville déactivée

// Zaros
//null = [["city_26"],[0,0],[10,1],[1,1],[3],[5],[0,0],[0,0,1500,EAST]] call NTA_fnc_eos_core; 	//grande ville déactivée


/*----------------------------------------- MOYENNES VILLES ---------------------------------------------------------*/
// Atsalis
null = [["city_40"],[0,0],[6,1],[2,1],[0],[_static],[0,0],[0,0,1500,EAST]] call NTA_fnc_eos_core; 	//moyenne ville

// Charkia
null = [["city_5"],[0,0],[6,1],[2,1],[0],[_static],[0,0],[0,0,1500,EAST]] call NTA_fnc_eos_core; 		//moyenne ville

// Chalkeia
null = [["city_6"],[0,0],[6,1],[2,1],[0],[_static],[0,0],[0,0,1500,EAST]] call NTA_fnc_eos_core; 		//moyenne ville

// Dorida
//null = [["city_32"],[0,1],[6,1],[2,1],[0],[2],[0,0],[0,0,1500,EAST]] call NTA_fnc_eos_core; //moyenne ville passée en bastion

// Frini
null = [["city_31"],[0,0],[6,1],[2,1],[0],[_static],[0,0],[0,0,1500,EAST]] call NTA_fnc_eos_core; 	//moyenne ville

// Feres
null = [["city_8"],[0,0],[6,1],[2,1],[0],[_static],[0,0],[0,0,1500,EAST]] call NTA_fnc_eos_core; 		//moyenne ville

// Kore
//null = [["city_22"],[0,0],[6,1],[2,1],[0],[2],[0,0],[0,0,1500,EAST]] call NTA_fnc_eos_core; 	//moyenne ville déactivée

// Kalochori
//null = [["city_11"],[0,0],[6,1],[2,1],[0],[2],[0,0],[0,0,1500,EAST]] call NTA_fnc_eos_core; 	//moyenne ville déactivée

// Lakka
//null = [["city_16"],[0,0],[6,1],[2,1],[0],[2],[0,0],[0,0,1500,EAST]] call NTA_fnc_eos_core; 	//moyenne ville déactivée

// Limni
null = [["city_19"],[0,0],[6,1],[2,1],[0],[_static],[0,0],[0,0,1500,EAST]] call NTA_fnc_eos_core; 	//moyenne ville

// Negades
//null = [["city_23"],[0,0],[6,1],[2,1],[0],[2],[0,0],[0,0,1500,EAST]] call NTA_fnc_eos_core; 	//moyenne ville déactivée

// Neri
//null = [["city_24"],[0,0],[6,1],[2,1],[0],[2],[0,0],[0,0,1500,EAST]] call NTA_fnc_eos_core; 	//moyenne ville déactivée

// Panagia
null = [["city_7"],[0,0],[6,1],[2,1],[0],[_static],[0,0],[0,0,1500,EAST]] call NTA_fnc_eos_core; 		//moyenne ville

// Poliakko
//null = [["city_18"],[0,0],[6,1],[2,1],[0],[2],[0,0],[0,0,1500,EAST]] call NTA_fnc_eos_core; 	//moyenne ville déactivée

// Syrta
//null = [["city_29"],[0,0],[6,1],[2,1],[0],[2],[0,0],[0,0,1500,EAST]] call NTA_fnc_eos_core; //moyenne ville passée en bastion

// Selakano
//null = [["city_9"],[0,0],[6,1],[2,1],[0],[2],[0,0],[0,0,1500,EAST]] call NTA_fnc_eos_core; 		//moyenne ville déactivée

// Sofia
null = [["city_12"],[4,0],[1,1],[0,0],[0],[0],[0,0],[0,0,1500,EAST]] call NTA_fnc_eos_core;  	//moyenne ville

// Therisa
null = [["city_27"],[0,0],[6,1],[2,1],[0],[_static],[0,0],[0,0,1500,EAST]] call NTA_fnc_eos_core; 	//moyenne ville


/*----------------------------------------- PETITES VILLES -------------------------------------------------------------*/
// Agios petros 192175 14batiments
null = [["city_33"],[2,0],[4,1],[1,1],[0],[1],[0,0],[0,0,1500,EAST]] call NTA_fnc_eos_core; 	//petite ville

// Agia triada 165205 5batiments
null = [["city_39"],[1,0],[3,1],[1,1],[0],[1],[0,0],[0,0,1500,EAST]] call NTA_fnc_eos_core; 	//petite ville

// Bomos 023222 1batiment zone montagneuse, forestière, cotière
null = [["city_43"],[1,0],[3,1],[1,1],[0],[1],[0,0],[0,0,1500,EAST]] call NTA_fnc_eos_core; 	//petite ville

// Cap Agrios 145232 0batiment
null = [["city_41"],[0,0],[3,1],[1,1],[0],[1],[0,0],[0,0,1500,EAST]] call NTA_fnc_eos_core; 	//petite ville

// Delfinaki 239201 12batiments W <- 400m loanina
null = [["city_15"],[5,0],[3,1],[1,1],[0],[1],[0,0],[0,0,1500,EAST]] call NTA_fnc_eos_core; 	//petite ville

// Ekali 171099 7batiments
null = [["city_46"],[4,0],[4,1],[1,1],[0],[1],[0,0],[0,0,1500,EAST]] call NTA_fnc_eos_core; 	//petite ville

// Fotia 031183 11batiments
null = [["city_42"],[3,0],[3,1],[1,1],[0],[1],[0,0],[0,0,1500,EAST]] call NTA_fnc_eos_core; 	//petite ville

// Galati 103190 +80batiments
//null = [["city_30"],[10,0],[4,1],[1,1],[0],[1],[0,0],[0,0,1500,EAST]] call NTA_fnc_eos_core; 	//petite ville déactivée

// Ifestiona 128196 21batiments
//null = [["city_36"],[6,0],[4,1],[1,1],[0],[1],[0,0],[0,0,1500,EAST]] call NTA_fnc_eos_core; //petite ville passée en bastion

// Koroni 117182 21batiments
null = [["city_34"],[3,0],[4,1],[1,1],[0],[1],[0,0],[0,0,1500,EAST]] call NTA_fnc_eos_core; 	//petite ville

// Loannina 232199 21batiments E -> 400m delfinaki
//null = [["city_14"],[10,0],[3,1],[1,1],[0],[1],[0,0],[0,0,1500,EAST]] call NTA_fnc_eos_core; 	//petite ville déactivée

// Orino 104172 22batiments
//null = [["city_35"],[6,0],[4,1],[1,1],[0],[1],[0,0],[0,0,1500,EAST]] call NTA_fnc_eos_core;	//petite ville passée en bastion

// Oreokastro 045214 34batiments
null = [["city_28"],[15,0],[3,1],[1,1],[0],[1],[0,0],[0,0,1500,EAST]] call NTA_fnc_eos_core; 	//petite ville

// Sfaka 091081 5batiments
null = [["city_44"],[1,2],[2,1],[1,1],[0],[1],[0,0],[0,0,1500,EAST]] call NTA_fnc_eos_core; 	//petite ville

// Vikos 117094 7batiments
null = [["city_45"],[6,0],[4,1],[1,1],[0],[1],[0,0],[0,0,1500,EAST]] call NTA_fnc_eos_core; 	//petite ville








//airfield



null = [["airfield_1_1"],[4,1],[2,0],[1],[0,0],[0,0,EAST,TRUE,FALSE],[360,1 + floor (random 2),100 + (random 300),TRUE,TRUE]] call NTA_fnc_eos_bastionCore; //moyen
null = [["airfield_1_2"],[4,1],[2,0],[1],[0,0],[0,0,EAST,TRUE,FALSE],[360,1 + floor (random 2),100 + (random 300),TRUE,TRUE]] call NTA_fnc_eos_bastionCore; //moyen
//null = [["airfield_1_3"],[4,1],[2,0],[1],[1,5],[0,0,EAST,TRUE,FALSE],[360,3,300,TRUE,TRUE]] call NTA_fnc_eos_bastionCore; //moyen
null = [["airfield_1_4"],[4,1],[2,0],[1],[0,0],[0,0,EAST,TRUE,FALSE],[360,1 + floor (random 2),100 + (random 300),TRUE,TRUE]] call NTA_fnc_eos_bastionCore; //moyen
null = [["airfield_1_5"],[4,1],[2,0],[1],[0,0],[0,0,EAST,TRUE,FALSE],[360,1 + floor (random 2),100 + (random 300),TRUE,TRUE]] call NTA_fnc_eos_bastionCore; //moyen
null = [["airfield_1_6"],[4,1],[2,0],[1],[0,0],[0,0,EAST,TRUE,FALSE],[360,1 + floor (random 2),100 + (random 300),TRUE,TRUE]] call NTA_fnc_eos_bastionCore; //moyen


null = [["tower_1"],[2,1],[4,1],[2,1],[1],[2],[1,0],[0,0,1500,EAST]] call NTA_fnc_eos_core;
null = [["tower_2"],[2,1],[4,1],[2,1],[1],[2],[1,0],[0,0,1500,EAST]] call NTA_fnc_eos_core;
null = [["tower_3"],[2,1],[4,1],[2,1],[1],[2],[1,0],[0,0,1500,EAST]] call NTA_fnc_eos_core;



null = [["base_1_1"],[2,2],[6,2],[3,1],[4],[4],[3,1],[0,0,1500,EAST]] call NTA_fnc_eos_core;
null = [["base_1_2"],[2,2],[6,2],[3,1],[4],[4],[3,1],[0,0,1500,EAST]] call NTA_fnc_eos_core;
null = [["base_1_3"],[2,2],[6,2],[3,1],[4],[4],[3,1],[0,0,1500,EAST]] call NTA_fnc_eos_core;
null = [["base_1_4"],[2,2],[6,2],[3,1],[4],[4],[3,1],[0,0,1500,EAST]] call NTA_fnc_eos_core;
null = [["base_1_5"],[2,2],[6,2],[3,1],[4],[4],[3,1],[0,0,1500,EAST]] call NTA_fnc_eos_core;
null = [["base_1_6"],[2,2],[6,2],[3,1],[4],[4],[3,1],[0,0,1500,EAST]] call NTA_fnc_eos_core;
//null = [["airfield_1_1","airfield_1_2","airfield_1_3","airfield_1_4","airfield_1_5","airfield_1_6"],[2,0],[6,1],[2,1,90],[2,90],[4],[2,0],[0,0,1500,EAST]] call NTA_fnc_eos_core;

// Zorrobyte's procedural markers
/*waitUntil {ztowninit==1};
{[[_x],[2,0],[1,1],[1,0,50],[0],[1],[0,0],[2,1,400,WEST,FALSE]] call NTA_fnc_eos_core} forEach ztownloc;
{[[_x],[0,0],[6,1],[2,0,80],[1],[2],[1,1,50],[0,0,400,EAST]] call NTA_fnc_eos_core} forEach ztowns;
{[[_x],[0,0],[10,1],[3,0,80],[1],[4],[1,1,60],[0,0,400,EAST]] call NTA_fnc_eos_core} forEach ztownm;
*/
missionNamespace setvariable ["EOSDone", true];
publicVariable "EOSDone";
"EOS Done..." call NTA_fnc_log;