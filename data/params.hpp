// =========================================================================================================
// !!  DO NOT MODIFY THIS FILE  !!
// =========================================================================================================
class NTA_Options {
	title = "====== NTA Options ======";
	values[]= {0};
	texts[]= {" "};
	default = 0;
	code = "";
};
class NTA_TIME {
	title = "Mission Hour";
	values[]={0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23};
	default=7;
	texts[]={"0000H","0100H","0200H","0300H","0400H","0500H","0600H","0700H","0800H","0900H","1000H","1100H","1200H","1300H","1400H","1500H","1600H","1700H","1800H","1900H","2000H","2100H","2200H","2300H"};
	code = "PO3_param_missionhour = %1;";
};

class NTA_EVENT {
	title = "EVENT? (No vehicle respawn)";
	values[] = {0,1};
	texts[] = {"OFF","ON"};
	default = 0;
};
class NRF_TRAINING {
	title = "Training? (3rd Person view for vehicles)";
	values[] = {0,1};
	texts[] = {"OFF","ON"};
	default = 0;
};
class NTA_TRAINING_Shoothouse {
	title = "Schoothouse Targets?";
	values[] = {0,1};
	texts[] = {"OFF","ON"};
	default = 1;
};
class NTA_TRAINING_Shootingrange {
	title = "Schootingrange Targets?";
	values[] = {0,1};
	texts[] = {"OFF","ON"};
	default = 1;
};
class NTA_Airpatrol {
	title = "Airpatrol? ( if (Trainig) then {!Airpatrol}; )";
	values[] = {0,1};
	texts[] = {"OFF","ON"};
	default = 1;
};
class NTA_Civilians {
	title = "Civilians?";
	values[] = {0,1};
	texts[] = {"OFF","ON"};
	default = 1;
};
class NTA_EOSsystem {
	title = "EOS?";
	values[] = {0,1};
	texts[] = {"OFF","ON"};
	default = 0;
};
class NTA_Tickets {
		title = "Tickets";
		values[] = {0, 500, 600, 800, 1000};
		texts[] = {"OFF", 500, 600, 800, 1000};
		default = 800;
};
class NTA_Cache {
	title = "Cache Units Not functional (zbe_cache)";
	values[] = {0,1};
	texts[] = {"False","True"};
	default = 0;
};
class NTA_Weather {
	title = "Dynamic Weather? (Real Weather edit by Ir0n1E)";
	values[]={0,1};
	texts[]={"False", "True"};
	default=1;
};
class NTA_haveAGMBWA3 {
	title = "Show warning for players without AGM/BWA3";
	values[]={0,1};
	texts[]={"False", "True"};
	default=1;
};
class NTA_Lights {
	title = "Interior Light script";
	values[]={0,1};
	texts[]={"False", "True"};
	default=1;
};
class PO3_param_missions_zeus {
	title = "====== ZEUS Options ======";
	values[]= {0};
	texts[]= {" "};
	default = 0;
	code = "";
};
class PlayerEditingAreaSize {
	title = $STR_A3_MP_ZGM_m11.Altis_Params_PlayerEditingAreaSize;
	values[] = {0,100,200,500,1000};
	texts[] = {0,100,200,500,1000};
	default = 500;
};
class PO3_param_missions_title {
	title = "====== PO3 Mission Options ======";
	values[]= {0};
	texts[]= {" "};
	default = 0;
	code = "";
};

	class param_PO3_missioncount {
		title = "Number of Missions";
		values[]={1,2,3,5,7,9,15,30,99};
		texts[]={"One","Two","Three","Five","Seven","Nine","Fifteen","Thirty","Unlimited"};
		default=99;
		code = "PO3_param_missioncount = if(%1 < 99)then{%1}else{-1};";
	};
	class param_PO3_missionskill {
		title = "Mission Difficulty";
		values[]={1,2,4,6};
		texts[]={$STR_PO3_TEXT_LOW,$STR_PO3_TEXT_MED,$STR_PO3_TEXT_HIGH,$STR_PO3_TEXT_ULTRA};
		default=2;
		code = "PO3_param_missionskill = (%1/3);";
	};
	class param_PO3_ai_skill {
		title = $STR_PO3_PARAM_SETAISKILL;
		values[]={1,2,3,4};
		texts[]={$STR_PO3_TEXT_LOW,$STR_PO3_TEXT_MED,$STR_PO3_TEXT_HIGH,$STR_PO3_TEXT_ULTRA};
		default=2;
		code = "PO3_param_ai_skill = 0.8 + log((%1)/4)";
	};
	class param_PO3_ai_Tkill {
		title = $STR_PO3_PARAM_SETAITKILL;
		values[]={0,1};
		texts[]={$STR_PO3_TEXT_NO,$STR_PO3_TEXT_YES};
		default=0;
		code = "PO3_param_ai_easyKill = if(%1 > 0)then{true}else{false};";
	};
