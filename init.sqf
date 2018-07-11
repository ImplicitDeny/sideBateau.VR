// tests d'attache de bateau à débarcadère
listeAttaches = [[7.51611,2.45117,-0.581624],[5.58154,2.44775,-0.581624],[7.55322,0.41748,-1.8348],[0.557617,2.45752,-0.581624],[2.49951,2.44434,-0.581624],[3.75244,2.44775,-0.581624],[-4.4502,2.4624,-0.581624],[-7.5835,2.45752,-0.581624],[-7.58887,0.414551,-0.581624],[-1.28369,2.4541,-0.581624]];


initQuai = {
	// Fonction créant les variables nécessaires pour le quai
	params["_quai"];
	/*
	{
		_quai setVariable [format["attache_%1", _forEachIndex], _x];
	} forEach _attaches;
	*/
	_quai setVariable ["attaches", listeAttaches];
};

initBateau = {
	// Fonction créant le point d'attache sur le bateau
	params["_bateau"];
	_bateau setVariable ["boucle", [0,2.39,-0.677]];
};

attacheBateau = {
	// Fonction attachant le bateau à une position à moins de 2m
	params["_bateau", "_quai"];
	_pos = _bateau modelToWorld (_bateau getVariable "boucle");

	// On essaye de trouver une attache à moins de 2m
	_valid = [];
	{
		if(_pos distance (_quai modelToWorld _x) < 5) exitWith {_valid = _x};
	} forEach (_quai getVariable "attaches");

	// Si on en a pas, on quitte
	if(count _valid == 0) exitWith {hint str "Pas d'attache à proximité !"};

	// On a une attache et un bateau, on crée une corde
	_attache = createVehicle ["B_static_AA_F", (_quai modelToWorld _valid), [], 0, "NONE"];
	_attache allowDamage false;

	_corde = ropeCreate[_attache, [0,0,0], _bateau, (_bateau getVariable "boucle")];
};


quai call initQuai;
bateau call initBateau;