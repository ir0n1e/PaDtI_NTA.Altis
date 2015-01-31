private ["_building","_bldPositions","_i","_bldInfo","_house","_nopos","_pos"];
_building = _this;

_bldPositions = [];

_i = 0;

while {str(_building buildingPos _i) != str([0,0,0])} do {
	_i = _i + 1;

};
_bldInfo = [_building, _i];

_house = _bldInfo select 0;
_noPos = _bldInfo select 1;

	_i = 0;
	while {_i < _noPos} do {
		_bldPositions = _bldPositions + [(_house buildingPos _i)];
		_i = _i + 1;
	};
_pos = _bldPositions call NTA_fnc_getRandArrayPos;
if (isnil "_pos") exitwith {
	position _building
};

_pos