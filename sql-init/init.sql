

CREATE TABLE `school` (
	`id` SMALLINT NOT NULL AUTO_INCREMENT UNIQUE,
	`name` VARCHAR(255) NOT NULL,
	PRIMARY KEY(`id`)
);


CREATE TABLE `aao_office` (
	`id` SMALLINT NOT NULL AUTO_INCREMENT UNIQUE,
	`name` VARCHAR(255) NOT NULL,
	`major_id` SMALLINT NOT NULL,
	PRIMARY KEY(`id`)
);


CREATE TABLE `teacher` (
	`id` CHAR(8) NOT NULL UNIQUE,
	`name` VARCHAR(255) NOT NULL,
	`hire_date` DATE NOT NULL,
	`phone` CHAR(11) NOT NULL,
	-- 专职教师，校内兼职教师，校外兼职教室
	`type` SMALLINT NOT NULL COMMENT '专职教师，校内兼职教师，校外兼职教室',
	`gender` BOOLEAN NOT NULL,
	`major_id` SMALLINT NOT NULL,
	`school_id` SMALLINT NOT NULL,
	`title` SMALLINT NOT NULL,
	`bachelor` SMALLINT NOT NULL,
	`email` VARCHAR(255),
	`desc` TEXT(65535),
	`research_focus` TEXT(65535),
	`teacher_pic` BIGINT,
	`identity` CHAR(18) NOT NULL,
	`address` VARCHAR(255),
	PRIMARY KEY(`id`)
);


CREATE TABLE `teacher_part_aao_office` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`teacher_id` CHAR(8) NOT NULL,
	`aao_office_kind` SMALLINT NOT NULL,
	`from_date` DATE NOT NULL,
	`to_date` DATE NOT NULL,
	`position` SMALLINT NOT NULL,
	PRIMARY KEY(`id`)
);


CREATE TABLE `major` (
	`id` SMALLINT NOT NULL AUTO_INCREMENT UNIQUE,
	`name` VARCHAR(255) NOT NULL,
	`school_id` SMALLINT NOT NULL,
	-- 四年制，五年制。。。
	`duration` SMALLINT NOT NULL COMMENT '四年制，五年制。。。',
	PRIMARY KEY(`id`)
);


CREATE TABLE `teacher_major` (
	`teacher_id` CHAR(8) NOT NULL,
	`major_id` SMALLINT NOT NULL,
	`from_date` DATETIME NOT NULL,
	`to_date` DATETIME NOT NULL,
	PRIMARY KEY(`teacher_id`, `major_id`)
);


CREATE TABLE `student` (
	`id` CHAR(10) NOT NULL UNIQUE,
	`name` VARCHAR(255) NOT NULL,
	`major_id` SMALLINT NOT NULL,
	`now_level` SMALLINT NOT NULL,
	`class_id` INT NOT NULL,
	`gender` BOOLEAN NOT NULL,
	`stu_pic` BIGINT NOT NULL,
	`phone_number` CHAR(11) NOT NULL,
	`birthday` DATE NOT NULL,
	-- 身份证号
	`identity` CHAR(18) NOT NULL COMMENT '身份证号',
	`address` VARCHAR(255) NOT NULL,
	PRIMARY KEY(`id`)
);


CREATE TABLE `classroom` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`building_name` VARCHAR(255) NOT NULL,
	`room_number` VARCHAR(255) NOT NULL,
	`campus_id` SMALLINT NOT NULL,
	`type` SMALLINT NOT NULL,
	`seat_num` SMALLINT,
	`area` SMALLINT,
	PRIMARY KEY(`id`)
);


CREATE TABLE `campus` (
	`id` SMALLINT NOT NULL AUTO_INCREMENT UNIQUE,
	`name` VARCHAR(255) NOT NULL,
	`location` VARCHAR(255) NOT NULL,
	`desc` TEXT(65535),
	PRIMARY KEY(`id`)
);


CREATE TABLE `course` (
	`id` CHAR(15) NOT NULL UNIQUE,
	`name` VARCHAR(255) NOT NULL,
	-- 全校性选修课，专业必修课，专业选修课
	`course_type` SMALLINT NOT NULL COMMENT '全校性选修课，专业必修课，专业选修课',
	-- 自然科学类，人文社科类，艺术类，体育类，科研实践类
	`course_cate` SMALLINT NOT NULL COMMENT '自然科学类，人文社科类，艺术类，体育类，科研实践类',
	-- 如果是专业必修课或者学科选修课，这里对应对应的专业id
	`course_for` SMALLINT NOT NULL COMMENT '如果是专业必修课或者学科选修课，这里对应对应的专业id',
	`credit` SMALLINT NOT NULL,
	-- 为几年级开设的，例如大一上为1.。。。
	`grade_level` SMALLINT NOT NULL COMMENT '为几年级开设的，例如大一上为1.。。。',
	`school_id` SMALLINT NOT NULL,
	`course_pic` BIGINT,
	PRIMARY KEY(`id`)
);


CREATE TABLE `course_inst` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`course_id` CHAR(15) NOT NULL,
	`year` INT NOT NULL,
	`term_part` BOOLEAN NOT NULL,
	`instructor_msg` TEXT(65535),
	`overview` TEXT(65535),
	`target` TEXT(65535),
	`assess_method` SMALLINT,
	`method_detal` TEXT(65535),
	`total_class_hour` SMALLINT NOT NULL,
	-- 最多选课人数
	`max_num` SMALLINT NOT NULL COMMENT '最多选课人数',
	PRIMARY KEY(`id`)
);


CREATE TABLE `course_sched` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`week` SMALLINT NOT NULL,
	`period_from` SMALLINT NOT NULL,
	`period_to` SMALLINT NOT NULL,
	`course_section_id` INT NOT NULL,
	`day_of_week` SMALLINT NOT NULL,
	`classroom_id` INT NOT NULL,
	`year` INT NOT NULL,
	`term_part` BOOLEAN NOT NULL,
	-- 准时，缺课，迟到
	`teacher_attend` SMALLINT NOT NULL COMMENT '准时，缺课，迟到',
	`course_log` TEXT(65535),
	PRIMARY KEY(`id`)
);


