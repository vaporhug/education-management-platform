CREATE TABLE `school` (
	`id` SMALLINT NOT NULL AUTO_INCREMENT UNIQUE,
	`name` VARCHAR(255),
	PRIMARY KEY(`id`)
);

CREATE TABLE `academic_affair_office` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`name` VARCHAR(255),
	PRIMARY KEY(`id`)
);

CREATE TABLE `aao_office` (
	`kind` SMALLINT NOT NULL AUTO_INCREMENT UNIQUE,
	`name` VARCHAR(255),
	`major_id` SMALLINT,
	PRIMARY KEY(`kind`)
);

CREATE TABLE `teacher` (
	`id` CHAR(1) NOT NULL UNIQUE,
	`name` VARCHAR(255),
	`hire_date` DATE,
	PRIMARY KEY(`id`)
);

CREATE TABLE `teacher_part_aao_office` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`teacher_id` CHAR(1),
	`aao_office_kind` SMALLINT,
	`from_date` DATE,
	`to_date` DATE,
	`position` SMALLINT,
	PRIMARY KEY(`id`)
);

CREATE TABLE `major` (
	`id` SMALLINT NOT NULL AUTO_INCREMENT UNIQUE,
	`name` VARCHAR(255),
	`school_id` SMALLINT,
	-- 四年制，五年制。。。
	`duration` SMALLINT COMMENT '四年制，五年制。。。',
	PRIMARY KEY(`id`)
);

CREATE TABLE `teacher_major` (
	`teacher_id` CHAR(1),
	`major_id` INT,
	`from_date` DATETIME,
	`to_date` DATETIME
);

CREATE TABLE `student` (
	`id` CHAR(1) NOT NULL UNIQUE,
	`name` VARCHAR(255),
	`major_id` SMALLINT,
	`now_level` SMALLINT,
	`class_id` INT,
	PRIMARY KEY(`id`)
);

CREATE TABLE `classroom` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`building_name` VARCHAR(255),
	`room_number` VARCHAR(255),
	`campus_id` SMALLINT,
	`type` SMALLINT,
	`seat_num` SMALLINT,
	`area` SMALLINT,
	PRIMARY KEY(`id`)
);

CREATE TABLE `campus` (
	`id` SMALLINT NOT NULL AUTO_INCREMENT UNIQUE,
	`name` VARCHAR(255),
	`location` VARCHAR(255),
	PRIMARY KEY(`id`)
);

CREATE TABLE `course` (
	`id` CHAR(1) NOT NULL UNIQUE,
	`name` VARCHAR(255),
	-- 全校性选修课，专业必修课，专业选修课
	`course_type` SMALLINT COMMENT '全校性选修课，专业必修课，专业选修课',
	-- 自然科学类，人文社科类，艺术类，体育类，科研实践类
	`course_cate` SMALLINT COMMENT '自然科学类，人文社科类，艺术类，体育类，科研实践类',
	`course_for` SMALLINT,
	`credit` SMALLINT,
	-- 为几年级开设的，例如大一上为1.。。。
	`grade_level` SMALLINT COMMENT '为几年级开设的，例如大一上为1.。。。',
	PRIMARY KEY(`id`)
);

CREATE TABLE `course_inst` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`course_id` CHAR(1),
	`year` INT,
	`term_part` BOOLEAN,
	`instructor_msg` TEXT(65535),
	`overview` TEXT(65535),
	`target` TEXT(65535),
	`assess_method` SMALLINT,
	`method_detal` TEXT(65535),
	PRIMARY KEY(`id`)
);

CREATE TABLE `course_sched` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`week` SMALLINT,
	`period_from` SMALLINT,
	`period_to` SMALLINT,
	`course_section_id` INT,
	`day_of_week` SMALLINT,
	`classroom_id` INT,
	`year` INT,
	`term_part` BOOLEAN,
	-- 准时，缺课，迟到
	`teacher_attend` SMALLINT COMMENT '准时，缺课，迟到',
	`course_log` TEXT(65535),
	PRIMARY KEY(`id`)
);

