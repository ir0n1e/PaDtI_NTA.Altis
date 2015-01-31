#define TASKFORCE "Task Force Radio"
#define NTAINFO "NTA Info"
#define TEAMSPEAK "TeamSpeak Server"
#define TASKFORCE_TEXT "<br /><font size='20'>Task Force Radio</font><br /><font size='15'>Kanal 2m Band: C1 Frequenz: 100<br />Kanal 4m Band: C1 Frequenz: 69</font>"
#define TEAMSPEAK_TEXT "<br/><br/><font size='20'>TeamSpeak Server</font><br/><font size='15'>Addresse: ntalpha.de</font><br/>"
#define NTAINFO_TEXT "<img width='200px' image='pics\NTA_Logo_G.paa'/><br/><br/><font size='20'>Willkomen auf dem NTA Public Server</font><br/><br/><font size='15'>Bei uns gibt es keine Festen Termine.<br/>Wir wollen uns auf allen Ebenen ausweiten, daher suchen wir Member. <br/>Ob Infanterie, Panzer oder in der Luft alles ist vertreten.<br/>Wir starten jedes Wochenende Events bei denen wir entweder Coop gegen KI<br/>oder mit anderen Clans PVP Matches veranstalten.<br/>Bei interesse einfach im Teamspeak melden IP:46.105.147.247:11124<br/><br/>Unsere Member stehen dir jeweils von MO - Fr ab 17:00 Uhr<br>und am Wochenende zu jeder Zeit zu verfügung</font>"

private ["_string", "_tickets", "_veh"];
NTA_VEHstring = "<font size='20'>Ticket System</font><br/><br/>";
{
	_veh = call compile format ["typeof %1",_x];
	if (!isnil "_veh") then {
	_tickets = call compile format ["%1 getvariable ['nta_tickets', 0]", _x];
	NTA_VEHstring = NTA_VEHstring + format ["<img width='50px' image='%1'/><font size='15'>  %2 Tickets: %3</font><br/>", getText (ConfigFile >> "CfgVehicles" >> _veh >> "picture"), getText (ConfigFile >> "CfgVehicles" >> _veh >> "displayName"), _tickets];
	};
} foreach (call NTA_fnc_all_vehicles);

publicvariable "NTA_VEHstring";

player createDiarySubject ["NTAInfo","NTA Info"];
player createDiaryRecord ["NTAINFO",[TASKFORCE,TASKFORCE_TEXT]];
player createDiaryRecord ["NTAINFO",[TEAMSPEAK,TEAMSPEAK_TEXT]];
player createDiaryRecord ["NTAINFO",[NTAINFO,NTAINFO_TEXT]];




player createDiarySubject ["NTAWIKI","NTA Wiki"];
player createDiaryRecord ["NTAWIKI",["Tickets Fahrzeuge", NTA_VEHstring]];
player createDiaryRecord ["NTAWIKI",["Tickets Spieler / NPC","<font size='20'>Tickets Spieler / NPC</font><br/><br/>
	<font size='15'>Spieler Tod: 10<br/>
	Zivilist angeschosse: 1<br/>
	Zivilist erschossen: 10<br/>
	</font>"]];
	player createDiaryRecord ["NTAWIKI",["Waffenkiste","<font size='20'>Waffenkiste</font><br/><br/>
	<font size='15'>- Speicheroption der Waffe<br/>
	- Ladeoption der Waffe<br/>
	- Statistiken abrufen<br/>
	- Sichtweite und Grass Qualität einstellen<br/>
	</font>"]];
	player createDiaryRecord ["NTAWIKI",["Sichtweite","<font size='20'>Sichteweite</font><br/><br/><font size='15'>Die Sichtweite wird über 'STRG-U' / 'U' eingestellt.<br/>Die Grass Qualität wird an der Waffenkiste über das AGM Menu eingestellt.<br/>Sobald das Grass gespeichert ist, wird die Sichtweite und die Grass Qualität beim nächsten Verbinden automatisch geladen.<br/>
	</font>"]];



player createDiarySubject ["Airpatrol","Airpatrol"];


player createDiaryRecord ["Airpatrol",["Airpatrol CAS","<font size='20'>Airpatrol CAS</font><br/><br/>
	<font size='15'>Zu unbestimmten Zeite stellt Euch die Mission CAS Unterstützung zur Verfügung.<br/>Diese kann Über das AGM Menu de TL abgerufen werden.<br></font>"]];
player createDiaryRecord ["Airpatrol",["Airpatrol Userinsertion","<font size='20'>Airpatrol Userinsertion</font><br/><br/><font size='15'>Am Bunker besteht die Möglichkeit sich per NPC in das Kampfgebiet einfliegen zu lassen.<br/>Anwahl der Option über das AGM Menu.<br>Gruppenmitglieder im, die eingeflogen werden sollen, im Menü anwählen und 'Do It' klicken.<br/>Im nächsten Menu die Hubschrauber Typ und die Anzahl auswählen.<br/></font><font color='#800000'>Achtung auf die Sitzplätze achten!</font><br/>Auf der Karte auf den Zielort klicken und ab geht!<br/>"]];
player createDiaryRecord ["Airpatrol",["Airpatrol","<font size='20'>Airpatrol</font><br/><br/><font size='15'>Zu unbestimmten Zeiten Schickt die Mission Hubschrauber und Flugzeuge über Eure Köpfe CSAT/NTAO.<br/>NATO Luftfahrzeuge kann der TL über das AGM Menu wieder nach Hause schicken.<br></font>"]];
player createDiarySubject ["CIVILIANS","Civilians"];
player createDiaryRecord ["CIVILIANS",["Zivilisten","<font size='20'>Zivilisten</font><br/><br/><font size='15'>
In jeder Stadt gibt es Zivilisten die Ihrem Geschäft nachgehen.<br/>Sollten sie Schüsse regestriren, steigt Ihr 'Riotfactor'. Übersteigt dieser eine bestimmte Grenze werden sie Autos anzünden.<br>Steigt er weiter werden sie sich Waffen besorgen oder Autobomben legen<br/></font>"]];