CREATE TABLE `teach` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`course_id` CHAR(15) NOT NULL,
	`teacher_id` CHAR(8) NOT NULL,
	PRIMARY KEY(`id`)
);


CREATE TABLE `semester` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`from_date` DATE NOT NULL,
	`to_date` DATE NOT NULL,
	`year` INT NOT NULL,
	`term_part` BOOLEAN NOT NULL,
	PRIMARY KEY(`id`)
);


CREATE TABLE `stu_course_sched` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	-- 例如，大一上为1，大一下为2
	`semester` SMALLINT NOT NULL COMMENT '例如，大一上为1，大一下为2',
	`stu_id` CHAR(10) NOT NULL,
	`course_sched_id` INT NOT NULL,
	-- 准时，迟到，缺课
	`stu_attend` SMALLINT NOT NULL COMMENT '准时，迟到，缺课',
	PRIMARY KEY(`id`)
);


CREATE TABLE `classroom_reservation` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`teacher_id` INT NOT NULL,
	-- 原因的枚举
	`reason` SMALLINT COMMENT '原因的枚举',
	`week` SMALLINT NOT NULL,
	`year` INT NOT NULL,
	`term_part` BOOLEAN NOT NULL,
	`day_of_week` SMALLINT NOT NULL,
	`class_period_from` SMALLINT NOT NULL,
	`class_period_to` SMALLINT NOT NULL,
	`processor_id` INT,
	`processed_at` DATETIME,
	`result` SMALLINT,
	`classroom_id` INT NOT NULL,
	`act_name` VARCHAR(255),
	`canceled` BOOLEAN NOT NULL,
	`reason_detail` VARCHAR(255),
	PRIMARY KEY(`id`)
);


CREATE TABLE `classroom_status` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`classroom_id` INT NOT NULL,
	`year` SMALLINT NOT NULL,
	`term_part` BOOLEAN NOT NULL,
	`week` SMALLINT NOT NULL,
	`day_of_week` SMALLINT NOT NULL,
	`period_from` SMALLINT NOT NULL,
	`period_to` SMALLINT NOT NULL,
	`status` SMALLINT NOT NULL,
	PRIMARY KEY(`id`)
);


CREATE TABLE `fault_report` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`classroom_id` INT NOT NULL,
	`reporter_role` SMALLINT NOT NULL,
	`identity` CHAR(18) NOT NULL,
	`fault_desc` TEXT(65535),
	`report_time` DATETIME NOT NULL,
	-- pending, in progress, completed
	`status` SMALLINT NOT NULL COMMENT 'pending, in progress, completed',
	PRIMARY KEY(`id`)
);


CREATE TABLE `maintainance_record` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`report_id` INT NOT NULL,
	`maint_from` DATETIME NOT NULL,
	`maint_to` DATETIME NOT NULL,
	`maint_detail` TEXT(65535),
	PRIMARY KEY(`id`)
);


CREATE TABLE `maintainance_fault_type` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`maint_id` INT NOT NULL,
	-- 'Electrical', 'Plumbing', 'HVAC', 'Furniture', 'Other'
	`type` SMALLINT NOT NULL COMMENT 'Electrical, Plumbing, HVAC, Furniture, Other',
	`extra_desc` TEXT(65535),
	PRIMARY KEY(`id`)
);


CREATE TABLE `class` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`name` VARCHAR(255) NOT NULL,
	`major_id` SMALLINT NOT NULL,
	`fe_stu_num` SMALLINT NOT NULL,
	`male_stu_num` SMALLINT NOT NULL,
	`counselor_id` CHAR(8) NOT NULL,
	`campus_id` SMALLINT NOT NULL,
	`start_year` SMALLINT NOT NULL,
	PRIMARY KEY(`id`)
);


CREATE TABLE `counselor` (
	`id` CHAR(8) NOT NULL UNIQUE,
	`name` VARCHAR(255) NOT NULL,
	`bir` DATE NOT NULL,
	PRIMARY KEY(`id`)
);


CREATE TABLE `exam_sched` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`course_inst_id` INT NOT NULL,
	`duration` INT NOT NULL,
	`classroom_id` INT NOT NULL,
	`year` SMALLINT NOT NULL,
	`term_part` BOOLEAN NOT NULL,
	`week` SMALLINT NOT NULL,
	`day_of_week` SMALLINT NOT NULL,
	`period_from` SMALLINT NOT NULL,
	`period_to` SMALLINT NOT NULL,
	-- 普通考试，补考，重修考试...
	`type` SMALLINT NOT NULL COMMENT '普通考试，补考，重修考试...',
	`original_exam_sched` INT,
	PRIMARY KEY(`id`)
);


CREATE TABLE `exam_stu` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`exam_sched_id` INT NOT NULL,
	`stu_id` CHAR(10) NOT NULL,
	-- 正常考试，缺考状态的枚举
	`status` SMALLINT NOT NULL COMMENT '正常考试，缺考状态的枚举',
	PRIMARY KEY(`id`)
);


CREATE TABLE `proctor` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`teacher_id` CHAR(8) NOT NULL,
	`exam_sched_id` INT NOT NULL,
	PRIMARY KEY(`id`)
);


CREATE TABLE `exam_paper_submission` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`teacher_id` CHAR(8) NOT NULL,
	`for_course_inst` INT NOT NULL,
	-- 如果是考卷考试，那么这个文件就是考卷，如果其他方式进行考核，这里应该是考核方式的说明
	`file_id` BIGINT NOT NULL COMMENT '如果是考卷考试，那么这个文件就是考卷，如果其他方式进行考核，这里应该是考核方式的说明',
	-- 对于考试以及考核方式的说明
	`detail` TEXT(65535) COMMENT '对于考试以及考核方式的说明',
	`review_time` DATETIME,
	`reviewer_id` INT,
	`status` SMALLINT NOT NULL,
	`submit_time` DATETIME NOT NULL,
	PRIMARY KEY(`id`)
);


