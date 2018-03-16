

CREATE TABLE `accounts` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `account` char(20) NOT NULL,
  `password` char(50) NOT NULL,
  `name` char(20) DEFAULT NULL,
  `department` char(10) DEFAULT NULL,
  `job` char(20) DEFAULT NULL,
  `mobile` char(20) DEFAULT NULL,
  `QQ` char(20) DEFAULT NULL,
  `email` char(45) DEFAULT NULL,
  `dingtalk` char(20) DEFAULT NULL,
  `organization` char(20) DEFAULT NULL,
  `role_id` int(4) DEFAULT NULL,
  `status` int(4) DEFAULT '0',
  `vpn` int(4) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8;


CREATE TABLE `vpn_connection_history` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(4) NOT NULL,
  `start_time` timestamp NULL DEFAULT NULL COMMENT 'time at which client connected',
  `end_time` timestamp NULL DEFAULT NULL COMMENT 'time at which client disconnected =\ntime_unix + time_duration',
  `bytes_received` int(10) unsigned DEFAULT NULL COMMENT 'Total number of bytes received from client during VPN session',
  `bytes_sent` int(10) unsigned DEFAULT NULL COMMENT 'Total number of bytes sent to client during VPN session',
  `trusted_ip` int(10) unsigned DEFAULT NULL COMMENT 'ip the client connected from',
  `trusted_port` smallint(5) unsigned DEFAULT NULL COMMENT 'port the client connected from',
  `ifconfig_pool_remote_ip` int(10) unsigned DEFAULT NULL COMMENT 'ip given to the client',
  PRIMARY KEY (`id`),
  KEY `user_id_idx` (`user_id`),
  CONSTRAINT `fk_connection_history_user_id` FOREIGN KEY (`user_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1492 DEFAULT CHARSET=utf8 COMMENT='History of connections from clients';

