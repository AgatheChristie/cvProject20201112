%%%----------------------------------------------------------------------
%% coding: latin-1
%%%
%%% @author: liyiming
%%% @doc: （自动生成,请勿编辑!)
%%%
%%%----------------------------------------------------------------------

-record(role, {
	id = 0, 
	pid = <<>>, 
	via_id = 0, 
	login_via_id = 0, 
	sdk_channel = <<>>, 
	sdk_platform_id = 0, 
	sdk_server_id = 0, 
	create_server_id = 0, 
	package_name = <<>>, 
	sdk_values = [], 
	accname = <<>>, 
	name = <<>>, 
	head_portrait_info = none, 
	chat_frame_info = none, 
	league_id = 0, 
	league_post = 0, 
	league_lq_sec = 0, 
	apply_league_ids = [], 
	sy_league_infos = [], 
	camp_id = 0, 
	resume = <<>>, 
	dummy_grow_id = 0, 
	settings = [], 
	create_sec = 0, 
	login_sec = 0, 
	logout_sec = 0, 
	lose_connect_sec = 0, 
	active_sec = 0, 
	offline_line_id = 0, 
	role_status = 0, 
	login_ip = <<>>, 
	online_sec = 0, 
	total_online_sec = 0, 
	login_day = 0, 
	role_type = 0, 
	reload_mod_times = 0, 
	role_group_id = 0, 
	change_public_condition = 0, 
	device_id = <<>>, 
	device_desc = <<>>, 
	other_desc = <<>>, 
	game_node = none, 
	gateway_node = none, 
	fight_node = none, 
	id_manages = [], 
	bag_infos = [], 
	item_expireds = [], 
	actors = [], 
	shops = [], 
	mail_terms = [], 
	public_mail_id = 0, 
	total_chat_count = 0, 
	activitys = [], 
	activity_customs = [], 
	red_triggers = [], 
	open_icon_ids = [], 
	pay_configs = [], 
	unspeak_sec = 0, 
	camp_unspeak_sec = 0, 
	task = none, 
	fcm_info = none, 
	zhengbing_info = none, 
	team_infos = [], 
	fb_team_infos = [], 
	resource_lands = [], 
	guide_groups = [], 
	is_skip_guide = 0, 
	play_infos = [], 
	extra_infos = [], 
	decree_info = none, 
	build_queues = [], 
	build_infos = [], 
	limit_items = [], 
	appoint_infos = [], 
	lottery_infos = [], 
	tujian_infos = [], 
	xunma = none, 
	world_chat_free_times = 0, 
	search_use_times = 0, 
	training_infos = [], 
	training_sec = 0, 
	train_times = 0, 
	total_train_times = 0, 
	friend = none, 
	private_chats = [], 
	personal_sys_chats = [], 
	achieve = none, 
	task_chapter = 1, 
	search_infos = [], 
	role_trends = [], 
	fb_infos = [], 
	max_fb_id = 0, 
	challenge_fb_id = 0, 
	taxes_info = none, 
	camp_post = 0, 
	vote_only_ids = [], 
	day_donate_num = 0, 
	prev_rank_id = 0, 
	yesterday_rank_id = 0, 
	now_devote = 0, 
	total_devote = 0, 
	today_devote = 0, 
	common_buff_ids = [], 
	welfare_boxs = [], 
	welfare_box_gets = [], 
	treasures = [], 
	science_support = none, 
	actor_value = 0, 
	attendance_info = none, 
	resource_push_sec = 0, 
	resource_change_flag = 1, 
	month_cards = [], 
	public_armys = [], 
	daily_huoyue = none, 
	total_gongxun = 0, 
	total_gongxun_sec = 0, 
	occupy_plot_ids = [], 
	special_sa_ids = [], 
	today_pay = 0, 
	team_hp_restore_sec = 0, 
	activity_limits = [], 
	apply_camp_posts = [], 
	sign_infos = [], 
	camp_task_mixs = [], 
	resource_init_flag = 0, 
	rob_sec = 0, 
	rob_times = 0, 
	fanpais = [], 
	privilege_infos = [], 
	end_privilege_ids = [], 
	actor_capitulates = [], 
	single_event = none, 
	tavern_infos = [], 
	challenge_tavern_info = []}).

-record(tavern_info, {
	tavern_id = 0, 
	tavern_groups = []}).

-record(tavern_group, {
	tavern_group_id = 0, 
	tavern_actors = []}).

-record(tavern_actor, {
	team_key = none, 
	tavern_actor_id = 0, 
	max_key = 0}).

-record(single_event, {
	reward_times = 0, 
	next_refresh_sec = 0, 
	single_event_terms = [], 
	single_event_points = []}).

-record(single_event_point, {
	only_id = 0, 
	city_point = none}).

-record(single_event_term, {
	only_id = 0, 
	type = 0, 
	sys_id = 0, 
	city_point = none, 
	team_id = 0, 
	status = 0, 
	status_end_sec = 0, 
	status_start_sec = 0, 
	source_id = 0}).

-record(fanpai, {
	plot_id = 0, 
	level = 0, 
	now_sort = 0, 
	fanpai_details = [], 
	rewards = []}).

-record(fanpai_detail, {
	type = 0, 
	fanpai_terms = []}).

-record(fanpai_term, {
	id = 0, 
	sort = 0, 
	is_key = 0}).

-record(science_support, {
	support_times = 0, 
	total_support_times = 0, 
	next_restore_sec = 0}).

-record(setting, {
	id = 0, 
	value = 0}).

