/*
Navicat MySQL Data Transfer

Source Server         : 远程
Source Server Version : 50724
Source Host           : 47.107.116.115:3306
Source Database       : submit

Target Server Type    : MYSQL
Target Server Version : 50724
File Encoding         : 65001

Date: 2019-03-10 13:26:18
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for `sys_permission`
-- ----------------------------
DROP TABLE IF EXISTS `sys_permission`;
CREATE TABLE `sys_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `url` varchar(255) NOT NULL COMMENT 'url地址',
  `description` varchar(64) NOT NULL COMMENT 'url描述',
  `gmt_create` datetime NOT NULL,
  `gmt_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_permission
-- ----------------------------
INSERT INTO `sys_permission` VALUES ('1', 'permission:ui', '页面：权限列表、添加权限、更新权限', '2018-12-12 00:08:55', '2019-01-19 10:03:55');
INSERT INTO `sys_permission` VALUES ('2', 'permission:add', '功能：添加权限', '2018-12-12 00:48:09', '2019-01-19 10:03:36');
INSERT INTO `sys_permission` VALUES ('6', 'permission:delete', '功能：删除权限', '2018-12-12 21:25:51', '2019-01-19 10:03:28');
INSERT INTO `sys_permission` VALUES ('7', 'permission:update', '功能：更新权限', '2018-12-12 21:26:03', '2019-01-19 10:04:44');
INSERT INTO `sys_permission` VALUES ('8', 'role:ui', '页面：角色列表、添加角色、修改角色', '2018-12-12 21:26:11', '2019-01-19 10:13:52');
INSERT INTO `sys_permission` VALUES ('9', 'role:add', '功能：添加角色', '2018-12-12 21:27:57', '2019-01-19 10:14:17');
INSERT INTO `sys_permission` VALUES ('10', 'role:update', '功能：修改角色', '2018-12-12 21:28:19', '2019-01-19 10:14:33');
INSERT INTO `sys_permission` VALUES ('11', 'role:delete', '功能：删除角色', '2018-12-12 21:28:26', '2019-01-19 10:15:00');
INSERT INTO `sys_permission` VALUES ('13', 'faculty:ui', '页面：院系列表、添加院系、修改院系', '2018-12-14 16:36:07', '2019-01-19 11:08:18');
INSERT INTO `sys_permission` VALUES ('14', 'faculty:add', '功能：添加院系', '2019-01-13 18:16:22', '2019-01-19 11:08:33');
INSERT INTO `sys_permission` VALUES ('15', 'faculty:update', '功能：修改院系', '2019-01-13 18:17:53', '2019-01-19 11:09:19');
INSERT INTO `sys_permission` VALUES ('17', 'faculty:delete', '功能：删除院系', '2019-01-13 18:18:27', '2019-01-19 11:10:05');
INSERT INTO `sys_permission` VALUES ('19', 'major:ui', '页面：专业列表、添加专业、修改专业', '2019-01-13 18:22:42', '2019-01-19 11:10:49');
INSERT INTO `sys_permission` VALUES ('20', 'major:add', '功能：添加专业', '2019-01-13 18:26:56', '2019-01-19 11:11:02');
INSERT INTO `sys_permission` VALUES ('21', 'major:update', '功能：修改专业', '2019-01-13 18:27:11', '2019-01-19 11:11:18');
INSERT INTO `sys_permission` VALUES ('24', 'major:delete', '功能：删除专业', '2019-01-13 18:29:53', '2019-01-19 11:12:23');
INSERT INTO `sys_permission` VALUES ('26', 'class:ui', '页面：班级列表-添加班级-修改班级', '2019-01-13 18:39:22', '2019-01-19 11:12:55');
INSERT INTO `sys_permission` VALUES ('27', 'class:add', '功能：添加班级', '2019-01-13 18:39:32', '2019-01-19 11:13:12');
INSERT INTO `sys_permission` VALUES ('28', 'class:update', '功能：修改班级', '2019-01-13 18:39:41', '2019-01-19 11:13:29');
INSERT INTO `sys_permission` VALUES ('30', 'class:delete', '功能：删除班级', '2019-01-13 18:40:12', '2019-01-19 11:14:02');
INSERT INTO `sys_permission` VALUES ('32', 'lession:ui', '页面：课程列表-添加课程-修改课程', '2019-01-13 18:41:22', '2019-01-19 11:14:28');
INSERT INTO `sys_permission` VALUES ('33', 'lession:add', '功能：添加课程', '2019-01-13 18:41:30', '2019-01-19 11:14:48');
INSERT INTO `sys_permission` VALUES ('34', 'lession:update', '功能：修改课程', '2019-01-13 18:41:39', '2019-01-19 11:15:02');
INSERT INTO `sys_permission` VALUES ('36', 'lession:delete', '功能：删除课程', '2019-01-13 18:42:12', '2019-01-19 11:15:33');
INSERT INTO `sys_permission` VALUES ('38', 'teaching:ui', '页面：授权列表-添加授权关系-修改授权关系', '2019-01-14 18:34:08', '2019-01-19 11:16:14');
INSERT INTO `sys_permission` VALUES ('39', 'teaching:add', '功能：添加权限', '2019-01-14 18:34:26', '2019-01-19 11:16:29');
INSERT INTO `sys_permission` VALUES ('40', 'teaching:update', '功能：修改权限', '2019-01-14 18:34:43', '2019-01-19 11:16:41');
INSERT INTO `sys_permission` VALUES ('42', 'teaching:delete', '功能：删除权限关系', '2019-01-14 18:35:29', '2019-01-19 11:17:05');
INSERT INTO `sys_permission` VALUES ('44', 'teacher:ui', '页面 : 教师列表-添加教师', '2019-01-19 11:34:16', null);
INSERT INTO `sys_permission` VALUES ('45', 'teacher:add', '功能 : 添加教师', '2019-01-19 11:34:36', null);
INSERT INTO `sys_permission` VALUES ('46', 'teacher:delete', '功能 : 删除教师', '2019-01-19 11:34:49', null);
INSERT INTO `sys_permission` VALUES ('47', 'teacher:update:status', '功能 : 设置教师状态', '2019-01-19 11:35:26', null);
INSERT INTO `sys_permission` VALUES ('48', 'student:update:status', '功能 : 设置学生状态', '2019-01-19 11:35:39', null);
INSERT INTO `sys_permission` VALUES ('49', 'student:delete', '功能 : 删除学生', '2019-01-19 11:35:54', null);
INSERT INTO `sys_permission` VALUES ('50', 'student:add', '功能 : 添加学生', '2019-01-19 11:36:02', null);
INSERT INTO `sys_permission` VALUES ('51', 'student:ui', '页面 : 学生列表-添加学生-一键导入学生', '2019-01-19 11:36:43', null);
INSERT INTO `sys_permission` VALUES ('52', 'student:import', '功能 : Excel一键导入学生', '2019-01-19 13:51:01', null);
INSERT INTO `sys_permission` VALUES ('53', 'user:ui', '页面 : 个人信息-密码更改', '2019-01-19 16:22:20', null);
INSERT INTO `sys_permission` VALUES ('54', 'user:update:info', '功能 : 更新个人信息', '2019-01-19 16:22:47', '2019-01-27 17:16:31');
INSERT INTO `sys_permission` VALUES ('56', 'student:update:class', '功能 : 修改学生所属班级', '2019-01-23 13:56:23', '2019-01-23 14:01:28');
INSERT INTO `sys_permission` VALUES ('57', 'user:update:passwd', '功能 : 修改个人密码', '2019-01-27 17:17:04', '2019-01-27 17:21:38');
INSERT INTO `sys_permission` VALUES ('58', 'work:publish', '功能&页面 : 发布作业', '2019-01-27 18:27:28', '2019-01-30 11:27:41');
INSERT INTO `sys_permission` VALUES ('59', 'work:recoders', '页面 : 作业列表', '2019-02-09 17:32:37', null);
INSERT INTO `sys_permission` VALUES ('60', 'work:mark', '功能 : 评分学生作业', '2019-02-26 10:22:49', '2019-02-26 10:25:54');
INSERT INTO `sys_permission` VALUES ('61', 'work:student', '学生的作业权限', '2019-03-09 13:42:39', null);

-- ----------------------------
-- Table structure for `sys_role`
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL COMMENT '角色名称',
  `type` varchar(10) DEFAULT NULL COMMENT '角色类型',
  `gmt_create` datetime NOT NULL,
  `gmt_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES ('11', '超级管理员', null, '2019-01-13 19:18:04', '2019-01-27 17:17:47');
INSERT INTO `sys_role` VALUES ('13', '教师', null, '2019-01-13 19:32:56', '2019-02-26 10:23:04');
INSERT INTO `sys_role` VALUES ('14', '学生', null, '2019-01-13 19:34:43', '2019-03-09 13:42:52');

-- ----------------------------
-- Table structure for `sys_role_permission`
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_permission`;
CREATE TABLE `sys_role_permission` (
  `role_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  KEY `role_id` (`role_id`),
  KEY `permission_id` (`permission_id`),
  CONSTRAINT `sys_role_permission_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `sys_role` (`id`),
  CONSTRAINT `sys_role_permission_ibfk_2` FOREIGN KEY (`permission_id`) REFERENCES `sys_permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_role_permission
-- ----------------------------
INSERT INTO `sys_role_permission` VALUES ('11', '1');
INSERT INTO `sys_role_permission` VALUES ('11', '2');
INSERT INTO `sys_role_permission` VALUES ('11', '6');
INSERT INTO `sys_role_permission` VALUES ('11', '7');
INSERT INTO `sys_role_permission` VALUES ('11', '8');
INSERT INTO `sys_role_permission` VALUES ('11', '9');
INSERT INTO `sys_role_permission` VALUES ('11', '10');
INSERT INTO `sys_role_permission` VALUES ('11', '11');
INSERT INTO `sys_role_permission` VALUES ('11', '13');
INSERT INTO `sys_role_permission` VALUES ('11', '14');
INSERT INTO `sys_role_permission` VALUES ('11', '15');
INSERT INTO `sys_role_permission` VALUES ('11', '17');
INSERT INTO `sys_role_permission` VALUES ('11', '19');
INSERT INTO `sys_role_permission` VALUES ('11', '20');
INSERT INTO `sys_role_permission` VALUES ('11', '21');
INSERT INTO `sys_role_permission` VALUES ('11', '24');
INSERT INTO `sys_role_permission` VALUES ('11', '26');
INSERT INTO `sys_role_permission` VALUES ('11', '27');
INSERT INTO `sys_role_permission` VALUES ('11', '28');
INSERT INTO `sys_role_permission` VALUES ('11', '30');
INSERT INTO `sys_role_permission` VALUES ('11', '32');
INSERT INTO `sys_role_permission` VALUES ('11', '33');
INSERT INTO `sys_role_permission` VALUES ('11', '34');
INSERT INTO `sys_role_permission` VALUES ('11', '36');
INSERT INTO `sys_role_permission` VALUES ('11', '38');
INSERT INTO `sys_role_permission` VALUES ('11', '39');
INSERT INTO `sys_role_permission` VALUES ('11', '40');
INSERT INTO `sys_role_permission` VALUES ('11', '42');
INSERT INTO `sys_role_permission` VALUES ('11', '44');
INSERT INTO `sys_role_permission` VALUES ('11', '45');
INSERT INTO `sys_role_permission` VALUES ('11', '46');
INSERT INTO `sys_role_permission` VALUES ('11', '47');
INSERT INTO `sys_role_permission` VALUES ('11', '48');
INSERT INTO `sys_role_permission` VALUES ('11', '49');
INSERT INTO `sys_role_permission` VALUES ('11', '50');
INSERT INTO `sys_role_permission` VALUES ('11', '51');
INSERT INTO `sys_role_permission` VALUES ('11', '52');
INSERT INTO `sys_role_permission` VALUES ('11', '53');
INSERT INTO `sys_role_permission` VALUES ('11', '56');
INSERT INTO `sys_role_permission` VALUES ('11', '57');
INSERT INTO `sys_role_permission` VALUES ('13', '53');
INSERT INTO `sys_role_permission` VALUES ('13', '54');
INSERT INTO `sys_role_permission` VALUES ('13', '57');
INSERT INTO `sys_role_permission` VALUES ('13', '58');
INSERT INTO `sys_role_permission` VALUES ('13', '59');
INSERT INTO `sys_role_permission` VALUES ('13', '60');
INSERT INTO `sys_role_permission` VALUES ('14', '53');
INSERT INTO `sys_role_permission` VALUES ('14', '54');
INSERT INTO `sys_role_permission` VALUES ('14', '57');
INSERT INTO `sys_role_permission` VALUES ('14', '61');

-- ----------------------------
-- Table structure for `t_class`
-- ----------------------------
DROP TABLE IF EXISTS `t_class`;
CREATE TABLE `t_class` (
  `id` varchar(32) NOT NULL,
  `name` varchar(64) NOT NULL,
  `major_id` int(11) NOT NULL,
  `gmt_create` datetime NOT NULL,
  `gmt_modified` datetime DEFAULT NULL,
  `year` int(11) NOT NULL DEFAULT '2018' COMMENT '年份',
  PRIMARY KEY (`id`),
  KEY `major_id` (`major_id`),
  CONSTRAINT `t_class_ibfk_1` FOREIGN KEY (`major_id`) REFERENCES `t_major` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_class
-- ----------------------------
INSERT INTO `t_class` VALUES ('1561aae6321e4d8295b47d7d98c34f14', '英语', '14', '2019-01-13 20:46:23', null, '2019');
INSERT INTO `t_class` VALUES ('16237ffba96147979041f7d6fd1c8955', '中华文化', '17', '2019-01-13 20:46:33', null, '2019');
INSERT INTO `t_class` VALUES ('4565abfe725e40f6ba371d25b40826a9', '软件工程', '1', '2019-01-13 20:44:47', null, '2015');
INSERT INTO `t_class` VALUES ('6502db0718c34198b85fd8dda895ecb9', '小说', '18', '2019-01-13 20:45:44', null, '2015');
INSERT INTO `t_class` VALUES ('880d8208e48940cd847d86b363c85c8f', '经济学', '11', '2019-01-13 20:46:06', null, '2019');
INSERT INTO `t_class` VALUES ('89a7e5af5a064f0da119cf3286c9666e', '马克思主义', '4', '2019-01-13 20:44:37', null, '2015');
INSERT INTO `t_class` VALUES ('95faab6c249c46a58e30e44d95bfa18e', '软件工程', '1', '2019-01-13 20:44:52', null, '2018');
INSERT INTO `t_class` VALUES ('96389dd160dd4075ad9f2f378629eb22', '自动化', '3', '2019-01-13 20:45:03', null, '2015');
INSERT INTO `t_class` VALUES ('a180472aa6dc42728c5e847863366677', '土木工程', '12', '2019-01-13 20:46:10', null, '2019');
INSERT INTO `t_class` VALUES ('a83beef999df43c19c97c923b57ce716', '软件工程', '1', '2019-01-13 20:45:09', null, '2017');
INSERT INTO `t_class` VALUES ('c13bd8a285ac49a882100015f8e9901c', '小说', '18', '2019-01-13 20:45:47', null, '2018');
INSERT INTO `t_class` VALUES ('d5e63ee944974e858799164dd83e0634', '幼儿教育', '5', '2019-01-13 20:45:55', null, '2018');
INSERT INTO `t_class` VALUES ('dec678b845f34f60a5f11b98dddf1818', '日语', '15', '2019-01-13 20:46:26', null, '2019');
INSERT INTO `t_class` VALUES ('e47a21103b294c65afb9bb3310fce3b4', '中华文化', '17', '2019-01-13 20:46:39', null, '2020');
INSERT INTO `t_class` VALUES ('e7923ad1ba62446b945dd2e4047b4767', '学前教育', '6', '2019-01-13 20:45:34', null, '2015');
INSERT INTO `t_class` VALUES ('e7efd724eae1415cb229e7f0fa1f1634', '体育', '13', '2019-01-13 20:46:19', null, '2019');
INSERT INTO `t_class` VALUES ('ebb860a4be684d79bece68ed92b814a9', '幼儿教育', '5', '2019-01-13 20:45:59', null, '2019');

-- ----------------------------
-- Table structure for `t_faculty`
-- ----------------------------
DROP TABLE IF EXISTS `t_faculty`;
CREATE TABLE `t_faculty` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(64) NOT NULL COMMENT '系院称名',
  `description` varchar(255) NOT NULL COMMENT '述描',
  `gmt_create` datetime NOT NULL COMMENT '建创时间',
  `gmt_modified` datetime DEFAULT NULL COMMENT '改修时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_faculty
-- ----------------------------
INSERT INTO `t_faculty` VALUES ('1', '马克思主义学院', '马克思主义学院前身是铜仁高等师范专科学校的马列主义教研室。2006年，学校升格为本科院校后马列主义教研室更名为社会科学部。2015年，社会科学部更名为马克思主义学院。2016年，马克思主义学院与社会发展学院的思想政治教育专业、法律文秘专业整合组建为现在的马克思主义学院。', '2019-01-13 19:43:11', null);
INSERT INTO `t_faculty` VALUES ('2', '教育学院', '当人类已经进入全球化、知识化、信息化的时代，中华民族的伟大复兴将由我们推动，“国将兴、必贵师而重傅，国将衰、必贱师而轻傅”。文明因教育而传承，教育因教师而薪火不息，教育乃国运之所向，民运之所系，作为未来的人民教师，我们“学高、身正、心和、行敏”，立学高身正之志，举民主科学之旗，扬创新教育之帆，脚踏实地，吃苦耐劳，诚实勇敢，全力以赴。', '2019-01-13 19:44:52', null);
INSERT INTO `t_faculty` VALUES ('3', '人文学院', '人文学院现有汉语言文学、秘书学、网络与新媒体、教育技术学、历史学等5个本科专业和1个文秘专科专业，设有中文系、历史系、新闻传播系和大学语文教学部。', '2019-01-13 19:45:49', null);
INSERT INTO `t_faculty` VALUES ('4', '艺术学院', '铜仁学院艺术学院是由原音乐学院和美术与设计学院整合组建的专业学院，设音乐与表演系、美术与设计系；现有音乐学、艺术教育（音乐、舞蹈）、美术学、视觉传达设计本科和舞蹈教育专科5个专业；', '2019-01-13 19:46:18', null);
INSERT INTO `t_faculty` VALUES ('5', '经济管理学院', '铜仁学院经济管理学院（亦称：铜仁学院电子商务学院），成立于2013年6月。', '2019-01-13 19:46:48', null);
INSERT INTO `t_faculty` VALUES ('6', '农林工程与规划学院', '2016年6月，原铜仁学院生物与农林工程学院生物科学、园林、水产养殖学三个专业与原物理与电子工程学院水利水电、土木工程两个专业及原经济与管理学院城乡规划专业建成农林工程与规划学院。', '2019-01-13 19:47:03', null);
INSERT INTO `t_faculty` VALUES ('7', '大数据学院', '学院于2016年6月正式组建成立，由原数学科学学院、信息工程学院、物理与电子工程学院、现代教育技术中心四个部门合并组建而成，学院现有四个教学系部：数学与统计系、物理与电子信息工程系、计算机科学系和大学数学与计算机基础教学部，开设有数学与应用数学、统计学、计算机科学与技术、软件工程、信息工程、自动化、物理学、应用物理学等八个本科专业。', '2019-01-13 19:47:47', null);
INSERT INTO `t_faculty` VALUES ('8', '材料与化学工程学院', '材料与化学工程学院始建于1978年，时名“化学科”，是贵州省最早建立化学高等教育的学院之一。学院历经铜仁师范专科学校化学科、铜仁师范高等专科学校生物与化学系、铜仁学院生物科学与化学系，生物科学与化学工程系，2014年5月年成立材料与化学工程学院。', '2019-01-13 19:48:22', null);
INSERT INTO `t_faculty` VALUES ('9', '大健康学院', '体育与健康学院的前称是1984年铜仁师范专科学校设置的体育科。1993年铜仁师范专科学校与铜仁教育学院合并为铜仁师范高等专科学校，体育科更名为体育系。2002年9月与贵州师范大学合作办本科层次教学并进行招生。2006年经教育部批准，铜仁师范高等专科学校升格为铜仁学院，同年我院正式独立招收本科生。2016年4月经学校批准“体育系”更名为“体育与健康学院”，完成了“系”改“院”历史突破。', '2019-01-13 19:49:02', null);
INSERT INTO `t_faculty` VALUES ('10', '国际学院', '国际学院前身是1920年创建的明德中学英语班。1978年铜仁师 范专科学校成立后设立英语科，开办英语教育专业（专科）；1993年更名铜仁师专英语系；2001年与贵州师范大学联合办学招收第一批英语本科专业学生；2006年9月英语专业作为铜仁学院首批本科开办专业之一，开始面向省内外招生；2009年更名为外国语言文学系，面向全国招生；2010年获取英语学士学位授予权；2016年3月更名为外国语学院；2016年6月外国语学院与国际教育学院合并，重新组建国际学院。', '2019-01-13 19:49:29', null);
INSERT INTO `t_faculty` VALUES ('11', '继续教育学院', '继续教育学院是铜仁学院主管各类职业培训和成人教育的职能机构,是“贵州省第九十七国家职业技能鉴定所”、“国家职业资格全国统一鉴定考试报名点”、“铜仁市教育干部培训基地”、“铜仁市中小学教师培训基地”，是铜仁学院大学生就业指导中心、职业培训中心，铜仁市未成年人心理健康辅导总站，铜仁市定点职业技能培训机构。', '2019-01-13 19:50:38', null);
INSERT INTO `t_faculty` VALUES ('12', '乌江学院', '乌江农林经济学院是铜仁学院与德江县人民政府合作共建的一所二级特色学院。是铜仁学院为贯彻落实《国务院关于加快发展现代职业教育的决定》和习近平总书记的重要指示精神，围绕建设人民满意的现代应用技术大学，推动学校转型发展，立足区域资源优势，密切产教深度融合，培养应用技术人才，服务地方产业发展的发展目标而建立的一所二级特色学院。', '2019-01-13 19:50:58', null);
INSERT INTO `t_faculty` VALUES ('13', '国学院', '暂无描述', '2019-01-13 19:51:52', null);
INSERT INTO `t_faculty` VALUES ('14', '田秋写作学院', '暂无描述', '2019-01-13 19:52:08', null);

-- ----------------------------
-- Table structure for `t_homework`
-- ----------------------------
DROP TABLE IF EXISTS `t_homework`;
CREATE TABLE `t_homework` (
  `id` varchar(32) NOT NULL,
  `student_id` int(10) NOT NULL COMMENT '生学',
  `work_id` varchar(32) NOT NULL COMMENT '作业id',
  `score` decimal(5,2) DEFAULT '0.00' COMMENT '数分',
  `annex` varchar(255) DEFAULT NULL COMMENT '件附',
  `gmt_modified` datetime DEFAULT NULL COMMENT '修改作业时间',
  `comment` varchar(255) DEFAULT NULL COMMENT '语评',
  `status` int(11) DEFAULT '0' COMMENT '0未交1已交未验收2已验收',
  PRIMARY KEY (`id`),
  KEY `user_id` (`student_id`),
  KEY `job_id` (`work_id`),
  CONSTRAINT `t_homework_ibfk_2` FOREIGN KEY (`work_id`) REFERENCES `t_work` (`id`),
  CONSTRAINT `t_homework_ibfk_3` FOREIGN KEY (`student_id`) REFERENCES `t_student` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_homework
-- ----------------------------

-- ----------------------------
-- Table structure for `t_lession`
-- ----------------------------
DROP TABLE IF EXISTS `t_lession`;
CREATE TABLE `t_lession` (
  `id` varchar(32) NOT NULL,
  `name` varchar(64) NOT NULL COMMENT '课程名',
  `description` varchar(255) DEFAULT NULL,
  `gmt_modified` datetime DEFAULT NULL,
  `gmt_create` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_lession
-- ----------------------------
INSERT INTO `t_lession` VALUES ('01f9c33849c144c5ad4ba402d8a00ab5', '无机化学实验', '暂无描述', null, '2019-01-13 20:57:36');
INSERT INTO `t_lession` VALUES ('02e6972b01864fdcbda390a794802e09', '现代科技概论与知识产权', '暂无描述', null, '2019-01-13 20:57:16');
INSERT INTO `t_lession` VALUES ('0ac3fc5aed4d446bad9becca0535e8ca', '色彩原理', '暂无描述', null, '2019-01-13 20:59:29');
INSERT INTO `t_lession` VALUES ('18099f9b6fcb49f397bf2d400c83f32c', '大学英语（二）', '暂无描述', null, '2019-01-13 20:53:19');
INSERT INTO `t_lession` VALUES ('330417581d1f4644a76321222a85d268', '中国近现代史纲要', '暂无描述', null, '2019-01-13 20:56:54');
INSERT INTO `t_lession` VALUES ('3448149f9d0b49bb986fe74b7ccca942', '多媒体技术', '暂无描述', null, '2019-01-13 20:55:14');
INSERT INTO `t_lession` VALUES ('3f27d83a278c45dc85d559ee4c382002', 'HTML5', '暂无描述', null, '2019-01-13 20:55:51');
INSERT INTO `t_lession` VALUES ('51d6d34c72aa4254b6bf1c957c0047d0', 'C++语言程序设计', 'C++', '2019-01-23 10:26:48', '2019-01-13 20:59:09');
INSERT INTO `t_lession` VALUES ('5256289a80c14933aef360fdb60611ba', 'ps基础教程', '暂无描述', null, '2019-01-13 20:59:40');
INSERT INTO `t_lession` VALUES ('54f7682577f641b388a88ae019d6faca', 'C语言程序设计', '暂无描述', null, '2019-01-13 20:54:33');
INSERT INTO `t_lession` VALUES ('5a3d5a5c01da44a0a893979e008ee869', '艺术概论', '暂无描述', null, '2019-01-13 20:57:19');
INSERT INTO `t_lession` VALUES ('68944598e3bc461eaf60a602b0dcc080', '大学英语（四）', '暂无描述', null, '2019-01-13 20:53:28');
INSERT INTO `t_lession` VALUES ('72e49506d575476fac3bd92ab215e2f4', '高等数学（二）', '高数第二册', null, '2019-01-13 20:52:32');
INSERT INTO `t_lession` VALUES ('75bcf27e32cc46e2898bfbd6b6d9d827', '毛泽东思想', '暂无描述', null, '2019-01-13 20:55:42');
INSERT INTO `t_lession` VALUES ('7b6b75e211ed4386985719683c6de905', '大学体育（一）', '暂无描述', null, '2019-01-13 20:52:58');
INSERT INTO `t_lession` VALUES ('867d2122e9bd49718da517b47ac6df2f', '马克思主义', '暂无描述', null, '2019-01-13 20:55:37');
INSERT INTO `t_lession` VALUES ('8e89d4138fdf4878a84616a4ed17ca39', '儒家经典与智慧', '暂无描述', null, '2019-01-13 20:57:11');
INSERT INTO `t_lession` VALUES ('93aaa7cdd92a4c4b8784b2573b5f686d', '高等数学（一）', '高数第一册', null, '2019-01-13 20:52:24');
INSERT INTO `t_lession` VALUES ('9826732c6fd74562b38159b6dc388269', '老子论', '暂无描述', null, '2019-01-13 20:55:23');
INSERT INTO `t_lession` VALUES ('9b3a3a7cf03144039ddd57acf52ce340', '大学生创新创业教育', '暂无描述', null, '2019-01-13 20:53:43');
INSERT INTO `t_lession` VALUES ('9d99de7461ba474fa51a180d38d8c2fa', 'python爬虫基础知识', '暂无描述', null, '2019-01-13 20:55:05');
INSERT INTO `t_lession` VALUES ('a5723e3fab8c4624acd8848ac1c71182', '心理案例分析', '暂无描述', null, '2019-01-13 20:57:07');
INSERT INTO `t_lession` VALUES ('a9829bc0c34a46908a4bd0ad51a95671', 'java网站建设', '暂无描述', null, '2019-01-13 20:54:48');
INSERT INTO `t_lession` VALUES ('ab29e054ff95444db810b9bfbfeb5187', '大学英语（三）', '暂无描述', null, '2019-01-13 20:53:23');
INSERT INTO `t_lession` VALUES ('b198ca3c88754d0eba499218639b9f3a', '计算机导论', '暂无描述', '2019-01-13 20:51:21', '2019-01-13 19:38:14');
INSERT INTO `t_lession` VALUES ('bfa253b528e141e3b08c65c4a1645ff4', '化工工程制图', '暂无描述', null, '2019-01-13 20:57:32');
INSERT INTO `t_lession` VALUES ('c8db9cd0354d4ce7aa58ddbf56bc6921', 'java语言程序设计', '暂无描述', null, '2019-01-13 20:54:40');
INSERT INTO `t_lession` VALUES ('ce8bfbdce55f42d9a9a138b1beeeb888', '诗经', '暂无描述', null, '2019-01-13 20:55:28');
INSERT INTO `t_lession` VALUES ('d79b48bfd9ad470d8aac8cd98044dcd5', '现代市场营销', '暂无描述', null, '2019-01-13 20:57:27');
INSERT INTO `t_lession` VALUES ('e5a63fe284d0479cb4886d8f6a8c2f17', '线性代数', '暂无描述', null, '2019-01-13 20:53:07');
INSERT INTO `t_lession` VALUES ('e656d090399f4f07adb7e688226824ea', 'flash制作原理', '暂无描述', '2019-01-13 23:23:33', '2019-01-13 20:59:22');
INSERT INTO `t_lession` VALUES ('ea4a3c427bed44d08486e5c129413bff', '数据结构', '暂无描述', null, '2019-01-13 20:59:15');
INSERT INTO `t_lession` VALUES ('ef94f8dd31ed408da6ae73d513918f08', '大学生心理健康教育', '暂无描述', null, '2019-01-13 20:56:07');
INSERT INTO `t_lession` VALUES ('f7fa6b0f2490415c93ad321add89bdf5', 'python爬虫实战', '暂无描述', null, '2019-01-13 20:54:59');

-- ----------------------------
-- Table structure for `t_login`
-- ----------------------------
DROP TABLE IF EXISTS `t_login`;
CREATE TABLE `t_login` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) NOT NULL COMMENT '称昵',
  `password` varchar(32) NOT NULL COMMENT '码密',
  `last_login_time` datetime DEFAULT NULL,
  `status` tinyint(1) DEFAULT '1' COMMENT '1有效0禁止登陆',
  `role_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_login
-- ----------------------------
INSERT INTO `t_login` VALUES ('1', '1005', '2c76a9fc355f948f858c26403447bb37', '2019-03-09 20:58:46', '1', '13');
INSERT INTO `t_login` VALUES ('2', '1006', '2c76a9fc355f948f858c26403447bb37', '2019-01-07 13:35:19', '1', '13');
INSERT INTO `t_login` VALUES ('3', '1007', '2c76a9fc355f948f858c26403447bb37', '2019-01-14 18:43:49', '1', '13');
INSERT INTO `t_login` VALUES ('4', '1008', '2c76a9fc355f948f858c26403447bb37', '2019-01-14 18:43:55', '1', '13');
INSERT INTO `t_login` VALUES ('7', '2019000000', '2c76a9fc355f948f858c26403447bb37', '2019-03-09 13:29:21', '1', '14');
INSERT INTO `t_login` VALUES ('8', '2019000002', '2c76a9fc355f948f858c26403447bb37', null, '1', '14');
INSERT INTO `t_login` VALUES ('9', '2019000003', '2c76a9fc355f948f858c26403447bb37', null, '1', '14');
INSERT INTO `t_login` VALUES ('10', '2019000004', '2c76a9fc355f948f858c26403447bb37', '2019-03-01 14:21:02', '1', '14');
INSERT INTO `t_login` VALUES ('11', '2019000005', '2c76a9fc355f948f858c26403447bb37', null, '1', '14');
INSERT INTO `t_login` VALUES ('12', '2019000006', '2c76a9fc355f948f858c26403447bb37', null, '1', '14');
INSERT INTO `t_login` VALUES ('13', '2019000007', '2c76a9fc355f948f858c26403447bb37', null, '1', '14');
INSERT INTO `t_login` VALUES ('14', '2019000008', '2c76a9fc355f948f858c26403447bb37', null, '1', '14');
INSERT INTO `t_login` VALUES ('15', '2019000009', '2c76a9fc355f948f858c26403447bb37', null, '1', '14');
INSERT INTO `t_login` VALUES ('17', '2019000011', '2c76a9fc355f948f858c26403447bb37', null, '1', '14');
INSERT INTO `t_login` VALUES ('18', '2019000012', '2c76a9fc355f948f858c26403447bb37', null, '1', '14');
INSERT INTO `t_login` VALUES ('19', '2019000013', '2c76a9fc355f948f858c26403447bb37', null, '1', '14');
INSERT INTO `t_login` VALUES ('20', '2019000014', '2c76a9fc355f948f858c26403447bb37', null, '1', '14');
INSERT INTO `t_login` VALUES ('21', '2019000015', '2c76a9fc355f948f858c26403447bb37', null, '1', '14');
INSERT INTO `t_login` VALUES ('22', '2019000016', '2c76a9fc355f948f858c26403447bb37', null, '1', '14');
INSERT INTO `t_login` VALUES ('23', '2019000017', '2c76a9fc355f948f858c26403447bb37', null, '1', '14');
INSERT INTO `t_login` VALUES ('24', '2019000018', '2c76a9fc355f948f858c26403447bb37', null, '1', '14');
INSERT INTO `t_login` VALUES ('25', '2019000019', '2c76a9fc355f948f858c26403447bb37', null, '1', '14');
INSERT INTO `t_login` VALUES ('26', '2019000020', '2c76a9fc355f948f858c26403447bb37', null, '1', '14');
INSERT INTO `t_login` VALUES ('30', '2019000024', '2c76a9fc355f948f858c26403447bb37', null, '1', '14');
INSERT INTO `t_login` VALUES ('31', '2019000025', '2c76a9fc355f948f858c26403447bb37', null, '1', '14');
INSERT INTO `t_login` VALUES ('32', '2019000026', '2c76a9fc355f948f858c26403447bb37', null, '1', '14');
INSERT INTO `t_login` VALUES ('33', '2019000027', '2c76a9fc355f948f858c26403447bb37', null, '1', '14');
INSERT INTO `t_login` VALUES ('50', '1000', '2c76a9fc355f948f858c26403447bb37', '2019-03-10 13:10:28', '1', '11');

-- ----------------------------
-- Table structure for `t_major`
-- ----------------------------
DROP TABLE IF EXISTS `t_major`;
CREATE TABLE `t_major` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL COMMENT '业专名称',
  `description` varchar(255) NOT NULL COMMENT '专业描述',
  `faculty_id` int(11) NOT NULL,
  `gmt_create` datetime NOT NULL,
  `gmt_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `faculty_id` (`faculty_id`),
  CONSTRAINT `t_major_ibfk_1` FOREIGN KEY (`faculty_id`) REFERENCES `t_faculty` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_major
-- ----------------------------
INSERT INTO `t_major` VALUES ('1', '软件工程', '软件开发', '7', '2019-01-13 20:23:39', null);
INSERT INTO `t_major` VALUES ('2', '计算机科学与技术', '计算机科学', '7', '2019-01-13 20:24:07', null);
INSERT INTO `t_major` VALUES ('3', '自动化', '自动化机械设备', '7', '2019-01-13 20:24:36', null);
INSERT INTO `t_major` VALUES ('4', '马克思主义', '学习马克思主义', '1', '2019-01-13 20:25:41', null);
INSERT INTO `t_major` VALUES ('5', '幼儿教育', '幼儿教育相关', '2', '2019-01-13 20:26:01', null);
INSERT INTO `t_major` VALUES ('6', '学前教育', '暂无描述', '2', '2019-01-13 20:26:19', null);
INSERT INTO `t_major` VALUES ('7', '历史', '研究历史', '3', '2019-01-13 20:26:48', null);
INSERT INTO `t_major` VALUES ('8', '地理', '人文地理', '3', '2019-01-13 20:27:04', null);
INSERT INTO `t_major` VALUES ('9', '音乐', '唱歌的', '4', '2019-01-13 20:27:24', '2019-01-13 23:20:24');
INSERT INTO `t_major` VALUES ('10', '舞蹈', '跳舞的', '4', '2019-01-13 20:27:42', null);
INSERT INTO `t_major` VALUES ('11', '经济学', '暂无描述', '5', '2019-01-13 20:28:05', null);
INSERT INTO `t_major` VALUES ('12', '土木工程', '暂无描述', '6', '2019-01-13 20:28:29', null);
INSERT INTO `t_major` VALUES ('13', '体育', '暂无描述', '9', '2019-01-13 20:28:53', null);
INSERT INTO `t_major` VALUES ('14', '英语', 'English', '10', '2019-01-13 20:29:11', null);
INSERT INTO `t_major` VALUES ('15', '日语', '日语', '10', '2019-01-13 20:29:24', null);
INSERT INTO `t_major` VALUES ('16', '继续教育', '暂无描述', '11', '2019-01-13 20:29:41', null);
INSERT INTO `t_major` VALUES ('17', '中华文化', '研究中华美德', '13', '2019-01-13 20:30:10', null);
INSERT INTO `t_major` VALUES ('18', '小说', '小说写作', '14', '2019-01-13 20:30:33', null);

-- ----------------------------
-- Table structure for `t_student`
-- ----------------------------
DROP TABLE IF EXISTS `t_student`;
CREATE TABLE `t_student` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(8) NOT NULL,
  `phone` char(11) DEFAULT NULL,
  `sex` tinyint(1) DEFAULT NULL,
  `headshot` varchar(42) DEFAULT NULL,
  `class_id` varchar(32) NOT NULL,
  `gmt_create` datetime NOT NULL,
  `gmt_modified` datetime DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `cls_id` (`class_id`),
  CONSTRAINT `t_student_ibfk_1` FOREIGN KEY (`class_id`) REFERENCES `t_class` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2019000047 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_student
-- ----------------------------
INSERT INTO `t_student` VALUES ('2019000000', '吴贤', '13618567912', '1', null, '4565abfe725e40f6ba371d25b40826a9', '2019-01-15 11:24:42', '2019-03-09 12:29:40', '1439410137@qq.com');
INSERT INTO `t_student` VALUES ('2019000002', '张三', null, '1', null, '4565abfe725e40f6ba371d25b40826a9', '2019-01-15 13:55:35', null, null);
INSERT INTO `t_student` VALUES ('2019000003', '李四', null, '1', null, '4565abfe725e40f6ba371d25b40826a9', '2019-01-15 13:56:11', null, null);
INSERT INTO `t_student` VALUES ('2019000004', '王五', null, '1', null, '95faab6c249c46a58e30e44d95bfa18e', '2019-01-15 13:59:24', null, null);
INSERT INTO `t_student` VALUES ('2019000005', '宋江', null, '1', null, '4565abfe725e40f6ba371d25b40826a9', '2019-01-15 14:12:16', null, null);
INSERT INTO `t_student` VALUES ('2019000006', '吴用', null, '1', null, '4565abfe725e40f6ba371d25b40826a9', '2019-01-15 14:12:59', null, null);
INSERT INTO `t_student` VALUES ('2019000007', '卢俊义', null, '1', null, '4565abfe725e40f6ba371d25b40826a9', '2019-01-15 14:13:08', null, null);
INSERT INTO `t_student` VALUES ('2019000008', '公孙胜', null, '1', null, '4565abfe725e40f6ba371d25b40826a9', '2019-01-15 14:13:13', null, null);
INSERT INTO `t_student` VALUES ('2019000009', '林冲', null, '1', null, '4565abfe725e40f6ba371d25b40826a9', '2019-01-15 14:13:20', null, null);
INSERT INTO `t_student` VALUES ('2019000011', '武松', null, '1', null, '4565abfe725e40f6ba371d25b40826a9', '2019-01-15 14:13:30', null, null);
INSERT INTO `t_student` VALUES ('2019000012', '张清', null, '1', null, '4565abfe725e40f6ba371d25b40826a9', '2019-01-15 14:13:35', null, null);
INSERT INTO `t_student` VALUES ('2019000013', '张顺', null, '1', null, '4565abfe725e40f6ba371d25b40826a9', '2019-01-15 14:13:39', null, null);
INSERT INTO `t_student` VALUES ('2019000014', '阮小五', null, '1', null, '4565abfe725e40f6ba371d25b40826a9', '2019-01-15 14:13:43', null, null);
INSERT INTO `t_student` VALUES ('2019000015', '阮小二', null, '1', null, '4565abfe725e40f6ba371d25b40826a9', '2019-01-15 14:13:48', null, null);
INSERT INTO `t_student` VALUES ('2019000016', '石秀', null, '1', null, '4565abfe725e40f6ba371d25b40826a9', '2019-01-15 14:13:52', null, null);
INSERT INTO `t_student` VALUES ('2019000017', '朱武', null, '1', null, '4565abfe725e40f6ba371d25b40826a9', '2019-01-15 14:13:56', null, null);
INSERT INTO `t_student` VALUES ('2019000018', '鲁智深', null, '1', null, '4565abfe725e40f6ba371d25b40826a9', '2019-01-15 14:14:00', null, null);
INSERT INTO `t_student` VALUES ('2019000019', '陶宗旺', null, '1', null, '4565abfe725e40f6ba371d25b40826a9', '2019-01-15 14:14:05', null, null);
INSERT INTO `t_student` VALUES ('2019000020', '宋万', null, '1', null, '4565abfe725e40f6ba371d25b40826a9', '2019-01-15 14:14:10', null, null);
INSERT INTO `t_student` VALUES ('2019000024', '朱贵', null, '1', null, '4565abfe725e40f6ba371d25b40826a9', '2019-01-15 14:14:30', null, null);
INSERT INTO `t_student` VALUES ('2019000025', '顾大嫂', null, '1', null, '4565abfe725e40f6ba371d25b40826a9', '2019-01-15 14:14:35', null, null);
INSERT INTO `t_student` VALUES ('2019000026', '孙二娘', null, '1', null, '4565abfe725e40f6ba371d25b40826a9', '2019-01-15 14:14:39', null, null);
INSERT INTO `t_student` VALUES ('2019000027', '郁保四', null, '1', null, '4565abfe725e40f6ba371d25b40826a9', '2019-01-15 14:14:42', null, null);

-- ----------------------------
-- Table structure for `t_teacher`
-- ----------------------------
DROP TABLE IF EXISTS `t_teacher`;
CREATE TABLE `t_teacher` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `name` varchar(8) NOT NULL,
  `sex` tinyint(1) NOT NULL,
  `phone` varchar(11) NOT NULL,
  `headshot` varchar(43) DEFAULT NULL,
  `gmt_create` datetime NOT NULL,
  `gmt_modified` datetime DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=1010 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_teacher
-- ----------------------------
INSERT INTO `t_teacher` VALUES ('1005', '孙悟空', '1', '13618567912', null, '2019-01-14 12:44:13', '2019-03-08 17:47:01', null);
INSERT INTO `t_teacher` VALUES ('1006', '唐僧', '1', '13618567912', null, '2019-01-14 13:30:08', null, null);
INSERT INTO `t_teacher` VALUES ('1007', '猪八戒', '1', '13618567912', null, '2019-01-14 13:31:00', null, null);
INSERT INTO `t_teacher` VALUES ('1008', '猪悟净', '1', '13618567912', null, '2019-01-14 13:39:03', null, null);

-- ----------------------------
-- Table structure for `t_teaching_lession`
-- ----------------------------
DROP TABLE IF EXISTS `t_teaching_lession`;
CREATE TABLE `t_teaching_lession` (
  `id` varchar(32) NOT NULL,
  `class_id` varchar(32) NOT NULL COMMENT '级班',
  `lession_id` varchar(32) NOT NULL COMMENT '程课',
  `teacher_id` varchar(64) NOT NULL COMMENT '任课人',
  `status` tinyint(1) DEFAULT '0' COMMENT '课授状态',
  `gmt_create` datetime NOT NULL,
  `gmt_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cls_id` (`class_id`) USING BTREE,
  KEY `lession_id` (`lession_id`) USING BTREE,
  KEY `user_id` (`teacher_id`) USING BTREE,
  CONSTRAINT `teacher_cls_lession_ibfk_1` FOREIGN KEY (`class_id`) REFERENCES `t_class` (`id`),
  CONSTRAINT `teacher_cls_lession_ibfk_2` FOREIGN KEY (`lession_id`) REFERENCES `t_lession` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_teaching_lession
-- ----------------------------
INSERT INTO `t_teaching_lession` VALUES ('1ab84abca2d845c48875b5aafa9bbb19', '4565abfe725e40f6ba371d25b40826a9', '51d6d34c72aa4254b6bf1c957c0047d0', '1005', '1', '2019-01-14 17:38:00', null);
INSERT INTO `t_teaching_lession` VALUES ('39e0e9fb3e4f44bd90b7e79c4e30584e', '89a7e5af5a064f0da119cf3286c9666e', '330417581d1f4644a76321222a85d268', '1006', '1', '2019-01-14 17:49:17', null);
INSERT INTO `t_teaching_lession` VALUES ('412cbd42f3b54bd0bd6772250932ee93', '6502db0718c34198b85fd8dda895ecb9', '9826732c6fd74562b38159b6dc388269', '1006', '1', '2019-01-14 17:54:29', '2019-01-14 18:03:31');
INSERT INTO `t_teaching_lession` VALUES ('5dd751dd5e4e4174bab098fc07d56d1d', '1561aae6321e4d8295b47d7d98c34f14', '68944598e3bc461eaf60a602b0dcc080', '1008', '1', '2019-01-14 17:51:10', null);

-- ----------------------------
-- Table structure for `t_work`
-- ----------------------------
DROP TABLE IF EXISTS `t_work`;
CREATE TABLE `t_work` (
  `id` varchar(32) NOT NULL,
  `name` varchar(64) NOT NULL COMMENT '业作名称',
  `teacher_id` int(4) NOT NULL,
  `acceptance_time` datetime NOT NULL COMMENT '收验时间',
  `demand` text COMMENT '要求',
  `teaching_lession_id` varchar(32) NOT NULL COMMENT '班级任课id',
  `annex` varchar(255) DEFAULT NULL COMMENT '件附',
  `gmt_create` datetime NOT NULL,
  `gmt_modified` datetime DEFAULT NULL,
  `status` int(2) DEFAULT '0' COMMENT '0未完成1间时结束2完成',
  PRIMARY KEY (`id`),
  KEY `t_job_ibfk_1` (`teacher_id`),
  CONSTRAINT `t_work_ibfk_1` FOREIGN KEY (`teacher_id`) REFERENCES `t_teacher` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_work
-- ----------------------------