CREATE TABLE `teach` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`course_id` CHAR(1),
	`teacher_id` CHAR(1),
	PRIMARY KEY(`id`)
);

CREATE TABLE `semester` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`from_date` DATE,
	`to_date` DATE,
	`year` INT,
	`term_part` BOOLEAN,
	PRIMARY KEY(`id`)
);

CREATE TABLE `stu_period` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`stu_id` CHAR(1),
	`degree_level` SMALLINT,
	`from_date` DATE,
	`to_date` DATE,
	PRIMARY KEY(`id`)
);

CREATE TABLE `stu_course_sched` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	-- 例如，大一上为1，大一下为2
	`semester` SMALLINT COMMENT '例如，大一上为1，大一下为2',
	`stu_id` CHAR(1),
	`course_sched_id` INT,
	-- 准时，迟到，缺课
	`stu_attend` SMALLINT COMMENT '准时，迟到，缺课',
	PRIMARY KEY(`id`)
);

CREATE TABLE `classroom_reservation` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`teacher_id` INT,
	-- 原因的枚举
	`reason` SMALLINT COMMENT '原因的枚举',
	`week` SMALLINT,
	`year` INT,
	`term_part` BOOLEAN,
	`day_of_week` SMALLINT,
	`class_period_from` SMALLINT,
	`class_period_to` SMALLINT,
	`processor_id` INT,
	`processed_at` DATETIME,
	`result` SMALLINT,
	`classroom_id` INT,
	`act_name` VARCHAR(255),
	`canceled` BOOLEAN,
	`reason_detail` VARCHAR(255),
	PRIMARY KEY(`id`)
);

CREATE TABLE `classroom_status` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`classroom_id` INT,
	`year` SMALLINT,
	`term_part` BOOLEAN,
	`week` SMALLINT,
	`day_of_week` SMALLINT,
	`period_from` SMALLINT,
	`period_to` SMALLINT,
	`status` SMALLINT,
	PRIMARY KEY(`id`)
);

CREATE TABLE `fault_report` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`classroom_id` INT,
	`reporter_role` SMALLINT,
	`reporter_id` CHAR(1),
	`fault_desc` TEXT(65535),
	`report_time` DATETIME,
	-- pending, in progress, completed
	`status` SMALLINT COMMENT 'pending, in progress, completed',
	PRIMARY KEY(`id`)
);

CREATE TABLE `maintainance_record` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`report_id` INT,
	`maint_from` DATETIME,
	`maint_to` DATETIME,
	`maint_detail` TEXT(65535),
	PRIMARY KEY(`id`)
);

CREATE TABLE `maintainance_fault_type` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`maint_id` INT,
	-- 'Electrical', 'Plumbing', 'HVAC', 'Furniture', 'Other'
	`type` SMALLINT COMMENT ''Electrical', 'Plumbing', 'HVAC', 'Furniture', 'Other'',
	`extra_desc` TEXT(65535),
	PRIMARY KEY(`id`)
);

CREATE TABLE `class` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`name` VARCHAR(255),
	`major_id` SMALLINT,
	`fe_stu_num` SMALLINT,
	`male_stu_num` SMALLINT,
	`counselor_id` CHAR(1),
	`campus_id` SMALLINT,
	`start_year` SMALLINT,
	PRIMARY KEY(`id`)
);

CREATE TABLE `counselor` (
	`id` CHAR(1) NOT NULL UNIQUE,
	`name` VARCHAR(255),
	PRIMARY KEY(`id`)
);

CREATE TABLE `exam_sched` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`course_inst_id` INT,
	`duration` INT,
	`classroom_id` INT,
	`year` SMALLINT,
	`term_part` BOOLEAN,
	`week` SMALLINT,
	`day_of_week` SMALLINT,
	`period_from` SMALLINT,
	`period_to` SMALLINT,
	-- 普通考试，补考，重修考试...
	`type` SMALLINT COMMENT '普通考试，补考，重修考试...',
	`original_exam_sched` INT,
	PRIMARY KEY(`id`)
);

