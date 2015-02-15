private ["_unit", "_allGear", "_headgear", "_goggles", "_uniform", "_uniformitems", "_vest", "_vestitems", "_backpack", "_backpackitems", "_primaryweapon", "_primaryweaponitems", "_primaryweaponmagazine", "_handgunweapon", "_handgunweaponitems", "_handgunweaponmagazine", "_assigneditems", "_binocular","_smallGear"];


_unit = _this select 0;
_allGear = _this select 1;
_unit call NTA_fnc_standardItems_player;

_headgear = _allGear select 0;
_goggles = _allGear select 1;
_uniform = _allGear select 2;
_uniformitems = _allGear select 3;
_vest = _allGear select 4;
_vestitems = _allGear select 5;
_backpack = _allGear select 6;
_backpackitems = _allGear select 7;
_primaryweapon = _allGear select 8;
_primaryweaponitems = _allGear select 9;
_primaryweaponmagazine = _allGear select 10;
_secondaryweapon = _allGear select 11;
_secondaryweaponitems = _allGear select 12;
_secondaryweaponmagazine = _allGear select 13;
_handgunweapon = _allGear select 14;
_handgunweaponitems = _allGear select 15;
_handgunweaponmagazine = _allGear select 16;
_assigneditems = _allGear select 17;
_binocular = _allGear select 18;


// start restoring the items
if (_headgear != "") then {
  _unit addHeadgear _headgear;
};

if (_vest != "") then {
  _unit addVest _vest;
};
if (_goggles != "") then {
  _unit addGoggles _goggles;
};

 for "_i" from 0 to 2 do {
    _unit addItemToVest "FirstAidKit";
  };
// primaryWeapon
if (_primaryweapon != "") then {
  {

    _unit addMagazine _x;

  } forEach _primaryweaponmagazine;

  _unit addWeapon _primaryweapon;

  for "_i" from 0 to 2 do {
    _unit addItemToVest (_primaryweaponmagazine select 0);
  };


  {
    if (_x != "") then {
      _unit addPrimaryWeaponItem _x;
    };
  } forEach _primaryweaponitems;
};
