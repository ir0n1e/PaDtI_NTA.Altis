private "_tickets";
_tickets = _this select 1;

NTA_Tickets = NTA_Tickets + _tickets;
publicvariable "NTA_Tickets";
format ["%1  %2  %3",  _tickets, NTA_TICKETS, (_this select 0)] call nta_fnc_log;