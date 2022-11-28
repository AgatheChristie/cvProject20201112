%% coding: latin-1
%%%----------------------------------------------------------------------
%%%
%%% @author: taiqi
%%% @doc: （自动生成,请勿编辑!)
%%%
%%%----------------------------------------------------------------------
-module(role).

-export([
    fields/0
    , to_term/1
    , to_binary/1
    , to_row/1
    , to_row/2
    , to_rec/1
    , to_rec_list/1
    , to_rec_t/1
    , to_rec_list_t/1
    , insert/3
    , insert_next/3
    , delete/3
    , select/2
    , select/3
    , select/4
    , select/5
    , select/6
    , select/7
    , update/3
    , update/4
    , update/5
    , replace/3
    , first_tab/0
    , assign_tab/2
]).

fields() -> 
    ["id", "via_id", "login_via_id", "sdk_channel", "sdk_platform_id", "sdk_server_id", "create_server_id", "package_name", "sdk_values", "accname", "name", "head_portrait_info", "chat_frame_info", "league_id", "league_post", "league_lq_sec", "apply_league_ids", "sy_league_infos", "camp_id", "resume", "dummy_grow_id", "settings", "create_sec", "login_sec", "logout_sec", "lose_connect_sec", "role_status", "login_ip", "online_sec", "total_online_sec", "login_day", "role_type", "reload_mod_times", "device_id", "device_desc", "other_desc", "id_manages", "bag_infos", "actors", "shops", "mail_terms", "public_mail_id", "total_chat_count", "activitys", "activity_customs", "pay_configs", "unspeak_sec", "camp_unspeak_sec", "task", "fcm_info", "zhengbing_info", "team_infos", "fb_team_infos", "resource_lands", "guide_groups", "is_skip_guide", "play_infos", "extra_infos", "decree_info", "build_queues", "build_infos", "limit_items", "appoint_infos", "lottery_infos", "tujian_infos", "xunma", "world_chat_free_times", "search_use_times", "training_infos", "training_sec", "train_times", "total_train_times", "friend", "private_chats", "personal_sys_chats", "achieve", "task_chapter", "search_infos", "role_trends", "fb_infos", "max_fb_id", "challenge_fb_id", "taxes_info", "camp_post", "vote_only_ids", "day_donate_num", "prev_rank_id", "yesterday_rank_id", "now_devote", "total_devote", "today_devote", "common_buff_ids", "welfare_boxs", "welfare_box_gets", "treasures", "science_support", "actor_value", "attendance_info", "month_cards", "public_armys", "daily_huoyue", "total_gongxun", "total_gongxun_sec", "occupy_plot_ids", "special_sa_ids", "today_pay", "team_hp_restore_sec", "activity_limits", "apply_camp_posts", "sign_infos", "camp_task_mixs", "fanpais", "privilege_infos", "end_privilege_ids", "actor_capitulates", "single_event", "tavern_infos", "challenge_tavern_info"].

to_term(<<>>) -> none; to_term(Binary) -> binary_to_term(Binary).

to_binary(none) -> <<>>; to_binary('_') -> '_'; to_binary(['_' | _T]) -> '_'; to_binary(Term) -> term_to_binary(Term).

to_row(Val) -> 
    to_row(Val, false).
