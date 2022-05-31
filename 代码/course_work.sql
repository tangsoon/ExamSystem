/*
Navicat MySQL Data Transfer

Source Server         : Mysql
Source Server Version : 50719
Source Host           : localhost:3306
Source Database       : course_work

Target Server Type    : MYSQL
Target Server Version : 50719
File Encoding         : 65001

Date: 2021-05-30 13:05:12
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for course
-- ----------------------------
DROP TABLE IF EXISTS `course`;
CREATE TABLE `course` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) DEFAULT NULL,
  `className` varchar(32) DEFAULT NULL,
  `schoolYear` varchar(9) DEFAULT NULL,
  `semester` tinyint(4) DEFAULT NULL,
  `joinCode` varchar(6) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of course
-- ----------------------------
INSERT INTO `course` VALUES ('11', '大学语文', '大学语文', '2011-2012', '1', '8JYDIS');
INSERT INTO `course` VALUES ('14', '大学英语', '大学英语冲刺班', '2016-2017', '1', 'OU3TU8');
INSERT INTO `course` VALUES ('15', '大学英语', '啦啦啦', '2017-2018', '2', 'aaaaaa');
INSERT INTO `course` VALUES ('16', '张老师语文', '啦啦', '2019-2020', '0', '38D2CD');
INSERT INTO `course` VALUES ('17', '啦啦啦啦', '啦啦啦啦', '2010-2011', '0', 'AMINXL');
INSERT INTO `course` VALUES ('18', '啦啦啦啦', '啦啦啦啦', '', '0', '9FEL8M');

-- ----------------------------
-- Table structure for exam
-- ----------------------------
DROP TABLE IF EXISTS `exam`;
CREATE TABLE `exam` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `exam_paper_id` int(11) DEFAULT NULL,
  `subject_id` int(11) DEFAULT NULL,
  `start_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  `duration` int(11) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `course_id` int(11) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `course_id` (`course_id`),
  KEY `user_id` (`user_id`),
  KEY `exam_paper_id` (`exam_paper_id`),
  KEY `subject_id` (`subject_id`),
  CONSTRAINT `exam_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `course` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `exam_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `exam_ibfk_3` FOREIGN KEY (`exam_paper_id`) REFERENCES `exam_paper` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `exam_ibfk_4` FOREIGN KEY (`subject_id`) REFERENCES `subject` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of exam
-- ----------------------------
INSERT INTO `exam` VALUES ('25', '28', '20', '2021-04-11 07:53:14', '2021-04-11 07:53:14', '50', '测试考试', '16', '123456789');
INSERT INTO `exam` VALUES ('26', '29', '20', '2021-04-15 07:22:36', '2021-04-15 07:22:36', '100', '英语考试', '16', '123456789');
INSERT INTO `exam` VALUES ('28', '30', '20', '2021-05-29 02:33:11', '2021-05-29 02:33:11', '100', '', '16', '123456789');

-- ----------------------------
-- Table structure for exam_paper
-- ----------------------------
DROP TABLE IF EXISTS `exam_paper`;
CREATE TABLE `exam_paper` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `subject_id` int(11) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `userId` (`user_id`),
  CONSTRAINT `exam_paper_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of exam_paper
-- ----------------------------
INSERT INTO `exam_paper` VALUES ('12', '7', '英语试卷一', '1', '1');
INSERT INTO `exam_paper` VALUES ('13', '7', '语文', '1', '0');
INSERT INTO `exam_paper` VALUES ('25', '14', '张老师的测试卷1', '123456789', '1');
INSERT INTO `exam_paper` VALUES ('26', '15', '测试试卷2', '123456789', '1');
INSERT INTO `exam_paper` VALUES ('27', '15', '测试试卷2', '11703080201', '1');
INSERT INTO `exam_paper` VALUES ('28', '20', '英语试卷', '1', '1');
INSERT INTO `exam_paper` VALUES ('29', '20', '英语试卷', '123456789', '1');
INSERT INTO `exam_paper` VALUES ('30', '20', '啊啊啊', '123456789', '1');

-- ----------------------------
-- Table structure for exam_paper_question_map
-- ----------------------------
DROP TABLE IF EXISTS `exam_paper_question_map`;
CREATE TABLE `exam_paper_question_map` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `exam_paper_id` int(11) DEFAULT NULL,
  `question_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `exam_paper_question_map_ibfk_1` (`question_id`),
  KEY `exam_paper_id` (`exam_paper_id`),
  CONSTRAINT `exam_paper_question_map_ibfk_1` FOREIGN KEY (`question_id`) REFERENCES `question` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `exam_paper_question_map_ibfk_2` FOREIGN KEY (`exam_paper_id`) REFERENCES `exam_paper` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of exam_paper_question_map
-- ----------------------------
INSERT INTO `exam_paper_question_map` VALUES ('22', '12', '20');
INSERT INTO `exam_paper_question_map` VALUES ('23', '12', '21');
INSERT INTO `exam_paper_question_map` VALUES ('24', '12', '22');
INSERT INTO `exam_paper_question_map` VALUES ('25', '12', '23');
INSERT INTO `exam_paper_question_map` VALUES ('26', '12', '24');
INSERT INTO `exam_paper_question_map` VALUES ('27', '12', '25');
INSERT INTO `exam_paper_question_map` VALUES ('28', '12', '27');
INSERT INTO `exam_paper_question_map` VALUES ('30', '13', '20');
INSERT INTO `exam_paper_question_map` VALUES ('31', '13', '21');
INSERT INTO `exam_paper_question_map` VALUES ('32', '13', '22');
INSERT INTO `exam_paper_question_map` VALUES ('33', '13', '23');
INSERT INTO `exam_paper_question_map` VALUES ('34', '13', '24');
INSERT INTO `exam_paper_question_map` VALUES ('56', '25', '29');
INSERT INTO `exam_paper_question_map` VALUES ('57', '25', '30');
INSERT INTO `exam_paper_question_map` VALUES ('58', '25', '31');
INSERT INTO `exam_paper_question_map` VALUES ('59', '25', '32');
INSERT INTO `exam_paper_question_map` VALUES ('60', '25', '33');
INSERT INTO `exam_paper_question_map` VALUES ('61', '25', '34');
INSERT INTO `exam_paper_question_map` VALUES ('62', '25', '35');
INSERT INTO `exam_paper_question_map` VALUES ('63', '26', '36');
INSERT INTO `exam_paper_question_map` VALUES ('64', '26', '37');
INSERT INTO `exam_paper_question_map` VALUES ('65', '28', '38');
INSERT INTO `exam_paper_question_map` VALUES ('66', '29', '39');
INSERT INTO `exam_paper_question_map` VALUES ('67', '30', '39');

-- ----------------------------
-- Table structure for explore_work
-- ----------------------------
DROP TABLE IF EXISTS `explore_work`;
CREATE TABLE `explore_work` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) DEFAULT NULL,
  `content` varchar(255) DEFAULT NULL,
  `endTime` timestamp NULL DEFAULT NULL,
  `fullScore` int(11) DEFAULT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `courseId` int(11) DEFAULT NULL,
  `exploreTime` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `work_ibfk_1` (`userId`),
  KEY `work_ibfk_2` (`courseId`),
  CONSTRAINT `explore_work_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `explore_work_ibfk_2` FOREIGN KEY (`courseId`) REFERENCES `course` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of explore_work
-- ----------------------------
INSERT INTO `explore_work` VALUES ('38', 'aa', 'a', '2019-12-30 16:00:00', '100', '11703080299', '14', '2019-12-28 11:29:47');
INSERT INTO `explore_work` VALUES ('39', '语文周末作业', '完成课堂内外第三页', '2021-03-26 04:13:29', '100', '123456789', '16', '2021-03-26 04:13:37');
INSERT INTO `explore_work` VALUES ('40', '语文作业', '啊啊啊啊', '2021-03-16 16:00:00', '90', '123456789', '16', '2021-03-31 15:25:42');
INSERT INTO `explore_work` VALUES ('41', '阿斯蒂芬', '阿萨德', '2021-05-29 02:38:10', '100', '123456789', '16', '2021-05-29 02:38:14');

-- ----------------------------
-- Table structure for explore_work_file
-- ----------------------------
DROP TABLE IF EXISTS `explore_work_file`;
CREATE TABLE `explore_work_file` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `exploreWorkId` int(11) DEFAULT NULL,
  `workFileId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `explore_work_file_ibfk_1` (`exploreWorkId`),
  KEY `explore_work_file_ibfk_2` (`workFileId`),
  CONSTRAINT `explore_work_file_ibfk_1` FOREIGN KEY (`exploreWorkId`) REFERENCES `explore_work` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `explore_work_file_ibfk_2` FOREIGN KEY (`workFileId`) REFERENCES `work_file` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of explore_work_file
-- ----------------------------
INSERT INTO `explore_work_file` VALUES ('1', '39', '2');
INSERT INTO `explore_work_file` VALUES ('2', '39', '4');

-- ----------------------------
-- Table structure for notice
-- ----------------------------
DROP TABLE IF EXISTS `notice`;
CREATE TABLE `notice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` tinyint(4) DEFAULT NULL,
  `times` int(11) DEFAULT NULL,
  `isTop` bit(1) DEFAULT NULL,
  `date` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `content` varchar(255) DEFAULT NULL,
  `userFromId` bigint(20) DEFAULT NULL,
  `userToId` bigint(20) DEFAULT NULL,
  `workId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `notice_ibfk_1` (`userFromId`),
  KEY `userToId` (`userToId`),
  KEY `workId` (`workId`),
  CONSTRAINT `notice_ibfk_1` FOREIGN KEY (`userFromId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `notice_ibfk_2` FOREIGN KEY (`userToId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `notice_ibfk_3` FOREIGN KEY (`workId`) REFERENCES `explore_work` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of notice
-- ----------------------------

-- ----------------------------
-- Table structure for question
-- ----------------------------
DROP TABLE IF EXISTS `question`;
CREATE TABLE `question` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `subject_id` int(11) DEFAULT NULL,
  `type` varchar(11) DEFAULT NULL,
  `score` float DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL COMMENT '题干',
  `status` int(255) DEFAULT NULL COMMENT '0私有，1共有',
  `content_id` int(11) DEFAULT NULL COMMENT '问题的内容，用json表示',
  `userId` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`),
  KEY `subject_id` (`subject_id`),
  CONSTRAINT `question_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `question_ibfk_2` FOREIGN KEY (`subject_id`) REFERENCES `subject` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of question
-- ----------------------------
INSERT INTO `question` VALUES ('20', null, '简答题', '10', '你对王者荣耀有什么看法？', '0', '11', '1');
INSERT INTO `question` VALUES ('21', null, '判断题', '10', '王者荣耀最厉害的英雄是典韦', '0', '12', '1');
INSERT INTO `question` VALUES ('22', null, '多选题', '10', '以下哪些是王者荣耀的英雄？', '0', '13', '1');
INSERT INTO `question` VALUES ('23', null, '简答题', '10', '你对王者荣耀有什么看法？', '0', '14', '1');
INSERT INTO `question` VALUES ('24', null, '简答题', '10', '你对王者荣耀有什么看法', '0', '15', '1');
INSERT INTO `question` VALUES ('25', null, '单选题', '100', '以下哪个英雄是射手', '0', '23', '1');
INSERT INTO `question` VALUES ('26', null, '单选题', '10', '下列说法正确的是？', '0', '25', '1');
INSERT INTO `question` VALUES ('27', null, '多选题', '10', '这是多选题', '0', '26', '1');
INSERT INTO `question` VALUES ('28', null, '判断题', '10', '下列说法正确吗？', '0', '27', '1');
INSERT INTO `question` VALUES ('29', null, '单选题', '50', '这是张老师的测试题', '0', '33', '123456789');
INSERT INTO `question` VALUES ('30', null, '多选题', '50', '张老师的测试多选题', '0', '34', '123456789');
INSERT INTO `question` VALUES ('31', null, '判断题', '100', '张老师的测试判断题', '0', '35', '123456789');
INSERT INTO `question` VALUES ('32', null, '填空题', '50', '三国演义中（）最厉害。', '0', '36', '123456789');
INSERT INTO `question` VALUES ('33', null, '简答题', '50', '请问这是测试题吗？', '0', '37', '123456789');
INSERT INTO `question` VALUES ('34', null, '简答题', '10', '请问哪个国家最强', '1', '38', '123456789');
INSERT INTO `question` VALUES ('35', null, '多选题', '100', '啦啦啦', '0', '48', '123456789');
INSERT INTO `question` VALUES ('36', null, '单选题', '10', '1+1=？', '0', '59', '123456789');
INSERT INTO `question` VALUES ('37', null, '简答题', '10', '2+2=？', '0', '60', '123456789');
INSERT INTO `question` VALUES ('38', '20', '简答题', '100', 'Are you ok?', '0', '63', '1');
INSERT INTO `question` VALUES ('39', '20', '判断题', '100', '这是英语题。', '0', '66', '123456789');

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) DEFAULT NULL,
  `nameZh` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES ('1', 'ROLE_teacher', '教师');
INSERT INTO `role` VALUES ('2', 'ROLE_student', '学生');
INSERT INTO `role` VALUES ('3', 'ROLE_admin', '管理员');

-- ----------------------------
-- Table structure for subject
-- ----------------------------
DROP TABLE IF EXISTS `subject`;
CREATE TABLE `subject` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `userId` bigint(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `subject_ibfk_1` (`userId`),
  CONSTRAINT `subject_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of subject
-- ----------------------------
INSERT INTO `subject` VALUES ('20', '英语', '1');
INSERT INTO `subject` VALUES ('21', 'C语言', '1');

-- ----------------------------
-- Table structure for submit_work
-- ----------------------------
DROP TABLE IF EXISTS `submit_work`;
CREATE TABLE `submit_work` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` bigint(20) DEFAULT NULL,
  `score` varchar(255) DEFAULT NULL,
  `exploreWorkId` int(11) DEFAULT NULL,
  `submitTime` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`),
  KEY `exploreWorkId` (`exploreWorkId`),
  CONSTRAINT `submit_work_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `submit_work_ibfk_2` FOREIGN KEY (`exploreWorkId`) REFERENCES `explore_work` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of submit_work
-- ----------------------------
INSERT INTO `submit_work` VALUES ('13', '11703080201', null, '38', null);
INSERT INTO `submit_work` VALUES ('14', '11703080201', null, '39', null);
INSERT INTO `submit_work` VALUES ('15', '11703080221', null, '39', null);
INSERT INTO `submit_work` VALUES ('16', '123456789', null, '39', null);
INSERT INTO `submit_work` VALUES ('17', '11703080201', null, '40', null);
INSERT INTO `submit_work` VALUES ('18', '11703080221', null, '40', null);
INSERT INTO `submit_work` VALUES ('19', '11703080201', null, '41', null);
INSERT INTO `submit_work` VALUES ('20', '11703080221', null, '41', null);

-- ----------------------------
-- Table structure for submit_work_file
-- ----------------------------
DROP TABLE IF EXISTS `submit_work_file`;
CREATE TABLE `submit_work_file` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `submitWorkId` int(11) DEFAULT NULL,
  `workFileId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `submitWorkId` (`submitWorkId`),
  KEY `submit_work_file_ibfk_2` (`workFileId`),
  CONSTRAINT `submit_work_file_ibfk_1` FOREIGN KEY (`submitWorkId`) REFERENCES `submit_work` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `submit_work_file_ibfk_2` FOREIGN KEY (`workFileId`) REFERENCES `work_file` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of submit_work_file
-- ----------------------------
INSERT INTO `submit_work_file` VALUES ('1', '14', '3');

-- ----------------------------
-- Table structure for text
-- ----------------------------
DROP TABLE IF EXISTS `text`;
CREATE TABLE `text` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of text
-- ----------------------------
INSERT INTO `text` VALUES ('4', '{\"options\":[{\"index\":\"0\",\"content\":\"fuck me.\"},{\"index\":\"1\",\"content\":\"help me.\"},{\"index\":\"2\",\"content\":\"get away.\"},{\"index\":\"3\",\"content\":\"good bye\"}],\"questionStem\":\"What can I do for you?\",\"answer\":\"help me.\"}');
INSERT INTO `text` VALUES ('11', '{\"options\":[{\"index\":\"0\",\"content\":\"\"},{\"index\":\"1\",\"content\":\"\"},{\"index\":\"2\",\"content\":\"\"},{\"index\":\"3\",\"content\":\"\"}],\"questionStem\":\"你对王者荣耀有什么看法？\",\"answer\":\"很垃圾的垃圾游戏\"}');
INSERT INTO `text` VALUES ('12', '{\"questionStem\":\"王者荣耀最厉害的英雄是典韦\",\"answer\":\"对\"}');
INSERT INTO `text` VALUES ('13', '{\"options\":[\"李白\",\"花木兰\",\"杜甫\"],\"answers\":[\"李白\",\"花木兰\"],\"questionStem\":\"以下哪些是王者荣耀的英雄？\"}');
INSERT INTO `text` VALUES ('14', '{\"options\":[{\"index\":\"0\",\"content\":\"\"},{\"index\":\"1\",\"content\":\"\"},{\"index\":\"2\",\"content\":\"\"},{\"index\":\"3\",\"content\":\"\"}],\"questionStem\":\"你对王者荣耀有什么看法？\",\"answer\":\"没看法\"}');
INSERT INTO `text` VALUES ('15', '{\"options\":[{\"index\":\"0\",\"content\":\"\"},{\"index\":\"1\",\"content\":\"\"},{\"index\":\"2\",\"content\":\"\"},{\"index\":\"3\",\"content\":\"\"}],\"questionStem\":\"你对王者荣耀有什么看法\",\"answer\":\"没看法\"}');
INSERT INTO `text` VALUES ('23', '{\"options\":[{\"index\":\"0\",\"content\":\"李白\"},{\"index\":\"1\",\"content\":\"典韦\"},{\"index\":\"2\",\"content\":\"鲁班\"},{\"index\":\"3\",\"content\":\"大乔\"}],\"questionStem\":\"以下哪个英雄是射手\",\"answer\":\"鲁班\"}');
INSERT INTO `text` VALUES ('25', '{\"options\":[{\"index\":\"0\",\"content\":\"啦啦啦\"},{\"index\":\"1\",\"content\":\"bb\"},{\"index\":\"2\",\"content\":\"dd\"},{\"index\":\"3\",\"content\":\"这是正确答案\"}],\"questionStem\":\"下列说法正确的是？\",\"answer\":\"这是正确答案\"}');
INSERT INTO `text` VALUES ('26', '{\"options\":[\"答案1\",\"答案2\",\"答案3\",\"答案4\"],\"answers\":[\"答案1\",\"答案2\"],\"questionStem\":\"这是多选题\"}');
INSERT INTO `text` VALUES ('27', '{\"questionStem\":\"下列说法正确吗？\",\"answer\":\"对\"}');
INSERT INTO `text` VALUES ('33', '{\"options\":[{\"index\":\"0\",\"content\":\"A选项\"},{\"index\":\"1\",\"content\":\"B选项\"},{\"index\":\"2\",\"content\":\"C选项\"},{\"index\":\"3\",\"content\":\"D选项\"}],\"questionStem\":\"这是张老师的测试题\",\"answer\":\"D选项\"}');
INSERT INTO `text` VALUES ('34', '{\"options\":[\"第一个选项\",\"2\",\"3\"],\"answers\":[\"第一个选项\",\"2\"],\"questionStem\":\"张老师的测试多选题\"}');
INSERT INTO `text` VALUES ('35', '{\"questionStem\":\"张老师的测试判断题\",\"answer\":\"对\"}');
INSERT INTO `text` VALUES ('36', '{\"questionStem\":\"三国演义中（）最厉害。\",\"answers\":[\"吕布\"]}');
INSERT INTO `text` VALUES ('37', '{\"options\":[{\"index\":\"0\",\"content\":\"\"},{\"index\":\"1\",\"content\":\"\"},{\"index\":\"2\",\"content\":\"\"},{\"index\":\"3\",\"content\":\"\"}],\"questionStem\":\"请问这是测试题吗？\",\"answer\":\"是的。\"}');
INSERT INTO `text` VALUES ('38', '{\"options\":[{\"index\":\"0\",\"content\":\"\"},{\"index\":\"1\",\"content\":\"\"},{\"index\":\"2\",\"content\":\"\"},{\"index\":\"3\",\"content\":\"\"}],\"questionStem\":\"请问哪个国家最强\",\"answer\":\"中国\"}');
INSERT INTO `text` VALUES ('48', '{\"options\":[\"aaa\",\"aaaaa\"],\"answers\":[\"aaa\",\"aaaaa\"],\"questionStem\":\"啦啦啦\"}');
INSERT INTO `text` VALUES ('57', '[{\"questionId\":29,\"type\":\"单选题\",\"content\":\"A选项\"},{\"questionId\":30,\"type\":\"多选题\",\"content\":[\"2\"]},{\"questionId\":31,\"type\":\"判断题\",\"content\":\"对\"},{\"questionId\":32,\"type\":\"填空题\",\"content\":[\"关羽\"]},{\"questionId\":33,\"type\":\"简答题\",\"content\":\"是\"},{\"questionId\":34,\"type\":\"简答题\",\"content\":\"中国\"},{\"questionId\":35,\"type\":\"多选题\",\"content\":[\"aaa\",\"aaaaa\"]}]');
INSERT INTO `text` VALUES ('58', null);
INSERT INTO `text` VALUES ('59', '{\"options\":[{\"index\":\"0\",\"content\":\"1\"},{\"index\":\"1\",\"content\":\"2\"},{\"index\":\"2\",\"content\":\"3\"},{\"index\":\"3\",\"content\":\"4\"}],\"questionStem\":\"1+1=？\",\"answer\":\"2\"}');
INSERT INTO `text` VALUES ('60', '{\"options\":[{\"index\":\"0\",\"content\":\"\"},{\"index\":\"1\",\"content\":\"\"},{\"index\":\"2\",\"content\":\"\"},{\"index\":\"3\",\"content\":\"\"}],\"questionStem\":\"2+2=？\",\"answer\":\"4\"}');
INSERT INTO `text` VALUES ('61', '[{\"questionId\":36,\"type\":\"单选题\",\"content\":\"2\"},{\"questionId\":37,\"type\":\"简答题\",\"content\":\"4\"}]');
INSERT INTO `text` VALUES ('62', null);
INSERT INTO `text` VALUES ('63', '{\"options\":[{\"index\":\"0\",\"content\":\"\"},{\"index\":\"1\",\"content\":\"\"},{\"index\":\"2\",\"content\":\"\"},{\"index\":\"3\",\"content\":\"\"}],\"questionStem\":\"Are you ok?\",\"answer\":\"yes\"}');
INSERT INTO `text` VALUES ('64', null);
INSERT INTO `text` VALUES ('65', null);
INSERT INTO `text` VALUES ('66', '{\"questionStem\":\"这是英语题。\",\"answer\":\"对\"}');
INSERT INTO `text` VALUES ('67', '[{\"questionId\":39,\"type\":\"判断题\",\"content\":\"对\"}]');
INSERT INTO `text` VALUES ('68', null);
INSERT INTO `text` VALUES ('69', '[{\"questionId\":39,\"type\":\"判断题\",\"content\":\"对\"}]');
INSERT INTO `text` VALUES ('70', null);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  `locked` tinyint(1) DEFAULT NULL,
  `real_name` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `sex` varchar(255) DEFAULT NULL,
  `addr` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`,`name`),
  KEY `id` (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=12345678914 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', 'admin', '$2a$10$H07D070HgEgArHeRIWqhGOEqfxE9pPLFPIxkux6WonKrChDzR0dnq', '1', '0', '糖糖', '13456789777', '20', '男', null);
INSERT INTO `user` VALUES ('123456789', '张老师', '$2a$10$GNiOPg954PVs5Ls91Z6StODIc9q6cmepCIoSOd7uEuGBkLSWu.KOO', '1', '0', '张三', '18523183538', '20', '男', null);
INSERT INTO `user` VALUES ('456454222', 'adsaf', '$2a$10$38dIc/1A18lY9fuuDtzPSuuwLg2W7uWeCaBJAe0yRMzESm8UqtgzC', '0', '0', '李思思', '12345644444', '20', '男', null);
INSERT INTO `user` VALUES ('11111111113', '啦啦啦', '$2a$10$e7EvCxEnsmiRqP1MIfEaauyfUwAh/xxexvPBFoTZwuQJWzkaBmzN.', '1', '0', '啦啦啦', '12345644444', '13', '男', null);
INSERT INTO `user` VALUES ('11111222223', '学生4', '$2a$10$CctdrsQmQyGgG2xMAQ5kfOScVj6aDJw1V4s0H11qEYrEOKhuiBzGy', '1', '0', '学生4', '12346544444', '54', '男', '背景');
INSERT INTO `user` VALUES ('11111222225', '学生5', '$2a$10$FtbLoVxFYdO9caS8OQmJTO4mbABzxsIuvNW86tX/lE5kIzlLkAJR2', '1', '0', '学生5', '11111111111', '21', '男', 'GV闹剧才能');
INSERT INTO `user` VALUES ('11703080201', '张三', '$2a$10$6G35NQ1UNGNhiwzOHOUtx.PgVBJjGPmQZKwokZgfKq2lZOz3QmgPe', '1', '0', '张三', '12345678977', '20', '男', null);
INSERT INTO `user` VALUES ('11703080206', '小明同学', '$2a$10$6G35NQ1UNGNhiwzOHOUtx.PgVBJjGPmQZKwokZgfKq2lZOz3QmgPe', '1', '0', '小明', '12345678977', '21', '男', null);
INSERT INTO `user` VALUES ('11703080207', '王老师', '$2a$10$6G35NQ1UNGNhiwzOHOUtx.PgVBJjGPmQZKwokZgfKq2lZOz3QmgPe', '1', '0', '王老师', '12345678977', '22', '男', null);
INSERT INTO `user` VALUES ('11703080221', '李四', '$2a$10$N84LnYxQ4zO4.xoJcijlt.WTicVZgX60.o3rv5m.ZhBFEAnVPW6Ky', '1', '0', '李四', '18523183538', '21', '男', null);
INSERT INTO `user` VALUES ('11703080294', '小明', '$2a$10$6G35NQ1UNGNhiwzOHOUtx.PgVBJjGPmQZKwokZgfKq2lZOz3QmgPe', '0', '0', '王明', '12345664444', '20', '女', null);
INSERT INTO `user` VALUES ('11703080298', '唐老师', '$2a$10$6G35NQ1UNGNhiwzOHOUtx.PgVBJjGPmQZKwokZgfKq2lZOz3QmgPe', '0', '0', '唐老师', '12345644444', '20', '男', null);
INSERT INTO `user` VALUES ('11703080299', '刘老师', '$2a$10$6G35NQ1UNGNhiwzOHOUtx.PgVBJjGPmQZKwokZgfKq2lZOz3QmgPe', '0', '0', '刘老师', '12346577777', '20', '男', null);
INSERT INTO `user` VALUES ('11703080308', '张飞', '$2a$10$6G35NQ1UNGNhiwzOHOUtx.PgVBJjGPmQZKwokZgfKq2lZOz3QmgPe', '0', '0', '张飞', '12345678911', '20', '男', null);
INSERT INTO `user` VALUES ('11703080309', '赵云', '$2a$10$w3sAoRNrIc7CRzDT/OwZF..D81wq2F8uxNtKYHKKINGGcrtfEvxqK', '1', '0', '赵云', '12345678911', '20', '男', null);
INSERT INTO `user` VALUES ('11703080310', '曹操', '$2a$10$6G35NQ1UNGNhiwzOHOUtx.PgVBJjGPmQZKwokZgfKq2lZOz3QmgPe', '0', '0', '曹操', '12345679812', '20', '男', null);
INSERT INTO `user` VALUES ('11703080311', '郭奉孝', '$2a$10$rzFnipP16cPI0rMsx2aFC.eDKyljP7R30V6lDJpXY2t539D3Wyu9m', '1', '0', '郭奉孝', '18523183538', '23', '男', null);
INSERT INTO `user` VALUES ('11703080312', '', '$2a$10$qep9JoXuPMSvEhuYW1Y8HOGYN1TMJM39Ydhh4FqtcID/gHn0hha2u', '1', '0', '', '', '0', '', null);
INSERT INTO `user` VALUES ('11703080313', '', '$2a$10$u6g.FIokRqpTt5MGcFROr.1bwAEd3nm/l2Hp5i55jc7f1qKr1qX4K', '1', '0', '', '', '0', '', null);
INSERT INTO `user` VALUES ('12345678913', '学生3', '$2a$10$PdTP77vo1xpUDKDO86jbj.CflWvXmsk4Hm8olIqpZf0k7H.9jblKK', '1', '0', '学生3', '12345678977', '12', '男', null);

-- ----------------------------
-- Table structure for user_answer
-- ----------------------------
DROP TABLE IF EXISTS `user_answer`;
CREATE TABLE `user_answer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(11) DEFAULT NULL,
  `text_id` int(11) DEFAULT NULL,
  `exam_paper_id` int(11) DEFAULT NULL,
  `subject_id` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT NULL COMMENT '0为未提交，进入考试，1为已经提交，等待批阅，2为被打回，进入考试,3为已经批改，查看结果',
  `exam_id` int(11) DEFAULT NULL,
  `score` float(255,0) DEFAULT NULL,
  `course_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `exam_paper_id` (`exam_paper_id`),
  KEY `exam_id` (`exam_id`),
  KEY `course_id` (`course_id`),
  CONSTRAINT `user_answer_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user_answer_ibfk_2` FOREIGN KEY (`exam_paper_id`) REFERENCES `exam_paper` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user_answer_ibfk_3` FOREIGN KEY (`exam_id`) REFERENCES `exam` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user_answer_ibfk_4` FOREIGN KEY (`course_id`) REFERENCES `course` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_answer
-- ----------------------------
INSERT INTO `user_answer` VALUES ('21', '11703080201', '64', '28', '20', '0', '25', '0', '16');
INSERT INTO `user_answer` VALUES ('22', '11703080221', '65', '28', '20', '0', '25', '0', '16');
INSERT INTO `user_answer` VALUES ('23', '11703080201', '67', '29', '20', '3', '26', '100', '16');
INSERT INTO `user_answer` VALUES ('24', '11703080221', '68', '29', '20', '0', '26', '0', '16');
INSERT INTO `user_answer` VALUES ('25', '11703080201', '69', '30', '20', '1', '28', '100', '16');
INSERT INTO `user_answer` VALUES ('26', '11703080221', '70', '30', '20', '0', '28', '0', '16');

-- ----------------------------
-- Table structure for user_course
-- ----------------------------
DROP TABLE IF EXISTS `user_course`;
CREATE TABLE `user_course` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `index` int(11) DEFAULT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `courseId` int(20) DEFAULT NULL,
  `userType` tinyint(4) DEFAULT NULL COMMENT '2是教师，0是学生，1是助教，3是管理员',
  `state` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_course_ibfk_1` (`userId`),
  KEY `a` (`courseId`),
  CONSTRAINT `a` FOREIGN KEY (`courseId`) REFERENCES `course` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user_course_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8 COMMENT='0为学生 1为助教 2为教师';

-- ----------------------------
-- Records of user_course
-- ----------------------------
INSERT INTO `user_course` VALUES ('27', '2', '11703080299', '11', '0', '0');
INSERT INTO `user_course` VALUES ('29', '3', '11703080299', '14', '2', '0');
INSERT INTO `user_course` VALUES ('31', '2', '11703080201', '14', '0', '0');
INSERT INTO `user_course` VALUES ('32', '1', '123456789', '16', '2', '0');
INSERT INTO `user_course` VALUES ('33', '3', '11703080201', '16', '0', '0');
INSERT INTO `user_course` VALUES ('34', '1', '11703080221', '16', '0', '0');
INSERT INTO `user_course` VALUES ('35', '2', '123456789', '17', '2', '0');
INSERT INTO `user_course` VALUES ('36', '3', '123456789', '18', '2', '0');

-- ----------------------------
-- Table structure for user_log
-- ----------------------------
DROP TABLE IF EXISTS `user_log`;
CREATE TABLE `user_log` (
  `user_name` varchar(20) DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  `operation` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_log
-- ----------------------------
INSERT INTO `user_log` VALUES ('1', '2021-04-03 16:15:37', '添加了课堂啦啦啦啦');
INSERT INTO `user_log` VALUES ('admin', '2021-04-04 05:04:55', '添加了科目\"汉语\"');
INSERT INTO `user_log` VALUES ('lalalal', null, 'aaaaaa');
INSERT INTO `user_log` VALUES ('admin', '2021-04-04 05:22:52', '删除了科目\"8\"');
INSERT INTO `user_log` VALUES ('admin', '2021-04-04 05:22:53', '删除了科目\"7\"');
INSERT INTO `user_log` VALUES ('admin', '2021-04-04 05:23:34', '添加了科目\"英语\"');
INSERT INTO `user_log` VALUES ('admin', '2021-04-04 05:24:42', '添加了题目\"Are you ok?\"');
INSERT INTO `user_log` VALUES ('admin', '2021-04-04 05:25:51', '添加了题目\"Today () a good day.\"');
INSERT INTO `user_log` VALUES ('admin', '2021-04-04 05:26:27', '删除了题目\"39\"');
INSERT INTO `user_log` VALUES ('admin', '2021-04-04 05:27:41', '添加了试卷\"英语试卷\"');
INSERT INTO `user_log` VALUES ('张老师', '2021-04-11 07:53:31', '添加了考试\"测试考试\"');
INSERT INTO `user_log` VALUES ('张老师', '2021-04-15 07:22:12', '添加了题目\"这是英语题。\"');
INSERT INTO `user_log` VALUES ('张老师', '2021-04-15 07:22:26', '添加了试卷\"英语试卷\"');
INSERT INTO `user_log` VALUES ('张老师', '2021-04-15 07:22:55', '添加了考试\"英语考试\"');
INSERT INTO `user_log` VALUES ('admin', '2021-05-17 02:55:50', '添加了科目\"C语言\"');
INSERT INTO `user_log` VALUES ('张老师', '2021-05-29 02:33:09', '添加了试卷\"啊啊啊\"');
INSERT INTO `user_log` VALUES ('张老师', '2021-05-29 02:33:24', '添加了考试\"\"');

-- ----------------------------
-- Table structure for user_role
-- ----------------------------
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `userId` bigint(20) DEFAULT NULL,
  `roleId` int(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `roleId` (`roleId`),
  KEY `userId` (`userId`),
  CONSTRAINT `roleId` FOREIGN KEY (`roleId`) REFERENCES `role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `userId` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_role
-- ----------------------------
INSERT INTO `user_role` VALUES ('13', '11703080201', '2');
INSERT INTO `user_role` VALUES ('16', '1', '3');
INSERT INTO `user_role` VALUES ('22', '11703080299', '1');
INSERT INTO `user_role` VALUES ('23', '11703080298', '1');
INSERT INTO `user_role` VALUES ('24', '11703080294', '1');
INSERT INTO `user_role` VALUES ('27', '11703080308', '2');
INSERT INTO `user_role` VALUES ('28', '11703080309', '2');
INSERT INTO `user_role` VALUES ('29', '11703080310', '2');
INSERT INTO `user_role` VALUES ('30', '11703080311', '2');
INSERT INTO `user_role` VALUES ('31', '456454222', '2');
INSERT INTO `user_role` VALUES ('32', '123456789', '1');
INSERT INTO `user_role` VALUES ('33', '11703080221', '2');
INSERT INTO `user_role` VALUES ('34', '11111111113', '1');
INSERT INTO `user_role` VALUES ('35', '12345678913', '2');
INSERT INTO `user_role` VALUES ('36', '11111222223', '2');
INSERT INTO `user_role` VALUES ('37', '11111222225', '2');

-- ----------------------------
-- Table structure for work_file
-- ----------------------------
DROP TABLE IF EXISTS `work_file`;
CREATE TABLE `work_file` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) DEFAULT NULL,
  `path` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of work_file
-- ----------------------------
INSERT INTO `work_file` VALUES ('1', 'java大作业设计文档.docx', '1577699961678.docx');
INSERT INTO `work_file` VALUES ('2', '毕业设计（论文）任务书+唐顺-彭滔.doc', '1617204359981.doc');
INSERT INTO `work_file` VALUES ('3', '毕业设计（论文）文献综述.docx', '1617204755599.docx');
INSERT INTO `work_file` VALUES ('4', '13毕业设计（论文）成绩评定书 - 副本.doc', '1622256003490.doc');