CREATE TABLE `assessment_application` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`teacher_id` CHAR(8) NOT NULL,
	`for_couese_inst` INT NOT NULL,
	`method_detail` TEXT(65535),
	`extra_file_id` INT,
	-- 考核方式枚举
	`method` SMALLINT NOT NULL COMMENT '考核方式枚举',
	`submit_time` DATETIME NOT NULL,
	`review_time` DATETIME,
	`reviewer_id` INT,
	`status` SMALLINT NOT NULL,
	PRIMARY KEY(`id`)
);


CREATE TABLE `exam_stat` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`exam_sched_id` INT NOT NULL,
	`total_stu_num` SMALLINT NOT NULL,
	`absent_stu_num` SMALLINT NOT NULL,
	PRIMARY KEY(`id`)
);


CREATE TABLE `retake_class_application` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`stu_id` CHAR(8) NOT NULL,
	`for_course_inst` INT NOT NULL,
	`submit_time` DATETIME NOT NULL,
	`reviewer_id` INT,
	`review_time` DATETIME,
	`status` SMALLINT NOT NULL,
	`fee_id` INT NOT NULL,
	PRIMARY KEY(`id`)
);


CREATE TABLE `payment` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`payer_role` SMALLINT NOT NULL,
	`payer_id` CHAR(8) NOT NULL,
	`payer_reason` SMALLINT NOT NULL,
	`payer_reason_detail` VARCHAR(255),
	`payment_amount` DECIMAL NOT NULL,
	`pay_time` DATETIME NOT NULL,
	`pay_method` SMALLINT NOT NULL,
	`transaction_id` VARCHAR(255),
	PRIMARY KEY(`id`)
);


CREATE TABLE `fee_requirement` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`payer_role` SMALLINT NOT NULL,
	`payer_id` CHAR(8) NOT NULL,
	`pay_amount` DECIMAL NOT NULL,
	`deadline` DATETIME NOT NULL,
	`payment_id` INT,
	PRIMARY KEY(`id`)
);


CREATE TABLE `credit_earned` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`stu_id` CHAR(8) NOT NULL,
	`credit_type` SMALLINT NOT NULL,
	-- 以0.1个学分为单位
	`credit_sum` SMALLINT NOT NULL COMMENT '以0.1个学分为单位',
	PRIMARY KEY(`id`)
);


CREATE TABLE `course_selection` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`stu_id` CHAR(8) NOT NULL,
	`course_sec_id` INT NOT NULL,
	`score` SMALLINT,
	-- 通过，不及格，缺考, 未考
	`status` SMALLINT NOT NULL COMMENT '通过，不及格，缺考, 未考',
	PRIMARY KEY(`id`)
);


CREATE TABLE `course_inst_section` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`course_inst_id` INT NOT NULL,
	`name` VARCHAR(255) NOT NULL,
	PRIMARY KEY(`id`)
);


CREATE TABLE `book_selection` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`aao_office_kind` SMALLINT NOT NULL,
	-- 专业必修课和专业选修课
	`for_course_inst` INT NOT NULL COMMENT '专业必修课和专业选修课',
	`book_isbn` CHAR(10) NOT NULL,
	`dept_chair_id` CHAR(8),
	`dept_chair_decision` SMALLINT,
	`aao_decision` SMALLINT,
	`unit_price` DECIMAL NOT NULL,
	`detail` TEXT(65535),
	PRIMARY KEY(`id`)
);


CREATE TABLE `book` (
	`isbn` CHAR(10) NOT NULL UNIQUE,
	`title` VARCHAR(255) NOT NULL,
	`author` VARCHAR(255) NOT NULL,
	`edition` SMALLINT NOT NULL,
	`publisher` VARCHAR(255) NOT NULL,
	`pub_date` DATE NOT NULL,
	`cover_url` VARCHAR(255),
	PRIMARY KEY(`isbn`)
);


CREATE TABLE `dept_emp` (
	`id` int AUTO_INCREMENT NOT NULL UNIQUE,
	`major_id` SMALLINT NOT NULL,
	`teacher_id` CHAR(8) NOT NULL,
	`from_date` DATE NOT NULL,
	`to_date` DATE NOT NULL,
	`position` SMALLINT NOT NULL,
	PRIMARY KEY(`id`)
);


CREATE TABLE `book_order` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`class_id` INT NOT NULL,
	`num` SMALLINT NOT NULL,
	`unit_price` DECIMAL NOT NULL,
	`isbn` CHAR(10) NOT NULL,
	PRIMARY KEY(`id`)
);


CREATE TABLE `graduate` (
	`cert_num` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`stu_id` CHAR(8) NOT NULL,
	`grad_dest` SMALLINT,
	`dest` VARCHAR(255),
	`stu_situa` TEXT(65535),
	PRIMARY KEY(`cert_num`)
);


CREATE TABLE `chapter` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`title` VARCHAR(255) NOT NULL,
	`title_level` SMALLINT NOT NULL,
	`course_inst_id` INT NOT NULL,
	PRIMARY KEY(`id`)
);


CREATE TABLE `teaching_material` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`for_chapter` INT NOT NULL,
	`upload_time` DATETIME NOT NULL,
	`uploader_id` CHAR(8) NOT NULL,
	`name` VARCHAR(255) NOT NULL,
	`file_id` BIGINT NOT NULL,
	PRIMARY KEY(`id`)
);


CREATE TABLE `file` (
	`id` BIGINT NOT NULL AUTO_INCREMENT UNIQUE,
	`url` VARCHAR(255) NOT NULL,
	`size` BIGINT NOT NULL,
	`hash` VARCHAR(255) NOT NULL,
	PRIMARY KEY(`id`)
);