to_row({role, ID, _PID, VIA_ID, LOGIN_VIA_ID, SDK_CHANNEL, SDK_PLATFORM_ID, SDK_SERVER_ID, CREATE_SERVER_ID, PACKAGE_NAME, SDK_VALUES, ACCNAME, NAME, HEAD_PORTRAIT_INFO, CHAT_FRAME_INFO, LEAGUE_ID, LEAGUE_POST, LEAGUE_LQ_SEC, APPLY_LEAGUE_IDS, SY_LEAGUE_INFOS, CAMP_ID, RESUME, DUMMY_GROW_ID, SETTINGS, CREATE_SEC, LOGIN_SEC, LOGOUT_SEC, LOSE_CONNECT_SEC, _ACTIVE_SEC, _OFFLINE_LINE_ID, ROLE_STATUS, LOGIN_IP, ONLINE_SEC, TOTAL_ONLINE_SEC, LOGIN_DAY, ROLE_TYPE, RELOAD_MOD_TIMES, _ROLE_GROUP_ID, _CHANGE_PUBLIC_CONDITION, DEVICE_ID, DEVICE_DESC, OTHER_DESC, _GAME_NODE, _GATEWAY_NODE, _FIGHT_NODE, ID_MANAGES, BAG_INFOS, _ITEM_EXPIREDS, ACTORS, SHOPS, MAIL_TERMS, PUBLIC_MAIL_ID, TOTAL_CHAT_COUNT, ACTIVITYS, ACTIVITY_CUSTOMS, _RED_TRIGGERS, _OPEN_ICON_IDS, PAY_CONFIGS, UNSPEAK_SEC, CAMP_UNSPEAK_SEC, TASK, FCM_INFO, ZHENGBING_INFO, TEAM_INFOS, FB_TEAM_INFOS, RESOURCE_LANDS, GUIDE_GROUPS, IS_SKIP_GUIDE, PLAY_INFOS, EXTRA_INFOS, DECREE_INFO, BUILD_QUEUES, BUILD_INFOS, LIMIT_ITEMS, APPOINT_INFOS, LOTTERY_INFOS, TUJIAN_INFOS, XUNMA, WORLD_CHAT_FREE_TIMES, SEARCH_USE_TIMES, TRAINING_INFOS, TRAINING_SEC, TRAIN_TIMES, TOTAL_TRAIN_TIMES, FRIEND, PRIVATE_CHATS, PERSONAL_SYS_CHATS, ACHIEVE, TASK_CHAPTER, SEARCH_INFOS, ROLE_TRENDS, FB_INFOS, MAX_FB_ID, CHALLENGE_FB_ID, TAXES_INFO, CAMP_POST, VOTE_ONLY_IDS, DAY_DONATE_NUM, PREV_RANK_ID, YESTERDAY_RANK_ID, NOW_DEVOTE, TOTAL_DEVOTE, TODAY_DEVOTE, COMMON_BUFF_IDS, WELFARE_BOXS, WELFARE_BOX_GETS, TREASURES, SCIENCE_SUPPORT, ACTOR_VALUE, ATTENDANCE_INFO, _RESOURCE_PUSH_SEC, _RESOURCE_CHANGE_FLAG, MONTH_CARDS, PUBLIC_ARMYS, DAILY_HUOYUE, TOTAL_GONGXUN, TOTAL_GONGXUN_SEC, OCCUPY_PLOT_IDS, SPECIAL_SA_IDS, TODAY_PAY, TEAM_HP_RESTORE_SEC, ACTIVITY_LIMITS, APPLY_CAMP_POSTS, SIGN_INFOS, CAMP_TASK_MIXS, _RESOURCE_INIT_FLAG, _ROB_SEC, _ROB_TIMES, FANPAIS, PRIVILEGE_INFOS, END_PRIVILEGE_IDS, ACTOR_CAPITULATES, SINGLE_EVENT, TAVERN_INFOS, CHALLENGE_TAVERN_INFO}, _Loop) -> 
    [ID, VIA_ID, LOGIN_VIA_ID, SDK_CHANNEL, SDK_PLATFORM_ID, SDK_SERVER_ID, CREATE_SERVER_ID, PACKAGE_NAME, to_binary(SDK_VALUES), ACCNAME, NAME, to_binary(HEAD_PORTRAIT_INFO), to_binary(CHAT_FRAME_INFO), LEAGUE_ID, LEAGUE_POST, LEAGUE_LQ_SEC, to_binary(APPLY_LEAGUE_IDS), to_binary(sy_league_info:to_row(SY_LEAGUE_INFOS, true)), CAMP_ID, RESUME, DUMMY_GROW_ID, to_binary(setting:to_row(SETTINGS, true)), CREATE_SEC, LOGIN_SEC, LOGOUT_SEC, LOSE_CONNECT_SEC, ROLE_STATUS, LOGIN_IP, ONLINE_SEC, TOTAL_ONLINE_SEC, LOGIN_DAY, ROLE_TYPE, RELOAD_MOD_TIMES, DEVICE_ID, DEVICE_DESC, OTHER_DESC, to_binary(id_manage:to_row(ID_MANAGES, true)), to_binary(bag_info:to_row(BAG_INFOS, true)), to_binary(actor:to_row(ACTORS, true)), to_binary(shop:to_row(SHOPS, true)), to_binary(mail_term:to_row(MAIL_TERMS, true)), PUBLIC_MAIL_ID, TOTAL_CHAT_COUNT, to_binary(activity:to_row(ACTIVITYS, true)), to_binary(activity_custom:to_row(ACTIVITY_CUSTOMS, true)), to_binary(pay_config:to_row(PAY_CONFIGS, true)), UNSPEAK_SEC, CAMP_UNSPEAK_SEC, to_binary(TASK), to_binary(FCM_INFO), to_binary(ZHENGBING_INFO), to_binary(team_info:to_row(TEAM_INFOS, true)), to_binary(fb_team_info:to_row(FB_TEAM_INFOS, true)), to_binary(resource_land:to_row(RESOURCE_LANDS, true)), to_binary(guide_group:to_row(GUIDE_GROUPS, true)), IS_SKIP_GUIDE, to_binary(play_info:to_row(PLAY_INFOS, true)), to_binary(extra_info:to_row(EXTRA_INFOS, true)), to_binary(DECREE_INFO), to_binary(build_queue:to_row(BUILD_QUEUES, true)), to_binary(build_info:to_row(BUILD_INFOS, true)), to_binary(limit_item:to_row(LIMIT_ITEMS, true)), to_binary(appoint_info:to_row(APPOINT_INFOS, true)), to_binary(lottery_info:to_row(LOTTERY_INFOS, true)), to_binary(tujian_info:to_row(TUJIAN_INFOS, true)), to_binary(XUNMA), WORLD_CHAT_FREE_TIMES, SEARCH_USE_TIMES, to_binary(training_info:to_row(TRAINING_INFOS, true)), TRAINING_SEC, TRAIN_TIMES, TOTAL_TRAIN_TIMES, to_binary(FRIEND), to_binary(private_chat:to_row(PRIVATE_CHATS, true)), to_binary(personal_sys_chat:to_row(PERSONAL_SYS_CHATS, true)), to_binary(ACHIEVE), TASK_CHAPTER, to_binary(search_info:to_row(SEARCH_INFOS, true)), to_binary(role_trend:to_row(ROLE_TRENDS, true)), to_binary(fb_info:to_row(FB_INFOS, true)), MAX_FB_ID, CHALLENGE_FB_ID, to_binary(TAXES_INFO), CAMP_POST, to_binary(VOTE_ONLY_IDS), DAY_DONATE_NUM, PREV_RANK_ID, YESTERDAY_RANK_ID, NOW_DEVOTE, TOTAL_DEVOTE, TODAY_DEVOTE, to_binary(COMMON_BUFF_IDS), to_binary(welfare_box:to_row(WELFARE_BOXS, true)), to_binary(welfare_box_get:to_row(WELFARE_BOX_GETS, true)), to_binary(treasure:to_row(TREASURES, true)), to_binary(SCIENCE_SUPPORT), ACTOR_VALUE, to_binary(ATTENDANCE_INFO), to_binary(month_card:to_row(MONTH_CARDS, true)), to_binary(public_army:to_row(PUBLIC_ARMYS, true)), to_binary(DAILY_HUOYUE), TOTAL_GONGXUN, TOTAL_GONGXUN_SEC, to_binary(OCCUPY_PLOT_IDS), to_binary(SPECIAL_SA_IDS), TODAY_PAY, TEAM_HP_RESTORE_SEC, to_binary(activity_limit:to_row(ACTIVITY_LIMITS, true)), to_binary(APPLY_CAMP_POSTS), to_binary(sign_info:to_row(SIGN_INFOS, true)), to_binary(camp_task_mix:to_row(CAMP_TASK_MIXS, true)), to_binary(fanpai:to_row(FANPAIS, true)), to_binary(privilege_info:to_row(PRIVILEGE_INFOS, true)), to_binary(END_PRIVILEGE_IDS), to_binary(actor_capitulate:to_row(ACTOR_CAPITULATES, true)), to_binary(SINGLE_EVENT), to_binary(tavern_info:to_row(TAVERN_INFOS, true)), to_binary(CHALLENGE_TAVERN_INFO)];
