CREATE DATABASE IF NOT EXISTS `blog`
  DEFAULT CHARACTER SET utf8mb4
  DEFAULT COLLATE utf8mb4_0900_ai_ci;

USE `blog`;

--
-- 用户表
--
CREATE TABLE `user` (
  `id`            int unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `username`      varchar(16)  NOT NULL COMMENT '用户名',
  `email`         varchar(255) NOT NULL COMMENT '邮箱',
  `password`      varchar(100) NOT NULL COMMENT '密码（BCrypt 哈希）',
  `role`          varchar(32)  NOT NULL DEFAULT 'USER' COMMENT '角色',
  `registered_at` datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '注册于',
  `updated_at`    datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新于',
  -- 软删除标记；注意用户名/邮箱是全表唯一，注销后不可被新账号复用
  `deleted_at`    datetime     DEFAULT NULL COMMENT '移除于',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_user_username` (`username`),
  UNIQUE KEY `uk_user_email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户表';

--
-- 个人信息表
--
CREATE TABLE `person_profile` (
  `id`               int unsigned      NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `user_id`          int unsigned      NOT NULL COMMENT '用户ID',
  `avatar`           varchar(255)      DEFAULT NULL COMMENT '头像路径',
  `name`             varchar(32)       DEFAULT NULL COMMENT '姓名',
  `birthday`         date              DEFAULT NULL COMMENT '生日',
  `school`           varchar(32)       DEFAULT NULL COMMENT '学校',
  `school_year_from` smallint unsigned DEFAULT NULL COMMENT '入校年份',
  `school_year_to`   smallint unsigned DEFAULT NULL COMMENT '毕业年份',
  `github`           varchar(64)       DEFAULT NULL COMMENT 'github账号名',
  `linuxdo`          varchar(64)       DEFAULT NULL COMMENT 'linuxdo账户名',
  `hobbies`          varchar(255)      DEFAULT NULL COMMENT '兴趣爱好（多选，逗号分隔）',
  `tools`            varchar(255)      DEFAULT NULL COMMENT '常用开发工具（多选，逗号分隔）',
  `created_at`       datetime          NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建于',
  `updated_at`       datetime          NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新于',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_profile_user_id` (`user_id`),
  CONSTRAINT `fk_profile_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='个人信息表';