-record(whole_role, {
	id = 0, 
	camp_id = 0, 
	plot_details = [], 
	plot_builds = [], 
	plot_orders = [], 
	restore_infos = [], 
	role_effects = [], 
	resource_items = [], 
	resource_decimals = [], 
	declare_kill_num = 0, 
	crusade_kill_num = 0, 
	daily_minxin = 0, 
	baggage_car_rewards = []}).

-record(resource_item, {
	resource_type = 0, 
	item_num = 0}).

-record(add_effect_mod, {
	mod_type = 0, 
	add_effects = []}).

-record(add_effect_info, {
	effect_type = 0, 
	add_num = 0, 
	add_terms = []}).

-record(add_effect_term, {
	term_id = 0, 
	term_value = 0}).

-record(resource_decimal, {
	resource_type = 0, 
	decimal = 0}).

-record(plot_detail, {
	plot_id = 0, 
	plot_status = 0, 
	is_detect = 0, 
	plot_level = 0, 
	occupy_mon_team = none, 
	assart_mon_team = none}).

-record(plot_build, {
	plot_id = 0, 
	build_type = 0, 
	build_level = 0}).

-record(plot_order, {
	plot_id = 0, 
	order_type = 0, 
	build_type = 0, 
	end_sec = 0, 
	custom_data = none}).

-record(restore_info, {
	restore_key = none, 
	plot_id = 0, 
	mon_team = none, 
	restore_sec = 0}).

-record(plot_mon_team, {
	only_id = 0, 
	last_fight_sec = 0}).

-record(head_portrait_info, {
	using_id = 0, 
	head_portraits = []}).

-record(head_portrait, {
	head_portrait_id = 0, 
	expire_sec = 0}).

-record(chat_frame_info, {
	using_id = 0, 
	chat_frames = []}).

-record(chat_frame, {
	chat_frame_id = 0, 
	expire_sec = 0}).

-record(whole_id, {
	id = 0, 
	is_dump = 0, 
	value = 0}).

-record(chat_part, {
	type = 0, 
	content = <<>>, 
	int_values = [], 
	string_values = [], 
	template_id = 0}).

-record(public_play, {
	id = 0, 
	custom_data = none}).

-record(id_manage, {
	type = 0, 
	max_id = 0, 
	assign_ids = []}).

-record(bag_grid_add, {
	add_type = 0, 
	add_grid = 0}).

-record(bag_info, {
	bag_type = 0, 
	name = <<>>, 
	items = [], 
	bag_grid_adds = []}).

-record(actor, {
	only_id = 0, 
	actor_id = 0, 
	actor_level = 0, 
	actor_star = 0, 
	armys = [], 
	zhenxings = [], 
	now_exp = 0, 
	attr_points = [], 
	is_fight = 0, 
	skills = [], 
	unique_skills = [], 
	special_statuss = [], 
	team_id = 0, 
	team_pos = 0, 
	fb_team_pos = 0, 
	first_attr = none, 
	attr = none, 
	now_attr = none, 
	calc_bingli = 0, 
	buff_ids = [], 
	appoint_id = 0, 
	appoint_sec = 0, 
	actor_skill_use_infos = [], 
	main_skills = [], 
	equips = [], 
	training_pos = 0, 
	fb_status = 0, 
	actor_value = 0, 
	max_assign_point = 0}).

-record(special_status, {
	status_type = 0, 
	status_end_sec = 0}).

-record(item, {
	only_id = 0, 
	item_id = 0, 
	item_num = 0, 
	expired_sec = 0, 
	is_bind = 0, 
	custom_data = none}).

-record(mail_term, {
	mail_sort = 0, 
	mails = []}).

-record(mail, {
	mail_id = 0, 
	mail_type = 0, 
	template_id = 0, 
	title = <<>>, 
	content = <<>>, 
	int_values = [], 
	string_values = [], 
	items = [], 
	log_type = 0, 
	send_sec = 0, 
	expire_sec = 0, 
	public_id = 0, 
	is_read = 0, 
	is_award = 0, 
	send_name = <<>>}).

-record(mail_item, {
	item_id = 0, 
	item_num = 0, 
	is_bind = 0}).

-record(league, {
	id = 0, 
	level = 0, 
	name = <<>>, 
	pid = <<>>, 
	is_save = 0, 
	is_save_sec = 0, 
	icon_id = 1, 
	exp = 0, 
	create_sec = 0, 
	notice_board = <<>>, 
	leader_id = 0, 
	members = [], 
	join_type = 0, 
	join_conditions = [], 
	league_applys = [], 
	league_resources = [], 
	league_logs = [], 
	league_chats = [], 
	chat_id = 0, 
	total_score = 0, 
	mail_sec = 0, 
	demise_info = none, 
	modify_notice_sec = 0, 
	diplomacy_infos = [], 
	dip_send_applys = [], 
	dip_receive_applys = [], 
	achieve = none}).

-record(diplomacy_info, {
	league_id = 0, 
	status = 0, 
	finish_sec = 0}).

-record(dip_send_apply, {
	apply_send_id = 0, 
	send_sec = 0}).

-record(dip_receive_apply, {
	apply_receive_id = 0, 
	receive_sec = 0}).

-record(league_member, {
	id = 0, 
	post = 0, 
	enter_sec = 0, 
	total_contribution = 0, 
	donate = 0, 
	is_open = 0, 
	score = 0, 
	pos = 0}).

-record(league_join_condition, {
	type = 0, 
	value = 0}).

-record(league_apply, {
	id = 0, 
	apply_sec = 0}).

