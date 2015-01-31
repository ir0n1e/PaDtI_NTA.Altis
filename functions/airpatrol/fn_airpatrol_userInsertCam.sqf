if (hasInterface) then {

    //Intro
    [] spawn {
    	sleep 1;
    	//0 cutRsc["", "BLACK OUT", 3];
    	//sleep 0.2;
    	//1 cutRsc["ntaImage", "BLACK", 3];
    	//sleep 0.1;
    	_text = "A I R P A T R O L  |  U S E R I N S E R T I O N";
	    titleText [_text, "BLACK OUT", 3];
		0 fadesound 0;
		sleep 10;

		titleText ["B Y   I r 0 n 1 E   N T A", "BLACK IN", 20];
		10 fadesound 0.9;


		//1 cutRsc["ntaImage", "BLACK IN", 3];
	};
};