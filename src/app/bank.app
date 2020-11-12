{
 application, bank,
 [
  {mod,{bank_app,[]}}
  ,{vsn, "1.0"}
 ]
}.

%% {application, Application,
%%   [{description,  Description},
%%    {id,           Id},
%%    {vsn,          Vsn},
%%    {modules,      Modules},
%%    {maxP,         MaxP},
%%    {maxT,         MaxT},
%%    {registered,   Names},
%%    {included_applications, Apps},
%%    {applications, Apps},
%%    {env,          Env},
%%    {mod,          Start},
%%    {start_phases, Phases},
%%    {runtime_dependencies, RTDeps}]}.
%% 
%%              Value                Default
%%              -----                -------
%% Application  atom()               -
%% Description  string()             ""
%% Id           string()             ""
%% Vsn          string()             ""
%% Modules      [Module]             []
%% MaxP         int()                infinity
%% MaxT         int()                infinity
%% Names        [Name]               []
%% Apps         [App]                []
%% Env          [{Par,Val}]          []
%% Start        {Module,StartArgs}   []
%% Phases       [{Phase,PhaseArgs}]  undefined
%% RTDeps       [ApplicationVersion] []
%%   Module = Name = App = Par = Phase = atom()
%%   Val = StartArgs = PhaseArgs = term()
%%   ApplicationVersion = string()

%% vim: set filetype=erlang foldmarker=%%',%%. foldmethod=marker:
