{   
    application, game,
    [   
        {description, "game application."},   
        {vsn, "0.1"},   
        {modules,	[]},   
        {registered, [game]},   
        {applications, [kernel, stdlib, sasl ]},   
        {mod, {game, []}},   
        {start_phases, []} 
	]
}.    
