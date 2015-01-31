if (!isserver) exitWith {};
private ["_markerpos", "_grp","_marker_heli","_objects","_briefing2","_side","_skill"];
//[13574.2,12189.5,0.00148296]

//islandhouse=createmarker ["Island_House", [13580.9,12196.2]];
//islandhouse setMarkersize [50,55];

//island = createMarker ["island",[13500.2,12040]];
//island setmarkersize [1000,1000];

fnc_pilots = {

	private ["_p_grp"];
	_p_grp = createGroup West;
	//pilot1 = "B_Helipilot_F" createVehicle [13574.2,12189.5,0.00148296];
	//pilot2 = "B_Helipilot_F" createVehicle [13574.2,12189.5,0.00148296];
"B_Helipilot_F" createUnit [[13574.2,12189.5,0.00148296], _p_grp,"pilot1 = this"];
"B_Helipilot_F" createUnit [[13574.2,12189.5,0.00148296], _p_grp,"pilot2 = this"];


	[pilot1, "pilot1_Handcuffed", true] call AGM_Interaction_fnc_setCaptivityStatus;
	[pilot2, "pilot2_Handcuffed", true] call AGM_Interaction_fnc_setCaptivityStatus;

	pilot1 setdamage 0.5;
	pilot2 setdamage 0.5;

	removeAllAssignedItems pilot1;
	removeAllAssignedItems pilot2;
	removeAllWeapons pilot1;
	removeHeadgear pilot1;
	removeAllWeapons pilot2;
	removeHeadgear pilot2;

	pilot1 addAction["<t color='#ff0000'>Befreien</t>",{pilot1 setCaptive false; pilot2 setcaptive false;pilot1 enableAI "Move"; pilot2 enableAI "Move" ;[pilot1,pilot2] join player }, nil, 6, false, true, '',''];

	[] spawn {
		waitUntil {(pilot1 distance Hospital < 8) or (pilot2 distance Hospital < 8)};
		["Task13","succeeded"] call SHK_Taskmaster_upd;
		["Task12","succeeded"] call SHK_Taskmaster_upd;

	};

	[] spawn {
		waituntil {(!alive pilot1) && (!alive pilot2)};

		["Task13","failed"] call SHK_Taskmaster_upd;
		["Task12","failed"] call SHK_Taskmaster_upd;
	};
};



fnc_island = {
	private ["_marker","_grp1","grp2","_skill","_hmg","_init","_markerpos","_side","_briefing","_skill","_markerpos"];

	_briefing = format ["<t align='center' size='2.2'>Prioritäts Ziel:</t><br/><t size='1.5' color='#b60000'>Funkturm und Sam Stellung</t><br/>____________________<br/><br/>Die Aufklärung hat gemeldet, dass es eine Samstellung und einen Funkturm auf der Insel gibt.<br/><br/>Aufgabe: Finden Sie die Stellung und zerstören Sie sie.<br/>"];

	_marker = "Island";
	_side = createCenter EAST;

	_grp1 = createGroup east;
	_grp2 = createGroup east;

	_skill = 0.75;
	hmg = [["EMPTY","O_HMG_01_high_F",[13611.7,12302.9,-0.0658245],309.382,""],["EMPTY","O_HMG_01_F",[13714.2,12301.8,0.038126],171.631,""],["EMPTY","O_HMG_01_high_F",[13579.2,12196.5,-0.111849],300.686,";_this setpos [13578.8,12196.7,2.775];"]];



	_init="[ _this, createGroup east ] call bis_fnc_spawncrew;";
	[hmg,false,_init] call NTA_fnc_mcc_createvehicle;


	_markerpos = getMarkerPos _marker;
	_grp1 = [_markerpos, _side, (configfile >> "CfgGroups" >> "East" >> "OPF_G_F" >> "Infantry" >> "ORG_InfTeam")] Call BIS_fnc_spawnGroup;
	{_x setSkill _skill} forEach units _grp1;
	_null=[leader _grp1,_marker,"random","delete:",120, "min:",3,"max:",3] execVM "scripts\UPSMON.sqf";

	_marker = "Island_house";
	_markerpos = getMarkerPos _marker;
	_grp2 = [_markerpos, _side, (configfile >> "CfgGroups" >> "East" >> "OPF_G_F" >> "Infantry" >> "ORG_InfTeam")] Call BIS_fnc_spawnGroup;
	{_x setSkill _skill} forEach units _grp2;
	_null=[leader _grp2,_marker,"fortify","delete:",120, "min:",1,"max:",1] execVM "scripts\UPSMON.sqf";



_briefing spawn {

	      waituntil  {(player distance objective2) <= 300};
	        ["Task10","Sam Stellung",_this] call SHK_Taskmaster_add;
};



	objective2 allowDamage true;
	objective3 allowDamage true;

	objective2 addEventHandler ["Explosion", {
		if (!alive objective2 && !alive objective4) then {
			["Task10","succeeded"] call SHK_Taskmaster_upd;
			//[nil,"objective2 setdamage 1",nil,false] spawn BIS_fnc_MP
		};
	}];
	objective4 addEventHandler ["Explosion", {
		if (!alive objective2 && !alive objective4) then {
			["Task10","succeeded"] call SHK_Taskmaster_upd;
			//[nil,"objective3 setdamage 1",nil,false] spawn BIS_fnc_MP
		};
	}];


};

