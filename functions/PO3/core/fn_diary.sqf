
player createDiaryRecord ["PO3CR",["Credits","Framework Written/Compiled by Eightysix for Online Combat Battalion Tactical Missions<br/><br/>Online Combat Battalion Australia (www.ocb.net.au), their support and testing has been vital to the success.<br/>- [OCB]Dash for Code, Inpiration and Effort in helping development<br/><br/>
Language Translations By:<br/>
- Czech: -<br/>
- French: GranolaBar<br/>
- German: Senshi<br/>
- Polish: Rydygier<br/>
- Portuguese: Caico1983<br/>
- Spanish: BIG (Armaholic)<br/>
<br/>Special thanks to:<br/>
- Bohemia Interactive Stuidos for the Arma Series, code and functions<br/>
- BON_Inf for Code and Inspiration from his missions and scripts<br/>
- Shuko for Code and Inspiration from his awesome Task System and Position Scripts<br/>
- KillZoneKid for Code and Inspiration from his tutorials<br/>
- Kegety for his spectator scripting<br/>
- XENO for Code and Inspiration from Domination and setting such a high standard<br/>
- R3F for Inspiration from their Arma 2 Logistics Scripts<br/>
- Tonic for the Virtual Ammobox System<br/>
- Tajin for the Helmet Camera Scripting<br/>
- aeroson for his detailed loadout scripts<br/>
- cobra4v320 for his HALO scripting<br/>
- Kronzky for his string function library<br/>
- SaMatra for help with UI Resources and Russian Translation<br/>
- Dslyecxi for his Paper doll giving insight on how to detect item types.<br/>
- Any and All ArmA community members for support, inspiration and solutions that have helped build this framework"]];

player createDiaryRecord ["PO3CR",["Version",format["MultiPlayer Scripting Framework<br/>Version %1",localize "STR_PO3_VERSION"]]];

player createDiaryRecord ["PO3WK",["Tasks","
Taskmaster System<br/>
Access by pressing ""J"" or in the tasks menu from the map screen.<br/
This shows all the tasks assigned to you and your team with the status of those tasks.<br/>
<br/>
<img image='\A3\ui_f\data\map\mapcontrol\taskIcon_ca.paa' width='25px'/> Status: Active - Colour: White<br/>
<img image='\A3\ui_f\data\map\mapcontrol\taskIconCanceled_ca.paa' width='25px'/> Status: Canceled - Colour: Grey<br/>
<img image='\A3\ui_f\data\map\mapcontrol\taskIconFailed_ca.paa' width='25px'/> Status: Failed - Colour: Red<br/>
<img image='\A3\ui_f\data\map\mapcontrol\taskIconDone_ca.paa' width='25px'/> Status: Succeeded - Colour: Green<br/>"]];

//player createDiaryRecord ["PO3WK",["Support","Support Requests are Work in Progress"]];

player createDiaryRecord ["PO3WK",["Squad Markers",format["Squad Marker System<br/><br/>Any Squad friendly to your side is marked on the map via their respective icon.<br/><br/>The icon shows you what vehicle their team leader has occupied.<br/><img image='%1' width='25px'/> - Infantry<br/><img image='%2' width='25px'/> - Armour<br/><img image='%3' width='25px'/> - Helicopter<br/><img image='%4' width='25px'/> - Mechanised: <br/><img image='%5' width='25px'/> - Motorised<br/><img image='%6' width='25px'/> - Plane<br/><img image='%7' width='25px'/> - Static Weapon<br/><img image='%8' width='25px'/> - UAV<br/>",["n_inf"] call PO3_fnc_getCfgIcon,["n_armor"] call PO3_fnc_getCfgIcon,["n_air"] call PO3_fnc_getCfgIcon,["n_mech_inf"] call PO3_fnc_getCfgIcon,["n_motor_inf"] call PO3_fnc_getCfgIcon,["n_plane"] call PO3_fnc_getCfgIcon,["n_art"] call PO3_fnc_getCfgIcon,["n_uav"] call PO3_fnc_getCfgIcon] ] ];


player createDiaryRecord ["PO3WK",["HUD","The Player Hud<br/><br/>The hud allows you to set your view distance options, terrain detail and density and toggle the 3D names that appear above each of nearby players.<br/>These options can be disabled by the mission admin."]];