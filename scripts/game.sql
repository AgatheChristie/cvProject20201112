CREATE TABLE IF NOT EXISTS `db_version` (
  `version` varchar(32) NOT NULL DEFAULT '' COMMENT '版本',

  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='当前数据库版本,更新数据库时使用' ROW_FORMAT=COMPRESSED;


DROP TABLE IF EXISTS `whole_id`;
CREATE TABLE IF NOT EXISTS `whole_id` (
  `id` bigint(20) NOT NULL COMMENT '唯一标识',
  `version` INT(11) NOT NULL DEFAULT 0 COMMENT '数据版本',
  `is_dump` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否持久',
  `value` bigint(20) unsigned NOT NULL COMMENT '对应的值',

  PRIMARY KEY (`id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin  COMMENT='唯一主键' ROW_FORMAT=COMPRESSED;

DROP TABLE IF EXISTS `ban`;
CREATE TABLE IF NOT EXISTS `ban` (
  `id` bigint(20) NOT NULL COMMENT '唯一标识',
  `version` int(11) NOT NULL DEFAULT '0' COMMENT '数据版本',
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `type` tinyint(2) NOT NULL COMMENT '封禁类型(1封号 3禁言 5踢下线)',
  `start_sec` int(11) NOT NULL DEFAULT '0' COMMENT '封禁开始时间',
  `end_sec` int(11) NOT NULL DEFAULT '0' COMMENT '封禁结束时间',

  PRIMARY KEY (`id`),
  UNIQUE KEY `INDEX_TYPE` (`role_id`,`type`),
  KEY `INDEX_ID` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='封禁信息' ROW_FORMAT=COMPRESSED;

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
