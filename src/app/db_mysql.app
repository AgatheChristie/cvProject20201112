{   
    application, db_mysql,
    [   
        {description, "db_mysql application."},   
        {vsn, "0.1"},   
        {modules,	[]},   
        {registered, [db_mysql]},   
        {applications, [kernel, stdlib, sasl ]},   
        {mod, {db_mysql, []}},   
        {start_phases, []} 
	]
}.    