CREATE TABLE `major_dev_manage` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`major_id` SMALLINT NOT NULL,
	`cohort_year` SMALLINT NOT NULL,
    `date` date NOT NULL,
	-- 专业简介
	`intro` TEXT(65535) NOT NULL COMMENT '专业简介',
	-- 培养目标
	`target` TEXT(65535) NOT NULL COMMENT '培养目标',
	-- 标准学制
	`standard_duration_year` SMALLINT NOT NULL COMMENT '标准学制',
	-- 最少学习时限
	`min_duration` SMALLINT NOT NULL COMMENT '最少学习时限',
	-- 最长学习年限
	`max_duration` SMALLINT NOT NULL COMMENT '最长学习年限',
	-- 授予学位
	`degree_awarded` SMALLINT NOT NULL COMMENT '授予学位',
	-- 培养要求
	`req` TEXT(65535) NOT NULL COMMENT '培养要求',
	`aao_office_id` SMALLINT NOT NULL,
	PRIMARY KEY(`id`)
);


CREATE TABLE `core_course_for_major` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`major_id` SMALLINT NOT NULL,
	`cohort_year` SMALLINT NOT NULL,
	`course_struct_id` INT NOT NULL,
	PRIMARY KEY(`id`)
);


CREATE TABLE `course_struct` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`for_major` SMALLINT NOT NULL,
	`cohort_year` SMALLINT NOT NULL,
	`cate` SMALLINT NOT NULL,
	`subcate` SMALLINT NOT NULL,
	`course_name` VARCHAR(255) NOT NULL,
	`course_type` BOOLEAN NOT NULL,
	`credit` SMALLINT NOT NULL,
	`hours` SMALLINT NOT NULL,
	PRIMARY KEY(`id`)
);


CREATE TABLE `course_struct_sem` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`course_struct_id` INT NOT NULL,
	`sem` SMALLINT NOT NULL,
	PRIMARY KEY(`id`)
);


CREATE TABLE `major_subcate_req` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`major_id` SMALLINT NOT NULL,
	`cohort_year` SMALLINT NOT NULL,
	`subcate` SMALLINT NOT NULL,
	`require` VARCHAR(255) NOT NULL,
	PRIMARY KEY(`id`)
);


CREATE TABLE `other_major_dev_require` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`major_id` SMALLINT NOT NULL,
	`cohort_year` SMALLINT NOT NULL,
	`req` TEXT(65535) NOT NULL,
	`req_index` SMALLINT NOT NULL,
	PRIMARY KEY(`id`)
);


CREATE TABLE `director` (
	`id` CHAR(8) NOT NULL UNIQUE,
	`name` VARCHAR(255) NOT NULL,
	`school_id` SMALLINT NOT NULL,
	PRIMARY KEY(`id`)
);


CREATE TABLE `edu_experience` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`from_date` DATE NOT NULL,
	`to_date` DATE NOT NULL,
	`uni_name` VARCHAR(255) NOT NULL,
	`major_name` VARCHAR(255) NOT NULL,
	`bachelor` SMALLINT NOT NULL,
	`teacher_id` CHAR(8) NOT NULL,
	PRIMARY KEY(`id`)
);


CREATE TABLE `reseach_findings` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`teacher_id` CHAR(8) NOT NULL,
	`index` SMALLINT NOT NULL,
	-- 类型，论文成果，著作成果，专利成果
	`type` SMALLINT NOT NULL COMMENT '类型，论文成果，著作成果，专利成果',
	`content` VARCHAR(255) NOT NULL,
	PRIMARY KEY(`id`)
);


CREATE TABLE `major_credit_req` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`major_id` SMALLINT NOT NULL,
	`credit_type` SMALLINT NOT NULL,
	-- 学分以0.1为单位
	`credit_total` SMALLINT NOT NULL COMMENT '学分以0.1为单位',
	PRIMARY KEY(`id`)
);


CREATE TABLE `password` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`user_id` VARCHAR(11) NOT NULL,
	`pwd` VARCHAR(255) NOT NULL,
	PRIMARY KEY(`id`)
);


CREATE TABLE `inventory` (
	`isbn` CHAR(10) NOT NULL UNIQUE,
	`title` VARCHAR(255) NOT NULL,
	`number` INT NOT NULL,
	PRIMARY KEY(`isbn`)
);


ALTER TABLE `teacher_part_aao_office`
ADD FOREIGN KEY(`teacher_id`) REFERENCES `teacher`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `teacher_part_aao_office`
ADD FOREIGN KEY(`aao_office_kind`) REFERENCES `aao_office`(`id`)
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
ALTER TABLE `aao_office`
ADD FOREIGN KEY(`major_id`) REFERENCES `major`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `book_selection`
ADD FOREIGN KEY(`aao_office_kind`) REFERENCES `aao_office`(`id`)
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
ADD FOREIGN KEY(`dept_chair_id`) REFERENCES `dept_emp`(`teacher_id`)
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
ALTER TABLE `core_course_for_major`
ADD FOREIGN KEY(`major_id`) REFERENCES `major`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `major_dev_manage`
ADD FOREIGN KEY(`major_id`) REFERENCES `major`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `course_struct`
ADD FOREIGN KEY(`for_major`) REFERENCES `major`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `course_struct_sem`
ADD FOREIGN KEY(`course_struct_id`) REFERENCES `course_struct`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `major_subcate_req`
ADD FOREIGN KEY(`major_id`) REFERENCES `major`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `core_course_for_major`
ADD FOREIGN KEY(`course_struct_id`) REFERENCES `course_struct`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `major_dev_manage`
ADD FOREIGN KEY(`aao_office_id`) REFERENCES `aao_office`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `teach`
ADD FOREIGN KEY(`teacher_id`) REFERENCES `teacher`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `teacher`
ADD FOREIGN KEY(`major_id`) REFERENCES `major`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `teacher`
ADD FOREIGN KEY(`school_id`) REFERENCES `school`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `course`
ADD FOREIGN KEY(`school_id`) REFERENCES `school`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `director`
ADD FOREIGN KEY(`school_id`) REFERENCES `school`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `edu_experience`
ADD FOREIGN KEY(`teacher_id`) REFERENCES `teacher`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `reseach_findings`
ADD FOREIGN KEY(`teacher_id`) REFERENCES `teacher`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `student`
ADD FOREIGN KEY(`stu_pic`) REFERENCES `file`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `teacher`
ADD FOREIGN KEY(`teacher_pic`) REFERENCES `file`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `course`
ADD FOREIGN KEY(`course_pic`) REFERENCES `file`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `exam_stu`
ADD FOREIGN KEY(`exam_sched_id`) REFERENCES `exam_sched`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `major_credit_req`
ADD FOREIGN KEY(`major_id`) REFERENCES `major`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `inventory`
ADD FOREIGN KEY(`isbn`) REFERENCES `book`(`isbn`)
ON UPDATE NO ACTION ON DELETE NO ACTION;




































