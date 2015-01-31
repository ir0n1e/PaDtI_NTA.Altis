if !(isClass(configFile/"CfgPatches"/"BWA3_Common")) exitwith {};

removeAllWeapons _this;
removeUniform _this;
removeHeadgear _this;
removeVest _this;
removeAllItems _this;
removeAllAssignedItems _this;

_this forceAddUniform "BWA3_Uniform_Fleck";
_this addVest "BWA3_Vest_Rifleman1_Fleck";
_this addHeadgear "BWA3_Beret_Wach_Blau";
_this addweapon "BWA3_G36_equipped";
_this addWeapon "BWA3_P8";

for "_i" from 1 to 6 do {_this addItemToVest "BWA3_30Rnd_556x45_G36";};
for "_i" from 1 to 2 do {_this addItemToVest "BWA3_15Rnd_9x19_P8";};
for "_i" from 1 to 2 do {_this addItemToUniform "FirstAidKit";};

_this addPrimaryWeaponItem "BWA3_30Rnd_556x45_G36";
_this addSecondaryWeaponItem "BWA3_15Rnd_9x19_P8";
_this linkItem "ItemMap";
_this linkItem "ItemCompass";
_this linkItem "ItemWatch";
_this linkItem "ItemRadio";