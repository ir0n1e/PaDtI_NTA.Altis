if (isclass (configfile >> "CfgPatches" >> "rhs_infantry")) exitwith {};

removeAllWeapons _this;
removeAllItems _this;
removeAllAssignedItems _this;
removeUniform _this;
removeVest _this;
removeBackpack _this;
removeHeadgear _this;
removeGoggles _this;


_this forceAddUniform (["U_O_CombatUniform_ocamo", "U_BG_Guerrilla_6_1"] call NTA_fnc_getRandArrayPos);
_this addVest "V_HarnessO_brn";
for "_i" from 1 to 6 do {_this addItemToVest "30Rnd_65x39_caseless_green";};
for "_i" from 1 to 2 do {_this addItemToVest "16Rnd_9x21_Mag";};
for "_i" from 1 to 2 do {_this addItemToVest "HandGrenade";};
for "_i" from 1 to 2 do {_this addItemToUniform "FirstAidKit";};
for "_i" from 1 to 2 do {_this addItemToUniform "SmokeShellRed";};
_this addHeadgear (["H_Cap_brn_SPECOPS", "H_Booniehat_khk"] call NTA_fnc_getRandArrayPos);

_this addWeapon "arifle_Katiba_C_F";

if (missionNamespace getvariable ["haveAGM", false]) then {
	_this addPrimaryWeaponItem "AGM_muzzle_mzls_H";
};

_this addPrimaryWeaponItem "acc_pointer_IR";
_this addPrimaryWeaponItem "optic_MRCO";
_this addWeapon "hgun_Rook40_F";
_this addWeapon "Rangefinder";

_this linkItem "ItemMap";
_this linkItem "ItemCompass";
_this linkItem "ItemWatch";
_this linkItem "ItemRadio";
_this linkItem "NVGoggles_OPFOR";
_this linkItem "ItemGPS";