to_row('_', _Loop) -> 
    ['_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_'];
to_row(none, false) -> 
    [0, 0, 0, <<>>, 0, 0, 0, <<>>, <<>>, <<>>, <<>>, <<>>, <<>>, 0, 0, 0, 0, <<>>, 0, <<>>, 0, <<>>, 0, 0, 0, 0, 0, <<>>, 0, 0, 0, 0, 0, <<>>, <<>>, <<>>, <<>>, <<>>, <<>>, <<>>, <<>>, 0, 0, <<>>, <<>>, <<>>, 0, 0, <<>>, <<>>, <<>>, <<>>, <<>>, <<>>, <<>>, 0, <<>>, <<>>, <<>>, <<>>, <<>>, <<>>, <<>>, <<>>, <<>>, <<>>, 0, 0, <<>>, 0, 0, 0, <<>>, <<>>, <<>>, <<>>, 0, <<>>, <<>>, <<>>, 0, 0, <<>>, 0, 0, 0, 0, 0, 0, 0, 0, 0, <<>>, <<>>, <<>>, <<>>, 0, <<>>, <<>>, <<>>, <<>>, 0, 0, 0, 0, 0, 0, <<>>, 0, <<>>, <<>>, <<>>, <<>>, 0, <<>>, <<>>, <<>>, 0];
to_row(none, true) -> 
    none;
to_row(L, Loop) when erlang:is_list(L) -> [ to_row(R, Loop) || R <- L ].

to_rec([0, <<>>, 0, 0, <<>>, 0, 0, 0, <<>>, <<>>, <<>>, <<>>, <<>>, <<>>, 0, 0, 0, 0, <<>>, 0, <<>>, 0, <<>>, 0, 0, 0, 0, 0, 0, 0, <<>>, 0, 0, 0, 0, 0, 0, 0, <<>>, <<>>, <<>>, <<>>, <<>>, <<>>, <<>>, <<>>, <<>>, <<>>, <<>>, <<>>, 0, 0, <<>>, <<>>, <<>>, 0, <<>>, 0, 0, <<>>, <<>>, <<>>, <<>>, <<>>, <<>>, <<>>, 0, <<>>, <<>>, <<>>, <<>>, <<>>, <<>>, <<>>, <<>>, <<>>, <<>>, 0, 0, <<>>, 0, 0, 0, <<>>, <<>>, <<>>, <<>>, 0, <<>>, <<>>, <<>>, 0, 0, <<>>, 0, 0, 0, 0, 0, 0, 0, 0, 0, <<>>, <<>>, <<>>, <<>>, 0, <<>>, 0, 0, <<>>, <<>>, <<>>, 0, 0, 0, 0, 0, 0, <<>>, 0, <<>>, <<>>, 0, 0, 0, <<>>, <<>>, 0, <<>>, <<>>, <<>>, 0]) -> 
	 {role, 0, <<>>, 0, 0, <<>>, 0, 0, 0, <<>>, <<>>, <<>>, <<>>, <<>>, <<>>, 0, 0, 0, 0, <<>>, 0, <<>>, 0, <<>>, 0, 0, 0, 0, 0, 0, 0, <<>>, 0, 0, 0, 0, 0, 0, 0, <<>>, <<>>, <<>>, <<>>, <<>>, <<>>, <<>>, <<>>, <<>>, <<>>, <<>>, <<>>, 0, 0, <<>>, <<>>, <<>>, 0, <<>>, 0, 0, <<>>, <<>>, <<>>, <<>>, <<>>, <<>>, <<>>, 0, <<>>, <<>>, <<>>, <<>>, <<>>, <<>>, <<>>, <<>>, <<>>, <<>>, 0, 0, <<>>, 0, 0, 0, <<>>, <<>>, <<>>, <<>>, 0, <<>>, <<>>, <<>>, 0, 0, <<>>, 0, 0, 0, 0, 0, 0, 0, 0, 0, <<>>, <<>>, <<>>, <<>>, 0, <<>>, 0, 0, <<>>, <<>>, <<>>, 0, 0, 0, 0, 0, 0, <<>>, 0, <<>>, <<>>, 0, 0, 0, <<>>, <<>>, 0, <<>>, <<>>, <<>>, 0};