-record(diplomacy_apply, {
	league_id = 0, 
	apply_sec = 0}).

-record(league_log, {
	log_sec = 0, 
	template_id = 0, 
	int_values = [], 
	string_values = []}).

-record(league_chat, {
	chat_id = 0, 
	send_id = 0, 
	send_sec = 0, 
	chat_parts = []}).

-record(rank, {
	id = 0, 
	rank_type = 0, 
	rank_infos = [], 
	start_sec = 0, 
	end_sec = 0, 
	award_sec = 0, 
	rank_status = 0, 
	is_award = 0, 
	is_clear = 0, 
	is_change = 0, 
	is_merge_collect = 0}).

-record(rank_info, {
	rank_key = none, 
	self_id = 0, 
	rank_values = [], 
	now_rank_values = [], 
	rank_sec = 0}).

-record(public_mail, {
	id = 0, 
	template_id = 0, 
	int_values = [], 
	string_values = [], 
	title = <<>>, 
	content = <<>>, 
	items = [], 
	conditions = [], 
	type = 0, 
	mail_sort = 0, 
	mail_type = 0, 
	log_type = 0, 
	role_ids = [], 
	send_sec = 0}).

-record(public_mail_condition, {
	condition_type = 0, 
	condition_value = 0}).

-record(world_chat, {
	id = 0, 
	chat_type = 0, 
	role_id = 0, 
	chat_parts = [], 
	chat_sec = 0, 
	is_light = 0}).

-record(shop, {
	shop_id = 0, 
	shop_items = [], 
	shop_buys = [], 
	refresh_times = 0, 
	manual_refresh_times = 0, 
	refresh_sec = 0, 
	item_refresh_sec = 0, 
	manual_times_refresh_sec = 0, 
	last_refresh_sec = 0, 
	start_sec = 0, 
	end_sec = 0}).

-record(shop_item, {
	sale_id = 0}).

-record(shop_buy, {
	sale_id = 0, 
	limit_type = 0, 
	buy_num = 0, 
	last_sec = 0}).

-record(activity, {
	id = 0, 
	activity_terms = [], 
	start_sec = 0, 
	end_sec = 0}).

-record(activity_term, {
	term_id = 0, 
	schedule = 0, 
	receive_times = 0, 
	has_receive_times = 0, 
	receive_sec = 0, 
	has_receive_sec = 0}).

-record(pay_order, {
	id = 0, 
	role_id = 0, 
	other_id = 0, 
	order_status = 0, 
	config_id = 0, 
	product_num = 0, 
	rmb = 0, 
	order_id = <<>>, 
	order_sec = 0, 
	send_sec = 0, 
	sdk_order_id = <<>>, 
	is_broadcast = 0, 
	trigger_activitys = []}).

-record(pay_config, {
	config_id = 0, 
	pay_num = 0}).

-record(task, {
	task_sorts = [], 
	finish_tasks = [], 
	com_main_task_id = 0}).

-record(task_sort, {
	task_type = 0, 
	tasks = []}).

-record(task_info, {
	only_id = 0, 
	task_id = 0, 
	terms = [], 
	status = 0, 
	accept_sec = 0, 
	end_sec = 0, 
	int_values = [], 
	finish_values = [], 
	is_stop = 0, 
	commit_times = 0}).

-record(task_info_term, {
	term_id = 0, 
	value = 0, 
	max_value = 0, 
	finish_times = 0}).

-record(finish_task, {
	task_id = 0, 
	int_values = []}).

-record(message, {
	msg_type = 0, 
	message_infos = []}).

-record(message_info, {
	msg_id = 0, 
	msg_key = none, 
	int_values = [], 
	string_values = []}).

-record(activity_mix, {
	id = 0, 
	mix_info = none}).

-record(icon, {
	icon_id = 0, 
	icon_status = 0, 
	advance_sec = 0, 
	start_sec = 0, 
	advance_end_sec = 0, 
	server_end_sec = 0, 
	end_sec = 0, 
	is_notice = 0}).

-record(trigger_activity, {
	activity_id = 0, 
	term_id = 0}).

-record(activity_custom, {
	activity_id = 0, 
	customdata = [], 
	start_sec = 0, 
	end_sec = 0}).

-record(snapshot, {
	id = 0, 
	snapshot_infos = []}).

-record(snapshot_info, {
	role_id = 0, 
	self_id = 0, 
	send_sec = 0, 
	custom_data = none}).

-record(fcm_info, {
	is_fcm = 0, 
	age = 0, 
	is_notice_fcm = 0, 
	fcm_allow_sec = 0, 
	is_notice_kick = 0}).

-record(guide_group, {
	group_id = 0, 
	guide_ids = []}).

-record(role_save, {
	id = 0, 
	max_msg_id = 0, 
	save_msgs = []}).

-record(role_save_msg, {
	msg_id = 0, 
	deal_sec = 0, 
	msg = none}).

-record(play_info, {
	play_id = 0, 
	start_sec = 0, 
	play_level = 0, 
	play_times = 0, 
	restore_times = 0, 
	last_restore_sec = 0}).

-record(decree_info, {
	recovery_sec = 0, 
	buy_decrees = []}).

-record(buy_decree, {
	buy_id = 0, 
	buy_times = 0}).

-record(extra_info, {
	extra_id = 0, 
	extra_value = none}).

-record(zhengbing_info, {
	available_num = 0, 
	zhengbing_num = 0, 
	queue_num = 0, 
	next_add_sec = 0, 
	queue_speed = 0, 
	queue_decimal = 0, 
	flag = 0, 
	last_sec = 0, 
	cfinish_all_sec = 0, 
	auto_type = 0}).

