waituntil {alive player};


if ((missionNamespace getVariable [format ["handler_%1",player],0]) > 0) then {
	removeMissionEventHandler ["Draw3d",(missionNamespace getVariable [format ["handler_%1",player],0])];
};
_Hnames = ["Loch","Bude","Höle","Reich","Bau","Home"];
hnames = _Hnames select (floor(random(count _Hnames)));

missionNamespace setVariable [ format ["handler_%1",player],

addMissionEventHandler ["Draw3D", {
	_box = call compile (player getvariable "Playerbox");
	if (!alive player) exitwith {};
	_alpha = 6 / (player distance _box);
	_picture = "";
	if (count squadParams player > 0) then {
		_picture = (squadParams player select 0) select 4;
	};
	drawIcon3D [
        	_picture,
        	 [1,1,1,_alpha],
		[ (visiblePosition _box) select 0,
            (visiblePosition _box) select 1,
            2],
		2,
		0,
		0,
		format ["%1's %2",name player, Hnames],
		1,
		0.045,
		"PuristaMedium"
	];
	drawIcon3D [
        	"",
        	 [1,1,1,_alpha],
		[ (visiblePosition _box) select 0,
            (visiblePosition _box) select 1,
            2],
		0,
		1.0,
		0,
		"WeaponSave",
		1,
		0.045,
		"PuristaMedium"
	];
	drawIcon3D [
        	"",
        	 [1,1,1,_alpha],
		[ (visiblePosition _box) select 0,
            (visiblePosition _box) select 1,
            2],
		0,
		2.0,
		0,
		"Viewdistance Statistics",
		1,
		0.045,
		"PuristaMedium"
	];
}]];
