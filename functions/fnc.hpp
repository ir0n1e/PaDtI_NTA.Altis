	class NTA {
		tag = "NTA";
		class Core {
			file = "functions\Core";
			class addToarray;
			class all_airunits;
			class all_boxes{postInit=1;};
			class all_houses;
			class all_vehicles;
			class all_publicvehicles;
			class core_findnearunits;
			class core_findnearestobject;
			class getRandArrayPos;
			class getRandHousePos;
			class getRandMkrLocs;
			class houseicons;
			class leftorright;
			class log{preInit=1;};
			class note;
			class playerinvehicle;
			class skiptime;
			class standardItems_player;
			class vehiclecamera;
			class welcome;
			class publicwelcome;
			class core_checkVehicleRights;
			class core_debug;
			class core_addTicketEH{postinit=1;};
			class core_addTickets;
			class core_nightTime;
			class core_isAdmin;
			class core_serverfps;
			class arraySplit;
			class weather;
			class core_diary;
			class core_debugHC;
			class spawnFlare;
			class setDate;
			class cleanUp;
		};
		class Init {
			file = "functions\Init";
			class initServer;
			class initPlayer;
			class init;
			class initHC{postinit=1;};
		};

		class EOS {
			file = "functions\EOS";
			class eos_init;
			class eos_core;
			class eos_spawn;
			class eos_delete;
			class eos_getUnitPool;
			class eos_setSkill;
			class eos_spawnVehicle;
			class eos_setCargo;
			class eos_spawnGroup;
			class eos_skillSet{postinit=1;};
			class eos_bastionCore;
			class eos_bastionLoop;
			class eos_bastionSpawn;
			class eos_postInit;
		};

	class Houses {
		file = "functions\houses";
		class lock_houses;
		class unlock_houses;
		class houses_perplayer;
		class create_door_trigger;
	};
	class Players {
		file = "functions\players";
		class allplayers;
		class players_actions;
		class players_adminactions;
		class players_publicinit;
		class players_id;
		class engineers;
		class players_modinfo;
		class players_viewDistance;
		class players_respawnSwitch;
		class players_saveGear;
		class players_loadGear;
		class players_loadGearSmall;
	};
	class Crate {
		file = "functions\crate";
		class crate_agm;
		class crate_agmmedsys_all;
		class crate_agmmedsys_medic;
		class crate_all;
		class crate_ammobox;
		class crate_at;
		class crate_auto;
		class crate_BWplusWeapons;
		class crate_clear_all;
		class crate_crew;
		class crate_engineer;
		class crate_exp;
		class crate_fill;
		class crate_ghost;
		class crate_gren;
		class crate_hunter;
		class crate_jtac;
		class crate_launcher;
		class crate_leader;
		class crate_marshall;
		class crate_medic;
		class crate_medicbox;
		class crate_playervariables;
		class crate_respawn;
		class crate_rifle;
		class crate_sniper;
		class crate_tfr;
		class crate_xmedsys_all;
		class crate_xmedsys_medic;
		class crate_expBox;
		class crate_waterBox;
	};
	class Alive {
		file = "functions\Alive";
		class alive_cqb_blacklist;
		class alive_faction_bwa3;
		class init_alive;
		class pause_alive;
		class unpause_alive;
	};

	class TaskForce {
		file = "functions\TaskForce";
		class taskforce_radioblocker;
		class taskforce_init;
	};
	class Vehicles {
		file = "functions\Vehicles";
		class vehicles_addwaypoint;
		class vehicles_artydoFire;
		class vehicles_create;
		class vehicles_createArty;
		class vehicles_createFire;
		class vehicles_createPatrol;
		class vehicles_createStatic;
		class vehicles_delete;
		class vehicles_info;
		class vehicles_init;
		class vehicles_lock;
		class vehicles_respawn;
		class vehicles_respawnnow;
		class vehicles_setInit;
		class vehicles_setVarName;
		class vehicles_unitLoadout;
		class vehicles_unlock;
		class vehicles_emplacement;
		class vehicles_defaults;
	};
	class BWplus {
		file = "functions\BWplus";
		class BWplus_checkVehicleRights;
	};
	class Airpatrol {
		file = "functions\airpatrol";
		class airpatrol_addwaypoints;
		class airpatrol_agmAddaction;
		class airpatrol_agmOpenChopperMenu;
		class airpatrol_agmOpenInsertMenu;
		class airpatrol_bombs;
		class airpatrol_callCAS;
		class airpatrol_callCAScondition;
		class airpatrol_callCsatPlane;
		class airpatrol_callGroup;
		class airpatrol_callRandom;
		class airpatrol_combatInsertion;
		class airpatrol_Create;
		class airpatrol_debug;
		class airpatrol_init;
		class airpatrol_insertParaTroops;
		class airpatrol_insertTroops;
		class airpatrol_movegroupHome;
		class airpatrol_movehomeCondition;
		class airpatrol_movein;
		class airpatrol_ParaDrop;
		class airpatrol_task;
		class airpatrol_userInsertCam;
		class airpatrol_userInsertion;
		class airpatrol_agmOpenParaMenu;
		class airpatrol_agmOpenParaConfMenu;
	};
	class Base {
		file = "functions\Base";
		class base_shoothouse;
		class base_shootingrange;
		class base_weapons;
		class base_Wind;
		class base_unitItems;
	};

	class Civilians {
		file = "functions\Civilians";
		class civilians_agent;
		class civilians_breakPatrol;
		class civilians_core;
		class civilians_debug;
		class civilians_delete;
		class civilians_handleShots;
		class civilians_init;
		class civilians_patrol;
		class civilians_riot;
		class civilians_setDefaults;
		class civilians_townInfo;
	};

	class AGM {
		file = "functions\AGM";
		class agmmedsys_init;
		class agmlogistics_init;
		class agmopenvehiclesinfo;
		class agmopenvehicleslist;
		class agmopentaskmenu;
		class agm_addInteractionSelf;
		class agm_addadminActions;
		class agm_openadminmenu;
		class agm_openplayerlist;
		class agm_openplayermenu;
		class agm_openticketmenu;
		class agm_WeaponsActions;
		class agm_WeaponsMenuSave;
		class agm_WeaponsMenuLoad;
		class agm_openPlayerStats;
		class agm_openNTAplayerMenu;
		class agm_viewSettingsMenu;
	};
	class RAVlifter {
		file = "functions\RAVlifter";
		class RAVlifter_init;
	};
	class shoothouse {
		file = "functions\Shoothouse";
		class shoothouse_popup;
		class shoothouse_reset;
		class shoothouse_count;
	};

	class Lamps {
		file = "functions\Lamps";
		class lamps_actions;
		class lamps_create;
		class lamps_LampSwitch;
		class lamps_LampSwitchAll;
		class lamps_runwayCreate;
		class lamps_runwayFlash;
		class lamps_runwaySwitch;
	};
	class mcc {
		file = "functions\MCC";
		class mcc_createvehicle;
		class mcc_init;
	};
	class missions {
		file = "functions\Missions";
		class missions_mortar;
		class missions_island;
		class missions_roadblock;
		class missions_addTask;
		class missions_compFuel;
		class missions_compCommand;
		class missions_Dam;
		class missions_DamPatrols;
		class missions_DamCreate;
		class missions_DamExp;
	};
	class INIDB {
		file = "functions\INIDB";
		class inidb_writeWeapon;
		class inidb_readWeapon;
		class inidb_writePlayerStats;
		class inidb_readPlayerStats;
		class inidb_NTAusers;
		class inidb_init;
		class inidb_viewSettings;
	};
	class curator {
		file = "functions\curator";
		class curator_init;
		class grpPlaced;
		class objPlaced;
	};
};
/*
class DLL
{

	class Towing
	{
		file = "functions\TOW";
		class moduleTowing{};
		class syncTowing{};
		class config{};
		class initT{};
		class action_attach{};
		class action_detach{};
		class searchP{};
		class tow{};
	};
};
*/
class PO3 {
	tag = "PO3";
	class Camera {
		file = "functions\PO3\camera";
		class camera_fadein;
		class camera_fadeout;
		class camera_path;
		class camera_Restrict3rdPerson;
		class introsequence;
		class outrosequence;
	};