-record(taxes_info, {
	free_taxes_times = 0, 
	jinzhu_taxes_times = 0, 
	free_taxes_value = 0, 
	jinzhu_taxes_value = 0}).

-record(city, {
	id = 0, 
	map_id = 0, 
	camp_id = 0, 
	minxin_camp_id = 0, 
	minxin = 0, 
	league_id = 0, 
	bei_city_mons = [], 
	zhu_city_mons = [], 
	defense_war_sec = 0, 
	war_free_sec = 0, 
	quick_times = 0, 
	quick_sec = 0, 
	has_fight_times = 0, 
	fight_only_id = 0, 
	team_queues = [], 
	common_fights = [], 
	add_fights = [], 
	role_summarys = [], 
	fight_ranks = [], 
	city_status = 0, 
	log_only_id = 0, 
	fight_logs = [], 
	wild_mon_infos = [], 
	governs = [], 
	caiwa_plots = [], 
	policy_tokens = [], 
	attack_sec = 0, 
	minxin_add_effects = [], 
	ccl_add_effects = [], 
	city_effects = [], 
	expire_effect_types = [], 
	city_npc_attack = none, 
	baggage_cars = []}).

-record(baggage_car, {
	key = none, 
	camp_id = 0, 
	reach_sec = 0, 
	rewards = []}).

-record(baggage_car_key, {
	city_id = 0, 
	start_sec = 0}).

-record(city_npc_attack, {
	attack_city_id = 0, 
	attack_camp_id = 0, 
	attack_mon_teams = [], 
	status = 0, 
	start_sec = 0, 
	end_sec = 0}).

-record(city_mon, {
	mon_type = 0, 
	mon_only_id = 0, 
	mon_teams = [], 
	city_mon_terms = []}).

-record(city_mon_term, {
	term_type = 0, 
	total_count = 0, 
	has_restore_count = 0, 
	now_count = 0, 
	only_ids = [], 
	max_count = 0, 
	max_level = 0, 
	restore_sec = 0}).

-record(caiwa_plot, {
	plot_id = 0, 
	caiwa_roles = [], 
	already_caiwas = [], 
	start_sec = 0}).

-record(caiwa_role, {
	role_id = 0, 
	team_key = none, 
	start_sec = 0}).

-record(already_caiwa, {
	role_id = 0, 
	caiwa_times = 0}).

-record(point, {
	x = 0, 
	y = 0}).

-record(wild_mon_info, {
	point = none, 
	disappear_sec = 0, 
	wild_mon_id = 0, 
	mon_team_id = 0, 
	mon_team = none, 
	battle_id = none, 
	is_fight = 0}).

-record(city_point, {
	city_id = 0, 
	point = none}).

-record(fight_log, {
	log_id = 0, 
	template_id = 0, 
	log_sec = 0, 
	int_values = [], 
	string_values = []}).

-record(fight_sort, {
	fight_id = 0, 
	fight_team_key = none, 
	defense_team_key = none, 
	defense_queue_type = 0, 
	battle_id = none, 
	fight_times = 0, 
	now_fight_times = 0, 
	is_quick = 0, 
	is_play = 0, 
	fs_look_ids = [], 
	next_sec = 0, 
	keep_sec = 0, 
	start_sec = 0, 
	end_sec = 0, 
	fight_sec = 0}).

-record(team_queue, {
	queue_type = 0, 
	queue_only_id = 0, 
	queue_terms = []}).

-record(team_queue_term, {
	queue_id = 0, 
	queue_type = 0, 
	team_key = none, 
	subject_type = 0, 
	subject_id = 0, 
	fight_status = 0, 
	special_int_value = 0, 
	special_decimal_value = 0, 
	enter_sec = 0}).

-record(city_role_summary, {
	subject_key = none, 
	camp_id = 0, 
	kill_actor_num = 0, 
	hurt_actor_hp = 0, 
	hurt_last_sec = 0}).

-record(mon_team, {
	team_id = 0, 
	sys_id = 0, 
	mon_type = 0, 
	mon_term_type = 0, 
	fight_status = 0, 
	team_status = 0, 
	max_level = 0, 
	mon_actors = []}).

-record(mon_actor, {
	id = 0, 
	actor_id = 0, 
	status = 0, 
	team_pos = 0, 
	first_attr = none, 
	attr = none, 
	now_attr = none, 
	buff_ids = [], 
	mon_star = 0, 
	mon_level = 0, 
	common_skills = [], 
	main_skills = [], 
	unique_skills = [], 
	army_id = 0, 
	army_level = 0, 
	m_major_skills = [], 
	m_zhenxing_id = 0}).

-record(detail_actor, {
	only_id = 0, 
	actor_id = 0, 
	team_id = 0, 
	team_pos = 0, 
	first_attr = none, 
	attr = none, 
	now_attr = none, 
	buff_ids = [], 
	actor_level = 0, 
	actor_star = 0, 
	army_id = 0, 
	army_level = 0, 
	m_zhenxing_id = 0, 
	m_major_skills = [], 
	common_skills = [], 
	main_skills = [], 
	unique_skills = [], 
	zhenxing_ids = [], 
	armys = []}).

-record(fight_skill, {
	skill_id = 0, 
	skill_pos = 0, 
	skill_level = 0}).

-record(role_order, {
	id = none, 
	subject_type = 0, 
	subject_id = 0, 
	team_orders = []}).