_briefing2 = format ["<t align='center' size='2.2'>Prioritäts Ziel:</t><br/><t size='1.5' color='#b60000'>Blackfood Down</t><br/>____________________<br/><br/>Die Aufklärung hat gemeldet, dass ein Blackfood in der Nähe von Faronaki abgeschossen wurde.<br/><br/>Aufgabe: Finden Sie die Piloten, sprengen sie den Hubschrauber und bringen sie die Piloten in die Basis zurück.<br/>"];



_objects = [["EMPTY","ModuleMine_APERSTripMine_F",[13513.6,12193.7,0],0.023836,""],["EMPTY","ModuleMine_APERSTripMine_F",[13511.7,12192.2,0],277.996,""],["EMPTY","ModuleMine_APERSTripMine_F",[13504.7,12139,0],0.669022,""],["EMPTY","ModuleMine_APERSTripMine_F",[13520.1,12156.2,5.45979e-005],0.36928,""],["EMPTY","B_Heli_Attack_01_F",[15069,11222.7,-0.00451183],359.916,"objective1=_this;_this setdamage 0.5"],["EMPTY","Land_TTowerBig_2_F",[13412.8,11882.1,0.938938],326.675,"objective2=_this"],["EMPTY","Intel_File1_F",[15075.4,11221.4,0.00137901],359.631,"objective3=_this;[_this,""fsfsd""] call bis_fnc_initIntelObject"],["EMPTY","O_APC_Tracked_02_AA_F",[13432.8,11893.3,0.0713215],0.161686,"objective4=_this"]];




[_objects,false] call NTA_fnc_mcc_createvehicle;

waitUntil { !isNil "objective1" && !isnil "objective2" && !isnil "objective3"};
objective2 allowdamage false;
objective4 allowdamage false;
_marker_heli = createMarker ["Heli", [(position objective1)select 0,(position objective1) select 1,0]];
objective1 allowDamage true;
_marker_heli setMarkerSize [200,200];
_side = createCenter EAST;
_grp = createGroup east;
_skill = 0.75;

_markerpos = getMarkerPos _marker_heli;
	_grp = [_markerpos, _side, (configfile >> "CfgGroups" >> "East" >> "OPF_G_F" >> "Infantry" >> "ORG_InfTeam")] Call BIS_fnc_spawnGroup;
	{_x setSkill _skill} forEach units _grp;
	_null=[leader _grp,_marker_heli,"random","delete:",120, "min:",2,"max:",2] execVM "scripts\UPSMON.sqf";






["Task11","Blackfoot zerstören","Zerstören Sie den Hubschrauber."] call SHK_Taskmaster_add;
["Task12","Blackfoot Down",_briefing2] call SHK_Taskmaster_add;
publicvariable "objective1";


objective1 addEventHandler ["Explosion",{

		objective1 setdamage 1;
		["Task11","succeeded"] call SHK_Taskmaster_upd;
	}];


_text= ["Hilferuf","<br /><execute expression=""['Task13','Piloten Retten','Finden Sie die Piloten auf Makrynisi. Bringen Sie sie in die Basis zurück'] call SHK_Taskmaster_add;"">Wir sind nach Makrynisi verschleppt worden.</execute><br />",""];

 [[objective3,"RscAttributeDiaryRecord",_text], "bis_fnc_setServerVariable",true,true] spawn BIS_fnc_MP;

waituntil{! alive objective1};
['Task13','Piloten Retten','Finden Sie die Piloten auf Makrynisi. Bringen Sie sie in die Basis zurück'] call SHK_Taskmaster_add;
	call fnc_island;
	call fnc_pilots;