	class EventHandlers {
		file = "functions\PO3\eventhandlers";
		class setContactStartEH_CRV;
		class setDamageEH;
		class setDamageEH_AI;
		class setDamageEH_C4Only;
		class setFiredEH;
		class setHealEH;
		class setKilledEH;
		class setRespawnEH;
	};

	class Interactions {
		file = "functions\PO3\interact";
		class checkActionBusy;
		class setActionBusy;
		class interaction_else {ext=".fsm";};
		class interaction_self {ext=".fsm";};
	};

	class Core {
		file = "functions\PO3\core";
		class animateUnit;
		class boundingBoxLWH;
		class change_direction;
		class checkObjCondition;
		class diary;
		class init;
		class isAdministrator;
		class log;
		class playActionNow;
		class requestOwnership;
		class setOwner;
		class setDir;
		class protector;
		class addToarray;
		class arrayShuffle;
		class consolidateArray;
		class getArrayRandom;
		class processParams;
		class sortBy;
		class getCfgIcon;
		class getCfgPO3;
		class getCfgPO3Loadout;
		class getCfgPicture;
		class getCfgText;
		class getVehicleTypes;
		class hlc_assignOwner;
		class hlc_sendKeepAlive;
	};
	class Creator {
		file = "functions\PO3\creator";
		class cleanup;
		class createGroup;
		class createMinefield;
		class createObjects;
		class createStaticDefense;
		class createVehicle;
		class getpreDefinedSquads;
		class getpreDefinedVehicles;
		class setObjectRespawn;
		class objectrespawn;
		class crewSpawner;
		class squadSpawner;
		class objectSpawner;
		class objectsSpawner;
		class vehicleSpawner;
		class ambientAirPatrols;
		class ambientGroundPatrols;
		class ambientIEDs;
		class groupAmbushPos;
		class groupAttackPos;
		class groupDefendPos;
		class groupPatrolArea;
		class groupMove;
		class groupOccupyVehicle;
		class supportCreateChute;
		class supportCreateHeloReinforcements;
		class supportCreateUAV;
		class supportCreateUGV;
	};
	class Position {
		file = "functions\PO3\position";
		class getflatarea;
		class getNearbyBuildings;
		class getNearbyPlayers;
		class getNearbyUnits;
		class getpos;
		class getSafePos;
		class getNearbylocations;
		class nearestlocation;
		class nearestroad;
		class findclosestposition;
		class getmarkercorners;
		class getmarkershape;
		class getposarray;
		class getposfromcircle;
		class getposfromellipse;
		class getposfromrectangle;
		class getposfromsquare;
		class getposmarker;
		class getposradius;
		class isblacklisted;
		class isincircle;
		class isinellipse;
		class isinrectangle;
		class issameposition;
		class rotateposition;
		class getLocationsOnRoute;
		class getNewPos;
		class registerGridSectors;
		class registerLocations;
		class checkNearEntities;
	};