-record(team_order, {
	team_id = 0, 
	order_type = 0, 
	map_id = 0, 
	born_city_id = 0, 
	now_city_id = 0, 
	team_status = 0, 
	back_city_id = 0, 
	plot_id = 0, 
	buildup_id = 0, 
	far_army_id = 0, 
	team_shiqi = 0, 
	team_shiqi_sec = 0, 
	start_sec = 0, 
	end_sec = 0, 
	is_loop_end = 0, 
	team_speed = 0, 
	is_skip_fight = 0, 
	now_deal_times = 0, 
	retreat_times = 0, 
	order_actors = [], 
	order_req_custom = none, 
	order_walk_custom = none}).

-record(order_actor, {
	only_id = 0, 
	actor_id = 0, 
	order_actor_supplys = []}).

-record(order_actor_supply, {
	supply_type = 0, 
	has_supply_num = 0, 
	plan_supply_num = 0, 
	init_num = 0, 
	queue_decimal = 0, 
	finish_num = 0, 
	queue_speed = 0, 
	next_sec = 0, 
	flag = 0, 
	last_sec = 0, 
	is_finish = 0, 
	finish_sec = 0}).

-record(order_req_custom, {
	order_type = 0, 
	map_id = 0, 
	source_id = 0, 
	plot_id = 0, 
	deal_times = 0, 
	auto_back = 0}).

-record(order_walk_custom, {
	now_id = 0, 
	next_sec = 0, 
	prev_id = 0, 
	source_id = 0, 
	source_sec = 0, 
	target_id = 0, 
	space_infos = [], 
	total_sec = 0}).

-record(walk_space_info, {
	source_id = 0, 
	use_sec = 0, 
	target_id = 0}).

-record(team_info, {
	team_id = 0, 
	team_status = 0, 
	ts_start_sec = 0, 
	ts_end_sec = 0, 
	team_special_status = 0, 
	tss_start_sec = 0, 
	tss_end_sec = 0, 
	team_pos_infos = [], 
	add_team_speed = 0, 
	team_speed = 0, 
	is_restore = 0, 
	can_action = 0, 
	team_tag = none, 
	event_status = 0, 
	ms_actor_id = 0}).

-record(team_tag, {
	order_type = 0, 
	plot_id = 0}).

-record(team_pos_info, {
	pos_id = 0, 
	only_id = 0}).

-record(fb_team_info, {
	pos_id = 0, 
	only_id = 0}).

-record(skill, {
	skill_id = 0, 
	skill_pos = 0, 
	skill_level = 0, 
	skill_bring = 0}).

-record(army, {
	army_id = 0, 
	level = 0, 
	army_status = 0}).

-record(zhenxing, {
	zhenxing_id = 0, 
	zhenxing_status = 0}).

-record(unique_skill, {
	skill_id = 0, 
	skill_level = 0, 
	is_active = 0}).

-record(first_attr, {
	liliang = 0, 
	zhili = 0, 
	tizhi = 0, 
	tongshuai = 0, 
	neizheng = 0}).

-record(attr, {
	hp = 0, 
	def = 0, 
	bingli = 0, 
	mp = 0, 
	attack = 0, 
	mingzhong = 0, 
	shanbi = 0, 
	baoji = 0, 
	baoji_def = 0, 
	baoji_hurt = 0, 
	mp_rec = 0, 
	move_speed_dp = 0, 
	fury_value = 0, 
	fury_rec = 0, 
	attack_speed = 0, 
	vision = 0, 
	gunshot = 0, 
	skill_damage = 0, 
	skill_damage_per = 0, 
	liliang_factor = 0, 
	zhili_factor = 0, 
	hurt_value = 0, 
	amplify_damage = 0, 
	damage_reduction = 0, 
	init_fury_value = 0}).

-record(now_attr, {
	now_hp = 0, 
	now_bingli = 0, 
	now_mp = 0, 
	now_fury_value = 0}).

-record(attr_point, {
	attr_type = 0, 
	point_value = 0}).

-record(limit_item, {
	item_id = 0, 
	used_times = 0}).

-record(build_info, {
	group_id = 0, 
	build_id = 0}).

-record(build_queue, {
	queue_pos = 0, 
	group_id = 0, 
	begin_sec = 0, 
	finish_sec = 0}).

-record(appoint_info, {
	appoint_id = 0, 
	only_id = 0}).

-record(resource_land, {
	resource_type = 0, 
	farmer_num = 0}).

-record(league_resource, {
	item_id = 0, 
	item_num = 0}).

-record(camp_resource, {
	item_id = 0, 
	item_num = 0}).

-record(battle_info, {
	id = none, 
	attack_subject_type = 0, 
	attack_id = 0, 
	attack_name = <<>>, 
	attack_team_id = 0, 
	attack_league_id = 0, 
	attack_league_name = <<>>, 
	attack_camp_id = 0, 
	defense_subject_type = 0, 
	defense_id = 0, 
	defense_name = <<>>, 
	defense_team_id = 0, 
	defense_league_id = 0, 
	defense_league_name = <<>>, 
	defense_camp_id = 0, 
	city_id = 0, 
	city_camp_id = 0, 
	is_skip_fight = 0, 
	battle_type = 0, 
	battle_step = 0, 
	battle_details = [], 
	total_fight_times = 0, 
	fight_infos = [], 
	total_result = 0, 
	total_status = 0, 
	result_sec = 0, 
	start_sec = 0, 
	end_sec = 0}).

