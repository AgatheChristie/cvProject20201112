%% coding: latin-1
%%%----------------------------------------------------------------------
%%% @author
%%% @date
%%%         全服boss进程接口
%%% @end
%%%----------------------------------------------------------------------
-module(util_server_boss_mgr).

-include("common.hrl").

-include("db_mnesia.hrl").
-include("server_boss.hrl").


-export([
    get_server_boss_info/0
    , role_enter/2
    , role_leave2/2
    , role_leave/2
    , start_server_boss/2
    , get_in_server_boss_info/0
]).


%% 获取全服boss活动信息
%%util_server_boss_mgr:get_server_boss_info().
get_server_boss_info() ->
    AllPlayers = util_m_server_boss_player:get_all_server_boss_player(),
    ?ERROR("cvAA:~p end", [AllPlayers]),
    ok.
%%util_server_boss_mgr:get_in_server_boss_info().
get_in_server_boss_info() ->
    AllInPlayers = util_m_server_boss_player:get_all_in_server_boss_player(),
    ?ERROR("cvAllInPlayers:~p end", [AllInPlayers]),
    ok.

%% 玩家进入场景
%%util_server_boss_mgr:role_enter(cvstate,20151777).
%%util_server_boss_mgr:role_enter(cvstate,1133222).
role_enter(State, RoleId) ->
    case catch check_role_enter(State, RoleId) of
        {ok, State2, MBossPlayer} ->
            MBossPlayer2 = MBossPlayer#server_boss_player_m{
                player_status = ?IS_IN_SERVER_BOSS
            },
            util_m_server_boss_player:add_server_boss_player(MBossPlayer2),
            {ok, State2};
        {error, aE_SERVER_BOSS_NOT_IN_ACTIVITY} ->
            %% 玩家信息不存在，初始化玩家信息
            MBossPlayer = #server_boss_player_m{
                role_id = RoleId,
                player_status = ?IS_IN_SERVER_BOSS
            },
            util_m_server_boss_player:add_server_boss_player(MBossPlayer),
            {ok, State};
        _E ->
            %% ?ERROR("=玩家进入场景出错:~w ~w", [RoleId, _E]),
            {ok, State}
    end.

%% 检查玩家进入场景
check_role_enter(State, RoleId) ->
    MBossPlayer =
        case util_m_server_boss_player:get_server_boss_player_by_id(RoleId) of
            [#server_boss_player_m{} = TMBossPlayer] ->
                TMBossPlayer;
            _ ->
                ?C2SERR(aE_SERVER_BOSS_NOT_IN_ACTIVITY)
        end,
    {ok, State, MBossPlayer}.
%%util_server_boss_mgr:role_leave(cvstate,20151777).
%% 玩家离开
role_leave(State, LeaveId) ->
    case lists:member(LeaveId, [20151777, 1133222]) of
        true ->
            %% 假人离开删除
            util_m_server_boss_player:delete_server_boss_player(LeaveId),
            {ok, State};
        false ->
            {ok, ActivityBoss2} = role_leave2(State, LeaveId),
            {ok, ActivityBoss2}
    end.

role_leave2(State, LeaveId) ->
    PlayStatus = ?SERVER_BOSS_START,
    case util_m_server_boss_player:get_server_boss_player_by_id(LeaveId) of
        [MBossPlayer] ->
            %% 开始游戏时才会算退出
            ?ERROR("cvMBossPlayer:~p end", [MBossPlayer]),
            case lists:member(PlayStatus, [?SERVER_BOSS_INIT, ?SERVER_BOSS_START]) of
                true ->
                    MBossPlayer2 = MBossPlayer#server_boss_player_m{
                        player_status = ?IS_LEAVE_SERVER_BOSS
                    },
                    util_m_server_boss_player:update_server_boss_player(MBossPlayer2),
                    {ok, State};
                false ->
                    {ok, State}
            end;
        _ ->
            {ok, State}
    end.

%% 检查全服boss开始
check_start_server_boss(State, _IconId) ->
    util_m_server_boss_player:clear_all_server_boss_player(),
    {ok, State}.
%%util_server_boss_mgr:start_server_boss(cvstate,1501).
%% 全服boss活动开始
start_server_boss(State, IconId) ->
    case catch check_start_server_boss(State, IconId) of
        {ok, State2} ->
            {ok, State2};
        _E ->
            %% ?ERROR("全服boss活动开始:~w", [_E]),
            {ok, State}
    end.






