-- 插入第一条记录
INSERT INTO `school` (`name`) VALUES ('计算机科学与技术学院');
-- 插入第二条记录
INSERT INTO `school` (`name`) VALUES ('电子信息工程学院');
-- 插入第三条记录
INSERT INTO `school` (`name`) VALUES ('机械工程学院');
-- 插入第四条记录
INSERT INTO `school` (`name`) VALUES ('经济管理学院');
-- 插入第五条记录
INSERT INTO `school` (`name`) VALUES ('外国语学院');
-- 插入第六条记录
INSERT INTO `school` (`name`) VALUES ('法学院');
-- 插入第七条记录
INSERT INTO `school` (`name`) VALUES ('建筑与土木工程学院');
-- 插入第八条记录
INSERT INTO `school` (`name`) VALUES ('生物医学工程学院');
-- 插入第九条记录
INSERT INTO `school` (`name`) VALUES ('艺术学院');
-- 插入第十条记录
INSERT INTO `school` (`name`) VALUES ('环境科学与工程学院');

-- 插入2020年的学期数据
INSERT INTO `semester` (`from_date`, `to_date`, `year`, `term_part`) VALUES
                                                                         ('2020-02-19', '2020-06-30', 2020, TRUE),  -- 上学期
                                                                         ('2020-09-01', '2020-12-31', 2020, FALSE); -- 下学期
-- 插入2021年的学期数据
INSERT INTO `semester` (`from_date`, `to_date`, `year`, `term_part`) VALUES
                                                                         ('2021-02-19', '2021-06-30', 2021, TRUE),  -- 上学期
                                                                         ('2021-09-01', '2021-12-31', 2021, FALSE); -- 下学期
-- 插入2022年的学期数
INSERT INTO `semester` (`from_date`, `to_date`, `year`, `term_part`) VALUES
                                                                         ('2022-02-19', '2022-06-30', 2022, TRUE),  -- 上学期
                                                                         ('2022-09-01', '2022-12-31', 2022, FALSE); -- 下学期
-- 插入2023年的学期数据
INSERT INTO `semester` (`from_date`, `to_date`, `year`, `term_part`) VALUES
                                                                         ('2023-02-19', '2023-06-30', 2023, TRUE),  -- 上学期
                                                                         ('2023-09-01', '2023-12-31', 2023, FALSE); -- 下学期
-- 插入2024年的学期数据
INSERT INTO `semester` (`from_date`, `to_date`, `year`, `term_part`) VALUES
                                                                         ('2024-02-19', '2024-06-30', 2024, TRUE),  -- 上学期
                                                                         ('2024-09-01', '2024-12-31', 2024, FALSE); -- 下学期

-- 插入校本部
INSERT INTO `campus` (`name`, `location`, `desc`) VALUES
    ('校本部', '湖南长沙岳麓区', '这是校本部，拥有主要的教学楼和行政办公楼。');

-- 插入铁道校区
INSERT INTO `campus` (`name`, `location`, `desc`) VALUES
    ('铁道校区', '湖南长沙天心区', '这是铁道校区，专注于铁道工程相关专业。');

-- 插入新校区
INSERT INTO `campus` (`name`, `location`, `desc`) VALUES
    ('新校区', '湖南长沙岳麓区', '这是新校区，拥有最新的教学设施和宿舍楼。');

-- 插入湘雅校区
INSERT INTO `campus` (`name`, `location`, `desc`) VALUES
    ('湘雅校区', '湖南长沙芙蓉区', '这是湘雅校区，主要提供医学相关专业的教学和研究。');

-- 插入第一本书
INSERT INTO `book` (`isbn`, `title`, `author`, `edition`, `publisher`, `pub_date`, `cover_url`) VALUES
    ('1234567890', '数据结构与算法分析', 'Mark Allen Weiss', 3, '清华大学出版社', '2013-01-01', 'http://example.com/cover1.jpg');

-- 插入第二本书
INSERT INTO `book` (`isbn`, `title`, `author`, `edition`, `publisher`, `pub_date`, `cover_url`) VALUES
    ('2345678901', '计算机网络', 'Andrew S. Tanenbaum', 5, '电子工业出版社', '2010-01-01', 'http://example.com/cover2.jpg');

-- 插入第三本书
INSERT INTO `book` (`isbn`, `title`, `author`, `edition`, `publisher`, `pub_date`, `cover_url`) VALUES
    ('3456789012', '操作系统：设计与实现', 'Andrew S. Tanenbaum', 3, '清华大学出版社', '2006-01-01', 'http://example.com/cover3.jpg');

-- 插入第四本书
INSERT INTO `book` (`isbn`, `title`, `author`, `edition`, `publisher`, `pub_date`, `cover_url`) VALUES
    ('4567890123', '数据库系统概念', 'Abraham Silberschatz', 6, '机械工业出版社', '2011-01-01', 'http://example.com/cover4.jpg');

-- 插入第五本书
INSERT INTO `book` (`isbn`, `title`, `author`, `edition`, `publisher`, `pub_date`, `cover_url`) VALUES
    ('5678901234', '软件工程：实践者的研究方法', 'Roger S. Pressman', 7, '清华大学出版社', '2014-01-01', 'http://example.com/cover5.jpg');
-- 插入会计学教材
INSERT INTO `book` (`isbn`, `title`, `author`, `edition`, `publisher`, `pub_date`, `cover_url`) VALUES
    ('6789012345', '财务会计', 'Robert Libby', 9, '中国人民大学出版社', '2016-01-01', 'http://example.com/cover6.jpg');