to_rec([ID, VIA_ID, LOGIN_VIA_ID, SDK_CHANNEL, SDK_PLATFORM_ID, SDK_SERVER_ID, CREATE_SERVER_ID, PACKAGE_NAME, SDK_VALUES, ACCNAME, NAME, HEAD_PORTRAIT_INFO, CHAT_FRAME_INFO, LEAGUE_ID, LEAGUE_POST, LEAGUE_LQ_SEC, APPLY_LEAGUE_IDS, SY_LEAGUE_INFOS, CAMP_ID, RESUME, DUMMY_GROW_ID, SETTINGS, CREATE_SEC, LOGIN_SEC, LOGOUT_SEC, LOSE_CONNECT_SEC, ROLE_STATUS, LOGIN_IP, ONLINE_SEC, TOTAL_ONLINE_SEC, LOGIN_DAY, ROLE_TYPE, RELOAD_MOD_TIMES, DEVICE_ID, DEVICE_DESC, OTHER_DESC, ID_MANAGES, BAG_INFOS, ACTORS, SHOPS, MAIL_TERMS, PUBLIC_MAIL_ID, TOTAL_CHAT_COUNT, ACTIVITYS, ACTIVITY_CUSTOMS, PAY_CONFIGS, UNSPEAK_SEC, CAMP_UNSPEAK_SEC, TASK, FCM_INFO, ZHENGBING_INFO, TEAM_INFOS, FB_TEAM_INFOS, RESOURCE_LANDS, GUIDE_GROUPS, IS_SKIP_GUIDE, PLAY_INFOS, EXTRA_INFOS, DECREE_INFO, BUILD_QUEUES, BUILD_INFOS, LIMIT_ITEMS, APPOINT_INFOS, LOTTERY_INFOS, TUJIAN_INFOS, XUNMA, WORLD_CHAT_FREE_TIMES, SEARCH_USE_TIMES, TRAINING_INFOS, TRAINING_SEC, TRAIN_TIMES, TOTAL_TRAIN_TIMES, FRIEND, PRIVATE_CHATS, PERSONAL_SYS_CHATS, ACHIEVE, TASK_CHAPTER, SEARCH_INFOS, ROLE_TRENDS, FB_INFOS, MAX_FB_ID, CHALLENGE_FB_ID, TAXES_INFO, CAMP_POST, VOTE_ONLY_IDS, DAY_DONATE_NUM, PREV_RANK_ID, YESTERDAY_RANK_ID, NOW_DEVOTE, TOTAL_DEVOTE, TODAY_DEVOTE, COMMON_BUFF_IDS, WELFARE_BOXS, WELFARE_BOX_GETS, TREASURES, SCIENCE_SUPPORT, ACTOR_VALUE, ATTENDANCE_INFO, MONTH_CARDS, PUBLIC_ARMYS, DAILY_HUOYUE, TOTAL_GONGXUN, TOTAL_GONGXUN_SEC, OCCUPY_PLOT_IDS, SPECIAL_SA_IDS, TODAY_PAY, TEAM_HP_RESTORE_SEC, ACTIVITY_LIMITS, APPLY_CAMP_POSTS, SIGN_INFOS, CAMP_TASK_MIXS, FANPAIS, PRIVILEGE_INFOS, END_PRIVILEGE_IDS, ACTOR_CAPITULATES, SINGLE_EVENT, TAVERN_INFOS, CHALLENGE_TAVERN_INFO]) -> 
    {role, ID, <<>>, VIA_ID, LOGIN_VIA_ID, SDK_CHANNEL, SDK_PLATFORM_ID, SDK_SERVER_ID, CREATE_SERVER_ID, PACKAGE_NAME, to_term(SDK_VALUES), ACCNAME, NAME, to_term(HEAD_PORTRAIT_INFO), to_term(CHAT_FRAME_INFO), LEAGUE_ID, LEAGUE_POST, LEAGUE_LQ_SEC, to_term(APPLY_LEAGUE_IDS), sy_league_info:to_rec_list(to_term(SY_LEAGUE_INFOS)), CAMP_ID, RESUME, DUMMY_GROW_ID, setting:to_rec_list(to_term(SETTINGS)), CREATE_SEC, LOGIN_SEC, LOGOUT_SEC, LOSE_CONNECT_SEC, 0, 0, ROLE_STATUS, LOGIN_IP, ONLINE_SEC, TOTAL_ONLINE_SEC, LOGIN_DAY, ROLE_TYPE, RELOAD_MOD_TIMES, 0, 0, DEVICE_ID, DEVICE_DESC, OTHER_DESC, none, none, none, id_manage:to_rec_list(to_term(ID_MANAGES)), bag_info:to_rec_list(to_term(BAG_INFOS)), [], actor:to_rec_list(to_term(ACTORS)), shop:to_rec_list(to_term(SHOPS)), mail_term:to_rec_list(to_term(MAIL_TERMS)), PUBLIC_MAIL_ID, TOTAL_CHAT_COUNT, activity:to_rec_list(to_term(ACTIVITYS)), activity_custom:to_rec_list(to_term(ACTIVITY_CUSTOMS)), [], [], pay_config:to_rec_list(to_term(PAY_CONFIGS)), UNSPEAK_SEC, CAMP_UNSPEAK_SEC, to_term(TASK), to_term(FCM_INFO), to_term(ZHENGBING_INFO), team_info:to_rec_list(to_term(TEAM_INFOS)), fb_team_info:to_rec_list(to_term(FB_TEAM_INFOS)), resource_land:to_rec_list(to_term(RESOURCE_LANDS)), guide_group:to_rec_list(to_term(GUIDE_GROUPS)), IS_SKIP_GUIDE, play_info:to_rec_list(to_term(PLAY_INFOS)), extra_info:to_rec_list(to_term(EXTRA_INFOS)), to_term(DECREE_INFO), build_queue:to_rec_list(to_term(BUILD_QUEUES)), build_info:to_rec_list(to_term(BUILD_INFOS)), limit_item:to_rec_list(to_term(LIMIT_ITEMS)), appoint_info:to_rec_list(to_term(APPOINT_INFOS)), lottery_info:to_rec_list(to_term(LOTTERY_INFOS)), tujian_info:to_rec_list(to_term(TUJIAN_INFOS)), to_term(XUNMA), WORLD_CHAT_FREE_TIMES, SEARCH_USE_TIMES, training_info:to_rec_list(to_term(TRAINING_INFOS)), TRAINING_SEC, TRAIN_TIMES, TOTAL_TRAIN_TIMES, to_term(FRIEND), private_chat:to_rec_list(to_term(PRIVATE_CHATS)), personal_sys_chat:to_rec_list(to_term(PERSONAL_SYS_CHATS)), to_term(ACHIEVE), TASK_CHAPTER, search_info:to_rec_list(to_term(SEARCH_INFOS)), role_trend:to_rec_list(to_term(ROLE_TRENDS)), fb_info:to_rec_list(to_term(FB_INFOS)), MAX_FB_ID, CHALLENGE_FB_ID, to_term(TAXES_INFO), CAMP_POST, to_term(VOTE_ONLY_IDS), DAY_DONATE_NUM, PREV_RANK_ID, YESTERDAY_RANK_ID, NOW_DEVOTE, TOTAL_DEVOTE, TODAY_DEVOTE, to_term(COMMON_BUFF_IDS), welfare_box:to_rec_list(to_term(WELFARE_BOXS)), welfare_box_get:to_rec_list(to_term(WELFARE_BOX_GETS)), treasure:to_rec_list(to_term(TREASURES)), to_term(SCIENCE_SUPPORT), ACTOR_VALUE, to_term(ATTENDANCE_INFO), 0, 1, month_card:to_rec_list(to_term(MONTH_CARDS)), public_army:to_rec_list(to_term(PUBLIC_ARMYS)), to_term(DAILY_HUOYUE), TOTAL_GONGXUN, TOTAL_GONGXUN_SEC, to_term(OCCUPY_PLOT_IDS), to_term(SPECIAL_SA_IDS), TODAY_PAY, TEAM_HP_RESTORE_SEC, activity_limit:to_rec_list(to_term(ACTIVITY_LIMITS)), to_term(APPLY_CAMP_POSTS), sign_info:to_rec_list(to_term(SIGN_INFOS)), camp_task_mix:to_rec_list(to_term(CAMP_TASK_MIXS)), 0, 0, 0, fanpai:to_rec_list(to_term(FANPAIS)), privilege_info:to_rec_list(to_term(PRIVILEGE_INFOS)), to_term(END_PRIVILEGE_IDS), actor_capitulate:to_rec_list(to_term(ACTOR_CAPITULATES)), to_term(SINGLE_EVENT), tavern_info:to_rec_list(to_term(TAVERN_INFOS)), to_term(CHALLENGE_TAVERN_INFO)}.