CREATE TABLE `exam_stu` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`exam_sched_id` INT,
	`stu_id` CHAR(1),
	-- 正常考试，缺考状态的枚举
	`status` SMALLINT COMMENT '正常考试，缺考状态的枚举',
	PRIMARY KEY(`id`)
);

CREATE TABLE `proctor` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`teacher_id` CHAR(1),
	`exam_sched_id` INT,
	PRIMARY KEY(`id`)
);

CREATE TABLE `exam_paper_submission` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`teacher_id` CHAR(1),
	`for_course_inst` INT,
	-- 如果是考卷考试，那么这个文件就是考卷，如果其他方式进行考核，这里应该是考核方式的说明
	`file_id` INT COMMENT '如果是考卷考试，那么这个文件就是考卷，如果其他方式进行考核，这里应该是考核方式的说明',
	-- 对于考试以及考核方式的说明
	`detail` TEXT(65535) COMMENT '对于考试以及考核方式的说明',
	`review_time` DATETIME,
	`reviewer_id` INT,
	`status` SMALLINT,
	`submit_time` DATETIME,
	PRIMARY KEY(`id`)
);

CREATE TABLE `assessment_application` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`teacher_id` CHAR(1),
	`for_couese_inst` INT,
	`method_detail` TEXT(65535),
	`extra_file_id` INT,
	-- 考核方式枚举
	`method` SMALLINT COMMENT '考核方式枚举',
	`submit_time` DATETIME,
	`review_time` DATETIME,
	`reviewer_id` INT,
	`status` SMALLINT,
	PRIMARY KEY(`id`)
);

CREATE TABLE `exam_stat` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`exam_sched_id` INT,
	`total_stu_num` SMALLINT,
	`absent_stu_num` SMALLINT,
	PRIMARY KEY(`id`)
);

CREATE TABLE `retake_class_application` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`stu_id` CHAR(1),
	`for_course_inst` INT,
	`submit_time` DATETIME,
	`reviewer_id` INT,
	`review_time` DATETIME,
	`status` SMALLINT,
	`fee_id` INT,
	PRIMARY KEY(`id`)
);

CREATE TABLE `payment` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`payer_role` SMALLINT,
	`payer_id` CHAR(1),
	`payer_reason` SMALLINT,
	`payer_reason_detail` VARCHAR(255),
	`payment_amount` DECIMAL,
	`pay_time` DATETIME,
	`pay_method` SMALLINT,
	`transaction_id` VARCHAR(255),
	PRIMARY KEY(`id`)
);

CREATE TABLE `fee_requirement` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`payer_role` SMALLINT,
	`payer_id` CHAR(1),
	`pay_amount` DECIMAL,
	`deadline` DATETIME,
	`payment_id` INT,
	PRIMARY KEY(`id`)
);

CREATE TABLE `credit_earned` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`stu_id` CHAR(1),
	`credit_type` SMALLINT,
	-- 以0.1个学分为单位
	`credit_sum` SMALLINT COMMENT '以0.1个学分为单位',
	PRIMARY KEY(`id`)
);

CREATE TABLE `course_selection` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`stu_id` CHAR(1),
	`course_sec_id` INT,
	`pass` BOOLEAN,
	`score` SMALLINT,
	`score_reviewer` CHAR(1),
	PRIMARY KEY(`id`)
);

CREATE TABLE `course_inst_section` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`course_inst_id` INT,
	`name` VARCHAR(255),
	PRIMARY KEY(`id`)
);

CREATE TABLE `book_selection` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`aao_office_kind` SMALLINT,
	-- 专业必修课和专业选修课
	`for_course_inst` INT COMMENT '专业必修课和专业选修课',
	`book_isbn` CHAR(1),
	`dept_chair_id` CHAR(1),
	`dept_chair_decision` SMALLINT,
	`aao_decision` SMALLINT,
	`unit_price` DECIMAL,
	`detail` TEXT(65535),
	PRIMARY KEY(`id`)
);