/*
class PO3_param_ambient_title {
	title = "====== PO3 Ambient Options ======";
	values[]= {0};
	texts[]= {" "};
	default = 0;
	code = "";
};
	class param_PO3_ambientair {
		title = "Ambient Air Patrols";
		values[]={0,1};
		texts[]={$STR_PO3_TEXT_OFF,$STR_PO3_TEXT_ON};
		default=0;
		code = "PO3_param_ambientpatrolair = if(%1 > 0)then{true}else{false};";
	};
	class param_PO3_ambientgnd {
		title = "Ambient Ground Patrols";
		values[]={0,400,600,800,1200};
		texts[]={$STR_PO3_TEXT_OFF,$STR_PO3_TEXT_LOW,$STR_PO3_TEXT_MED,$STR_PO3_TEXT_HIGH,$STR_PO3_TEXT_ULTRA};
		default=0;
		code = "PO3_param_ambientpatrolgnd = if(%1 > 0)then{ PO3_count_ambientpatrolgnd = %1; true}else{false};";
	};
	class param_PO3_ambientradius {
		title = "Ambient Spawn Radius";
		values[]={0,500,1000,1500,2000,2500,5000,10000};
		texts[]={$STR_PO3_TEXT_OFF,"500","1000","1500","2000","2500","5000","10000"};
		default=0;
		code = "PO3_radius_ambientpatrolgnd = %1;";
	};

class PO3_param_injury_title {
	title = $STR_PO3_PTITLE_INJURY;
	values[]= {0};
	texts[]= {" "};
	default = 0;
	code = "";
};
	class param_PO3_injury_factor {
		title = $STR_PO3_PARAM_INJURYTOLERANCE;
		values[]={1,2,4,6,8};
		texts[]={$STR_PO3_TEXT_NONE,$STR_PO3_TEXT_LOW,$STR_PO3_TEXT_MED,$STR_PO3_TEXT_HIGH,$STR_PO3_TEXT_VHIGH};
		default=4;
		code = "PO3_param_injury_factor = %1";
	};
	class param_PO3_injury_down {
		title = $STR_PO3_PARAM_INJURYDOWN;
		values[]={0,1};
		texts[]={$STR_PO3_TEXT_NO,$STR_PO3_TEXT_YES};
		default=1;
		code = "PO3_param_injury_down = if(%1 > 0)then{true}else{false};";
	};

class PO3_param_respawn_title {
	title = $STR_PO3_PTITLE_RESPAWN;
	values[]= {0};
	texts[]= {$STR_PO3_TEXT_ENABLED};
	default = 0;
	code = "";
};
	class param_PO3_respawn_playertime {
		title = $STR_PO3_PARAM_RESPAWNTIME;
		values[]={10,20,30,40,50,60,70,90,120,300};
		texts[]={"10","20","30","40","50","60","70","90","120","300"};
		default=10;
		code = "PO3_param_respawn_playertime = %1;";
	};
	class param_PO3_respawn_rallypoint {
		title = $STR_PO3_PARAM_RESPAWNRALLY;
		values[]={0,1};
		texts[]={$STR_PO3_TEXT_NO,$STR_PO3_TEXT_YES};
		default=0;
		code = "PO3_param_respawn_rallypoint_allow = if(%1 > 0)then{true}else{false};";
	};
	class param_PO3_respawn_halo_allow {
		title = $STR_PO3_PARAM_RESPAWNHALO;
		values[]={0,1};
		texts[]={$STR_PO3_TEXT_NO,$STR_PO3_TEXT_YES};
		default=0;
		code = "PO3_param_respawn_halo_allow = if(%1 > 0)then{true}else{false};";
	};
	class param_PO3_respawn_halo_time {
		title = $STR_PO3_PARAM_RESPAWNHALOTIME;
		values[]={0,60,300,600,900,1200,1800,3600,7200,86400};
		texts[]={"None","1min","5mins","10mins","15mins","20mins","30mins","60mins","120mins","24hrs"};
		default=60;
		code = "PO3_param_respawn_halo_time = %1;";
	};
	class param_PO3_respawn_deathcount {
		title = $STR_PO3_PARAM_RESPAWNLIVES;
		values[]={0,1,2,3,5,7,9,25,99};
		texts[]={$STR_PO3_TEXT_NONE,"One","Two","Three","Five","Seven","Nine","Many","Unlimited"};
		default=99;
		code = "PO3_param_respawn_deathcount = if(%1 < 99)then{%1}else{-1};";
	};

class PO3_param_gameplay_title {
	title = $STR_PO3_PTITLE_GAMEOPTIONS;
	values[]= {0};
	texts[]= {" "};
	default = 0;
	code = "";
};
	class param_PO3_ingameradio {
		title = $STR_PO3_PARAM_GAMERADIO;
		values[]={0,1};
		texts[]={$STR_PO3_TEXT_OFF,$STR_PO3_TEXT_ON};
		default=0;
		code = "if(%1 > 0)then{ enableRadio true; 0 fadeRadio 0; enableSentences true; }else{ 0 fadeRadio 0; enableRadio false; enableSentences false; };";
	};
	class param_PO3_grpmark_icons {
		title = $STR_PO3_PARAM_GRPMARK_GRP;
		values[]={0,1};
		texts[]={$STR_PO3_TEXT_NO,$STR_PO3_TEXT_YES};
		default=0;
		code = "PO3_param_grpmark_allow = if(%1 > 0)then{true}else{false};";
	};

	class param_PO3_grpmark_squadicons {
		title = $STR_PO3_PARAM_GRPMARK_SQD;
		values[]={0,1};
		texts[]={$STR_PO3_TEXT_NO,$STR_PO3_TEXT_YES};
		default=0;
		code = "PO3_param_grpmark_squad_allow = if(%1 > 0)then{true}else{false};";
	};

class PO3_param_playergame_title {
	title = $STR_PO3_PTITLE_PLAYROPTIONS;
	values[]= {0};
	texts[]= {" "};
	default = 0;
	code = "";
};

	class param_PO3_player_fatigue {
		title = $STR_PO3_PARAM_PLAYRFATIGUE;
		values[]={0,1};
		texts[]={$STR_PO3_TEXT_DISABLED,$STR_PO3_TEXT_ENABLED};
		default=1;
		code = "PO3_param_player_fatigue = if(%1 > 0)then{true}else{false};";
	};

	class param_PO3_hud_squadlist {
		title = $STR_PO3_PARAM_HUDGLASSES;
		values[]={0,1};
		texts[]={$STR_PO3_TEXT_ALLOW,$STR_PO3_TEXT_FORCEOFF};
		default=0;
		code = "PO3_param_hud_requireGlasses = if(%1 > 0)then{true}else{false};";
	};
	class param_PO3_hud_grassview {
		title = $STR_PO3_PARAM_HUDGRASS;
		values[]={0,1};
		texts[]={$STR_PO3_TEXT_ALLOW,$STR_PO3_TEXT_FORCEOFF};
		default=0;
		code = "PO3_param_hud_grassview = %1";
	};

	class param_PO3_camera_3dvwalker {
		title = $STR_PO3_PARAM_3DVWALKER;
		values[]={0,1};
		texts[]={$STR_PO3_TEXT_NO,$STR_PO3_TEXT_YES};
		default=0;
		code = "PO3_param_camera_restrict_3dvwalker = if(%1 > 0)then{true}else{false};";
	};

class PO3_param_enviro_title {
	title = $STR_PO3_PTITLE_AMBIENT;
	values[]= {0};
	texts[]= {" "};
	default = 0;
	code = "";
};


	class param_PO3_enviro_weather {
		title = $STR_PO3_PARAM_AMBWEATHER;
		values[]={0,1};
		texts[]={$STR_PO3_TEXT_NO,$STR_PO3_TEXT_YES};
		default=1;
		code = "PO3_param_ambient_weather_enable = if(%1 > 0)then{true}else{false};";
	};
	*/