to_rec_list(none) -> [];
to_rec_list(LL) -> [ to_rec(L) || L <- LL ].

to_rec_t([0, <<>>, 0, 0, <<>>, 0, 0, 0, <<>>, <<>>, <<>>, <<>>, <<>>, <<>>, 0, 0, 0, 0, <<>>, 0, <<>>, 0, <<>>, 0, 0, 0, 0, 0, 0, 0, <<>>, 0, 0, 0, 0, 0, 0, 0, <<>>, <<>>, <<>>, <<>>, <<>>, <<>>, <<>>, <<>>, <<>>, <<>>, <<>>, <<>>, 0, 0, <<>>, <<>>, <<>>, 0, <<>>, 0, 0, <<>>, <<>>, <<>>, <<>>, <<>>, <<>>, <<>>, 0, <<>>, <<>>, <<>>, <<>>, <<>>, <<>>, <<>>, <<>>, <<>>, <<>>, 0, 0, <<>>, 0, 0, 0, <<>>, <<>>, <<>>, <<>>, 0, <<>>, <<>>, <<>>, 0, 0, <<>>, 0, 0, 0, 0, 0, 0, 0, 0, 0, <<>>, <<>>, <<>>, <<>>, 0, <<>>, 0, 0, <<>>, <<>>, <<>>, 0, 0, 0, 0, 0, 0, <<>>, 0, <<>>, <<>>, 0, 0, 0, <<>>, <<>>, 0, <<>>, <<>>, <<>>, 0]) -> 
	   {role, 0, <<>>, 0, 0, <<>>, 0, 0, 0, <<>>, <<>>, <<>>, <<>>, <<>>, <<>>, 0, 0, 0, 0, <<>>, 0, <<>>, 0, <<>>, 0, 0, 0, 0, 0, 0, 0, <<>>, 0, 0, 0, 0, 0, 0, 0, <<>>, <<>>, <<>>, <<>>, <<>>, <<>>, <<>>, <<>>, <<>>, <<>>, <<>>, <<>>, 0, 0, <<>>, <<>>, <<>>, 0, <<>>, 0, 0, <<>>, <<>>, <<>>, <<>>, <<>>, <<>>, <<>>, 0, <<>>, <<>>, <<>>, <<>>, <<>>, <<>>, <<>>, <<>>, <<>>, <<>>, 0, 0, <<>>, 0, 0, 0, <<>>, <<>>, <<>>, <<>>, 0, <<>>, <<>>, <<>>, 0, 0, <<>>, 0, 0, 0, 0, 0, 0, 0, 0, 0, <<>>, <<>>, <<>>, <<>>, 0, <<>>, 0, 0, <<>>, <<>>, <<>>, 0, 0, 0, 0, 0, 0, <<>>, 0, <<>>, <<>>, 0, 0, 0, <<>>, <<>>, 0, <<>>, <<>>, <<>>, 0};