-- 插入经济学教材
INSERT INTO `book` (`isbn`, `title`, `author`, `edition`, `publisher`, `pub_date`, `cover_url`) VALUES
    ('7890123456', '微观经济学', 'Robert S. Pindyck', 8, '机械工业出版社', '2018-01-01', 'http://example.com/cover7.jpg');

-- 插入管理学教材
INSERT INTO `book` (`isbn`, `title`, `author`, `edition`, `publisher`, `pub_date`, `cover_url`) VALUES
    ('8901234567', '管理学：原理与实践', 'Stephen P. Robbins', 13, '清华大学出版社', '2015-01-01', 'http://example.com/cover8.jpg');

-- 插入市场营销教材
INSERT INTO `book` (`isbn`, `title`, `author`, `edition`, `publisher`, `pub_date`, `cover_url`) VALUES
    ('9012345678', '市场营销原理', 'Philip Kotler', 15, '机械工业出版社', '2017-01-01', 'http://example.com/cover9.jpg');

-- 插入心理学教材
INSERT INTO `book` (`isbn`, `title`, `author`, `edition`, `publisher`, `pub_date`, `cover_url`) VALUES
    ('0123456789', '心理学导论', 'John W. Santrock', 10, '北京大学出版社', '2013-01-01', 'http://example.com/cover10.jpg');

-- 插入法律教材
INSERT INTO `book` (`isbn`, `title`, `author`, `edition`, `publisher`, `pub_date`, `cover_url`) VALUES
    ('1123456789', '民法总则', '崔建远', 2, '法律出版社', '2018-01-01', 'http://example.com/cover11.jpg');

-- 插入医学教材
INSERT INTO `book` (`isbn`, `title`, `author`, `edition`, `publisher`, `pub_date`, `cover_url`) VALUES
    ('2123456789', '医学影像学', '金义成', 4, '人民卫生出版社', '2016-01-01', 'http://example.com/cover12.jpg');

-- 插入教育学教材
INSERT INTO `book` (`isbn`, `title`, `author`, `edition`, `publisher`, `pub_date`, `cover_url`) VALUES
    ('3123456789', '教育心理学', 'Jeanne Ellis Ormrod', 9, '中国轻工业出版社', '2017-01-01', 'http://example.com/cover13.jpg');

-- 插入历史学教材
INSERT INTO `book` (`isbn`, `title`, `author`, `edition`, `publisher`, `pub_date`, `cover_url`) VALUES
    ('4123456789', '世界历史', 'William J. Duiker', 7, '高等教育出版社', '2014-01-01', 'http://example.com/cover14.jpg');

-- 插入哲学教材
INSERT INTO `book` (`isbn`, `title`, `author`, `edition`, `publisher`, `pub_date`, `cover_url`) VALUES
    ('5123456789', '西方哲学史', 'Bertrand Russell', 3, '商务印书馆', '2013-01-01', 'http://example.com/cover15.jpg');


INSERT INTO `major` (`name`, `school_id`, `duration`) VALUES
    ('计算机科学与技术', 1, 4);
INSERT INTO `major` (`name`, `school_id`, `duration`) VALUES
    ('电子信息工程', 2, 4);
INSERT INTO `major` (`name`, `school_id`, `duration`) VALUES
    ('机械工程', 3, 4);
INSERT INTO `major` (`name`, `school_id`, `duration`) VALUES
    ('经济学', 4, 4);
INSERT INTO `major` (`name`, `school_id`, `duration`) VALUES
    ('法学', 6, 4);
INSERT INTO `major` (`name`, `school_id`, `duration`) VALUES
    ('医学', 8, 5);
INSERT INTO `major` (`name`, `school_id`, `duration`) VALUES
    ('工商管理', 4, 4);
INSERT INTO `major` (`name`, `school_id`, `duration`) VALUES
    ('教育学', 9, 4);
INSERT INTO `major` (`name`, `school_id`, `duration`) VALUES
    ('建筑学', 7, 5);
INSERT INTO `major` (`name`, `school_id`, `duration`) VALUES
    ('环境工程', 10, 4);

INSERT INTO `counselor` (`id`, `name`, `bir`) VALUES
    ('C0000001', '张三', '1980-05-15');
INSERT INTO `counselor` (`id`, `name`, `bir`) VALUES
    ('C0000002', '李四', '1975-08-23');
INSERT INTO `counselor` (`id`, `name`, `bir`) VALUES
    ('C0000003', '王五', '1982-02-10');
INSERT INTO `counselor` (`id`, `name`, `bir`) VALUES
    ('C0000004', '赵六', '1978-11-30');
INSERT INTO `counselor` (`id`, `name`, `bir`) VALUES
    ('C0000005', '刘七', '1985-07-08');

INSERT INTO `classroom` (`building_name`, `room_number`, `campus_id`, `type`, `seat_num`, `area`) VALUES
    ('主教学楼', '101', 1, 1, 50, 100);
INSERT INTO `classroom` (`building_name`, `room_number`, `campus_id`, `type`, `seat_num`, `area`) VALUES
    ('科技楼', '201', 2, 2, 40, 80);
INSERT INTO `classroom` (`building_name`, `room_number`, `campus_id`, `type`, `seat_num`, `area`) VALUES
    ('实验楼', '301', 3, 3, 30, 60);
INSERT INTO `classroom` (`building_name`, `room_number`, `campus_id`, `type`, `seat_num`, `area`) VALUES
    ('图书馆', '401', 4, 4, 80, 150);
INSERT INTO `classroom` (`building_name`, `room_number`, `campus_id`, `type`, `seat_num`, `area`) VALUES
    ('主教学楼', '102', 1, 2, 45, 95);
INSERT INTO `classroom` (`building_name`, `room_number`, `campus_id`, `type`, `seat_num`, `area`) VALUES
    ('科技楼', '202', 2, 3, 35, 70);
INSERT INTO `classroom` (`building_name`, `room_number`, `campus_id`, `type`, `seat_num`, `area`) VALUES
    ('实验楼', '302', 3, 4, 25, 50);
INSERT INTO `classroom` (`building_name`, `room_number`, `campus_id`, `type`, `seat_num`, `area`) VALUES
    ('图书馆', '402', 4, 1, 75, 140);