-record(battle_report_info, {
	id = none, 
	attack_subject_type = 0, 
	attack_id = 0, 
	attack_name = <<>>, 
	attack_team_id = 0, 
	attack_league_id = 0, 
	attack_league_name = <<>>, 
	attack_camp_id = 0, 
	attack_is_read = 0, 
	defense_subject_type = 0, 
	defense_id = 0, 
	defense_name = <<>>, 
	defense_team_id = 0, 
	defense_league_id = 0, 
	defense_league_name = <<>>, 
	defense_camp_id = 0, 
	defense_is_read = 0, 
	city_id = 0, 
	city_camp_id = 0, 
	is_skip_fight = 0, 
	battle_type = 0, 
	battle_details = [], 
	total_fight_times = 0, 
	fight_infos = [], 
	total_result = 0, 
	result_sec = 0, 
	start_sec = 0, 
	end_sec = 0}).

-record(battle_store, {
	id = none, 
	role_id = 0, 
	battle_id = none}).

-record(public_item, {
	item_id = 0, 
	item_num = 0}).

-record(battle_detail, {
	self_type = 0, 
	camp_id = 0, 
	role_name = <<>>, 
	team_shiqi = 0, 
	public_items = [], 
	ms_actor_id = 0, 
	battle_actors = []}).

-record(battle_actor, {
	actor_id = 0, 
	self_id = 0, 
	team_pos = 0, 
	actor_level = 0, 
	actor_star = 0, 
	common_skills = [], 
	main_skills = [], 
	unique_skills = [], 
	zhenxing_ids = [], 
	m_zhenxing_id = 0, 
	m_major_skills = [], 
	army_id = 0, 
	battle_status = 0, 
	army_level = 0, 
	first_attr = none, 
	attr = none, 
	prev_now_attr = none, 
	now_attr = none, 
	buff_ids = [], 
	award_exp = 0, 
	armys = []}).

-record(fight_info, {
	fight_times = 0, 
	fight_result = 0, 
	fight_details = []}).

-record(fight_detail, {
	self_type = 0, 
	actor_id = 0, 
	self_id = 0, 
	actor_level = 0, 
	prev_now_attr = none, 
	after_now_attr = none, 
	fight_summary = none, 
	major_skills = [], 
	fight_zhenxing_id = 0, 
	hand_infos = [], 
	total_frame = 0}).

-record(fight_summary, {
	has_hp = 0, 
	restore_hp = 0, 
	lose_hp = 0, 
	has_soldier = 0, 
	lose_soldier = 0, 
	restore_soldier = 0, 
	summary_data = none, 
	skill_summary_datas = [], 
	buff_summary_datas = [], 
	process_summary_datas = []}).

-record(fight_summary_values, {
	int_values = []}).

-record(hand_info, {
	frame_id = 0, 
	command = 0, 
	extra = 0}).

-record(tujian_info, {
	actor_id = 0, 
	once_num = 0}).

-record(lottery_info, {
	lottery_id = 0, 
	total_times = 0, 
	draw_times = 0, 
	top_times_flag = 0, 
	stage_award_ids = [], 
	start_sec = 0, 
	end_sec = 0}).

-record(main_skill, {
	active_id = 0, 
	skill_id = 0, 
	skill_level = 0, 
	skill_pos = 0, 
	skill_bring = 0}).

-record(xunma, {
	xunma_id = 0, 
	start_sec = 0, 
	end_sec = 0, 
	status = 0}).

-record(equip, {
	pos = 0, 
	only_id = 0, 
	item_id = 0}).

-record(camp_info, {
	id = 0, 
	city_ids = [], 
	once_city_ids = [], 
	pid = <<>>, 
	notice_board = <<>>, 
	leader_id = 0, 
	is_save = 0, 
	is_save_sec = 0, 
	camp_members = [], 
	member_count = 0, 
	today_donate = 0, 
	today_gongxun = 0, 
	mail_sec = 0, 
	demise_info = none, 
	impeach_info = none, 
	camp_chats = [], 
	chat_id = 0, 
	box_increment_id = 0, 
	treasure_increment_id = 0, 
	devote_sec = 0, 
	modify_notice_sec = 0, 
	leader_born_sec = 0, 
	camp_resources = [], 
	camp_logs = [], 
	city_output_sec = 0, 
	welfare_boxs = [], 
	welfare_box_nums = [], 
	treasures = [], 
	camp_exp = 0, 
	camp_level = 0, 
	treasure_exp = 0, 
	look_role_ids = [], 
	day_treasure_times = 0, 
	science = none, 
	camp_effects = [], 
	role_effects = [], 
	city_effects = [], 
	resource_decimals = [], 
	yesterday_login_num = 0, 
	today_login_num = 0, 
	today_pay = 0, 
	last_reset_sec = 0, 
	camp_status = 0, 
	status_end_sec = 0, 
	camp_death_sec = 0, 
	attack_camp_id = 0, 
	camp_post_applys = [], 
	camp_npc_attack = none, 
	camp_faling_id = 0, 
	camp_falings = [], 
	camp_signs = [], 
	buildup_infos = [], 
	total_science_point = 0, 
	week_science_point = 0, 
	extra_science_point = 0, 
	far_army_info = none, 
	role_summarys = [], 
	camp_activitys = [], 
	camp_wgfks = [], 
	camp_xlfjs = [], 
	finished_win_type = 0}).

-record(camp_xlfj, {
	activity_key = none, 
	start_sec = 0, 
	xlfj_boxs = [], 
	refresh_times = 0, 
	refresh_sec = 0, 
	next_refresh_sec = 0}).