to_rec_t([ID, _PID, VIA_ID, LOGIN_VIA_ID, SDK_CHANNEL, SDK_PLATFORM_ID, SDK_SERVER_ID, CREATE_SERVER_ID, PACKAGE_NAME, SDK_VALUES, ACCNAME, NAME, HEAD_PORTRAIT_INFO, CHAT_FRAME_INFO, LEAGUE_ID, LEAGUE_POST, LEAGUE_LQ_SEC, APPLY_LEAGUE_IDS, SY_LEAGUE_INFOS, CAMP_ID, RESUME, DUMMY_GROW_ID, SETTINGS, CREATE_SEC, LOGIN_SEC, LOGOUT_SEC, LOSE_CONNECT_SEC, _ACTIVE_SEC, _OFFLINE_LINE_ID, ROLE_STATUS, LOGIN_IP, ONLINE_SEC, TOTAL_ONLINE_SEC, LOGIN_DAY, ROLE_TYPE, RELOAD_MOD_TIMES, _ROLE_GROUP_ID, _CHANGE_PUBLIC_CONDITION, DEVICE_ID, DEVICE_DESC, OTHER_DESC, _GAME_NODE, _GATEWAY_NODE, _FIGHT_NODE, ID_MANAGES, BAG_INFOS, _ITEM_EXPIREDS, ACTORS, SHOPS, MAIL_TERMS, PUBLIC_MAIL_ID, TOTAL_CHAT_COUNT, ACTIVITYS, ACTIVITY_CUSTOMS, _RED_TRIGGERS, _OPEN_ICON_IDS, PAY_CONFIGS, UNSPEAK_SEC, CAMP_UNSPEAK_SEC, TASK, FCM_INFO, ZHENGBING_INFO, TEAM_INFOS, FB_TEAM_INFOS, RESOURCE_LANDS, GUIDE_GROUPS, IS_SKIP_GUIDE, PLAY_INFOS, EXTRA_INFOS, DECREE_INFO, BUILD_QUEUES, BUILD_INFOS, LIMIT_ITEMS, APPOINT_INFOS, LOTTERY_INFOS, TUJIAN_INFOS, XUNMA, WORLD_CHAT_FREE_TIMES, SEARCH_USE_TIMES, TRAINING_INFOS, TRAINING_SEC, TRAIN_TIMES, TOTAL_TRAIN_TIMES, FRIEND, PRIVATE_CHATS, PERSONAL_SYS_CHATS, ACHIEVE, TASK_CHAPTER, SEARCH_INFOS, ROLE_TRENDS, FB_INFOS, MAX_FB_ID, CHALLENGE_FB_ID, TAXES_INFO, CAMP_POST, VOTE_ONLY_IDS, DAY_DONATE_NUM, PREV_RANK_ID, YESTERDAY_RANK_ID, NOW_DEVOTE, TOTAL_DEVOTE, TODAY_DEVOTE, COMMON_BUFF_IDS, WELFARE_BOXS, WELFARE_BOX_GETS, TREASURES, SCIENCE_SUPPORT, ACTOR_VALUE, ATTENDANCE_INFO, _RESOURCE_PUSH_SEC, _RESOURCE_CHANGE_FLAG, MONTH_CARDS, PUBLIC_ARMYS, DAILY_HUOYUE, TOTAL_GONGXUN, TOTAL_GONGXUN_SEC, OCCUPY_PLOT_IDS, SPECIAL_SA_IDS, TODAY_PAY, TEAM_HP_RESTORE_SEC, ACTIVITY_LIMITS, APPLY_CAMP_POSTS, SIGN_INFOS, CAMP_TASK_MIXS, _RESOURCE_INIT_FLAG, _ROB_SEC, _ROB_TIMES, FANPAIS, PRIVILEGE_INFOS, END_PRIVILEGE_IDS, ACTOR_CAPITULATES, SINGLE_EVENT, TAVERN_INFOS, CHALLENGE_TAVERN_INFO]) -> 
    {role, ID, <<>>, VIA_ID, LOGIN_VIA_ID, SDK_CHANNEL, SDK_PLATFORM_ID, SDK_SERVER_ID, CREATE_SERVER_ID, PACKAGE_NAME, to_term(SDK_VALUES), ACCNAME, NAME, to_term(HEAD_PORTRAIT_INFO), to_term(CHAT_FRAME_INFO), LEAGUE_ID, LEAGUE_POST, LEAGUE_LQ_SEC, to_term(APPLY_LEAGUE_IDS), sy_league_info:to_rec_list_t(to_term(SY_LEAGUE_INFOS)), CAMP_ID, RESUME, DUMMY_GROW_ID, setting:to_rec_list_t(to_term(SETTINGS)), CREATE_SEC, LOGIN_SEC, LOGOUT_SEC, LOSE_CONNECT_SEC, 0, 0, ROLE_STATUS, LOGIN_IP, ONLINE_SEC, TOTAL_ONLINE_SEC, LOGIN_DAY, ROLE_TYPE, RELOAD_MOD_TIMES, 0, 0, DEVICE_ID, DEVICE_DESC, OTHER_DESC, none, none, none, id_manage:to_rec_list_t(to_term(ID_MANAGES)), bag_info:to_rec_list_t(to_term(BAG_INFOS)), [], actor:to_rec_list_t(to_term(ACTORS)), shop:to_rec_list_t(to_term(SHOPS)), mail_term:to_rec_list_t(to_term(MAIL_TERMS)), PUBLIC_MAIL_ID, TOTAL_CHAT_COUNT, activity:to_rec_list_t(to_term(ACTIVITYS)), activity_custom:to_rec_list_t(to_term(ACTIVITY_CUSTOMS)), [], [], pay_config:to_rec_list_t(to_term(PAY_CONFIGS)), UNSPEAK_SEC, CAMP_UNSPEAK_SEC, to_term(TASK), to_term(FCM_INFO), to_term(ZHENGBING_INFO), team_info:to_rec_list_t(to_term(TEAM_INFOS)), fb_team_info:to_rec_list_t(to_term(FB_TEAM_INFOS)), resource_land:to_rec_list_t(to_term(RESOURCE_LANDS)), guide_group:to_rec_list_t(to_term(GUIDE_GROUPS)), IS_SKIP_GUIDE, play_info:to_rec_list_t(to_term(PLAY_INFOS)), extra_info:to_rec_list_t(to_term(EXTRA_INFOS)), to_term(DECREE_INFO), build_queue:to_rec_list_t(to_term(BUILD_QUEUES)), build_info:to_rec_list_t(to_term(BUILD_INFOS)), limit_item:to_rec_list_t(to_term(LIMIT_ITEMS)), appoint_info:to_rec_list_t(to_term(APPOINT_INFOS)), lottery_info:to_rec_list_t(to_term(LOTTERY_INFOS)), tujian_info:to_rec_list_t(to_term(TUJIAN_INFOS)), to_term(XUNMA), WORLD_CHAT_FREE_TIMES, SEARCH_USE_TIMES, training_info:to_rec_list_t(to_term(TRAINING_INFOS)), TRAINING_SEC, TRAIN_TIMES, TOTAL_TRAIN_TIMES, to_term(FRIEND), private_chat:to_rec_list_t(to_term(PRIVATE_CHATS)), personal_sys_chat:to_rec_list_t(to_term(PERSONAL_SYS_CHATS)), to_term(ACHIEVE), TASK_CHAPTER, search_info:to_rec_list_t(to_term(SEARCH_INFOS)), role_trend:to_rec_list_t(to_term(ROLE_TRENDS)), fb_info:to_rec_list_t(to_term(FB_INFOS)), MAX_FB_ID, CHALLENGE_FB_ID, to_term(TAXES_INFO), CAMP_POST, to_term(VOTE_ONLY_IDS), DAY_DONATE_NUM, PREV_RANK_ID, YESTERDAY_RANK_ID, NOW_DEVOTE, TOTAL_DEVOTE, TODAY_DEVOTE, to_term(COMMON_BUFF_IDS), welfare_box:to_rec_list_t(to_term(WELFARE_BOXS)), welfare_box_get:to_rec_list_t(to_term(WELFARE_BOX_GETS)), treasure:to_rec_list_t(to_term(TREASURES)), to_term(SCIENCE_SUPPORT), ACTOR_VALUE, to_term(ATTENDANCE_INFO), 0, 1, month_card:to_rec_list_t(to_term(MONTH_CARDS)), public_army:to_rec_list_t(to_term(PUBLIC_ARMYS)), to_term(DAILY_HUOYUE), TOTAL_GONGXUN, TOTAL_GONGXUN_SEC, to_term(OCCUPY_PLOT_IDS), to_term(SPECIAL_SA_IDS), TODAY_PAY, TEAM_HP_RESTORE_SEC, activity_limit:to_rec_list_t(to_term(ACTIVITY_LIMITS)), to_term(APPLY_CAMP_POSTS), sign_info:to_rec_list_t(to_term(SIGN_INFOS)), camp_task_mix:to_rec_list_t(to_term(CAMP_TASK_MIXS)), 0, 0, 0, fanpai:to_rec_list_t(to_term(FANPAIS)), privilege_info:to_rec_list_t(to_term(PRIVILEGE_INFOS)), to_term(END_PRIVILEGE_IDS), actor_capitulate:to_rec_list_t(to_term(ACTOR_CAPITULATES)), to_term(SINGLE_EVENT), tavern_info:to_rec_list_t(to_term(TAVERN_INFOS)), to_term(CHALLENGE_TAVERN_INFO)}.

