/*
 Navicat MySQL Data Transfer

 Source Server         : Django
 Source Server Type    : MySQL
 Source Server Version : 50721
 Source Host           : localhost:3306
 Source Schema         : django

 Target Server Type    : MySQL
 Target Server Version : 50721
 File Encoding         : 65001

 Date: 21/04/2018 09:49:32
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for auth_group
-- ----------------------------
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for auth_group_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_group_permissions_group_id_permission_id_0cd325b0_uniq`(`group_id`, `permission_id`) USING BTREE,
  INDEX `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm`(`permission_id`) USING BTREE,
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 46 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for auth_permission
-- ----------------------------
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_permission_content_type_id_codename_01ab375a_uniq`(`content_type_id`, `codename`) USING BTREE,
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 58 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for auth_user
-- ----------------------------
DROP TABLE IF EXISTS `auth_user`;
CREATE TABLE `auth_user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `last_login` datetime(6) NULL DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `first_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `last_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `email` varchar(254) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for auth_user_groups
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_groups`;
CREATE TABLE `auth_user_groups`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_user_groups_user_id_group_id_94350c0c_uniq`(`user_id`, `group_id`) USING BTREE,
  INDEX `auth_user_groups_group_id_97559544_fk_auth_group_id`(`group_id`) USING BTREE,
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for auth_user_user_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_user_permissions`;
CREATE TABLE `auth_user_user_permissions`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq`(`user_id`, `permission_id`) USING BTREE,
  INDEX `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm`(`permission_id`) USING BTREE,
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for authtoken_token
-- ----------------------------
DROP TABLE IF EXISTS `authtoken_token`;
CREATE TABLE `authtoken_token`  (
  `key` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `created` datetime(6) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`key`) USING BTREE,
  UNIQUE INDEX `user_id`(`user_id`) USING BTREE,
  CONSTRAINT `authtoken_token_user_id_35299eff_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for bearing_cpuinfo
-- ----------------------------
DROP TABLE IF EXISTS `bearing_cpuinfo`;
CREATE TABLE `bearing_cpuinfo`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `value` double NOT NULL,
  `time` datetime(6) NOT NULL,
  `machine_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `bearing_cpuinfo_machine_id_83e8671c_fk_bearing_machine_machineID`(`machine_id`) USING BTREE,
  CONSTRAINT `bearing_cpuinfo_machine_id_83e8671c_fk_bearing_machine_machineID` FOREIGN KEY (`machine_id`) REFERENCES `bearing_machine` (`machineID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 452 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for bearing_factory
-- ----------------------------
DROP TABLE IF EXISTS `bearing_factory`;
CREATE TABLE `bearing_factory`  (
  `factorID` int(11) NOT NULL AUTO_INCREMENT,
  `factorDes` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `location` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `areaCode` varchar(6) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `personInCharge` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `phoneNumber` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `otherInfo` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `saveDate` datetime(6) NOT NULL,
  `modDate` datetime(6) NOT NULL,
  PRIMARY KEY (`factorID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1007 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for bearing_ioinfo
-- ----------------------------
DROP TABLE IF EXISTS `bearing_ioinfo`;
CREATE TABLE `bearing_ioinfo`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `value` double NOT NULL,
  `time` datetime(6) NOT NULL,
  `machine_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `bearing_ioinfo_machine_id_22f2bbf9_fk_bearing_machine_machineID`(`machine_id`) USING BTREE,
  CONSTRAINT `bearing_ioinfo_machine_id_22f2bbf9_fk_bearing_machine_machineID` FOREIGN KEY (`machine_id`) REFERENCES `bearing_machine` (`machineID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for bearing_machine
-- ----------------------------
DROP TABLE IF EXISTS `bearing_machine`;
CREATE TABLE `bearing_machine`  (
  `machineID` int(11) NOT NULL AUTO_INCREMENT,
  `machineDes` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `saveDate` datetime(6) NOT NULL,
  `modDate` datetime(6) NOT NULL,
  `otherInfo` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `productDepart_id` int(11) NOT NULL,
  PRIMARY KEY (`machineID`) USING BTREE,
  INDEX `bearing_machine_productDepart_id_7983075c_fk_bearing_p`(`productDepart_id`) USING BTREE,
  CONSTRAINT `bearing_machine_productDepart_id_7983075c_fk_bearing_p` FOREIGN KEY (`productDepart_id`) REFERENCES `bearing_productdepart` (`departID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for bearing_machineruntime
-- ----------------------------
DROP TABLE IF EXISTS `bearing_machineruntime`;
CREATE TABLE `bearing_machineruntime`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `machine_id` int(11) NOT NULL,
  `opStartEnddate_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `bearing_machinerunti_machine_id_eac8f45d_fk_bearing_m`(`machine_id`) USING BTREE,
  INDEX `bearing_machinerunti_opStartEnddate_id_f4ba3ca5_fk_bearing_o`(`opStartEnddate_id`) USING BTREE,
  CONSTRAINT `bearing_machinerunti_machine_id_eac8f45d_fk_bearing_m` FOREIGN KEY (`machine_id`) REFERENCES `bearing_machine` (`machineID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `bearing_machinerunti_opStartEnddate_id_f4ba3ca5_fk_bearing_o` FOREIGN KEY (`opStartEnddate_id`) REFERENCES `bearing_opstartenddate` (`opCodeID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for bearing_memoryinfo
-- ----------------------------
DROP TABLE IF EXISTS `bearing_memoryinfo`;
CREATE TABLE `bearing_memoryinfo`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `valueUsed` double NOT NULL,
  `memPercent` double NOT NULL,
  `time` datetime(6) NOT NULL,
  `machine_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `bearing_memoryinfo_machine_id_68beaa61_fk_bearing_m`(`machine_id`) USING BTREE,
  CONSTRAINT `bearing_memoryinfo_machine_id_68beaa61_fk_bearing_m` FOREIGN KEY (`machine_id`) REFERENCES `bearing_machine` (`machineID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 452 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for bearing_opstartenddate
-- ----------------------------
DROP TABLE IF EXISTS `bearing_opstartenddate`;
CREATE TABLE `bearing_opstartenddate`  (
  `opCodeID` int(11) NOT NULL AUTO_INCREMENT,
  `startDate` datetime(6) NOT NULL,
  `endDate` datetime(6) NOT NULL,
  PRIMARY KEY (`opCodeID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for bearing_productdepart
-- ----------------------------
DROP TABLE IF EXISTS `bearing_productdepart`;
CREATE TABLE `bearing_productdepart`  (
  `departID` int(11) NOT NULL AUTO_INCREMENT,
  `depatrDes` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `personInCharge` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `otherInfo` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `saveDate` datetime(6) NOT NULL,
  `modDate` datetime(6) NOT NULL,
  `factory_id` int(11) NOT NULL,
  PRIMARY KEY (`departID`) USING BTREE,
  INDEX `bearing_productdepar_factory_id_f4b0f1ab_fk_bearing_f`(`factory_id`) USING BTREE,
  CONSTRAINT `bearing_productdepar_factory_id_f4b0f1ab_fk_bearing_f` FOREIGN KEY (`factory_id`) REFERENCES `bearing_factory` (`factorID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 100010 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for bearing_profile
-- ----------------------------
DROP TABLE IF EXISTS `bearing_profile`;
CREATE TABLE `bearing_profile`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `phonenumber` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `avatar` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `gender` int(11) NOT NULL,
  `otherText` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `user_id`(`user_id`) USING BTREE,
  CONSTRAINT `bearing_profile_user_id_a4d62636_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for bearing_sensorinfo
-- ----------------------------
DROP TABLE IF EXISTS `bearing_sensorinfo`;
CREATE TABLE `bearing_sensorinfo`  (
  `sensorID` int(11) NOT NULL AUTO_INCREMENT,
  `saveDate` datetime(6) NOT NULL,
  `modDate` datetime(6) NOT NULL,
  `machine_id` int(11) NULL DEFAULT NULL,
  `dsensorDes` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sensorCode` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`sensorID`) USING BTREE,
  INDEX `bearing_sensorinfo_machine_id_c1da53d3_fk_bearing_m`(`machine_id`) USING BTREE,
  CONSTRAINT `bearing_sensorinfo_machine_id_c1da53d3_fk_bearing_m` FOREIGN KEY (`machine_id`) REFERENCES `bearing_machine` (`machineID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 33 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for bearing_sensorrawdata
-- ----------------------------
DROP TABLE IF EXISTS `bearing_sensorrawdata`;
CREATE TABLE `bearing_sensorrawdata`  (
  `sensorID` int(11) NOT NULL AUTO_INCREMENT,
  `sesorValue` double NOT NULL,
  `saveDate` datetime(6) NOT NULL,
  `opStartEnddate_id` int(11) NOT NULL,
  `sensorInfo_id` int(11) NOT NULL,
  PRIMARY KEY (`sensorID`) USING BTREE,
  INDEX `bearing_sensorrawdat_opStartEnddate_id_3977b7d1_fk_bearing_o`(`opStartEnddate_id`) USING BTREE,
  INDEX `bearing_sensorrawdat_sensorInfo_id_f1467128_fk_bearing_s`(`sensorInfo_id`) USING BTREE,
  CONSTRAINT `bearing_sensorrawdat_opStartEnddate_id_3977b7d1_fk_bearing_o` FOREIGN KEY (`opStartEnddate_id`) REFERENCES `bearing_opstartenddate` (`opCodeID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `bearing_sensorrawdat_sensorInfo_id_f1467128_fk_bearing_s` FOREIGN KEY (`sensorInfo_id`) REFERENCES `bearing_sensorinfo` (`sensorID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 21001 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for bearing_sensorwaveletdata
-- ----------------------------
DROP TABLE IF EXISTS `bearing_sensorwaveletdata`;
CREATE TABLE `bearing_sensorwaveletdata`  (
  `sensorID` int(11) NOT NULL AUTO_INCREMENT,
  `sesorValue` double NOT NULL,
  `saveDate` datetime(6) NOT NULL,
  `opStartEnddate_id` int(11) NOT NULL,
  `sensorInfo_id` int(11) NOT NULL,
  PRIMARY KEY (`sensorID`) USING BTREE,
  INDEX `bearing_sensorwavele_opStartEnddate_id_bdd383e6_fk_bearing_o`(`opStartEnddate_id`) USING BTREE,
  INDEX `bearing_sensorwavele_sensorInfo_id_c7968757_fk_bearing_s`(`sensorInfo_id`) USING BTREE,
  CONSTRAINT `bearing_sensorwavele_opStartEnddate_id_bdd383e6_fk_bearing_o` FOREIGN KEY (`opStartEnddate_id`) REFERENCES `bearing_opstartenddate` (`opCodeID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `bearing_sensorwavele_sensorInfo_id_c7968757_fk_bearing_s` FOREIGN KEY (`sensorInfo_id`) REFERENCES `bearing_sensorinfo` (`sensorID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for django_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE `django_admin_log`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `object_repr` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL,
  `change_message` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `content_type_id` int(11) NULL DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `django_admin_log_content_type_id_c4bce8eb_fk_django_co`(`content_type_id`) USING BTREE,
  INDEX `django_admin_log_user_id_c564eba6_fk_auth_user_id`(`user_id`) USING BTREE,
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 168 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for django_content_type
-- ----------------------------
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `model` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `django_content_type_app_label_model_76bd3d3b_uniq`(`app_label`, `model`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for django_migrations
-- ----------------------------
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for django_session
-- ----------------------------
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session`  (
  `session_key` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `session_data` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`) USING BTREE,
  INDEX `django_session_expire_date_a5c62663`(`expire_date`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