-record(xlfj_box, {
	box_id = 0, 
	city_point = none, 
	is_reward = 0, 
	reward_role_id = 0, 
	disclose_role_ids = [], 
	get_tips_role_ids = []}).

-record(camp_role_summary, {
	role_id = 0, 
	camp_id = 0, 
	kill_actor_num = 0, 
	hurt_last_sec = 0}).

-record(far_army_info, {
	only_id = 0, 
	subject_id = 0, 
	aim_city_id = 0, 
	team_num = 0, 
	now_team_id = 0, 
	end_sec = 0}).

-record(buildup_info, {
	only_id = 0, 
	buildup_city_id = 0, 
	aim_city_id = 0, 
	defense_city_id = 0, 
	buildup_status = 0, 
	status_end_sec = 0, 
	buildup_dispatch_times = 0, 
	buildup_total_num = 0}).

-record(camp_faling, {
	faling_id = 0, 
	faling_title = <<>>, 
	faling_content = <<>>, 
	send_id = 0, 
	send_sec = 0}).

-record(camp_npc_attack, {
	is_npc_attack = 0, 
	npc_attack_sec = 0}).

-record(camp_chat, {
	chat_id = 0, 
	send_id = 0, 
	send_sec = 0, 
	chat_parts = []}).

-record(camp_member, {
	id = 0, 
	post = 0, 
	reach_sec = 0, 
	total_devote = 0, 
	prev_devote = 0, 
	now_devote = 0, 
	prev_rank_id = 0, 
	today_devote = 0, 
	yesterday_devote = 0, 
	yesterday_rank_id = 0, 
	rob_gold_infos = [], 
	game_win_award_ids = []}).

-record(camp_log, {
	log_sec = 0, 
	template_id = 0, 
	int_values = [], 
	string_values = []}).

-record(impeach_info, {
	now_vote_id = 0, 
	impeach_sec = 0, 
	vote_ids = []}).

-record(demise_info, {
	demise_id = 0, 
	finish_sec = 0}).

-record(training_info, {
	training_pos = 0, 
	only_id = 0}).

-record(friend, {
	friend_ids = [], 
	black_infos = [], 
	send_applys = [], 
	receive_applys = []}).

-record(black_info, {
	black_id = 0, 
	is_friend = 0}).

-record(friend_send_apply, {
	apply_send_id = 0, 
	send_sec = 0}).

-record(friend_receive_apply, {
	apply_receive_id = 0, 
	receive_sec = 0}).

-record(sy_league_info, {
	league_id = 0, 
	yq_role_id = 0}).

-record(private_chat, {
	role_id = 0, 
	max_chat_id = 0, 
	self_msgs = [], 
	not_read_msgs = [], 
	read_msgs = []}).

-record(personal_sys_chat, {
	type = 0, 
	max_chat_id = 0, 
	msgs = []}).

-record(personal_sys_msg, {
	chat_id = 0, 
	chat_sec = 0, 
	chat_parts = []}).

-record(private_msg, {
	chat_id = 0, 
	role_id = 0, 
	is_read = 0, 
	chat_sec = 0, 
	chat_parts = []}).

-record(achieve, {
	achieve_sorts = [], 
	finish_achieves = [], 
	award_ids = []}).

-record(achieve_sort, {
	achieve_type = 0, 
	achieves = []}).

-record(achieve_info, {
	achieve_id = 0, 
	terms = [], 
	status = 0, 
	end_sec = 0, 
	int_values = [], 
	finish_values = [], 
	commit_times = 0}).

-record(achieve_info_term, {
	term_id = 0, 
	value = 0, 
	max_value = 0, 
	finish_times = 0}).

-record(finish_achieve, {
	achieve_id = 0, 
	int_values = []}).

-record(search_info, {
	search_sec = 0, 
	template_id = 0, 
	int_values = [], 
	string_values = []}).

-record(role_trend, {
	trend_id = 0, 
	award_status = 0}).

-record(role_trend_term, {
	term_id = 0, 
	award_status = 0}).

-record(trend_info, {
	id = 0, 
	start_sec = 0, 
	complete_sec = 0, 
	end_sec = 0, 
	max_value = 0, 
	value = 0, 
	trend_term_camps = [], 
	status = 0}).

-record(trend_term_camp, {
	camp_id = 0, 
	camp_complete_sec = 0, 
	value = 0}).

-record(fb_info, {
	fb_id = 0, 
	has_times = 0}).

-record(vote_info, {
	id = 0, 
	vote_id = 0, 
	reason = <<>>, 
	end_sec = 0, 
	is_end = 0, 
	is_pass = 0, 
	source_id = 0, 
	target_id = 0, 
	vote_terms = [], 
	voter_num = 0, 
	voter_ids = []}).

-record(vote_term, {
	role_id = 0, 
	select_id = 0}).

-record(month_card, {
	card_id = 0, 
	status = 0, 
	expired_sec = 0}).

-record(welfare_box, {
	box_sort = 0, 
	gift_boxs = []}).

-record(welfare_box_get, {
	box_sort = 0, 
	get_num = 0}).

-record(welfare_box_num, {
	source_type = 0, 
	num = 0}).

-record(gift_box, {
	only_id = 0, 
	box_id = 0, 
	expire_sec = 0, 
	is_award = 0, 
	award_sec = 0, 
	log_type = 0, 
	public_items = [], 
	role_name = <<>>, 
	stage = 0}).

-record(treasure, {
	only_id = 0, 
	treasure_grade = 0, 
	expire_sec = 0, 
	is_award = 0}).