to_rec_list_t(none) -> [];
to_rec_list_t(LL) -> [ to_rec_t(L) || L <- LL ].

insert(PoolId, Tab, Rec) when erlang:is_tuple(Rec) ->
    case util_db_handle:insert(PoolId, Tab, fields(), to_row(Rec)) of
        {updated, _} ->
            ok;
        Ret ->
            Ret
    end.

insert_next(PoolId, Tab, Rec) when erlang:is_tuple(Rec) ->
    case util_db_handle:insert_next(PoolId, Tab, fields(), to_row(Rec)) of
        {updated, _} ->
            ok;
        Ret ->
            Ret
    end.

delete(PoolId, Tab, Id) when erlang:is_integer(Id) ->
    delete(PoolId, Tab, ["Id=", mysql:encode(Id)]);
delete(PoolId, Tab, Where) ->
    case util_db_handle:delete(PoolId, Tab, Where) of
        {updated, _} ->
            ok;
        Ret ->
            Ret
    end.

select(PoolId, Tab) ->
    select(PoolId, Tab, fields(), "", true).
select(PoolId, Tab, Id) when erlang:is_integer(Id) ->
    select(PoolId, Tab, ["id=", mysql:encode(Id)]);
select(PoolId, Tab, Where) ->
    select(PoolId, Tab, fields(), Where, true).
