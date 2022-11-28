/**
* 设计到修改字段时,请在文件尾部追加,格式要严格相符
* 格式如下:
* -- TinyBlob 最大 255
* -- Blob 最大 65K
* -- MediumBlob 最大 16M
* -- LongBlob 最大 4G
* -- 添加xx字段
* -- author
* -- 2016xxxx
* --
*ALTER table `xxx` add `new_field` int(10) COMMENT '新字段";
*/
--
-- 添加表,设置数据库版本
-- init
-- 20160415
--
CREATE TABLE IF NOT EXISTS `db_version` (
  `version` varchar(32) NOT NULL DEFAULT '' COMMENT '版本',

  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='当前数据库版本,更新数据库时使用' ROW_FORMAT=COMPRESSED;

--
--
-- taiqi  玩家表
-- 20221120
--
DROP TABLE IF EXISTS `whole_id`;
CREATE TABLE IF NOT EXISTS `whole_id` (
  `id` bigint(20) NOT NULL COMMENT '唯一标识',
  `is_dump` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否持久',
  `value` bigint(20) unsigned NOT NULL COMMENT '对应的值',

  PRIMARY KEY (`id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin  COMMENT='唯一主键' ROW_FORMAT=COMPRESSED;

DROP TABLE IF EXISTS `role`;
CREATE TABLE IF NOT EXISTS `role` (
  `id` bigint(20) NOT NULL COMMENT 'id',
  `via_id` int(11) NOT NULL COMMENT '用户来源id',
  `login_via_id` int(11) NOT NULL DEFAULT '0' COMMENT '本次登陆来源',
  `sdk_channel` varchar(50) DEFAULT '' COMMENT '游戏包名',
  `sdk_platform_id` int(11) NOT NULL COMMENT 'sdk渠道id',
  `sdk_server_id` int(11) NOT NULL DEFAULT '0' COMMENT 'sdk唯一服务器id',
  `select_server_id` int(11) NOT NULL DEFAULT '0' COMMENT '选择的服务器平台id',
  `create_server_id` int(11) NOT NULL DEFAULT '0' COMMENT '创角时的服务器平台id',
  `package_name` varchar(50) DEFAULT '' COMMENT '游戏包名',
  `sdk_values` blob NOT NULL COMMENT 'sdk自定义参数',
  `accname` varchar(50) NOT NULL DEFAULT '' COMMENT '平台账户',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '玩家名',
  `head_portrait_info` blob NOT NULL COMMENT '玩家头像信息',
  `chat_frame_info` blob NOT NULL COMMENT '玩家气泡信息',
  `league_id` bigint(20) NOT NULL COMMENT '联盟id',
  `league_post` int(20) NOT NULL COMMENT '联盟职位',
  `league_lq_sec` int(11) DEFAULT '0' COMMENT '入盟冷却时间',
  `apply_league_ids` blob NOT NULL COMMENT '已申请联盟id列表',
  `sy_league_infos` blob NOT NULL COMMENT '受邀联盟信息',
  `camp_id` int(11) NOT NULL DEFAULT '0' COMMENT '玩家势力id',
  `resume` varchar(50) NOT NULL DEFAULT '' COMMENT '个人简介',
  `dummy_grow_id` int(11) NOT NULL DEFAULT '0' COMMENT '假人成长id',
  `settings` blob NOT NULL COMMENT '玩家设置',
  `create_sec` int(11) NOT NULL COMMENT '创角时间',
  `login_sec` int(11) NOT NULL DEFAULT '0' COMMENT '最后登录时间',
  `logout_sec` int(11) NOT NULL DEFAULT '0' COMMENT '最后登出时间',
  `lose_connect_sec` int(11) NOT NULL DEFAULT '0' COMMENT '丢失链接时间',
  `role_status` int(11) NOT NULL DEFAULT '0' COMMENT '玩家状态',
  `login_ip` varchar(15) NOT NULL DEFAULT '' COMMENT '最后登录ip',
  `online_sec` int(11) NOT NULL DEFAULT '0' COMMENT '当天登陆在线时长',
  `total_online_sec` int(11) NOT NULL DEFAULT '0' COMMENT '玩家总共游戏时间',
  `login_day` int(11) NOT NULL DEFAULT '0' COMMENT '累计登录天数',
  `role_type` int(11) NOT NULL DEFAULT '0' COMMENT '玩家类型',
  `reload_mod_times` int(11) NOT NULL DEFAULT '0' COMMENT '重载各模块数据的次数',
  `device_id` text COMMENT '当前登录的设备Id',
  `device_desc` text COMMENT '当前登录的设备描述',
  `other_desc` varchar(50) DEFAULT NULL COMMENT '其他的描述(浏览器)',
  `id_manages` blob NOT NULL COMMENT 'id管理信息',
  `bag_infos` mediumblob NOT NULL COMMENT '背包栏',
  `actors` mediumblob NOT NULL COMMENT '角色栏信息',
  `shops` mediumblob NOT NULL COMMENT '商店信息',
  `mail_terms` mediumblob NOT NULL COMMENT '邮件列表',
  `public_mail_id` int(20) NOT NULL DEFAULT '0' COMMENT '公共邮件最大id',
  `total_chat_count` int(11) NOT NULL DEFAULT '0' COMMENT '当天总聊天数量',
  `activitys` mediumblob NOT NULL COMMENT '活动信息',
  `activity_customs` mediumblob NOT NULL COMMENT '特殊自定义活动',
  `pay_configs` blob NOT NULL COMMENT '充值档次信息',
  `unspeak_sec` int(11) DEFAULT '0' COMMENT '禁言结束时间',
  `camp_unspeak_sec` int(11) DEFAULT '0' COMMENT '国家禁言结束时间',
  `task` mediumblob NOT NULL COMMENT '任务信息',
  `fcm_info` blob NOT NULL COMMENT '防沉迷信息',
  `zhengbing_info` blob NOT NULL COMMENT '征兵信息',
  `team_infos` blob NOT NULL COMMENT '队伍信息',
  `fb_team_infos` blob NOT NULL COMMENT '副本队伍信息',
  `resource_lands` blob NOT NULL COMMENT '资源地信息',
  `guide_groups` blob NOT NULL COMMENT '引导信息',
  `is_skip_guide` int(11) NOT NULL DEFAULT '0' COMMENT '是否跳过引导',
  `play_infos` blob NOT NULL COMMENT '特殊玩法信息',
  `extra_infos` blob NOT NULL COMMENT '额外信息',
  `decree_info` blob NOT NULL COMMENT '政令信息',
  `build_queues` blob  COMMENT '城建倒计时队列',
  `build_infos` blob NOT NULL COMMENT '城建信息',
  `limit_items` blob NOT NULL COMMENT '限制道具',
  `appoint_infos` blob NOT NULL COMMENT '委任信息',
  `lottery_infos` blob NOT NULL COMMENT '寻访数据',
  `tujian_infos` blob NOT NULL COMMENT '图鉴信息',
  `xunma` mediumblob NOT NULL COMMENT '驯马',
  `world_chat_free_times` int(3) DEFAULT '0' COMMENT '世界聊天免费次数',
  `search_use_times` int(3) DEFAULT '0' COMMENT '寻访使用次数',
  `training_infos` blob NOT NULL COMMENT '练兵信息',
  `training_sec` int(11) DEFAULT '0' COMMENT '练兵时间戳',
  `train_times` int(3) DEFAULT '0' COMMENT '训练次数',
  `total_train_times` int(3) DEFAULT '0' COMMENT '总的训练次数',
  `friend` mediumblob NOT NULL COMMENT '好友模块信息',
  `private_chats` mediumblob NOT NULL COMMENT '私聊信息',
  `personal_sys_chats` mediumblob NOT NULL COMMENT '个人系统信息',
  `achieve` mediumblob NOT NULL COMMENT '成就信息',
  `task_chapter` int(11) NOT NULL DEFAULT '1' COMMENT '任务当前章节',
  `search_infos` blob NOT NULL COMMENT '寻访信息',
  `role_trends` blob NOT NULL COMMENT '天下大势信息',
  `fb_infos` blob NOT NULL COMMENT '关卡信息',
  `max_fb_id` int(11) DEFAULT '0' COMMENT '通关最大关卡id',
  `challenge_fb_id` int(11) DEFAULT '0' COMMENT '当前正在挑战的关卡',
  `taxes_info` blob NOT NULL COMMENT '赋税信息',
  `camp_post` int(11) DEFAULT '0' COMMENT '国家职位',
  `vote_only_ids` blob NOT NULL COMMENT '投票唯一ids',
  `day_donate_num` int(11) DEFAULT '0' COMMENT '今日国库捐献数量(0点清空)',
  `prev_rank_id` int(11) DEFAULT '0' COMMENT '上周贡献度排名',
  `yesterday_rank_id` int(11) DEFAULT '0' COMMENT '昨日贡献度排名',
  `now_devote` int(11) DEFAULT '0' COMMENT '本周贡献度',
  `total_devote` int(11) DEFAULT '0' COMMENT '总贡献度',
  `today_devote` int(11) DEFAULT '0' COMMENT '今日贡献度',
  `common_buff_ids` blob NOT NULL COMMENT '公共buff_ids',
  `welfare_boxs` blob NOT NULL COMMENT '福利宝箱',
  `welfare_box_gets` blob NOT NULL COMMENT '已获取宝箱数量',
  `treasures` blob NOT NULL COMMENT '福利宝藏',
  `science_support` blob NOT NULL COMMENT '国家科技支援',
  `actor_value` int(11) DEFAULT '0' COMMENT '武将实力',
  `build_value` int(11) DEFAULT '0' COMMENT '城建实力',
  `attendance_info` blob NOT NULL COMMENT '签到信息',
  `month_cards` blob NOT NULL COMMENT '月卡信息',
  `public_armys` blob NOT NULL COMMENT '公共兵种信息',
  `daily_huoyue` blob NOT NULL COMMENT '每日活跃',
  `total_gongxun` int(11) DEFAULT '0' COMMENT '总功勋',
  `total_gongxun_sec` int(11) DEFAULT '0' COMMENT '获取总功勋时间',
  `occupy_plot_ids` blob NOT NULL COMMENT '占领过地块id',
  `special_sa_ids` blob NOT NULL COMMENT '特殊状态武将id列表',
  `today_pay` int(11) DEFAULT '0' COMMENT '今日充值金额',
  `team_hp_restore_sec` int(11) DEFAULT '0' COMMENT '队伍hp下次恢复时间',
  `activity_limits` blob NOT NULL COMMENT '个人限时活动信息',
  `apply_camp_posts` blob NOT NULL COMMENT '已申请国家官员列表',
  `sign_infos` blob NOT NULL COMMENT '个人标记',
  `camp_task_mixs` blob NOT NULL COMMENT '国家任务杂项',
  `fanpais` blob NOT NULL COMMENT '屯田翻牌玩法',
  `privilege_infos` blob NOT NULL COMMENT '特权信息',
  `end_privilege_ids` blob NOT NULL COMMENT '已结束特权ids',
  `actor_capitulates` blob NOT NULL COMMENT '武将劝降',
  `single_event` blob NOT NULL COMMENT '单人事件',
  `tavern_infos` blob NOT NULL COMMENT '酒馆比武',
  `challenge_tavern_info` blob NOT NULL COMMENT '当前正在挑战的酒馆信息',

  PRIMARY KEY (`id`),
  KEY `INDEX_ACCNAME` (`accname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户信息' ROW_FORMAT=COMPRESSED;

DROP TABLE IF EXISTS `game_win_info`;
CREATE TABLE IF NOT EXISTS `game_win_info` (
    `id` bigint(20) NOT NULL COMMENT '唯一标识',
    `icon_id` int(11) NOT NULL DEFAULT '0' COMMENT '图标id',
    `win_flag` int(11) NOT NULL DEFAULT '0' COMMENT '结算标识  0未结算 1已结算',
    `game_win_status` int(11) NOT NULL DEFAULT '0' COMMENT '游戏结算状态',
    `touch_sec` int(11) NOT NULL DEFAULT '0' COMMENT '触发结算时间',

    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='游戏结算发奖' ROW_FORMAT=COMPRESSED;

DROP TABLE IF EXISTS `world_chat`;
CREATE TABLE IF NOT EXISTS `world_chat` (
  `id` bigint(20) NOT NULL COMMENT '唯一标识',
  `chat_type` int(11) NOT NULL DEFAULT '0' COMMENT '聊天类型',
  `role_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '玩家id',
  `chat_parts` blob NOT NULL COMMENT '聊天模板信息',
  `chat_sec` int(11) NOT NULL COMMENT '世界聊天时间',
  `is_light` int(11) NOT NULL DEFAULT '0' COMMENT '是否跑马灯',

  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='世界聊天' ROW_FORMAT=COMPRESSED;

DROP TABLE IF EXISTS `runoob_tbl`;
CREATE TABLE IF NOT EXISTS `runoob_tbl`(
   `runoob_id` INT UNSIGNED AUTO_INCREMENT,
   `runoob_title` VARCHAR(100) NOT NULL,
   `runoob_author` VARCHAR(40) NOT NULL,
   `submission_date` DATE,
   PRIMARY KEY ( `runoob_id` )
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='测试表' ROW_FORMAT=COMPRESSED;


INSERT INTO runoob_tbl
    (runoob_title, runoob_author, submission_date)
     VALUES
    ("Google Ruby1", "ccppd1", NOW()),
    ("Google Erlang", "cccwd2", NOW()),
    ("Google Java", "ccghjh3", NOW()),
    ("Google Golang4", "ccwgg4", NOW());