-record(science, {
	study_id = 0, 
	end_sec = 0, 
	recommend_id = 0, 
	science_terms = [], 
	science_tokens = []}).

-record(science_term, {
	science_id = 0, 
	level = 0, 
	schedule = 0}).

-record(science_token, {
	science_id = 0, 
	level = 0, 
	schedule = 0, 
	effect_level = 0, 
	effect_status = 0, 
	effect_sec = 0, 
	cooling_sec = 0}).

-record(govern, {
	camp_id = 0, 
	favour_point = 0, 
	govern_logs = []}).

-record(govern_log, {
	log_sec = 0, 
	template_id = 0, 
	int_values = [], 
	string_values = []}).

-record(policy_token, {
	camp_id = 0, 
	policy_token_id = 0, 
	used_times = 0, 
	effect_sec = 0}).

-record(attendance_info, {
	attendance_status = 0, 
	now_group_id = 0, 
	now_reward_id = 0, 
	login_day = 0}).

-record(minxin_add_effect, {
	effect_id = 0, 
	city_id = 0, 
	effect_level = 0}).

-record(ccl_add_effect, {
	policy_token_id = 0, 
	city_id = 0, 
	end_sec = 0}).

-record(effect_end_sec, {
	effect_type = 0, 
	end_sec = 0}).

-record(public_army, {
	army_id = 0, 
	level = 0}).

-record(ban_mgr, {
	id = 0, 
	bw_type = 0, 
	bw_type_args = <<>>, 
	type = 0, 
	end_sec = 0}).

-record(daily_huoyue, {
	finish_huoyue_ids = [], 
	huoyue_value = 0, 
	award_ids = []}).

-record(activity_limit, {
	id = 0, 
	is_close = 0, 
	end_sec = 0, 
	activity_limit_terms = []}).

-record(activity_limit_term, {
	term_id = 0, 
	buy_times = 0, 
	limit_times = 0, 
	receive_times = 0}).

-record(camp_post_apply, {
	id = 0, 
	post = 0, 
	apply_sec = 0}).

-record(sign_info, {
	city_id = 0, 
	describe = <<>>, 
	sign_sec = 0}).

-record(camp_sign, {
	city_id = 0, 
	describe = <<>>, 
	operator_id = 0, 
	sign_sec = 0}).

-record(camp_task_mix, {
	group_id = 0, 
	camp_task_mix_terms = [], 
	finish_times = 0}).

-record(camp_task_mix_term, {
	term_type = 0, 
	term_value = 0}).

-record(subject, {
	id = 0, 
	is_save = 0, 
	is_save_sec = 0, 
	subject_type = 0, 
	fun_type = 0, 
	is_close = 0, 
	camp_id = 0, 
	name = <<>>, 
	subject_teams = []}).

-record(subject_team, {
	team_id = 0, 
	sys_id = 0, 
	team_status = 0, 
	mon_actors = []}).

-record(camp_wgfk, {
	activity_key = none, 
	status = 0, 
	gold_num = 0, 
	join_role_ids = [], 
	left_times = 0, 
	begin_sec = 0, 
	end_sec = 0, 
	look_wgfk_role_ids = [], 
	wgfk_logs = []}).

-record(wgfk_log, {
	log_sec = 0, 
	template_id = 0, 
	int_values = [], 
	string_values = []}).

-record(rob_gold_info, {
	activity_key = none, 
	gold_num = 0, 
	unusual_reward_num = 0}).

-record(camp_activity, {
	activity_key = none, 
	activity_id = 0, 
	activity_status = 0, 
	status_start_sec = 0}).

-record(privilege_info, {
	privilege_id = 0, 
	begin_sec = 0, 
	end_sec = 0}).

-record(public_privilege, {
	id = 0, 
	status = 0, 
	begin_sec = 0, 
	end_sec = 0}).

-record(actor_capitulate, {
	id = 0, 
	schedule = 0, 
	city_id = 0, 
	can_fight = 0, 
	reborn_sec = 0, 
	stage = 0}).

-record(declare_info, {
	id = 0, 
	icon_id = 0, 
	declare_status = 0, 
	declare_sec = 0, 
	declare_ranks = [], 
	declare_chat_sec = 0, 
	down_chat_sec = 0, 
	declare_citys = []}).

-record(declare_city, {
	city_id = 0, 
	camp_id = 0, 
	old_camp_id = 0, 
	new_camp_id = 0}).

-record(declare_rank, {
	rank_id = 0, 
	role_id = 0, 
	kill_num = 0}).

-record(crusade_info, {
	id = 0, 
	icon_id = 0, 
	city_id = 0, 
	crusade_status = 0, 
	crusade_result = 0, 
	crusade_ranks = [], 
	down_chat_sec = 0, 
	end_sec = 0}).

-record(crusade_rank, {
	rank_id = 0, 
	camp_id = 0, 
	rank_value = 0, 
	kill_num = 0}).

-record(mj_challenge_info, {
	id = 0, 
	mj_challenge_roles = [], 
	mj_challenge_ranks = []}).

-record(mj_challenge_role, {
	role_id = 0, 
	mj_challenge_terms = []}).

-record(mj_challenge_term, {
	term_id = 0, 
	is_reward = 0, 
	score = 0}).

-record(mj_challenge_rank, {
	rank_id = 0, 
	role_id = 0, 
	total_score = 0}).

-record(game_win_info, {
	id = 0, 
	icon_id = 0, 
	win_camp_id = 0, 
	game_win_status = 0, 
	touch_sec = 0}).