select(PoolId, Tab, Fields, Where) ->
    select(PoolId, Tab, Fields, Where, false).
select(PoolId, Tab, Fields, Where, Convert) ->
    case util_db_handle:select(PoolId, Tab, Fields, Where) of
        {selected, _, Ret} when Convert ->
            Ret2 = [to_rec(Row) || Row <- Ret],
            {ok, Ret2};
        {selected, _, Ret} ->
            {ok, Ret};
        Ret ->
            Ret
    end.
select(PoolId, Tab, Fields, Where, Convert, Other) ->
    case util_db_handle:select(PoolId, Tab, Fields, Where, Other) of
        {selected, _, Ret} when Convert ->
            Ret2 = [to_rec(Row) || Row <- Ret],
            {ok, Ret2};
        {selected, _, Ret} ->
            {ok, Ret};
        Ret ->
            Ret
    end.
select(PoolId, Tab, Fields, Index, Where, Convert, Other) ->
    case util_db_handle:select(PoolId, Tab, Fields, Index, Where, Other) of
        {selected, _, Ret} when Convert ->
            Ret2 = [to_rec(Row) || Row <- Ret],
            {ok, Ret2};
        {selected, _, Ret} ->
            {ok, Ret};
        Ret ->
            Ret
    end.

update(PoolId, Tab, Rec) ->
    Id = erlang:element(2, Rec),
    update(PoolId, Tab, Rec, ["id=", mysql:encode(Id)]).
update(PoolId, Tab, Rec, Where) ->
    [_ | Fields] = fields(),
    [_ | Values] = to_row(Rec),
    update(PoolId, Tab, Fields, Values, Where).
update(PoolId, Tab, Fields, Values, Where) ->
    case util_db_handle:update(PoolId, Tab, Fields, Values, Where) of
        {updated, _} ->
            ok;
        Ret ->
            Ret
    end.

replace(PoolId, Tab, Rec) when erlang:is_tuple(Rec) ->
    case util_db_handle:replace(PoolId, Tab, fields(), to_row(Rec)) of
        {updated, _} ->
            ok;
        Ret ->
            Ret
    end.

first_tab() ->
     "role".

assign_tab(_Id, _TabNum) ->
     "role".