CREATE INDEX `book_order_request_index_0`
ON `book_selection` ();
CREATE TABLE `book` (
	`isbn` CHAR(1) NOT NULL UNIQUE,
	`title` VARCHAR(255),
	`author` VARCHAR(255),
	`edition` SMALLINT,
	`publisher` VARCHAR(255),
	`pub_date` DATE,
	`cover_url` VARCHAR(255),
	`checked` BOOLEAN,
	PRIMARY KEY(`isbn`)
);

CREATE TABLE `dept_emp` (
	`id` CHAR(1) NOT NULL UNIQUE,
	`major_id` SMALLINT,
	`teacher_id` CHAR(1),
	`from_date` DATE,
	`to_date` DATE,
	`position` SMALLINT,
	PRIMARY KEY(`id`)
);

CREATE TABLE `book_order` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`class_id` INT,
	`num` SMALLINT,
	`unit_price` DECIMAL,
	`isbn` CHAR(1),
	PRIMARY KEY(`id`)
);

CREATE TABLE `graduate` (
	`cert_num` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`stu_id` CHAR(1),
	`grad_dest` SMALLINT,
	`dest` VARCHAR(255),
	`stu_situa` TEXT(65535),
	PRIMARY KEY(`cert_num`)
);

CREATE TABLE `chapter` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`title` VARCHAR(255),
	`title_level` SMALLINT,
	`course_inst_id` INT,
	PRIMARY KEY(`id`)
);

CREATE TABLE `teaching_material` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`for_chapter` INT,
	`upload_time` DATETIME,
	`uploader_id` CHAR(1),
	`name` VARCHAR(255),
	`file_id` INT,
	PRIMARY KEY(`id`)
);

CREATE TABLE `file` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`url` VARCHAR(255),
	`size` BIGINT,
	`hash` VARCHAR(255),
	PRIMARY KEY(`id`)
);