INSERT INTO `classroom` (`building_name`, `room_number`, `campus_id`, `type`, `seat_num`, `area`) VALUES
    ('行政楼', '502', 1, 3, 55, 105);
INSERT INTO `classroom` (`building_name`, `room_number`, `campus_id`, `type`, `seat_num`, `area`) VALUES
    ('主教学楼', '103', 1, 1, 50, 100);
INSERT INTO `classroom` (`building_name`, `room_number`, `campus_id`, `type`, `seat_num`, `area`) VALUES
    ('科技楼', '203', 2, 2, 40, 80);
INSERT INTO `classroom` (`building_name`, `room_number`, `campus_id`, `type`, `seat_num`, `area`) VALUES
    ('实验楼', '303', 3, 3, 30, 60);
INSERT INTO `classroom` (`building_name`, `room_number`, `campus_id`, `type`, `seat_num`, `area`) VALUES
    ('图书馆', '403', 4, 4, 80, 150);
INSERT INTO `classroom` (`building_name`, `room_number`, `campus_id`, `type`, `seat_num`, `area`) VALUES
    ('主教学楼', '104', 1, 2, 45, 95);
INSERT INTO `classroom` (`building_name`, `room_number`, `campus_id`, `type`, `seat_num`, `area`) VALUES
    ('科技楼', '204', 2, 3, 35, 70);
INSERT INTO `classroom` (`building_name`, `room_number`, `campus_id`, `type`, `seat_num`, `area`) VALUES
    ('实验楼', '304', 3, 4, 25, 50);
INSERT INTO `classroom` (`building_name`, `room_number`, `campus_id`, `type`, `seat_num`, `area`) VALUES
    ('图书馆', '404', 4, 1, 75, 140);
INSERT INTO `classroom` (`building_name`, `room_number`, `campus_id`, `type`, `seat_num`, `area`) VALUES
    ('行政楼', '503', 1, 3, 55, 105);
INSERT INTO `classroom` (`building_name`, `room_number`, `campus_id`, `type`, `seat_num`, `area`) VALUES
    ('主教学楼', '105', 1, 1, 50, 100);
INSERT INTO `classroom` (`building_name`, `room_number`, `campus_id`, `type`, `seat_num`, `area`) VALUES
    ('科技楼', '205', 2, 2, 40, 80);
INSERT INTO `classroom` (`building_name`, `room_number`, `campus_id`, `type`, `seat_num`, `area`) VALUES
    ('实验楼', '305', 3, 3, 30, 60);
INSERT INTO `classroom` (`building_name`, `room_number`, `campus_id`, `type`, `seat_num`, `area`) VALUES
    ('图书馆', '405', 4, 4, 80, 150);
INSERT INTO `classroom` (`building_name`, `room_number`, `campus_id`, `type`, `seat_num`, `area`) VALUES
    ('主教学楼', '106', 1, 2, 45, 95);
INSERT INTO `classroom` (`building_name`, `room_number`, `campus_id`, `type`, `seat_num`, `area`) VALUES
    ('科技楼', '206', 2, 3, 35, 70);
INSERT INTO `classroom` (`building_name`, `room_number`, `campus_id`, `type`, `seat_num`, `area`) VALUES
    ('实验楼', '306', 3, 4, 25, 50);
INSERT INTO `classroom` (`building_name`, `room_number`, `campus_id`, `type`, `seat_num`, `area`) VALUES
    ('图书馆', '406', 4, 1, 75, 140);
INSERT INTO `classroom` (`building_name`, `room_number`, `campus_id`, `type`, `seat_num`, `area`) VALUES
    ('行政楼', '504', 1, 3, 55, 105);
INSERT INTO `classroom` (`building_name`, `room_number`, `campus_id`, `type`, `seat_num`, `area`) VALUES
    ('主教学楼', '107', 1, 1, 50, 100);
INSERT INTO `classroom` (`building_name`, `room_number`, `campus_id`, `type`, `seat_num`, `area`) VALUES
    ('科技楼', '207', 2, 2, 40, 80);
INSERT INTO `classroom` (`building_name`, `room_number`, `campus_id`, `type`, `seat_num`, `area`) VALUES
    ('实验楼', '307', 3, 3, 30, 60);
INSERT INTO `classroom` (`building_name`, `room_number`, `campus_id`, `type`, `seat_num`, `area`) VALUES
    ('图书馆', '407', 4, 4, 80, 150);
INSERT INTO `classroom` (`building_name`, `room_number`, `campus_id`, `type`, `seat_num`, `area`) VALUES
    ('行政楼', '505', 1, 1, 60, 110);
INSERT INTO `classroom` (`building_name`, `room_number`, `campus_id`, `type`, `seat_num`, `area`) VALUES
    ('主教学楼', '108', 1, 2, 45, 95);
INSERT INTO `classroom` (`building_name`, `room_number`, `campus_id`, `type`, `seat_num`, `area`) VALUES
    ('科技楼', '208', 2, 3, 35, 70);
INSERT INTO `classroom` (`building_name`, `room_number`, `campus_id`, `type`, `seat_num`, `area`) VALUES
    ('实验楼', '308', 3, 4, 25, 50);
INSERT INTO `classroom` (`building_name`, `room_number`, `campus_id`, `type`, `seat_num`, `area`) VALUES
    ('图书馆', '408', 4, 1, 75, 140);
INSERT INTO `classroom` (`building_name`, `room_number`, `campus_id`, `type`, `seat_num`, `area`) VALUES
    ('行政楼', '506', 1, 3, 55, 105);
INSERT INTO `classroom` (`building_name`, `room_number`, `campus_id`, `type`, `seat_num`, `area`) VALUES
    ('主教学楼', '109', 1, 1, 50, 100);
INSERT INTO `classroom` (`building_name`, `room_number`, `campus_id`, `type`, `seat_num`, `area`) VALUES
    ('科技楼', '209', 2, 2, 40, 80);
INSERT INTO `classroom` (`building_name`, `room_number`, `campus_id`, `type`, `seat_num`, `area`) VALUES
    ('实验楼', '309', 3, 3, 30, 60);
