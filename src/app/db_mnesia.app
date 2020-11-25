{   
    application, db_mnesia,
    [   
        {description, "db_mnesia application."},   
        {vsn, "0.1"},   
        {modules,	[]},   
        {registered, [db_mnesia]},   
        {applications, [kernel, stdlib, sasl ]},   
        {mod, {db_mnesia, []}},   
        {start_phases, []} 
	]
}.    