class NTA_Vehicle_Options {
	title = "====== NTA Vehicle Options ======";
	values[]= {0};
	texts[]= {" "};
	default = 0;
	code = "";
};
class params_NTA_BWPLUS {
		title = "Bw.Plus Vehicles?";
		values[] = {0,1};
		texts[] = {"False","True"};
		default = 1;
	};

class NTA_Vehicles
	{
		title = "All Vehicles?";
		values[] = {0,1};
		texts[] = {"False","True"};
		default = 0;
	};
class NTA_Puma1
	{
		title = "Puma 1";
		values[] = {0,1};
		texts[] = {"False","True"};
		default = 1;
	};
	class NTA_Puma2
	{
		title = "Puma 2";
		values[] = {0,1};
		texts[] = {"False","True"};
		default = 1;
	};
	class NTA_Leo1
	{
		title = "Leopard 1";
		values[] = {0,1};
		texts[] = {"False","True"};
		default = 1;
	};
	class NTA_Leo2
	{
		title = "Leopard 2";
		values[] = {0,1};
		texts[] = {"False","True"};
		default = 1;
	};
	class NTA_APC1
	{
		title = "APC 1";
		values[] = {0,1};
		texts[] = {"False","True"};
		default = 1;
	};
	class NTA_APC2
	{
		title = "APC 2";
		values[] = {0,1};
		texts[] = {"False","True"};
		default = 1;
	};
	class NTA_CRV1
	{
		title = "CRV 1";
		values[] = {0,1};
		texts[] = {"False","True"};
		default = 1;
	};
	class NTA_CRV2
	{
		title = "CRV 2";
		values[] = {0,1};
		texts[] = {"False","True"};
		default = 1;
	};

	class NTA_Strider5
	{
		title = "Fennek HMG (Hill 46)";
		values[] = {0,1};
		texts[] = {"False","True"};
		default = 1;
	};
	class NTA_Strider6
	{
		title = "Fennek GMG (Hill 46)";
		values[] = {0,1};
		texts[] = {"False","True"};
		default = 1;
	};
	class NTA_Strider1
	{
		title = "Fennek GMG";
		values[] = {0,1};
		texts[] = {"False","True"};
		default = 1;
	};
	class NTA_Strider2
	{
		title = "Fennek HMG";
		values[] = {0,1};
		texts[] = {"False","True"};
		default = 1;
	};
	class NTA_Strider3
	{
		title = "Fennek HMG";
		values[] = {0,1};
		texts[] = {"False","True"};
		default = 1;
	};
	class NTA_Strider4
	{
		title = "Fennek GMG";
		values[] = {0,1};
		texts[] = {"False","True"};
		default = 1;
	};
	class NTA_Strider9
	{
		title = "Fennek HMG";
		values[] = {0,1};
		texts[] = {"False","True"};
		default = 1;
	};
	class NTA_StriderCheck1
	{
		title = "Fennek Checkpoint 1";
		values[] = {0,1};
		texts[] = {"False","True"};
		default = 1;
	};
	class NTA_StriderCheck2
	{
		title = "Fennek Checkpoint 2";
		values[] = {0,1};
		texts[] = {"False","True"};
		default = 1;
	};
	class NTA_Vec_engineer
	{
		title = "Fennek Pionier 1";
		values[] = {0,1};
		texts[] = {"False","True"};
		default = 1;
	};
	class NTA_Vec_engineer2
	{
		title = "Fennek Pionier 2";
		values[] = {0,1};
		texts[] = {"False","True"};
		default = 1;
	};
	class NTA_Med1
	{
		title = "Fennek Sanni";
		values[] = {0,1};
		texts[] = {"False","True"};
		default = 1;
	};
	class NTA_Med2
	{
		title = "Ghosthawk Sanni";
		values[] = {0,1};
		texts[] = {"False","True"};
		default = 1;
	};
	class NTA_Wildcat1
	{
		title = "Wildcat 1";
		values[] = {0,1};
		texts[] = {"False","True"};
		default = 1;
	};
	class NTA_Ghost1
	{
		title = "Ghosthawk 1";
		values[] = {0,1};
		texts[] = {"False","True"};
		default = 1;
	};
	class NTA_Moe1
	{
		title = "Merlin 1";
		values[] = {0,1};
		texts[] = {"False","True"};
		default = 1;
	};
	class NTA_Moe2
	{
		title = "Merlin 2";
		values[] = {0,1};
		texts[] = {"False","True"};
		default = 1;
	};
	class NTA_Black1
	{
		title = "Blackhawk 1";
		values[] = {0,1};
		texts[] = {"False","True"};
		default = 1;
	};
	class NTA_Wipe1
	{
		title = "A10 2";
		values[] = {0,1};
		texts[] = {"False","True"};
		default = 1;
	};
	class NTA_Wipe2
	{
		title = "A10 2";
		values[] = {0,1};
		texts[] = {"False","True"};
		default = 1;
	};
	class NTA_Drone1
	{
		title = "Drone 1";
		values[] = {0,1};
		texts[] = {"False","True"};
		default = 0;
	};
	class NTA_Gummi1
	{
		title = "Schlauchboot 1";
		values[] = {0,1};
		texts[] = {"False","True"};
		default = 1;
	};
	class NTA_Gummi2
	{
		title = "Schlauchboot 2";
		values[] = {0,1};
		texts[] = {"False","True"};
		default = 1;
	};
	class NTA_Gummi3
	{
		title = "Schlauchboot 3";
		values[] = {0,1};
		texts[] = {"False","True"};
		default = 1;
	};
	class NTA_Speed1
	{
		title = "Schnellboot 1";
		values[] = {0,1};
		texts[] = {"False","True"};
		default = 1;
	};
	class NTA_Speed2
	{
		title = "Schnellboot 2";
		values[] = {0,1};
		texts[] = {"False","True"};
		default = 1;
	};
	class NTA_SDV1
	{
		title = "SDV 1";
		values[] = {0,1};
		texts[] = {"False","True"};
		default = 1;
	};
	class NTA_SDV2
	{
		title = "SDV 2";
		values[] = {0,1};
		texts[] = {"False","True"};
		default = 1;
	};
	class NTA_Ammo1
	{
		title = "LKW Munition 1";
		values[] = {0,1};
		texts[] = {"False","True"};
		default = 1;
	};
	class NTA_FUEL1
	{
		title = "LKW Benzin 1";
		values[] = {0,1};
		texts[] = {"False","True"};
		default = 1;
	};
	class NTA_Repair1
	{
		title = "LKW Reparatur 1";
		values[] = {0,1};
		texts[] = {"False","True"};
		default = 1;
	};
	class NTA_Repair2
	{
		title = "LKW Reparatur 2";
		values[] = {0,1};
		texts[] = {"False","True"};
		default = 1;
	};
	class NTA_Repair4
	{
		title = "LKW Reparatur 1";
		values[] = {0,1};
		texts[] = {"False","True"};
		default = 1;
	};
	class NTA_Repair3
	{
		title = "Offroad Reparatur 3";
		values[] = {0,1};
		texts[] = {"False","True"};
		default = 1;
	};
	class NTA_Supp1
	{
		title = "Nachschubkiste 1";
		values[] = {0,1};
		texts[] = {"False","True"};
		default = 1;
	};
	class NTA_Supp2
	{
		title = "Nachschubkiste 2";
		values[] = {0,1};
		texts[] = {"False","True"};
		default = 1;
	};
	class NTA_Supp3
	{
		title = "Nachschubkiste 3";
		values[] = {0,1};
		texts[] = {"False","True"};
		default = 1;
	};
	class NTA_Supp4
	{
		title = "Nachschubkiste 4";
		values[] = {0,1};
		texts[] = {"False","True"};
		default = 1;
	};
	class NTA_Supp5
	{
		title = "Nachschubkiste 5";
		values[] = {0,1};
		texts[] = {"False","True"};
		default = 1;
	};
	class NTA_Supp6
	{
		title = "Nachschubkiste 6";
		values[] = {0,1};
		texts[] = {"False","True"};
		default = 1;
	};