INSERT INTO `classroom` (`building_name`, `room_number`, `campus_id`, `type`, `seat_num`, `area`) VALUES
    ('图书馆', '409', 4, 4, 80, 150);
INSERT INTO `classroom` (`building_name`, `room_number`, `campus_id`, `type`, `seat_num`, `area`) VALUES
    ('行政楼', '507', 1, 1, 60, 110);
INSERT INTO `classroom` (`building_name`, `room_number`, `campus_id`, `type`, `seat_num`, `area`) VALUES
    ('主教学楼', '110', 1, 2, 45, 95);
INSERT INTO `classroom` (`building_name`, `room_number`, `campus_id`, `type`, `seat_num`, `area`) VALUES
    ('科技楼', '210', 2, 3, 35, 70);
INSERT INTO `classroom` (`building_name`, `room_number`, `campus_id`, `type`, `seat_num`, `area`) VALUES
    ('实验楼', '310', 3, 4, 25, 50);
INSERT INTO `classroom` (`building_name`, `room_number`, `campus_id`, `type`, `seat_num`, `area`) VALUES
    ('图书馆', '410', 4, 1, 75, 140);
INSERT INTO `classroom` (`building_name`, `room_number`, `campus_id`, `type`, `seat_num`, `area`) VALUES
    ('行政楼', '508', 1, 3, 55, 105);
INSERT INTO `classroom` (`building_name`, `room_number`, `campus_id`, `type`, `seat_num`, `area`) VALUES
    ('主教学楼', '111', 1, 1, 50, 100);
INSERT INTO `classroom` (`building_name`, `room_number`, `campus_id`, `type`, `seat_num`, `area`) VALUES
    ('科技楼', '211', 2, 2, 40, 80);
INSERT INTO `classroom` (`building_name`, `room_number`, `campus_id`, `type`, `seat_num`, `area`) VALUES
    ('实验楼', '311', 3, 3, 30, 60);
INSERT INTO `classroom` (`building_name`, `room_number`, `campus_id`, `type`, `seat_num`, `area`) VALUES
    ('图书馆', '411', 4, 4, 80, 150);
INSERT INTO `classroom` (`building_name`, `room_number`, `campus_id`, `type`, `seat_num`, `area`) VALUES
    ('行政楼', '509', 1, 1, 60, 110);
INSERT INTO `classroom` (`building_name`, `room_number`, `campus_id`, `type`, `seat_num`, `area`) VALUES
    ('主教学楼', '112', 1, 2, 45, 95);
INSERT INTO `classroom` (`building_name`, `room_number`, `campus_id`, `type`, `seat_num`, `area`) VALUES
    ('科技楼', '212', 2, 3, 35, 70);
INSERT INTO `classroom` (`building_name`, `room_number`, `campus_id`, `type`, `seat_num`, `area`) VALUES
    ('实验楼', '312', 3, 4, 25, 50);
INSERT INTO `classroom` (`building_name`, `room_number`, `campus_id`, `type`, `seat_num`, `area`) VALUES
    ('图书馆', '412', 4, 1, 75, 140);
INSERT INTO `classroom` (`building_name`, `room_number`, `campus_id`, `type`, `seat_num`, `area`) VALUES
    ('行政楼', '510', 1, 3, 55, 105);


-- 插入数据到 class 表中
INSERT INTO `class` (`name`, `major_id`, `fe_stu_num`, `male_stu_num`, `counselor_id`, `campus_id`, `start_year`)
VALUES
    ('电信2201', 2, 30, 20, 'C0000001', 1, 2022),
    ('电信2202', 2, 25, 25, 'C0000001', 2, 2022),
    ('电信2203', 2, 20, 30, 'C0000001', 3, 2022),
    ('电信2204', 2, 35, 15, 'C0000001', 4, 2022),
    ('电信2205', 2, 28, 22, 'C0000001', 1, 2022),

    ('机械2001', 3, 27, 23, 'C0000002', 2, 2020),
    ('机械2002', 3, 24, 26, 'C0000002', 3, 2020),
    ('机械2003', 3, 22, 28, 'C0000002', 4, 2020),
    ('机械2004', 3, 33, 17, 'C0000002', 1, 2020),
    ('机械2005', 3, 26, 24, 'C0000002', 2, 2020),

    ('计科2101', 1, 31, 19, 'C0000003', 3, 2021),
    ('计科2102', 1, 29, 21, 'C0000003', 4, 2021),
    ('计科2103', 1, 23, 27, 'C0000003', 1, 2021),
    ('计科2104', 1, 32, 18, 'C0000003', 2, 2021),
    ('计科2105', 1, 30, 20, 'C0000003', 3, 2021),

    ('经济管理2201', 4, 28, 22, 'C0000004', 4, 2022),
    ('经济管理2202', 4, 27, 23, 'C0000004', 1, 2022),
    ('经济管理2203', 4, 26, 24, 'C0000004', 2, 2022),
    ('经济管理2204', 4, 29, 21, 'C0000004', 3, 2022),
    ('经济管理2205', 4, 30, 20, 'C0000004', 4, 2022);

INSERT INTO `class` (`name`, `major_id`, `fe_stu_num`, `male_stu_num`, `counselor_id`, `campus_id`, `start_year`)
VALUES
    ('法学2201', 5, 30, 20, 'C0000004', 2, 2022),
    ('法学2202', 5, 25, 25, 'C0000004', 3, 2022),
    ('法学2203', 5, 20, 30, 'C0000004', 4, 2022),
    ('法学2204', 5, 35, 15, 'C0000004', 1, 2022),
    ('法学2205', 5, 28, 22, 'C0000004', 2, 2022),
    ('生物医学2201', 6, 30, 20, 'C0000005', 1, 2023),
    ('生物医学2202', 6, 25, 25, 'C0000005', 2, 2023),
    ('生物医学2203', 6, 20, 30, 'C0000005', 3, 2023),
    ('生物医学2204', 6, 35, 15, 'C0000005', 4, 2023),
    ('生物医学2205', 6, 28, 22, 'C0000005', 1, 2023);




