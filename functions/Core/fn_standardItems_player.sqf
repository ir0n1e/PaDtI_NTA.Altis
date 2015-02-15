removeAllWeapons _this;
removeAllItems _this;
removeBackpack _this;

removeUniform _this;
removeVest _this;
removeHeadgear _this;
removeGoggles _this;
removeAllAssignedItems _this;

if !(player getvariable ["haveBWA3", false]) exitwith {
    _this addUniform "U_B_Wetsuit";
    _this addItem "ItemMap"; _this assignItem "ItemMap";
    _this addItem "ItemCompass"; _this assignItem "ItemCompass";
    _this addItem "ItemWatch"; _this assignItem "ItemWatch";
    //_this addItem "ItemGPS"; _this assignItem "ItemGPS";
    _this addItem "NVGoggles_OPFOR";
};

if ((name _this) == "drei.zehn" && {player getvariable ["haveBWplus", false]}) then {
    _this addHeadgear "BWA3_BoonieHat_Fleck";
    _this addUniform "BWA3_Uniform3_Fleck";
    _this addgoggles "BWplus_Shemagh_Green";
} else {
    _this addUniform "BWA3_Uniform_Fleck";
};

_this addItem "ItemMap"; _this assignItem "ItemMap";
_this addItem "ItemCompass"; _this assignItem "ItemCompass";
_this addItem "ItemWatch"; _this assignItem "ItemWatch";
//_this addItem "ItemGPS"; _this assignItem "ItemGPS";

if (isClass(configFile/"CfgPatches"/"AGM_NightVision")) then {
    _this addItem "AGM_NVG_Wide";
} else {
    _this addItem "NVGoggles_OPFOR";
};

if (isClass(configFile/"CfgPatches"/"AGM_Medical")) then {
    _this addItem "AGM_EarBuds";
};
if (isClass(configFile/"CfgPatches"/"AGM_Map")) then {
    _this addItem "AGM_MapTools";
};