ALTER TABLE `teacher_part_aao_office`
ADD FOREIGN KEY(`teacher_id`) REFERENCES `teacher`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `teacher_part_aao_office`
ADD FOREIGN KEY(`aao_office_kind`) REFERENCES `aao_office`(`kind`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `teacher`
ADD FOREIGN KEY(`id`) REFERENCES `teacher_major`(`teacher_id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `teacher_major`
ADD FOREIGN KEY(`major_id`) REFERENCES `major`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `student`
ADD FOREIGN KEY(`major_id`) REFERENCES `major`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `classroom`
ADD FOREIGN KEY(`campus_id`) REFERENCES `campus`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `course_inst`
ADD FOREIGN KEY(`course_id`) REFERENCES `course`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `teach`
ADD FOREIGN KEY(`course_id`) REFERENCES `course`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `stu_period`
ADD FOREIGN KEY(`stu_id`) REFERENCES `student`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `stu_course_sched`
ADD FOREIGN KEY(`stu_id`) REFERENCES `student`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `stu_course_sched`
ADD FOREIGN KEY(`course_sched_id`) REFERENCES `course_sched`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `course_sched`
ADD FOREIGN KEY(`classroom_id`) REFERENCES `classroom`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `major`
ADD FOREIGN KEY(`school_id`) REFERENCES `school`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `classroom_reservation`
ADD FOREIGN KEY(`classroom_id`) REFERENCES `classroom`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `classroom_status`
ADD FOREIGN KEY(`classroom_id`) REFERENCES `classroom`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `fault_report`
ADD FOREIGN KEY(`classroom_id`) REFERENCES `classroom`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `maintainance_fault_type`
ADD FOREIGN KEY(`maint_id`) REFERENCES `maintainance_record`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `maintainance_record`
ADD FOREIGN KEY(`report_id`) REFERENCES `fault_report`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `course`
ADD FOREIGN KEY(`course_for`) REFERENCES `major`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `class`
ADD FOREIGN KEY(`major_id`) REFERENCES `major`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `class`
ADD FOREIGN KEY(`counselor_id`) REFERENCES `counselor`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `student`
ADD FOREIGN KEY(`class_id`) REFERENCES `class`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `exam_sched`
ADD FOREIGN KEY(`classroom_id`) REFERENCES `classroom`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `exam_sched`
ADD FOREIGN KEY(`course_inst_id`) REFERENCES `course_inst`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `exam_stu`
ADD FOREIGN KEY(`id`) REFERENCES `exam_sched`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `exam_stu`
ADD FOREIGN KEY(`stu_id`) REFERENCES `student`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `proctor`
ADD FOREIGN KEY(`exam_sched_id`) REFERENCES `exam_sched`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `proctor`
ADD FOREIGN KEY(`teacher_id`) REFERENCES `teacher`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `exam_paper_submission`
ADD FOREIGN KEY(`for_course_inst`) REFERENCES `course_inst`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `exam_paper_submission`
ADD FOREIGN KEY(`teacher_id`) REFERENCES `teacher`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `exam_sched`
ADD FOREIGN KEY(`original_exam_sched`) REFERENCES `exam_sched`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `assessment_application`
ADD FOREIGN KEY(`for_couese_inst`) REFERENCES `course_inst`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `assessment_application`
ADD FOREIGN KEY(`teacher_id`) REFERENCES `teacher_major`(`teacher_id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `exam_stat`
ADD FOREIGN KEY(`exam_sched_id`) REFERENCES `exam_sched`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `retake_class_application`
ADD FOREIGN KEY(`for_course_inst`) REFERENCES `course_inst`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `retake_class_application`
ADD FOREIGN KEY(`stu_id`) REFERENCES `student`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `retake_class_application`
ADD FOREIGN KEY(`fee_id`) REFERENCES `fee_requirement`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `fee_requirement`
ADD FOREIGN KEY(`payment_id`) REFERENCES `payment`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `credit_earned`
ADD FOREIGN KEY(`stu_id`) REFERENCES `student`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `course_sched`
ADD FOREIGN KEY(`course_section_id`) REFERENCES `course_inst_section`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `course_selection`
ADD FOREIGN KEY(`stu_id`) REFERENCES `student`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `course_selection`
ADD FOREIGN KEY(`course_sec_id`) REFERENCES `course_inst_section`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `course_selection`
ADD FOREIGN KEY(`score_reviewer`) REFERENCES `teacher`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `aao_office`
ADD FOREIGN KEY(`major_id`) REFERENCES `major`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `book_selection`
ADD FOREIGN KEY(`aao_office_kind`) REFERENCES `aao_office`(`kind`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `book_selection`
ADD FOREIGN KEY(`for_course_inst`) REFERENCES `course_inst`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `book_selection`
ADD FOREIGN KEY(`book_isbn`) REFERENCES `book`(`isbn`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `dept_emp`
ADD FOREIGN KEY(`major_id`) REFERENCES `major`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `dept_emp`
ADD FOREIGN KEY(`teacher_id`) REFERENCES `teacher`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `book_selection`
ADD FOREIGN KEY(`dept_chair_id`) REFERENCES `dept_emp`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `book_order`
ADD FOREIGN KEY(`class_id`) REFERENCES `class`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `book_order`
ADD FOREIGN KEY(`isbn`) REFERENCES `book_selection`(`book_isbn`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `graduate`
ADD FOREIGN KEY(`stu_id`) REFERENCES `student`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `course_inst_section`
ADD FOREIGN KEY(`course_inst_id`) REFERENCES `course_inst`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `chapter`
ADD FOREIGN KEY(`course_inst_id`) REFERENCES `course_inst`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `teaching_material`
ADD FOREIGN KEY(`for_chapter`) REFERENCES `chapter`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `teaching_material`
ADD FOREIGN KEY(`uploader_id`) REFERENCES `teacher`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `teaching_material`
ADD FOREIGN KEY(`file_id`) REFERENCES `file`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `exam_paper_submission`
ADD FOREIGN KEY(`file_id`) REFERENCES `file`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;