	class Intel {
		file = "functions\PO3\intel";
		class chat;
		class hint;
		class progressbar;
		class sendChat;
		class sendHint;
		class sendProgressBar;
		class showTacticalText;
		class text_cursortarget;
		class text_sitrep;
		class text_tactical;
		class drawIcon;
		class getGroupColour;
		class getGroupSizeMarkerType;
		class getObjectMarkerType;
		class getUnitMarkerColour;
		class hideGroupMarker;
		class hideMarkers;
		class worldsize;
		class grpmark_detectGroups;
		class grpmark_detectTeam;
		class grpmark_detectUAV;
		class grpmark_draw;
		class drawIcon3D;
		class hud_getTeamColour;
		class hud_getUnitIcon;
		class hud_assignedTeamWatcher;
		class progressbar_display;
		class roundInterger;
		class world2Screen;
		class crewlist;
		class display_init;
		class GUI_display;
		class GUI_settings;
		class GUI_settings_slider;
		class keypress;
	};

	class Tasks {
		file = "functions\PO3\taskmaster";
		class runTaskSequence;
		class runTasksRandom;
		class addTask;
		class getTaskState;
		class hasTaskState;
		class isTaskcompleted;
		class updateTask;
		class addLocalTask;
		class addTaskNote;
		class assignTask;
		class getAssignedTasks;
		class handleTaskEvent;
		class hasLocalTask;
		class hasTask;
		class hasTaskStateChanged;
		class showTaskHint;
		class skipTask;
		class taskmaster;
		class updateLocalTask;
	};
};
class IL {
	tag = "IL";
	class Core {
		file = "functions\vehicle_lights";
		class actions;
		class config;
		class init;
		class inList;
		class returnTurretUnits;
		class switchGreen;
		class switchGreenCondition;
		class switchOn;
		class switchOnCondition;
	};
};
