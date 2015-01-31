COSTownLabel=[];
"COSTownLabel" addPublicVariableEventHandler {
	private ["_GHint","_GHint1","_GHint1","_Hintg","_sizeX","_sizeY", "_factor"];
	_Hintg = (_this select 1);
	_GHint = (_Hintg select 0);
	_GHint1= (_Hintg select 1);
	_GHint2= (_Hintg select 2);
	_sizeX=getMarkerSize _GHint1 select 0;
	_sizeY=getMarkerSize _GHint1 select 1;

	if (_sizeY>_sizeX) then {_mSize=_sizeY}else{_mSize=_sizeX};
	if (player distance markerpos _GHint1 < (COS_distance+ _mSize)) then {
		_population=format ["Population: %1",_GHint];
		0=[markertext _GHint1,_population, format ["RiotFactor: %1",_GHint2]] spawn BIS_fnc_infoText;
	};
};