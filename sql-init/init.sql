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
	`teacher_id` char(8) NOT NULL,
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
	`stu_id` CHAR(10) NOT NULL,
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
	`stu_id` CHAR(10) NOT NULL,
	`credit_type` SMALLINT NOT NULL,
	-- 以0.1个学分为单位
	`credit_sum` SMALLINT NOT NULL COMMENT '以0.1个学分为单位',
	PRIMARY KEY(`id`)
);


CREATE TABLE `course_selection` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`stu_id` CHAR(10) NOT NULL,
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
	`stu_id` CHAR(10) NOT NULL,
	`grad_dest` SMALLINT,
	`dest` VARCHAR(255),
	`stu_situa` TEXT(65535),
	PRIMARY KEY(`cert_num`)
);


CREATE TABLE `chapter` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
    `parent` int,
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


INSERT INTO `course` (`id`, `name`, `course_type`, `course_cate`, `course_for`, `credit`, `grade_level`, `school_id`, `course_pic`)
VALUES
    ('C00000000000001', 'Introduction to Computer Science', FLOOR(1 + RAND() * 3), FLOOR(1 + RAND() * 5), 1, FLOOR(1 + RAND() * 5), FLOOR(1 + RAND() * 4), 1, NULL),
    ('C00000000000002', 'Calculus I', FLOOR(1 + RAND() * 3), FLOOR(1 + RAND() * 5), 1, FLOOR(1 + RAND() * 5), FLOOR(1 + RAND() * 4), 1, NULL),
    ('C00000000000003', 'Physics I', FLOOR(1 + RAND() * 3), FLOOR(1 + RAND() * 5), 1, FLOOR(1 + RAND() * 5), FLOOR(1 + RAND() * 4), 1, NULL),
    ('C00000000000004', 'Chemistry I', FLOOR(1 + RAND() * 3), FLOOR(1 + RAND() * 5), 1, FLOOR(1 + RAND() * 5), FLOOR(1 + RAND() * 4), 1, NULL),
    ('C00000000000005', 'Biology I', FLOOR(1 + RAND() * 3), FLOOR(1 + RAND() * 5), 2, FLOOR(1 + RAND() * 5), FLOOR(1 + RAND() * 4), 2, NULL),
    ('C00000000000006', 'Introduction to Psychology', FLOOR(1 + RAND() * 3), FLOOR(1 + RAND() * 5), 2, FLOOR(1 + RAND() * 5), FLOOR(1 + RAND() * 4), 2, NULL),
    ('C00000000000007', 'World History', FLOOR(1 + RAND() * 3), FLOOR(1 + RAND() * 5), 2, FLOOR(1 + RAND() * 5), FLOOR(1 + RAND() * 4), 2, NULL),
    ('C00000000000008', 'English Literature', FLOOR(1 + RAND() * 3), FLOOR(1 + RAND() * 5), 2, FLOOR(1 + RAND() * 5), FLOOR(1 + RAND() * 4), 2, NULL),
    ('C00000000000009', 'Art Appreciation', FLOOR(1 + RAND() * 3), FLOOR(1 + RAND() * 5), 3, FLOOR(1 + RAND() * 5), FLOOR(1 + RAND() * 4), 3, NULL),
    ('C00000000000010', 'Music Theory', FLOOR(1 + RAND() * 3), FLOOR(1 + RAND() * 5), 3, FLOOR(1 + RAND() * 5), FLOOR(1 + RAND() * 4), 3, NULL),
    ('C00000000000011', 'Statistics', FLOOR(1 + RAND() * 3), FLOOR(1 + RAND() * 5), 3, FLOOR(1 + RAND() * 5), FLOOR(1 + RAND() * 4), 3, NULL),
    ('C00000000000012', 'Discrete Mathematics', FLOOR(1 + RAND() * 3), FLOOR(1 + RAND() * 5), 3, FLOOR(1 + RAND() * 5), FLOOR(1 + RAND() * 4), 3, NULL),
    ('C00000000000013', 'Microeconomics', FLOOR(1 + RAND() * 3), FLOOR(1 + RAND() * 5), 4, FLOOR(1 + RAND() * 5), FLOOR(1 + RAND() * 4), 4, NULL),
    ('C00000000000014', 'Macroeconomics', FLOOR(1 + RAND() * 3), FLOOR(1 + RAND() * 5), 4, FLOOR(1 + RAND() * 5), FLOOR(1 + RAND() * 4), 4, NULL),
    ('C00000000000015', 'Business Management', FLOOR(1 + RAND() * 3), FLOOR(1 + RAND() * 5), 4, FLOOR(1 + RAND() * 5), FLOOR(1 + RAND() * 4), 4, NULL),
    ('C00000000000016', 'Marketing Principles', FLOOR(1 + RAND() * 3), FLOOR(1 + RAND() * 5), 4, FLOOR(1 + RAND() * 5), FLOOR(1 + RAND() * 4), 4, NULL),
    ('C00000000000017', 'Computer Networks', FLOOR(1 + RAND() * 3), FLOOR(1 + RAND() * 5), 5, FLOOR(1 + RAND() * 5), FLOOR(1 + RAND() * 4), 6, NULL),
    ('C00000000000018', 'Database Systems', FLOOR(1 + RAND() * 3), FLOOR(1 + RAND() * 5), 5, FLOOR(1 + RAND() * 5), FLOOR(1 + RAND() * 4), 6, NULL),
    ('C00000000000019', 'Software Engineering', FLOOR(1 + RAND() * 3), FLOOR(1 + RAND() * 5), 5, FLOOR(1 + RAND() * 5), FLOOR(1 + RAND() * 4), 6, NULL),
    ('C00000000000020', 'Artificial Intelligence', FLOOR(1 + RAND() * 3), FLOOR(1 + RAND() * 5), 5, FLOOR(1 + RAND() * 5), FLOOR(1 + RAND() * 4), 6, NULL),
    ('C00000000000021', 'Operating Systems', FLOOR(1 + RAND() * 3), FLOOR(1 + RAND() * 5), 6, FLOOR(1 + RAND() * 5), FLOOR(1 + RAND() * 4), 8, NULL),
    ('C00000000000022', 'Data Structures', FLOOR(1 + RAND() * 3), FLOOR(1 + RAND() * 5), 6, FLOOR(1 + RAND() * 5), FLOOR(1 + RAND() * 4), 8, NULL),
    ('C00000000000023', 'Algorithms', FLOOR(1 + RAND() * 3), FLOOR(1 + RAND() * 5), 6, FLOOR(1 + RAND() * 5), FLOOR(1 + RAND() * 4), 8, NULL),
    ('C00000000000024', 'Linear Algebra', FLOOR(1 + RAND() * 3), FLOOR(1 + RAND() * 5), 6, FLOOR(1 + RAND() * 5), FLOOR(1 + RAND() * 4), 8, NULL),
    ('C00000000000025', 'Differential Equations', FLOOR(1 + RAND() * 3), FLOOR(1 + RAND() * 5), 7, FLOOR(1 + RAND() * 5), FLOOR(1 + RAND() * 4), 4, NULL),
    ('C00000000000026', 'Environmental Science', FLOOR(1 + RAND() * 3), FLOOR(1 + RAND() * 5), 7, FLOOR(1 + RAND() * 5), FLOOR(1 + RAND() * 4), 4, NULL),
    ('C00000000000027', 'Geography', FLOOR(1 + RAND() * 3), FLOOR(1 + RAND() * 5), 7, FLOOR(1 + RAND() * 5), FLOOR(1 + RAND() * 4), 4, NULL),
    ('C00000000000028', 'Philosophy', FLOOR(1 + RAND() * 3), FLOOR(1 + RAND() * 5), 7, FLOOR(1 + RAND() * 5), FLOOR(1 + RAND() * 4), 4, NULL),
    ('C00000000000029', 'Political Science', FLOOR(1 + RAND() * 3), FLOOR(1 + RAND() * 5), 8, FLOOR(1 + RAND() * 5), FLOOR(1 + RAND() * 4), 9, NULL),
    ('C00000000000030', 'Sociology', FLOOR(1 + RAND() * 3), FLOOR(1 + RAND() * 5), 8, FLOOR(1 + RAND() * 5), FLOOR(1 + RAND() * 4), 9, NULL),
    ('C00000000000031', 'Anthropology', FLOOR(1 + RAND() * 3), FLOOR(1 + RAND() * 5), 8, FLOOR(1 + RAND() * 5), FLOOR(1 + RAND() * 4), 9, NULL),
    ('C00000000000032', 'Public Speaking', FLOOR(1 + RAND() * 3), FLOOR(1 + RAND() * 5), 8, FLOOR(1 + RAND() * 5), FLOOR(1 + RAND() * 4), 9, NULL),
    ('C00000000000033', 'Creative Writing', FLOOR(1 + RAND() * 3), FLOOR(1 + RAND() * 5), 9, FLOOR(1 + RAND() * 5), FLOOR(1 + RAND() * 4), 7, NULL),
    ('C00000000000034', 'Journalism', FLOOR(1 + RAND() * 3), FLOOR(1 + RAND() * 5), 9, FLOOR(1 + RAND() * 5), FLOOR(1 + RAND() * 4), 7, NULL),
    ('C00000000000035', 'Photography', FLOOR(1 + RAND() * 3), FLOOR(1 + RAND() * 5), 9, FLOOR(1 + RAND() * 5), FLOOR(1 + RAND() * 4), 7, NULL),
    ('C00000000000036', 'Film Studies', FLOOR(1 + RAND() * 3), FLOOR(1 + RAND() * 5), 9, FLOOR(1 + RAND() * 5), FLOOR(1 + RAND() * 4), 7, NULL),
    ('C00000000000037', 'Graphic Design', FLOOR(1 + RAND() * 3), FLOOR(1 + RAND() * 5), 10, FLOOR(1 + RAND() * 5), FLOOR(1 + RAND() * 4), 10, NULL),
    ('C00000000000038', 'Web Development', FLOOR(1 + RAND() * 3), FLOOR(1 + RAND() * 5), 10, FLOOR(1 + RAND() * 5), FLOOR(1 + RAND() * 4), 10, NULL),
    ('C00000000000039', 'Mobile App Development', FLOOR(1 + RAND() * 3), FLOOR(1 + RAND() * 5), 10, FLOOR(1 + RAND() * 5), FLOOR(1 + RAND() * 4), 10, NULL),
    ('C00000000000040', 'Cybersecurity', FLOOR(1 + RAND() * 3), FLOOR(1 + RAND() * 5), 10, FLOOR(1 + RAND() * 5), FLOOR(1 + RAND() * 4), 10, NULL);

INSERT INTO `course_inst` (`course_id`, `year`, `term_part`, `assess_method`, `method_detal`, `total_class_hour`, `max_num`)
VALUES
    ('C00000000000001', 2020, TRUE, 1, '机试', FLOOR(20 + RAND() * 30), FLOOR(20 + RAND() * 40)),
    ('C00000000000002', 2020, FALSE, 2, '笔试', FLOOR(20 + RAND() * 30), FLOOR(20 + RAND() * 40)),
    ('C00000000000003', 2020, TRUE, 1, '机试', FLOOR(20 + RAND() * 30), FLOOR(20 + RAND() * 40)),
    ('C00000000000004', 2020, FALSE, 2, '笔试', FLOOR(20 + RAND() * 30), FLOOR(20 + RAND() * 40)),
    ('C00000000000005', 2020, TRUE, 1, '机试', FLOOR(20 + RAND() * 30), FLOOR(20 + RAND() * 40)),
    ('C00000000000006', 2020, FALSE, 2, '笔试', FLOOR(20 + RAND() * 30), FLOOR(20 + RAND() * 40)),
    ('C00000000000007', 2020, TRUE, 1, '机试', FLOOR(20 + RAND() * 30), FLOOR(20 + RAND() * 40)),
    ('C00000000000008', 2021, FALSE, 2, '笔试', FLOOR(20 + RAND() * 30), FLOOR(20 + RAND() * 40)),
    ('C00000000000009', 2021, TRUE, 1, '机试', FLOOR(20 + RAND() * 30), FLOOR(20 + RAND() * 40)),
    ('C00000000000010', 2021, FALSE, 2, '笔试', FLOOR(20 + RAND() * 30), FLOOR(20 + RAND() * 40)),
    ('C00000000000011', 2021, TRUE, 1, '机试', FLOOR(20 + RAND() * 30), FLOOR(20 + RAND() * 40)),
    ('C00000000000012', 2021, FALSE, 2, '笔试', FLOOR(20 + RAND() * 30), FLOOR(20 + RAND() * 40)),
    ('C00000000000013', 2021, TRUE, 1, '机试', FLOOR(20 + RAND() * 30), FLOOR(20 + RAND() * 40)),
    ('C00000000000014', 2022, FALSE, 2, '笔试', FLOOR(20 + RAND() * 30), FLOOR(20 + RAND() * 40)),
    ('C00000000000015', 2022, TRUE, 1, '机试', FLOOR(20 + RAND() * 30), FLOOR(20 + RAND() * 40)),
    ('C00000000000016', 2022, FALSE, 2, '笔试', FLOOR(20 + RAND() * 30), FLOOR(20 + RAND() * 40)),
    ('C00000000000017', 2022, TRUE, 1, '机试', FLOOR(20 + RAND() * 30), FLOOR(20 + RAND() * 40)),
    ('C00000000000018', 2022, FALSE, 2, '笔试', FLOOR(20 + RAND() * 30), FLOOR(20 + RAND() * 40)),
    ('C00000000000019', 2022, TRUE, 1, '机试', FLOOR(20 + RAND() * 30), FLOOR(20 + RAND() * 40)),
    ('C00000000000020', 2022, FALSE, 2, '笔试', FLOOR(20 + RAND() * 30), FLOOR(20 + RAND() * 40)),
    ('C00000000000021', 2022, TRUE, 1, '机试', FLOOR(20 + RAND() * 30), FLOOR(20 + RAND() * 40)),
    ('C00000000000022', 2022, FALSE, 2, '笔试', FLOOR(20 + RAND() * 30), FLOOR(20 + RAND() * 40)),
    ('C00000000000023', 2022, TRUE, 1, '机试', FLOOR(20 + RAND() * 30), FLOOR(20 + RAND() * 40)),
    ('C00000000000024', 2022, FALSE, 2, '笔试', FLOOR(20 + RAND() * 30), FLOOR(20 + RAND() * 40)),
    ('C00000000000025', 2023, TRUE, 1, '机试', FLOOR(20 + RAND() * 30), FLOOR(20 + RAND() * 40)),
    ('C00000000000026', 2023, FALSE, 2, '笔试', FLOOR(20 + RAND() * 30), FLOOR(20 + RAND() * 40)),
    ('C00000000000027', 2023, TRUE, 1, '机试', FLOOR(20 + RAND() * 30), FLOOR(20 + RAND() * 40)),
    ('C00000000000028', 2023, FALSE, 2, '笔试', FLOOR(20 + RAND() * 30), FLOOR(20 + RAND() * 40)),
    ('C00000000000029', 2023, TRUE, 1, '机试', FLOOR(20 + RAND() * 30), FLOOR(20 + RAND() * 40)),
    ('C00000000000030', 2023, FALSE, 2, '笔试', FLOOR(20 + RAND() * 30), FLOOR(20 + RAND() * 40)),
    ('C00000000000031', 2023, TRUE, 1, '机试', FLOOR(20 + RAND() * 30), FLOOR(20 + RAND() * 40)),
    ('C00000000000032', 2023, FALSE, 2, '笔试', FLOOR(20 + RAND() * 30), FLOOR(20 + RAND() * 40)),
    ('C00000000000033', 2024, TRUE, 1, '机试', FLOOR(20 + RAND() * 30), FLOOR(20 + RAND() * 40)),
    ('C00000000000034', 2024, FALSE, 2, '笔试', FLOOR(20 + RAND() * 30), FLOOR(20 + RAND() * 40)),
    ('C00000000000035', 2024, TRUE, 1, '机试', FLOOR(20 + RAND() * 30), FLOOR(20 + RAND() * 40)),
    ('C00000000000036', 2024, FALSE, 2, '笔试', FLOOR(20 + RAND() * 30), FLOOR(20 + RAND() * 40)),
    ('C00000000000037', 2024, TRUE, 1, '机试', FLOOR(20 + RAND() * 30), FLOOR(20 + RAND() * 40)),
    ('C00000000000038', 2024, FALSE, 2, '笔试', FLOOR(20 + RAND() * 30), FLOOR(20 + RAND() * 40)),
    ('C00000000000039', 2024, TRUE, 1, '机试', FLOOR(20 + RAND() * 30), FLOOR(20 + RAND() * 40)),
    ('C00000000000040', 2024, FALSE, 2, '笔试', FLOOR(20 + RAND() * 30), FLOOR(20 + RAND() * 40));


INSERT INTO `course_inst_section` (`course_inst_id`, `name`)
VALUES
    (1, IF(RAND() > 0.5, '123班', '456班')),
    (2, IF(RAND() > 0.5, '123班', '456班')),
    (3, IF(RAND() > 0.5, '123班', '456班')),
    (4, IF(RAND() > 0.5, '123班', '456班')),
    (5, IF(RAND() > 0.5, '123班', '456班')),
    (6, IF(RAND() > 0.5, '123班', '456班')),
    (7, IF(RAND() > 0.5, '123班', '456班')),
    (8, IF(RAND() > 0.5, '123班', '456班')),
    (9, IF(RAND() > 0.5, '123班', '456班')),
    (10, IF(RAND() > 0.5, '123班', '456班')),
    (11, IF(RAND() > 0.5, '123班', '456班')),
    (12, IF(RAND() > 0.5, '123班', '456班')),
    (13, IF(RAND() > 0.5, '123班', '456班')),
    (14, IF(RAND() > 0.5, '123班', '456班')),
    (15, IF(RAND() > 0.5, '123班', '456班')),
    (16, IF(RAND() > 0.5, '123班', '456班')),
    (17, IF(RAND() > 0.5, '123班', '456班')),
    (18, IF(RAND() > 0.5, '123班', '456班')),
    (19, IF(RAND() > 0.5, '123班', '456班')),
    (20, IF(RAND() > 0.5, '123班', '456班')),
    (21, IF(RAND() > 0.5, '123班', '456班')),
    (22, IF(RAND() > 0.5, '123班', '456班')),
    (23, IF(RAND() > 0.5, '123班', '456班')),
    (24, IF(RAND() > 0.5, '123班', '456班')),
    (25, IF(RAND() > 0.5, '123班', '456班')),
    (26, IF(RAND() > 0.5, '123班', '456班')),
    (27, IF(RAND() > 0.5, '123班', '456班')),
    (28, IF(RAND() > 0.5, '123班', '456班')),
    (29, IF(RAND() > 0.5, '123班', '456班')),
    (30, IF(RAND() > 0.5, '123班', '456班')),
    (31, IF(RAND() > 0.5, '123班', '456班')),
    (32, IF(RAND() > 0.5, '123班', '456班')),
    (33, IF(RAND() > 0.5, '123班', '456班')),
    (34, IF(RAND() > 0.5, '123班', '456班')),
    (35, IF(RAND() > 0.5, '123班', '456班')),
    (36, IF(RAND() > 0.5, '123班', '456班')),
    (37, IF(RAND() > 0.5, '123班', '456班')),
    (38, IF(RAND() > 0.5, '123班', '456班')),
    (39, IF(RAND() > 0.5, '123班', '456班')),
    (40, IF(RAND() > 0.5, '123班', '456班'));

insert into file(url, size, hash) values('http://8.130.106.248:9000/system/123.jpg',1,'123');

INSERT INTO `student` (`id`, `name`, `major_id`, `now_level`, `class_id`, `gender`, `stu_pic`, `phone_number`, `birthday`, `identity`, `address`) VALUES
                                                                                                                                                      ('S000000001', '秦且', 5, 2, 25, True, 1, '13878429564', '2000-01-01', '123456291945851234', '北京市某区某街道'),
                                                                                                                                                      ('S000000002', '谈刚', 5, 2, 22, True, 1, '13883053825', '2000-01-01', '123456256952681234', '北京市某区某街道'),
                                                                                                                                                      ('S000000003', '皮香', 3, 4, 6, False, 1, '13892994307', '2000-01-01', '123456286417591234', '北京市某区某街道'),
                                                                                                                                                      ('S000000004', '穆迷', 1, 3, 14, False, 1, '13830358464', '2000-01-01', '123456141115311234', '北京市某区某街道'),
                                                                                                                                                      ('S000000005', '卜丈', 1, 3, 15, True, 1, '13898491412', '2000-01-01', '123456446312921234', '北京市某区某街道'),
                                                                                                                                                      ('S000000006', '平草', 5, 2, 23, True, 1, '13887313803', '2000-01-01', '123456572218731234', '北京市某区某街道'),
                                                                                                                                                      ('S000000007', '苗松', 3, 4, 7, False, 1, '13891181548', '2000-01-01', '123456757383611234', '北京市某区某街道'),
                                                                                                                                                      ('S000000008', '柳蜖', 1, 3, 15, True, 1, '13890588409', '2000-01-01', '123456611642411234', '北京市某区某街道'),
                                                                                                                                                      ('S000000009', '禹戴', 3, 4, 6, False, 1, '13828906065', '2000-01-01', '123456714376101234', '北京市某区某街道'),
                                                                                                                                                      ('S000000010', '时托', 1, 3, 13, False, 1, '13829174232', '2000-01-01', '123456814719361234', '北京市某区某街道'),
                                                                                                                                                      ('S000000011', '臧念', 6, 1, 26, False, 1, '13888262727', '2000-01-01', '123456338720351234', '北京市某区某街道'),
                                                                                                                                                      ('S000000012', '苏球', 4, 2, 17, False, 1, '13822593895', '2000-01-01', '123456647409581234', '北京市某区某街道'),
                                                                                                                                                      ('S000000013', '戴升', 6, 1, 30, True, 1, '13864168477', '2000-01-01', '123456848885661234', '北京市某区某街道'),
                                                                                                                                                      ('S000000014', '酆汽', 3, 4, 8, True, 1, '13826366785', '2000-01-01', '123456377913871234', '北京市某区某街道'),
                                                                                                                                                      ('S000000015', '曹万', 4, 2, 16, False, 1, '13828590114', '2000-01-01', '123456481701491234', '北京市某区某街道'),
                                                                                                                                                      ('S000000016', '钱些', 2, 2, 4, True, 1, '13885047613', '2000-01-01', '123456977852681234', '北京市某区某街道'),
                                                                                                                                                      ('S000000017', '柏信', 3, 4, 9, False, 1, '13888722925', '2000-01-01', '123456115140251234', '北京市某区某街道'),
                                                                                                                                                      ('S000000018', '华晚', 1, 3, 14, False, 1, '13830107602', '2000-01-01', '123456330323321234', '北京市某区某街道'),
                                                                                                                                                      ('S000000019', '朱及', 6, 1, 30, False, 1, '13830905469', '2000-01-01', '123456261433641234', '北京市某区某街道'),
                                                                                                                                                      ('S000000020', '庞谢', 1, 3, 12, True, 1, '13814058852', '2000-01-01', '123456593436311234', '北京市某区某街道'),
                                                                                                                                                      ('S000000021', '钱犯', 1, 3, 13, True, 1, '13854058875', '2000-01-01', '123456809058501234', '北京市某区某街道'),
                                                                                                                                                      ('S000000022', '孟两', 4, 2, 19, True, 1, '13855414071', '2000-01-01', '123456567091051234', '北京市某区某街道'),
                                                                                                                                                      ('S000000023', '余卖', 6, 1, 28, True, 1, '13847765850', '2000-01-01', '123456144855151234', '北京市某区某街道'),
                                                                                                                                                      ('S000000024', '贺阵', 4, 2, 17, True, 1, '13892204777', '2000-01-01', '123456526737341234', '北京市某区某街道'),
                                                                                                                                                      ('S000000025', '赵毫', 1, 3, 14, False, 1, '13849179787', '2000-01-01', '123456180111821234', '北京市某区某街道'),
                                                                                                                                                      ('S000000026', '雷卖', 2, 2, 3, False, 1, '13825093336', '2000-01-01', '123456335437651234', '北京市某区某街道'),
                                                                                                                                                      ('S000000027', '茅勒', 1, 3, 15, True, 1, '13840012396', '2000-01-01', '123456950946971234', '北京市某区某街道'),
                                                                                                                                                      ('S000000028', '项临', 1, 3, 14, False, 1, '13865667757', '2000-01-01', '123456280015151234', '北京市某区某街道'),
                                                                                                                                                      ('S000000029', '韩如', 6, 1, 30, True, 1, '13896747862', '2000-01-01', '123456853950001234', '北京市某区某街道'),
                                                                                                                                                      ('S000000030', '苏谁', 6, 1, 29, True, 1, '13848706325', '2000-01-01', '123456566115931234', '北京市某区某街道'),
                                                                                                                                                      ('S000000031', '柏势', 5, 2, 25, False, 1, '13827624404', '2000-01-01', '123456261716161234', '北京市某区某街道'),
                                                                                                                                                      ('S000000032', '谢套', 6, 1, 28, False, 1, '13838567230', '2000-01-01', '123456881772601234', '北京市某区某街道'),
                                                                                                                                                      ('S000000033', '屈乐', 3, 4, 10, True, 1, '13862524675', '2000-01-01', '123456689176571234', '北京市某区某街道'),
                                                                                                                                                      ('S000000034', '宋误', 2, 2, 5, True, 1, '13899127895', '2000-01-01', '123456928332391234', '北京市某区某街道'),
                                                                                                                                                      ('S000000035', '费丝', 6, 1, 30, True, 1, '13833722825', '2000-01-01', '123456783395191234', '北京市某区某街道'),
                                                                                                                                                      ('S000000036', '鲁问', 2, 2, 3, True, 1, '13839932286', '2000-01-01', '123456969005141234', '北京市某区某街道'),
                                                                                                                                                      ('S000000037', '米满', 4, 2, 16, False, 1, '13891910120', '2000-01-01', '123456816998361234', '北京市某区某街道'),
                                                                                                                                                      ('S000000038', '时著', 5, 2, 23, False, 1, '13834755911', '2000-01-01', '123456387768831234', '北京市某区某街道'),
                                                                                                                                                      ('S000000039', '廉窢', 3, 4, 10, True, 1, '13839404699', '2000-01-01', '123456544243971234', '北京市某区某街道'),
                                                                                                                                                      ('S000000040', '安解', 5, 2, 24, True, 1, '13831214180', '2000-01-01', '123456869594441234', '北京市某区某街道'),
                                                                                                                                                      ('S000000041', '邬本', 5, 2, 21, True, 1, '13869817470', '2000-01-01', '123456645306031234', '北京市某区某街道'),
                                                                                                                                                      ('S000000042', '倪边', 1, 3, 13, True, 1, '13825490944', '2000-01-01', '123456953786411234', '北京市某区某街道'),
                                                                                                                                                      ('S000000043', '尹书', 4, 2, 20, False, 1, '13895843283', '2000-01-01', '123456888234701234', '北京市某区某街道'),
                                                                                                                                                      ('S000000044', '何况', 3, 4, 8, False, 1, '13817220841', '2000-01-01', '123456953738761234', '北京市某区某街道'),
                                                                                                                                                      ('S000000045', '尤走', 2, 2, 1, False, 1, '13870810793', '2000-01-01', '123456452586271234', '北京市某区某街道'),
                                                                                                                                                      ('S000000046', '梁见', 2, 2, 3, False, 1, '13895319096', '2000-01-01', '123456427288601234', '北京市某区某街道'),
                                                                                                                                                      ('S000000047', '项啊', 1, 3, 14, False, 1, '13863593625', '2000-01-01', '123456747643081234', '北京市某区某街道'),
                                                                                                                                                      ('S000000048', '周修', 3, 4, 7, False, 1, '13859068197', '2000-01-01', '123456195348081234', '北京市某区某街道'),
                                                                                                                                                      ('S000000049', '和校', 5, 2, 24, False, 1, '13813851032', '2000-01-01', '123456897126921234', '北京市某区某街道'),
                                                                                                                                                      ('S000000050', '金范', 4, 2, 18, True, 1, '13810668908', '2000-01-01', '123456585888681234', '北京市某区某街道'),
                                                                                                                                                      ('S000000051', '方校', 1, 3, 11, False, 1, '13830400983', '2000-01-01', '123456750028621234', '北京市某区某街道'),
                                                                                                                                                      ('S000000052', '康宫', 6, 1, 27, True, 1, '13832221751', '2000-01-01', '123456245408231234', '北京市某区某街道'),
                                                                                                                                                      ('S000000053', '方优', 6, 1, 26, False, 1, '13817741655', '2000-01-01', '123456720990681234', '北京市某区某街道'),
                                                                                                                                                      ('S000000054', '皮希', 4, 2, 16, True, 1, '13823055860', '2000-01-01', '123456711566471234', '北京市某区某街道'),
                                                                                                                                                      ('S000000055', '乐你', 1, 3, 12, True, 1, '13873365431', '2000-01-01', '123456646492991234', '北京市某区某街道'),
                                                                                                                                                      ('S000000056', '舒议', 6, 1, 28, False, 1, '13855686222', '2000-01-01', '123456170864561234', '北京市某区某街道'),
                                                                                                                                                      ('S000000057', '罗数', 1, 3, 15, True, 1, '13887136941', '2000-01-01', '123456816032071234', '北京市某区某街道'),
                                                                                                                                                      ('S000000058', '花康', 2, 2, 5, False, 1, '13861624785', '2000-01-01', '123456524012491234', '北京市某区某街道'),
                                                                                                                                                      ('S000000059', '赵副', 5, 2, 23, False, 1, '13868111341', '2000-01-01', '123456811269641234', '北京市某区某街道'),
                                                                                                                                                      ('S000000060', '姜火', 2, 2, 4, True, 1, '13866023510', '2000-01-01', '123456257667171234', '北京市某区某街道'),
                                                                                                                                                      ('S000000061', '平蜖', 5, 2, 21, False, 1, '13845710847', '2000-01-01', '123456562889611234', '北京市某区某街道'),
                                                                                                                                                      ('S000000062', '葛毫', 1, 3, 14, True, 1, '13845546607', '2000-01-01', '123456136801411234', '北京市某区某街道'),
                                                                                                                                                      ('S000000063', '华记', 6, 1, 26, True, 1, '13861585632', '2000-01-01', '123456292696211234', '北京市某区某街道'),
                                                                                                                                                      ('S000000064', '杨人', 2, 2, 1, False, 1, '13812101142', '2000-01-01', '123456131330011234', '北京市某区某街道'),
                                                                                                                                                      ('S000000065', '王始', 2, 2, 3, False, 1, '13859080857', '2000-01-01', '123456597282861234', '北京市某区某街道'),
                                                                                                                                                      ('S000000066', '郑数', 4, 2, 20, True, 1, '13846157714', '2000-01-01', '123456556733501234', '北京市某区某街道'),
                                                                                                                                                      ('S000000067', '何帝', 2, 2, 1, True, 1, '13844442803', '2000-01-01', '123456929197781234', '北京市某区某街道'),
                                                                                                                                                      ('S000000068', '郝资', 5, 2, 23, False, 1, '13868160315', '2000-01-01', '123456893598321234', '北京市某区某街道'),
                                                                                                                                                      ('S000000069', '费记', 2, 2, 1, True, 1, '13858021442', '2000-01-01', '123456606821621234', '北京市某区某街道'),
                                                                                                                                                      ('S000000070', '尤梦', 1, 3, 13, False, 1, '13889094688', '2000-01-01', '123456666647891234', '北京市某区某街道'),
                                                                                                                                                      ('S000000071', '熊会', 4, 2, 20, False, 1, '13846077904', '2000-01-01', '123456779219411234', '北京市某区某街道'),
                                                                                                                                                      ('S000000072', '凤整', 1, 3, 14, False, 1, '13870433028', '2000-01-01', '123456455894931234', '北京市某区某街道'),
                                                                                                                                                      ('S000000073', '薛步', 1, 3, 14, True, 1, '13842871193', '2000-01-01', '123456110964471234', '北京市某区某街道'),
                                                                                                                                                      ('S000000074', '沈迹', 4, 2, 16, False, 1, '13838320570', '2000-01-01', '123456710298441234', '北京市某区某街道'),
                                                                                                                                                      ('S000000075', '施声', 2, 2, 5, False, 1, '13867151455', '2000-01-01', '123456995850941234', '北京市某区某街道'),
                                                                                                                                                      ('S000000076', '臧善', 2, 2, 5, False, 1, '13814427490', '2000-01-01', '123456504671241234', '北京市某区某街道'),
                                                                                                                                                      ('S000000077', '周提', 1, 3, 11, True, 1, '13843427137', '2000-01-01', '123456751553041234', '北京市某区某街道'),
                                                                                                                                                      ('S000000078', '潘记', 6, 1, 27, True, 1, '13870772681', '2000-01-01', '123456938343861234', '北京市某区某街道'),
                                                                                                                                                      ('S000000079', '毛饭', 2, 2, 4, True, 1, '13866339100', '2000-01-01', '123456628005791234', '北京市某区某街道'),
                                                                                                                                                      ('S000000080', '明则', 3, 4, 7, True, 1, '13896354821', '2000-01-01', '123456643639051234', '北京市某区某街道'),
                                                                                                                                                      ('S000000081', '薛太', 4, 2, 20, False, 1, '13876430290', '2000-01-01', '123456428429451234', '北京市某区某街道'),
                                                                                                                                                      ('S000000082', '费及', 1, 3, 15, False, 1, '13894858163', '2000-01-01', '123456389109071234', '北京市某区某街道'),
                                                                                                                                                      ('S000000083', '尤求', 1, 3, 11, False, 1, '13865071465', '2000-01-01', '123456609702571234', '北京市某区某街道'),
                                                                                                                                                      ('S000000084', '俞剧', 4, 2, 16, False, 1, '13897791388', '2000-01-01', '123456975930451234', '北京市某区某街道'),
                                                                                                                                                      ('S000000085', '范历', 3, 4, 8, False, 1, '13853260686', '2000-01-01', '123456406420541234', '北京市某区某街道'),
                                                                                                                                                      ('S000000086', '沈创', 6, 1, 28, True, 1, '13896648905', '2000-01-01', '123456115494781234', '北京市某区某街道'),
                                                                                                                                                      ('S000000087', '尹熟', 6, 1, 28, False, 1, '13826991112', '2000-01-01', '123456170885711234', '北京市某区某街道'),
                                                                                                                                                      ('S000000088', '尤灯', 1, 3, 15, True, 1, '13889763884', '2000-01-01', '123456240350341234', '北京市某区某街道'),
                                                                                                                                                      ('S000000089', '郎和', 5, 2, 24, True, 1, '13882933514', '2000-01-01', '123456376404451234', '北京市某区某街道'),
                                                                                                                                                      ('S000000090', '郝广', 6, 1, 30, False, 1, '13838333987', '2000-01-01', '123456626269461234', '北京市某区某街道'),
                                                                                                                                                      ('S000000091', '陶诺', 1, 3, 12, False, 1, '13892715914', '2000-01-01', '123456611872481234', '北京市某区某街道'),
                                                                                                                                                      ('S000000092', '昌微', 2, 2, 4, False, 1, '13842183769', '2000-01-01', '123456313022181234', '北京市某区某街道'),
                                                                                                                                                      ('S000000093', '伏床', 1, 3, 13, False, 1, '13879873581', '2000-01-01', '123456312219481234', '北京市某区某街道'),
                                                                                                                                                      ('S000000094', '滕命', 4, 2, 20, True, 1, '13820508999', '2000-01-01', '123456162041931234', '北京市某区某街道'),
                                                                                                                                                      ('S000000095', '尹照', 4, 2, 16, True, 1, '13857404446', '2000-01-01', '123456681406261234', '北京市某区某街道'),
                                                                                                                                                      ('S000000096', '齐练', 4, 2, 17, True, 1, '13894699036', '2000-01-01', '123456608811621234', '北京市某区某街道'),
                                                                                                                                                      ('S000000097', '任脱', 3, 4, 9, False, 1, '13838435466', '2000-01-01', '123456310256101234', '北京市某区某街道'),
                                                                                                                                                      ('S000000098', '华文', 6, 1, 28, True, 1, '13852534519', '2000-01-01', '123456763668791234', '北京市某区某街道'),
                                                                                                                                                      ('S000000099', '梁使', 4, 2, 19, True, 1, '13857856595', '2000-01-01', '123456231626881234', '北京市某区某街道'),
                                                                                                                                                      ('S000000100', '任证', 1, 3, 13, False, 1, '13867882849', '2000-01-01', '123456369981441234', '北京市某区某街道'),
                                                                                                                                                      ('S000000101', '谢奖', 2, 2, 2, True, 1, '13891223915', '2000-01-01', '123456174717471234', '北京市某区某街道'),
                                                                                                                                                      ('S000000102', '花传', 3, 4, 8, False, 1, '13839010201', '2000-01-01', '123456449573951234', '北京市某区某街道'),
                                                                                                                                                      ('S000000103', '穆果', 4, 2, 17, True, 1, '13893944807', '2000-01-01', '123456746104271234', '北京市某区某街道'),
                                                                                                                                                      ('S000000104', '卞忙', 2, 2, 1, True, 1, '13854766664', '2000-01-01', '123456334720811234', '北京市某区某街道'),
                                                                                                                                                      ('S000000105', '滕来', 2, 2, 3, True, 1, '13864780971', '2000-01-01', '123456850788451234', '北京市某区某街道'),
                                                                                                                                                      ('S000000106', '严流', 4, 2, 20, False, 1, '13885947626', '2000-01-01', '123456799422781234', '北京市某区某街道'),
                                                                                                                                                      ('S000000107', '昌杀', 1, 3, 13, True, 1, '13835489835', '2000-01-01', '123456226988011234', '北京市某区某街道'),
                                                                                                                                                      ('S000000108', '伏风', 3, 4, 9, False, 1, '13821233080', '2000-01-01', '123456117652381234', '北京市某区某街道'),
                                                                                                                                                      ('S000000109', '皮研', 5, 2, 25, False, 1, '13827013586', '2000-01-01', '123456424333071234', '北京市某区某街道'),
                                                                                                                                                      ('S000000110', '郝京', 2, 2, 3, True, 1, '13858000642', '2000-01-01', '123456561567441234', '北京市某区某街道'),
                                                                                                                                                      ('S000000111', '秦这', 1, 3, 15, True, 1, '13836631451', '2000-01-01', '123456209240491234', '北京市某区某街道'),
                                                                                                                                                      ('S000000112', '韦顾', 6, 1, 27, True, 1, '13813181477', '2000-01-01', '123456776257961234', '北京市某区某街道'),
                                                                                                                                                      ('S000000113', '花回', 4, 2, 19, True, 1, '13870287353', '2000-01-01', '123456761078621234', '北京市某区某街道'),
                                                                                                                                                      ('S000000114', '鲁营', 2, 2, 3, False, 1, '13888010016', '2000-01-01', '123456522002271234', '北京市某区某街道'),
                                                                                                                                                      ('S000000115', '史自', 1, 3, 14, True, 1, '13813569660', '2000-01-01', '123456601409111234', '北京市某区某街道'),
                                                                                                                                                      ('S000000116', '董少', 3, 4, 10, True, 1, '13873652773', '2000-01-01', '123456256672121234', '北京市某区某街道'),
                                                                                                                                                      ('S000000117', '臧想', 2, 2, 3, True, 1, '13875877373', '2000-01-01', '123456980945161234', '北京市某区某街道'),
                                                                                                                                                      ('S000000118', '狄个', 3, 4, 7, True, 1, '13876886351', '2000-01-01', '123456404582611234', '北京市某区某街道'),
                                                                                                                                                      ('S000000119', '蒋稜', 3, 4, 6, False, 1, '13894082676', '2000-01-01', '123456903949381234', '北京市某区某街道'),
                                                                                                                                                      ('S000000120', '苗怎', 6, 1, 26, False, 1, '13869819903', '2000-01-01', '123456696364361234', '北京市某区某街道'),
                                                                                                                                                      ('S000000121', '顾亲', 4, 2, 17, False, 1, '13851893302', '2000-01-01', '123456435614331234', '北京市某区某街道'),
                                                                                                                                                      ('S000000122', '滕国', 5, 2, 21, True, 1, '13887003655', '2000-01-01', '123456663819441234', '北京市某区某街道'),
                                                                                                                                                      ('S000000123', '郑好', 2, 2, 1, False, 1, '13828540704', '2000-01-01', '123456200427341234', '北京市某区某街道'),
                                                                                                                                                      ('S000000124', '柳场', 4, 2, 19, False, 1, '13824784603', '2000-01-01', '123456291657211234', '北京市某区某街道'),
                                                                                                                                                      ('S000000125', '茅格', 4, 2, 17, False, 1, '13834624031', '2000-01-01', '123456442751611234', '北京市某区某街道'),
                                                                                                                                                      ('S000000126', '秦单', 1, 3, 14, False, 1, '13875259060', '2000-01-01', '123456764768121234', '北京市某区某街道'),
                                                                                                                                                      ('S000000127', '毛剧', 5, 2, 21, True, 1, '13854960006', '2000-01-01', '123456991810731234', '北京市某区某街道'),
                                                                                                                                                      ('S000000128', '孔勒', 1, 3, 12, True, 1, '13856823437', '2000-01-01', '123456264347711234', '北京市某区某街道'),
                                                                                                                                                      ('S000000129', '成显', 6, 1, 26, False, 1, '13863701207', '2000-01-01', '123456104311081234', '北京市某区某街道'),
                                                                                                                                                      ('S000000130', '鲁级', 1, 3, 13, True, 1, '13810578356', '2000-01-01', '123456879298501234', '北京市某区某街道'),
                                                                                                                                                      ('S000000131', '云界', 6, 1, 26, False, 1, '13885219203', '2000-01-01', '123456810782541234', '北京市某区某街道'),
                                                                                                                                                      ('S000000132', '傅伴', 3, 4, 9, True, 1, '13872600949', '2000-01-01', '123456410419331234', '北京市某区某街道'),
                                                                                                                                                      ('S000000133', '梁型', 3, 4, 7, False, 1, '13894068374', '2000-01-01', '123456260492651234', '北京市某区某街道'),
                                                                                                                                                      ('S000000134', '窦据', 1, 3, 12, True, 1, '13873904726', '2000-01-01', '123456192533811234', '北京市某区某街道'),
                                                                                                                                                      ('S000000135', '李却', 2, 2, 4, True, 1, '13860004401', '2000-01-01', '123456600426591234', '北京市某区某街道'),
                                                                                                                                                      ('S000000136', '水组', 3, 4, 8, False, 1, '13841424551', '2000-01-01', '123456369919121234', '北京市某区某街道'),
                                                                                                                                                      ('S000000137', '穆及', 4, 2, 19, False, 1, '13879407747', '2000-01-01', '123456886421391234', '北京市某区某街道'),
                                                                                                                                                      ('S000000138', '何加', 6, 1, 26, False, 1, '13820203256', '2000-01-01', '123456677264931234', '北京市某区某街道'),
                                                                                                                                                      ('S000000139', '鲁况', 2, 2, 5, True, 1, '13880803246', '2000-01-01', '123456954962141234', '北京市某区某街道'),
                                                                                                                                                      ('S000000140', '卫调', 4, 2, 18, True, 1, '13819131142', '2000-01-01', '123456605282061234', '北京市某区某街道'),
                                                                                                                                                      ('S000000141', '罗备', 3, 4, 10, True, 1, '13843383786', '2000-01-01', '123456959948971234', '北京市某区某街道'),
                                                                                                                                                      ('S000000142', '马层', 3, 4, 8, True, 1, '13886890351', '2000-01-01', '123456579652191234', '北京市某区某街道'),
                                                                                                                                                      ('S000000143', '舒给', 3, 4, 6, True, 1, '13834423522', '2000-01-01', '123456411212031234', '北京市某区某街道'),
                                                                                                                                                      ('S000000144', '苏重', 2, 2, 5, False, 1, '13858329033', '2000-01-01', '123456686040491234', '北京市某区某街道'),
                                                                                                                                                      ('S000000145', '廉复', 1, 3, 12, False, 1, '13850510891', '2000-01-01', '123456400448311234', '北京市某区某街道'),
                                                                                                                                                      ('S000000146', '穆九', 6, 1, 30, False, 1, '13864566872', '2000-01-01', '123456565669661234', '北京市某区某街道'),
                                                                                                                                                      ('S000000147', '祁受', 2, 2, 4, False, 1, '13818136325', '2000-01-01', '123456314587421234', '北京市某区某街道'),
                                                                                                                                                      ('S000000148', '狄欢', 3, 4, 6, True, 1, '13882889008', '2000-01-01', '123456954678961234', '北京市某区某街道'),
                                                                                                                                                      ('S000000149', '毛本', 1, 3, 15, False, 1, '13855397027', '2000-01-01', '123456508657881234', '北京市某区某街道'),
                                                                                                                                                      ('S000000150', '喻通', 1, 3, 12, True, 1, '13832560465', '2000-01-01', '123456285428941234', '北京市某区某街道'),
                                                                                                                                                      ('S000000151', '郝罗', 4, 2, 20, True, 1, '13810891385', '2000-01-01', '123456967638741234', '北京市某区某街道'),
                                                                                                                                                      ('S000000152', '尹种', 1, 3, 15, False, 1, '13899125732', '2000-01-01', '123456513496341234', '北京市某区某街道'),
                                                                                                                                                      ('S000000153', '姜某', 2, 2, 2, True, 1, '13896786769', '2000-01-01', '123456750333641234', '北京市某区某街道'),
                                                                                                                                                      ('S000000154', '卜莱', 1, 3, 12, True, 1, '13876182715', '2000-01-01', '123456583930651234', '北京市某区某街道'),
                                                                                                                                                      ('S000000155', '狄育', 3, 4, 9, True, 1, '13824964724', '2000-01-01', '123456474507191234', '北京市某区某街道'),
                                                                                                                                                      ('S000000156', '平甚', 5, 2, 25, False, 1, '13897463533', '2000-01-01', '123456764879071234', '北京市某区某街道'),
                                                                                                                                                      ('S000000157', '黄恶', 2, 2, 4, True, 1, '13875511021', '2000-01-01', '123456152160481234', '北京市某区某街道'),
                                                                                                                                                      ('S000000158', '秦伤', 1, 3, 11, True, 1, '13870460109', '2000-01-01', '123456295898211234', '北京市某区某街道'),
                                                                                                                                                      ('S000000159', '秦何', 5, 2, 25, False, 1, '13854664672', '2000-01-01', '123456620488021234', '北京市某区某街道'),
                                                                                                                                                      ('S000000160', '堪热', 4, 2, 18, False, 1, '13869164137', '2000-01-01', '123456164522341234', '北京市某区某街道'),
                                                                                                                                                      ('S000000161', '时马', 1, 3, 15, False, 1, '13867608398', '2000-01-01', '123456948616461234', '北京市某区某街道'),
                                                                                                                                                      ('S000000162', '贝退', 6, 1, 27, False, 1, '13890156297', '2000-01-01', '123456926190361234', '北京市某区某街道'),
                                                                                                                                                      ('S000000163', '姜跟', 2, 2, 3, True, 1, '13875587613', '2000-01-01', '123456869654751234', '北京市某区某街道'),
                                                                                                                                                      ('S000000164', '卫忽', 2, 2, 1, True, 1, '13840520532', '2000-01-01', '123456263271851234', '北京市某区某街道'),
                                                                                                                                                      ('S000000165', '俞遗', 5, 2, 22, True, 1, '13890316211', '2000-01-01', '123456301000001234', '北京市某区某街道'),
                                                                                                                                                      ('S000000166', '汪供', 3, 4, 8, False, 1, '13893944112', '2000-01-01', '123456776529081234', '北京市某区某街道'),
                                                                                                                                                      ('S000000167', '沈东', 3, 4, 9, False, 1, '13879409239', '2000-01-01', '123456971035181234', '北京市某区某街道'),
                                                                                                                                                      ('S000000168', '伍区', 3, 4, 8, True, 1, '13821589027', '2000-01-01', '123456186681061234', '北京市某区某街道'),
                                                                                                                                                      ('S000000169', '孔杂', 5, 2, 24, True, 1, '13824056441', '2000-01-01', '123456572744871234', '北京市某区某街道'),
                                                                                                                                                      ('S000000170', '卫平', 4, 2, 18, False, 1, '13852437494', '2000-01-01', '123456157488101234', '北京市某区某街道'),
                                                                                                                                                      ('S000000171', '和间', 2, 2, 2, True, 1, '13840788276', '2000-01-01', '123456617713821234', '北京市某区某街道'),
                                                                                                                                                      ('S000000172', '祁样', 5, 2, 22, True, 1, '13852887554', '2000-01-01', '123456479650621234', '北京市某区某街道'),
                                                                                                                                                      ('S000000173', '许降', 1, 3, 14, False, 1, '13886756672', '2000-01-01', '123456214998681234', '北京市某区某街道'),
                                                                                                                                                      ('S000000174', '费精', 1, 3, 14, False, 1, '13896772116', '2000-01-01', '123456705394581234', '北京市某区某街道'),
                                                                                                                                                      ('S000000175', '尤卖', 3, 4, 10, True, 1, '13866710068', '2000-01-01', '123456693272541234', '北京市某区某街道'),
                                                                                                                                                      ('S000000176', '俞饭', 6, 1, 30, False, 1, '13860017785', '2000-01-01', '123456684752931234', '北京市某区某街道'),
                                                                                                                                                      ('S000000177', '汤层', 5, 2, 25, False, 1, '13839115313', '2000-01-01', '123456588807571234', '北京市某区某街道'),
                                                                                                                                                      ('S000000178', '毛见', 6, 1, 27, True, 1, '13888806649', '2000-01-01', '123456981453841234', '北京市某区某街道'),
                                                                                                                                                      ('S000000179', '花脑', 5, 2, 21, True, 1, '13878150167', '2000-01-01', '123456431904071234', '北京市某区某街道'),
                                                                                                                                                      ('S000000180', '许万', 1, 3, 15, True, 1, '13891612308', '2000-01-01', '123456291469891234', '北京市某区某街道'),
                                                                                                                                                      ('S000000181', '舒设', 5, 2, 24, True, 1, '13822752857', '2000-01-01', '123456427592431234', '北京市某区某街道'),
                                                                                                                                                      ('S000000182', '伍球', 6, 1, 27, False, 1, '13823853041', '2000-01-01', '123456372886931234', '北京市某区某街道'),
                                                                                                                                                      ('S000000183', '沈始', 1, 3, 12, False, 1, '13824731623', '2000-01-01', '123456921246451234', '北京市某区某街道'),
                                                                                                                                                      ('S000000184', '皮晚', 4, 2, 17, False, 1, '13854206673', '2000-01-01', '123456350904121234', '北京市某区某街道'),
                                                                                                                                                      ('S000000185', '许势', 3, 4, 10, False, 1, '13821932796', '2000-01-01', '123456575689631234', '北京市某区某街道'),
                                                                                                                                                      ('S000000186', '苗传', 1, 3, 14, False, 1, '13816159509', '2000-01-01', '123456919850011234', '北京市某区某街道'),
                                                                                                                                                      ('S000000187', '冯习', 5, 2, 21, True, 1, '13887528103', '2000-01-01', '123456620412861234', '北京市某区某街道'),
                                                                                                                                                      ('S000000188', '孔付', 5, 2, 23, True, 1, '13817207642', '2000-01-01', '123456477412471234', '北京市某区某街道'),
                                                                                                                                                      ('S000000189', '项品', 4, 2, 19, True, 1, '13861739343', '2000-01-01', '123456232444401234', '北京市某区某街道'),
                                                                                                                                                      ('S000000190', '毛兰', 4, 2, 18, True, 1, '13828845783', '2000-01-01', '123456233839701234', '北京市某区某街道'),
                                                                                                                                                      ('S000000191', '戴伊', 2, 2, 1, True, 1, '13889115862', '2000-01-01', '123456817588231234', '北京市某区某街道'),
                                                                                                                                                      ('S000000192', '伏大', 1, 3, 14, False, 1, '13859685921', '2000-01-01', '123456441920191234', '北京市某区某街道'),
                                                                                                                                                      ('S000000193', '康和', 1, 3, 12, True, 1, '13883462553', '2000-01-01', '123456833362281234', '北京市某区某街道'),
                                                                                                                                                      ('S000000194', '章模', 2, 2, 5, False, 1, '13850914968', '2000-01-01', '123456160204581234', '北京市某区某街道'),
                                                                                                                                                      ('S000000195', '殷副', 5, 2, 24, True, 1, '13821605430', '2000-01-01', '123456857143171234', '北京市某区某街道'),
                                                                                                                                                      ('S000000196', '郎药', 6, 1, 30, False, 1, '13855121151', '2000-01-01', '123456377155961234', '北京市某区某街道'),
                                                                                                                                                      ('S000000197', '华希', 2, 2, 4, True, 1, '13822778158', '2000-01-01', '123456607999181234', '北京市某区某街道'),
                                                                                                                                                      ('S000000198', '安势', 3, 4, 8, False, 1, '13866650264', '2000-01-01', '123456895812381234', '北京市某区某街道'),
                                                                                                                                                      ('S000000199', '马觉', 2, 2, 2, True, 1, '13857164711', '2000-01-01', '123456646407761234', '北京市某区某街道'),
                                                                                                                                                      ('S000000200', '姚牌', 2, 2, 1, False, 1, '13895438710', '2000-01-01', '123456659552831234', '北京市某区某街道'),
                                                                                                                                                      ('S000000201', '黄业', 4, 2, 16, False, 1, '13850061002', '2000-01-01', '123456238705091234', '北京市某区某街道'),
                                                                                                                                                      ('S000000202', '章母', 4, 2, 20, False, 1, '13874567589', '2000-01-01', '123456734819131234', '北京市某区某街道'),
                                                                                                                                                      ('S000000203', '贺临', 2, 2, 1, True, 1, '13811099801', '2000-01-01', '123456836413061234', '北京市某区某街道'),
                                                                                                                                                      ('S000000204', '韦藏', 6, 1, 29, False, 1, '13855692408', '2000-01-01', '123456926731921234', '北京市某区某街道'),
                                                                                                                                                      ('S000000205', '宋制', 6, 1, 27, False, 1, '13871632281', '2000-01-01', '123456909182081234', '北京市某区某街道'),
                                                                                                                                                      ('S000000206', '禹秋', 3, 4, 10, False, 1, '13810374582', '2000-01-01', '123456728201021234', '北京市某区某街道'),
                                                                                                                                                      ('S000000207', '鲁牌', 1, 3, 14, False, 1, '13890117592', '2000-01-01', '123456219370571234', '北京市某区某街道'),
                                                                                                                                                      ('S000000208', '鲍报', 2, 2, 4, True, 1, '13829423386', '2000-01-01', '123456480835611234', '北京市某区某街道'),
                                                                                                                                                      ('S000000209', '范优', 5, 2, 21, True, 1, '13887587102', '2000-01-01', '123456476956571234', '北京市某区某街道'),
                                                                                                                                                      ('S000000210', '冯树', 2, 2, 5, True, 1, '13889743115', '2000-01-01', '123456460151651234', '北京市某区某街道'),
                                                                                                                                                      ('S000000211', '戴财', 3, 4, 9, True, 1, '13877061080', '2000-01-01', '123456450822491234', '北京市某区某街道'),
                                                                                                                                                      ('S000000212', '蒋亲', 3, 4, 8, False, 1, '13832557281', '2000-01-01', '123456879831771234', '北京市某区某街道'),
                                                                                                                                                      ('S000000213', '鲍委', 4, 2, 20, True, 1, '13856268545', '2000-01-01', '123456891480841234', '北京市某区某街道'),
                                                                                                                                                      ('S000000214', '董历', 2, 2, 4, False, 1, '13877883430', '2000-01-01', '123456754754501234', '北京市某区某街道'),
                                                                                                                                                      ('S000000215', '乐负', 4, 2, 19, False, 1, '13835897448', '2000-01-01', '123456682589981234', '北京市某区某街道'),
                                                                                                                                                      ('S000000216', '熊静', 4, 2, 19, True, 1, '13853468574', '2000-01-01', '123456243256121234', '北京市某区某街道'),
                                                                                                                                                      ('S000000217', '郑岁', 3, 4, 6, True, 1, '13836630749', '2000-01-01', '123456813837111234', '北京市某区某街道'),
                                                                                                                                                      ('S000000218', '赵信', 3, 4, 10, True, 1, '13827401096', '2000-01-01', '123456910260321234', '北京市某区某街道'),
                                                                                                                                                      ('S000000219', '水书', 2, 2, 4, False, 1, '13878549997', '2000-01-01', '123456799799441234', '北京市某区某街道'),
                                                                                                                                                      ('S000000220', '伏娜', 2, 2, 1, True, 1, '13895374483', '2000-01-01', '123456134421881234', '北京市某区某街道'),
                                                                                                                                                      ('S000000221', '姚戴', 2, 2, 1, False, 1, '13846947336', '2000-01-01', '123456623842551234', '北京市某区某街道'),
                                                                                                                                                      ('S000000222', '尤项', 3, 4, 8, True, 1, '13845910716', '2000-01-01', '123456792969191234', '北京市某区某街道'),
                                                                                                                                                      ('S000000223', '廉张', 2, 2, 2, True, 1, '13844311951', '2000-01-01', '123456732918471234', '北京市某区某街道'),
                                                                                                                                                      ('S000000224', '傅诉', 6, 1, 27, True, 1, '13885237698', '2000-01-01', '123456186037971234', '北京市某区某街道'),
                                                                                                                                                      ('S000000225', '吕较', 6, 1, 29, False, 1, '13815164533', '2000-01-01', '123456412251691234', '北京市某区某街道'),
                                                                                                                                                      ('S000000226', '邹希', 6, 1, 28, False, 1, '13866606833', '2000-01-01', '123456755366721234', '北京市某区某街道'),
                                                                                                                                                      ('S000000227', '戴书', 3, 4, 7, True, 1, '13888364238', '2000-01-01', '123456280926211234', '北京市某区某街道'),
                                                                                                                                                      ('S000000228', '纪分', 6, 1, 26, False, 1, '13848133952', '2000-01-01', '123456960938171234', '北京市某区某街道'),
                                                                                                                                                      ('S000000229', '禹选', 2, 2, 4, False, 1, '13856187175', '2000-01-01', '123456384503841234', '北京市某区某街道'),
                                                                                                                                                      ('S000000230', '屈骨', 2, 2, 4, False, 1, '13818856256', '2000-01-01', '123456861838311234', '北京市某区某街道'),
                                                                                                                                                      ('S000000231', '何规', 1, 3, 14, True, 1, '13813505510', '2000-01-01', '123456855743761234', '北京市某区某街道'),
                                                                                                                                                      ('S000000232', '舒暗', 6, 1, 29, False, 1, '13820025596', '2000-01-01', '123456511740291234', '北京市某区某街道'),
                                                                                                                                                      ('S000000233', '尤恶', 2, 2, 3, True, 1, '13853669658', '2000-01-01', '123456462056281234', '北京市某区某街道'),
                                                                                                                                                      ('S000000234', '喻兵', 3, 4, 10, False, 1, '13866557351', '2000-01-01', '123456527269251234', '北京市某区某街道'),
                                                                                                                                                      ('S000000235', '谈园', 2, 2, 2, False, 1, '13869182279', '2000-01-01', '123456343668841234', '北京市某区某街道'),
                                                                                                                                                      ('S000000236', '傅食', 1, 3, 15, True, 1, '13894419562', '2000-01-01', '123456331725751234', '北京市某区某街道'),
                                                                                                                                                      ('S000000237', '皮顶', 1, 3, 14, True, 1, '13886931376', '2000-01-01', '123456149283141234', '北京市某区某街道'),
                                                                                                                                                      ('S000000238', '狄过', 3, 4, 6, True, 1, '13830868539', '2000-01-01', '123456477836671234', '北京市某区某街道'),
                                                                                                                                                      ('S000000239', '计臓', 1, 3, 13, True, 1, '13879317491', '2000-01-01', '123456701795401234', '北京市某区某街道'),
                                                                                                                                                      ('S000000240', '堪足', 1, 3, 12, True, 1, '13853081999', '2000-01-01', '123456223241881234', '北京市某区某街道'),
                                                                                                                                                      ('S000000241', '彭里', 5, 2, 22, True, 1, '13828635541', '2000-01-01', '123456930609281234', '北京市某区某街道'),
                                                                                                                                                      ('S000000242', '云剧', 1, 3, 12, True, 1, '13882583271', '2000-01-01', '123456210875811234', '北京市某区某街道'),
                                                                                                                                                      ('S000000243', '黄时', 3, 4, 10, True, 1, '13836533011', '2000-01-01', '123456927639381234', '北京市某区某街道'),
                                                                                                                                                      ('S000000244', '谢散', 5, 2, 21, True, 1, '13898960525', '2000-01-01', '123456459010851234', '北京市某区某街道'),
                                                                                                                                                      ('S000000245', '舒看', 6, 1, 30, True, 1, '13898569420', '2000-01-01', '123456741171001234', '北京市某区某街道'),
                                                                                                                                                      ('S000000246', '赵失', 2, 2, 5, False, 1, '13832698478', '2000-01-01', '123456166948821234', '北京市某区某街道'),
                                                                                                                                                      ('S000000247', '卞朝', 4, 2, 20, True, 1, '13854662420', '2000-01-01', '123456267198411234', '北京市某区某街道'),
                                                                                                                                                      ('S000000248', '郎等', 3, 4, 10, False, 1, '13835936186', '2000-01-01', '123456636815881234', '北京市某区某街道'),
                                                                                                                                                      ('S000000249', '严发', 1, 3, 13, False, 1, '13893769942', '2000-01-01', '123456650912801234', '北京市某区某街道'),
                                                                                                                                                      ('S000000250', '许而', 5, 2, 22, False, 1, '13834518970', '2000-01-01', '123456202909201234', '北京市某区某街道'),
                                                                                                                                                      ('S000000251', '郎式', 6, 1, 29, False, 1, '13818834195', '2000-01-01', '123456306880641234', '北京市某区某街道'),
                                                                                                                                                      ('S000000252', '潘性', 4, 2, 17, False, 1, '13875368085', '2000-01-01', '123456385581181234', '北京市某区某街道'),
                                                                                                                                                      ('S000000253', '俞院', 6, 1, 27, False, 1, '13895969205', '2000-01-01', '123456517754421234', '北京市某区某街道'),
                                                                                                                                                      ('S000000254', '卞种', 1, 3, 12, False, 1, '13831085031', '2000-01-01', '123456817165851234', '北京市某区某街道'),
                                                                                                                                                      ('S000000255', '史量', 3, 4, 10, False, 1, '13823706242', '2000-01-01', '123456215629501234', '北京市某区某街道'),
                                                                                                                                                      ('S000000256', '冯课', 1, 3, 14, False, 1, '13886872547', '2000-01-01', '123456905975151234', '北京市某区某街道'),
                                                                                                                                                      ('S000000257', '董一', 5, 2, 24, True, 1, '13880131848', '2000-01-01', '123456526747651234', '北京市某区某街道'),
                                                                                                                                                      ('S000000258', '卞营', 5, 2, 24, True, 1, '13810529165', '2000-01-01', '123456510399181234', '北京市某区某街道'),
                                                                                                                                                      ('S000000259', '蒋份', 5, 2, 22, True, 1, '13880659129', '2000-01-01', '123456284049831234', '北京市某区某街道'),
                                                                                                                                                      ('S000000260', '米底', 4, 2, 16, False, 1, '13897618469', '2000-01-01', '123456659586411234', '北京市某区某街道'),
                                                                                                                                                      ('S000000261', '贺讲', 4, 2, 19, False, 1, '13883757866', '2000-01-01', '123456922749941234', '北京市某区某街道'),
                                                                                                                                                      ('S000000262', '彭先', 2, 2, 2, True, 1, '13835405455', '2000-01-01', '123456874554641234', '北京市某区某街道'),
                                                                                                                                                      ('S000000263', '姜福', 2, 2, 4, True, 1, '13890052251', '2000-01-01', '123456260244931234', '北京市某区某街道'),
                                                                                                                                                      ('S000000264', '奚微', 6, 1, 27, True, 1, '13886534229', '2000-01-01', '123456422068871234', '北京市某区某街道'),
                                                                                                                                                      ('S000000265', '和春', 2, 2, 3, False, 1, '13811329640', '2000-01-01', '123456731178741234', '北京市某区某街道'),
                                                                                                                                                      ('S000000266', '邵火', 5, 2, 24, True, 1, '13890526246', '2000-01-01', '123456559890081234', '北京市某区某街道'),
                                                                                                                                                      ('S000000267', '齐卡', 5, 2, 21, True, 1, '13868002772', '2000-01-01', '123456633167571234', '北京市某区某街道'),
                                                                                                                                                      ('S000000268', '杨队', 2, 2, 2, True, 1, '13835647886', '2000-01-01', '123456154916891234', '北京市某区某街道'),
                                                                                                                                                      ('S000000269', '张际', 4, 2, 19, False, 1, '13875456062', '2000-01-01', '123456791930811234', '北京市某区某街道'),
                                                                                                                                                      ('S000000270', '贺满', 4, 2, 16, False, 1, '13849187985', '2000-01-01', '123456471114471234', '北京市某区某街道'),
                                                                                                                                                      ('S000000271', '喻发', 5, 2, 24, True, 1, '13885875171', '2000-01-01', '123456681846501234', '北京市某区某街道'),
                                                                                                                                                      ('S000000272', '殷既', 2, 2, 1, False, 1, '13892354320', '2000-01-01', '123456853560441234', '北京市某区某街道'),
                                                                                                                                                      ('S000000273', '皮经', 4, 2, 16, False, 1, '13889812772', '2000-01-01', '123456878648731234', '北京市某区某街道'),
                                                                                                                                                      ('S000000274', '邬马', 1, 3, 12, False, 1, '13846645311', '2000-01-01', '123456274615141234', '北京市某区某街道'),
                                                                                                                                                      ('S000000275', '华员', 1, 3, 11, True, 1, '13876708821', '2000-01-01', '123456917369131234', '北京市某区某街道'),
                                                                                                                                                      ('S000000276', '计嘴', 5, 2, 22, True, 1, '13895761740', '2000-01-01', '123456747211771234', '北京市某区某街道'),
                                                                                                                                                      ('S000000277', '成象', 3, 4, 7, True, 1, '13870492215', '2000-01-01', '123456781475801234', '北京市某区某街道'),
                                                                                                                                                      ('S000000278', '伍断', 5, 2, 23, True, 1, '13832042124', '2000-01-01', '123456998778021234', '北京市某区某街道'),
                                                                                                                                                      ('S000000279', '伍况', 6, 1, 28, False, 1, '13833759859', '2000-01-01', '123456742742751234', '北京市某区某街道'),
                                                                                                                                                      ('S000000280', '安叶', 2, 2, 5, False, 1, '13850663978', '2000-01-01', '123456195622461234', '北京市某区某街道'),
                                                                                                                                                      ('S000000281', '贝乎', 3, 4, 6, False, 1, '13875585157', '2000-01-01', '123456519436371234', '北京市某区某街道'),
                                                                                                                                                      ('S000000282', '谈纸', 2, 2, 5, True, 1, '13822194518', '2000-01-01', '123456810741491234', '北京市某区某街道'),
                                                                                                                                                      ('S000000283', '马观', 6, 1, 26, True, 1, '13842156635', '2000-01-01', '123456163831981234', '北京市某区某街道'),
                                                                                                                                                      ('S000000284', '董北', 2, 2, 1, False, 1, '13841008822', '2000-01-01', '123456928465431234', '北京市某区某街道'),
                                                                                                                                                      ('S000000285', '何记', 2, 2, 4, False, 1, '13872325617', '2000-01-01', '123456660239721234', '北京市某区某街道'),
                                                                                                                                                      ('S000000286', '陶清', 2, 2, 4, False, 1, '13839764444', '2000-01-01', '123456741392551234', '北京市某区某街道'),
                                                                                                                                                      ('S000000287', '陶极', 2, 2, 5, True, 1, '13871050420', '2000-01-01', '123456277582401234', '北京市某区某街道'),
                                                                                                                                                      ('S000000288', '秦左', 1, 3, 12, True, 1, '13826277947', '2000-01-01', '123456955803391234', '北京市某区某街道'),
                                                                                                                                                      ('S000000289', '陶船', 2, 2, 4, False, 1, '13853915001', '2000-01-01', '123456664476571234', '北京市某区某街道'),
                                                                                                                                                      ('S000000290', '宋常', 4, 2, 19, True, 1, '13837102214', '2000-01-01', '123456947165441234', '北京市某区某街道'),
                                                                                                                                                      ('S000000291', '梁而', 3, 4, 8, False, 1, '13823613997', '2000-01-01', '123456320480841234', '北京市某区某街道'),
                                                                                                                                                      ('S000000292', '施音', 3, 4, 6, False, 1, '13898095268', '2000-01-01', '123456850578051234', '北京市某区某街道'),
                                                                                                                                                      ('S000000293', '臧坏', 2, 2, 3, False, 1, '13810681265', '2000-01-01', '123456949448331234', '北京市某区某街道'),
                                                                                                                                                      ('S000000294', '金属', 1, 3, 15, False, 1, '13841366380', '2000-01-01', '123456134450471234', '北京市某区某街道'),
                                                                                                                                                      ('S000000295', '毛份', 3, 4, 10, True, 1, '13818552255', '2000-01-01', '123456773114161234', '北京市某区某街道'),
                                                                                                                                                      ('S000000296', '堪贝', 2, 2, 1, False, 1, '13899491161', '2000-01-01', '123456859121701234', '北京市某区某街道'),
                                                                                                                                                      ('S000000297', '赵须', 5, 2, 24, True, 1, '13876009888', '2000-01-01', '123456197251291234', '北京市某区某街道'),
                                                                                                                                                      ('S000000298', '庞四', 2, 2, 5, True, 1, '13845332033', '2000-01-01', '123456758926671234', '北京市某区某街道'),
                                                                                                                                                      ('S000000299', '吕主', 5, 2, 25, True, 1, '13824197569', '2000-01-01', '123456885646941234', '北京市某区某街道'),
                                                                                                                                                      ('S000000300', '卜底', 2, 2, 4, True, 1, '13833800381', '2000-01-01', '123456328801891234', '北京市某区某街道'),
                                                                                                                                                      ('S000000301', '郝养', 5, 2, 23, True, 1, '13879174631', '2000-01-01', '123456381204491234', '北京市某区某街道'),
                                                                                                                                                      ('S000000302', '贝鞋', 4, 2, 17, True, 1, '13817266049', '2000-01-01', '123456955844791234', '北京市某区某街道'),
                                                                                                                                                      ('S000000303', '何天', 1, 3, 12, False, 1, '13882640746', '2000-01-01', '123456602165941234', '北京市某区某街道'),
                                                                                                                                                      ('S000000304', '苗闻', 6, 1, 30, False, 1, '13810440376', '2000-01-01', '123456118467801234', '北京市某区某街道'),
                                                                                                                                                      ('S000000305', '褚师', 3, 4, 9, True, 1, '13879072577', '2000-01-01', '123456165573771234', '北京市某区某街道'),
                                                                                                                                                      ('S000000306', '昌纪', 5, 2, 23, False, 1, '13817969159', '2000-01-01', '123456486167571234', '北京市某区某街道'),
                                                                                                                                                      ('S000000307', '卜森', 3, 4, 7, False, 1, '13831616662', '2000-01-01', '123456867011311234', '北京市某区某街道'),
                                                                                                                                                      ('S000000308', '岑寻', 1, 3, 12, True, 1, '13887324085', '2000-01-01', '123456473735221234', '北京市某区某街道'),
                                                                                                                                                      ('S000000309', '邹琴', 3, 4, 7, True, 1, '13810036817', '2000-01-01', '123456356868751234', '北京市某区某街道'),
                                                                                                                                                      ('S000000310', '韩块', 1, 3, 14, False, 1, '13891121746', '2000-01-01', '123456159267611234', '北京市某区某街道'),
                                                                                                                                                      ('S000000311', '华童', 4, 2, 16, False, 1, '13895884416', '2000-01-01', '123456325863041234', '北京市某区某街道'),
                                                                                                                                                      ('S000000312', '纪久', 2, 2, 3, True, 1, '13832475292', '2000-01-01', '123456548039651234', '北京市某区某街道'),
                                                                                                                                                      ('S000000313', '张孤', 3, 4, 10, False, 1, '13820301378', '2000-01-01', '123456108386651234', '北京市某区某街道'),
                                                                                                                                                      ('S000000314', '许水', 6, 1, 26, True, 1, '13829392780', '2000-01-01', '123456270450071234', '北京市某区某街道'),
                                                                                                                                                      ('S000000315', '祝諣', 3, 4, 8, True, 1, '13881132786', '2000-01-01', '123456144106821234', '北京市某区某街道'),
                                                                                                                                                      ('S000000316', '齐光', 2, 2, 4, True, 1, '13843788989', '2000-01-01', '123456822656381234', '北京市某区某街道'),
                                                                                                                                                      ('S000000317', '黄投', 2, 2, 2, False, 1, '13848974640', '2000-01-01', '123456295243981234', '北京市某区某街道'),
                                                                                                                                                      ('S000000318', '范果', 3, 4, 10, True, 1, '13811291761', '2000-01-01', '123456763953101234', '北京市某区某街道'),
                                                                                                                                                      ('S000000319', '奚喝', 4, 2, 18, False, 1, '13835270099', '2000-01-01', '123456436602151234', '北京市某区某街道'),
                                                                                                                                                      ('S000000320', '赵言', 2, 2, 2, False, 1, '13893449737', '2000-01-01', '123456381157941234', '北京市某区某街道'),
                                                                                                                                                      ('S000000321', '伏济', 2, 2, 2, True, 1, '13825977031', '2000-01-01', '123456909069281234', '北京市某区某街道'),
                                                                                                                                                      ('S000000322', '梁如', 5, 2, 24, False, 1, '13855496376', '2000-01-01', '123456402665851234', '北京市某区某街道'),
                                                                                                                                                      ('S000000323', '时汉', 1, 3, 12, False, 1, '13885578220', '2000-01-01', '123456215055331234', '北京市某区某街道'),
                                                                                                                                                      ('S000000324', '奚严', 5, 2, 23, True, 1, '13845582225', '2000-01-01', '123456732094011234', '北京市某区某街道'),
                                                                                                                                                      ('S000000325', '郑张', 2, 2, 1, False, 1, '13879942030', '2000-01-01', '123456888807711234', '北京市某区某街道'),
                                                                                                                                                      ('S000000326', '皮击', 2, 2, 4, True, 1, '13887197437', '2000-01-01', '123456659361951234', '北京市某区某街道'),
                                                                                                                                                      ('S000000327', '凤笔', 5, 2, 21, False, 1, '13835735227', '2000-01-01', '123456158167101234', '北京市某区某街道'),
                                                                                                                                                      ('S000000328', '何喊', 5, 2, 24, False, 1, '13881738674', '2000-01-01', '123456597312061234', '北京市某区某街道'),
                                                                                                                                                      ('S000000329', '韦黑', 3, 4, 6, True, 1, '13813354933', '2000-01-01', '123456429976771234', '北京市某区某街道'),
                                                                                                                                                      ('S000000330', '陈建', 1, 3, 14, False, 1, '13885045549', '2000-01-01', '123456314606031234', '北京市某区某街道'),
                                                                                                                                                      ('S000000331', '韩乎', 5, 2, 25, False, 1, '13868006316', '2000-01-01', '123456673671361234', '北京市某区某街道'),
                                                                                                                                                      ('S000000332', '禹征', 4, 2, 17, False, 1, '13844713883', '2000-01-01', '123456605792071234', '北京市某区某街道'),
                                                                                                                                                      ('S000000333', '何智', 6, 1, 28, False, 1, '13876418863', '2000-01-01', '123456447698671234', '北京市某区某街道'),
                                                                                                                                                      ('S000000334', '钱都', 6, 1, 27, True, 1, '13877525535', '2000-01-01', '123456707251991234', '北京市某区某街道'),
                                                                                                                                                      ('S000000335', '韦当', 5, 2, 21, True, 1, '13896295597', '2000-01-01', '123456155279451234', '北京市某区某街道'),
                                                                                                                                                      ('S000000336', '贺舞', 6, 1, 27, True, 1, '13856411390', '2000-01-01', '123456794976631234', '北京市某区某街道'),
                                                                                                                                                      ('S000000337', '康树', 6, 1, 26, False, 1, '13844394150', '2000-01-01', '123456153297601234', '北京市某区某街道'),
                                                                                                                                                      ('S000000338', '毛品', 1, 3, 15, True, 1, '13822480595', '2000-01-01', '123456395401771234', '北京市某区某街道'),
                                                                                                                                                      ('S000000339', '皮养', 3, 4, 6, False, 1, '13896541091', '2000-01-01', '123456739240301234', '北京市某区某街道'),
                                                                                                                                                      ('S000000340', '杨目', 6, 1, 30, True, 1, '13813587765', '2000-01-01', '123456444598581234', '北京市某区某街道'),
                                                                                                                                                      ('S000000341', '堪不', 3, 4, 8, False, 1, '13842973942', '2000-01-01', '123456925421851234', '北京市某区某街道'),
                                                                                                                                                      ('S000000342', '卜卖', 4, 2, 17, True, 1, '13836044822', '2000-01-01', '123456705419231234', '北京市某区某街道'),
                                                                                                                                                      ('S000000343', '顾与', 4, 2, 18, False, 1, '13841639023', '2000-01-01', '123456311161311234', '北京市某区某街道'),
                                                                                                                                                      ('S000000344', '施流', 5, 2, 23, True, 1, '13826017206', '2000-01-01', '123456664673411234', '北京市某区某街道'),
                                                                                                                                                      ('S000000345', '米苦', 1, 3, 15, True, 1, '13840698765', '2000-01-01', '123456978917441234', '北京市某区某街道'),
                                                                                                                                                      ('S000000346', '乐住', 3, 4, 7, False, 1, '13863752482', '2000-01-01', '123456146030631234', '北京市某区某街道'),
                                                                                                                                                      ('S000000347', '薛是', 4, 2, 20, True, 1, '13828152257', '2000-01-01', '123456438150741234', '北京市某区某街道'),
                                                                                                                                                      ('S000000348', '余信', 2, 2, 3, False, 1, '13839273383', '2000-01-01', '123456514071331234', '北京市某区某街道'),
                                                                                                                                                      ('S000000349', '陈苏', 4, 2, 19, False, 1, '13842476268', '2000-01-01', '123456696539571234', '北京市某区某街道'),
                                                                                                                                                      ('S000000350', '费的', 6, 1, 30, False, 1, '13861323423', '2000-01-01', '123456284526331234', '北京市某区某街道'),
                                                                                                                                                      ('S000000351', '明怎', 5, 2, 25, True, 1, '13878997673', '2000-01-01', '123456982032221234', '北京市某区某街道'),
                                                                                                                                                      ('S000000352', '史革', 2, 2, 1, True, 1, '13822081418', '2000-01-01', '123456429685981234', '北京市某区某街道'),
                                                                                                                                                      ('S000000353', '和顺', 2, 2, 5, True, 1, '13895174001', '2000-01-01', '123456361229531234', '北京市某区某街道'),
                                                                                                                                                      ('S000000354', '魏风', 5, 2, 22, True, 1, '13811309089', '2000-01-01', '123456614518081234', '北京市某区某街道'),
                                                                                                                                                      ('S000000355', '安富', 2, 2, 3, True, 1, '13826632490', '2000-01-01', '123456175365891234', '北京市某区某街道'),
                                                                                                                                                      ('S000000356', '禹友', 3, 4, 6, True, 1, '13856123954', '2000-01-01', '123456618896131234', '北京市某区某街道'),
                                                                                                                                                      ('S000000357', '鲍错', 4, 2, 20, True, 1, '13810632035', '2000-01-01', '123456755347891234', '北京市某区某街道'),
                                                                                                                                                      ('S000000358', '皮杀', 6, 1, 28, True, 1, '13868088972', '2000-01-01', '123456405620001234', '北京市某区某街道'),
                                                                                                                                                      ('S000000359', '时姑', 5, 2, 23, True, 1, '13881553498', '2000-01-01', '123456449111041234', '北京市某区某街道'),
                                                                                                                                                      ('S000000360', '沈抱', 5, 2, 25, False, 1, '13886138734', '2000-01-01', '123456799092051234', '北京市某区某街道'),
                                                                                                                                                      ('S000000361', '祁消', 3, 4, 9, False, 1, '13869802243', '2000-01-01', '123456706121581234', '北京市某区某街道'),
                                                                                                                                                      ('S000000362', '成反', 1, 3, 15, True, 1, '13852727872', '2000-01-01', '123456626932421234', '北京市某区某街道'),
                                                                                                                                                      ('S000000363', '陶位', 3, 4, 7, False, 1, '13839556013', '2000-01-01', '123456991562381234', '北京市某区某街道'),
                                                                                                                                                      ('S000000364', '冯授', 1, 3, 12, False, 1, '13833117193', '2000-01-01', '123456188346131234', '北京市某区某街道'),
                                                                                                                                                      ('S000000365', '明选', 3, 4, 8, False, 1, '13897334252', '2000-01-01', '123456914359941234', '北京市某区某街道'),
                                                                                                                                                      ('S000000366', '唐编', 5, 2, 23, True, 1, '13864045601', '2000-01-01', '123456585217201234', '北京市某区某街道'),
                                                                                                                                                      ('S000000367', '郝船', 2, 2, 5, False, 1, '13812338179', '2000-01-01', '123456999841341234', '北京市某区某街道'),
                                                                                                                                                      ('S000000368', '常散', 2, 2, 1, True, 1, '13820665144', '2000-01-01', '123456891940351234', '北京市某区某街道'),
                                                                                                                                                      ('S000000369', '孙举', 2, 2, 3, False, 1, '13883717893', '2000-01-01', '123456672560051234', '北京市某区某街道'),
                                                                                                                                                      ('S000000370', '元河', 4, 2, 17, False, 1, '13866128058', '2000-01-01', '123456636929711234', '北京市某区某街道'),
                                                                                                                                                      ('S000000371', '平消', 5, 2, 22, True, 1, '13814708064', '2000-01-01', '123456448356091234', '北京市某区某街道'),
                                                                                                                                                      ('S000000372', '臧初', 3, 4, 6, False, 1, '13897272580', '2000-01-01', '123456689763751234', '北京市某区某街道'),
                                                                                                                                                      ('S000000373', '马战', 5, 2, 24, True, 1, '13887405965', '2000-01-01', '123456896684431234', '北京市某区某街道'),
                                                                                                                                                      ('S000000374', '俞放', 4, 2, 16, True, 1, '13849950508', '2000-01-01', '123456653175751234', '北京市某区某街道'),
                                                                                                                                                      ('S000000375', '狄简', 3, 4, 6, False, 1, '13848455047', '2000-01-01', '123456774576731234', '北京市某区某街道'),
                                                                                                                                                      ('S000000376', '孙遍', 4, 2, 17, True, 1, '13864733600', '2000-01-01', '123456308782381234', '北京市某区某街道'),
                                                                                                                                                      ('S000000377', '尤诺', 6, 1, 30, False, 1, '13826360839', '2000-01-01', '123456756236471234', '北京市某区某街道'),
                                                                                                                                                      ('S000000378', '窦慢', 6, 1, 26, False, 1, '13837230157', '2000-01-01', '123456638755061234', '北京市某区某街道'),
                                                                                                                                                      ('S000000379', '严莱', 1, 3, 11, True, 1, '13825855063', '2000-01-01', '123456454331961234', '北京市某区某街道'),
                                                                                                                                                      ('S000000380', '常困', 2, 2, 2, False, 1, '13867479431', '2000-01-01', '123456355191951234', '北京市某区某街道'),
                                                                                                                                                      ('S000000381', '曹今', 6, 1, 27, False, 1, '13868083402', '2000-01-01', '123456462827471234', '北京市某区某街道'),
                                                                                                                                                      ('S000000382', '尤营', 4, 2, 17, False, 1, '13870519780', '2000-01-01', '123456771771181234', '北京市某区某街道'),
                                                                                                                                                      ('S000000383', '水得', 3, 4, 9, True, 1, '13878922620', '2000-01-01', '123456896034511234', '北京市某区某街道'),
                                                                                                                                                      ('S000000384', '薛还', 2, 2, 4, False, 1, '13874407934', '2000-01-01', '123456515225121234', '北京市某区某街道'),
                                                                                                                                                      ('S000000385', '禹往', 5, 2, 24, True, 1, '13825862267', '2000-01-01', '123456750834971234', '北京市某区某街道'),
                                                                                                                                                      ('S000000386', '邵胜', 6, 1, 28, False, 1, '13857855839', '2000-01-01', '123456951218411234', '北京市某区某街道'),
                                                                                                                                                      ('S000000387', '罗内', 3, 4, 10, False, 1, '13838257807', '2000-01-01', '123456519132581234', '北京市某区某街道'),
                                                                                                                                                      ('S000000388', '潘再', 6, 1, 28, True, 1, '13867348677', '2000-01-01', '123456263186891234', '北京市某区某街道'),
                                                                                                                                                      ('S000000389', '汤盛', 1, 3, 13, False, 1, '13886272932', '2000-01-01', '123456805241761234', '北京市某区某街道'),
                                                                                                                                                      ('S000000390', '成都', 4, 2, 18, False, 1, '13820952164', '2000-01-01', '123456539708931234', '北京市某区某街道'),
                                                                                                                                                      ('S000000391', '苏况', 4, 2, 19, True, 1, '13852033981', '2000-01-01', '123456710283361234', '北京市某区某街道'),
                                                                                                                                                      ('S000000392', '郑模', 5, 2, 22, True, 1, '13876960220', '2000-01-01', '123456282335061234', '北京市某区某街道'),
                                                                                                                                                      ('S000000393', '和块', 3, 4, 7, True, 1, '13847674497', '2000-01-01', '123456813754691234', '北京市某区某街道'),
                                                                                                                                                      ('S000000394', '伏记', 3, 4, 6, True, 1, '13841740189', '2000-01-01', '123456575870181234', '北京市某区某街道'),
                                                                                                                                                      ('S000000395', '毕内', 2, 2, 3, False, 1, '13828391221', '2000-01-01', '123456711566861234', '北京市某区某街道'),
                                                                                                                                                      ('S000000396', '郑千', 5, 2, 25, False, 1, '13873922073', '2000-01-01', '123456672185951234', '北京市某区某街道'),
                                                                                                                                                      ('S000000397', '米画', 5, 2, 21, True, 1, '13888801259', '2000-01-01', '123456408917211234', '北京市某区某街道'),
                                                                                                                                                      ('S000000398', '米雄', 1, 3, 13, False, 1, '13874686701', '2000-01-01', '123456852699511234', '北京市某区某街道'),
                                                                                                                                                      ('S000000399', '时普', 6, 1, 27, False, 1, '13834267260', '2000-01-01', '123456144627821234', '北京市某区某街道'),
                                                                                                                                                      ('S000000400', '邹面', 6, 1, 30, True, 1, '13834842176', '2000-01-01', '123456846092581234', '北京市某区某街道'),
                                                                                                                                                      ('S000000401', '魏坏', 6, 1, 29, True, 1, '13839673659', '2000-01-01', '123456607190921234', '北京市某区某街道'),
                                                                                                                                                      ('S000000402', '纪站', 2, 2, 2, True, 1, '13842428881', '2000-01-01', '123456911301071234', '北京市某区某街道'),
                                                                                                                                                      ('S000000403', '朱五', 3, 4, 7, True, 1, '13863603021', '2000-01-01', '123456586507661234', '北京市某区某街道'),
                                                                                                                                                      ('S000000404', '成示', 2, 2, 1, False, 1, '13816373174', '2000-01-01', '123456658862581234', '北京市某区某街道'),
                                                                                                                                                      ('S000000405', '柳莫', 4, 2, 19, True, 1, '13843152058', '2000-01-01', '123456843035701234', '北京市某区某街道'),
                                                                                                                                                      ('S000000406', '余连', 1, 3, 11, True, 1, '13810352302', '2000-01-01', '123456777250591234', '北京市某区某街道'),
                                                                                                                                                      ('S000000407', '庞守', 2, 2, 4, False, 1, '13869600852', '2000-01-01', '123456563333991234', '北京市某区某街道'),
                                                                                                                                                      ('S000000408', '乐窢', 4, 2, 16, False, 1, '13882118473', '2000-01-01', '123456664460161234', '北京市某区某街道'),
                                                                                                                                                      ('S000000409', '俞苦', 5, 2, 22, False, 1, '13862840265', '2000-01-01', '123456817868421234', '北京市某区某街道'),
                                                                                                                                                      ('S000000410', '姚数', 3, 4, 6, True, 1, '13828755926', '2000-01-01', '123456498521391234', '北京市某区某街道'),
                                                                                                                                                      ('S000000411', '窦终', 5, 2, 25, True, 1, '13865317994', '2000-01-01', '123456717050411234', '北京市某区某街道'),
                                                                                                                                                      ('S000000412', '曹雪', 4, 2, 20, True, 1, '13860238079', '2000-01-01', '123456882400881234', '北京市某区某街道'),
                                                                                                                                                      ('S000000413', '乐娘', 2, 2, 2, False, 1, '13832085958', '2000-01-01', '123456385978881234', '北京市某区某街道'),
                                                                                                                                                      ('S000000414', '汪洛', 4, 2, 19, False, 1, '13888750281', '2000-01-01', '123456416738451234', '北京市某区某街道'),
                                                                                                                                                      ('S000000415', '马回', 1, 3, 13, False, 1, '13868216100', '2000-01-01', '123456730684691234', '北京市某区某街道'),
                                                                                                                                                      ('S000000416', '章鲁', 5, 2, 22, True, 1, '13866230600', '2000-01-01', '123456775334371234', '北京市某区某街道'),
                                                                                                                                                      ('S000000417', '齐运', 5, 2, 23, False, 1, '13882931836', '2000-01-01', '123456408678411234', '北京市某区某街道'),
                                                                                                                                                      ('S000000418', '贝留', 4, 2, 19, True, 1, '13820664216', '2000-01-01', '123456720050351234', '北京市某区某街道'),
                                                                                                                                                      ('S000000419', '狄敢', 2, 2, 4, False, 1, '13896050994', '2000-01-01', '123456111697761234', '北京市某区某街道'),
                                                                                                                                                      ('S000000420', '柏半', 4, 2, 19, True, 1, '13820708436', '2000-01-01', '123456324529371234', '北京市某区某街道'),
                                                                                                                                                      ('S000000421', '褚释', 5, 2, 22, True, 1, '13846418878', '2000-01-01', '123456940802881234', '北京市某区某街道'),
                                                                                                                                                      ('S000000422', '方演', 2, 2, 2, True, 1, '13856135008', '2000-01-01', '123456433472871234', '北京市某区某街道'),
                                                                                                                                                      ('S000000423', '乐旅', 1, 3, 13, True, 1, '13823219901', '2000-01-01', '123456822740031234', '北京市某区某街道'),
                                                                                                                                                      ('S000000424', '常付', 3, 4, 6, True, 1, '13875925634', '2000-01-01', '123456921388191234', '北京市某区某街道'),
                                                                                                                                                      ('S000000425', '屈曾', 5, 2, 22, False, 1, '13863911477', '2000-01-01', '123456775541721234', '北京市某区某街道'),
                                                                                                                                                      ('S000000426', '王馆', 1, 3, 15, True, 1, '13847433268', '2000-01-01', '123456642588421234', '北京市某区某街道'),
                                                                                                                                                      ('S000000427', '贝前', 1, 3, 15, True, 1, '13830791867', '2000-01-01', '123456424800271234', '北京市某区某街道'),
                                                                                                                                                      ('S000000428', '昌转', 6, 1, 28, True, 1, '13876299583', '2000-01-01', '123456250476641234', '北京市某区某街道'),
                                                                                                                                                      ('S000000429', '王随', 6, 1, 28, False, 1, '13874773234', '2000-01-01', '123456457114621234', '北京市某区某街道'),
                                                                                                                                                      ('S000000430', '蒋严', 6, 1, 29, False, 1, '13896125627', '2000-01-01', '123456257371301234', '北京市某区某街道'),
                                                                                                                                                      ('S000000431', '袁总', 5, 2, 21, False, 1, '13886200550', '2000-01-01', '123456545741381234', '北京市某区某街道'),
                                                                                                                                                      ('S000000432', '马最', 4, 2, 20, False, 1, '13835874529', '2000-01-01', '123456162268971234', '北京市某区某街道'),
                                                                                                                                                      ('S000000433', '褚四', 2, 2, 1, True, 1, '13887980845', '2000-01-01', '123456840921911234', '北京市某区某街道'),
                                                                                                                                                      ('S000000434', '平敢', 3, 4, 7, True, 1, '13834871648', '2000-01-01', '123456732045671234', '北京市某区某街道'),
                                                                                                                                                      ('S000000435', '酆该', 1, 3, 13, False, 1, '13899148388', '2000-01-01', '123456978389681234', '北京市某区某街道'),
                                                                                                                                                      ('S000000436', '孟坐', 2, 2, 5, False, 1, '13897600965', '2000-01-01', '123456899906171234', '北京市某区某街道'),
                                                                                                                                                      ('S000000437', '凤渐', 3, 4, 6, True, 1, '13865650532', '2000-01-01', '123456981754441234', '北京市某区某街道'),
                                                                                                                                                      ('S000000438', '朱看', 3, 4, 10, True, 1, '13867987337', '2000-01-01', '123456829596241234', '北京市某区某街道'),
                                                                                                                                                      ('S000000439', '黄半', 6, 1, 28, True, 1, '13812107188', '2000-01-01', '123456286505391234', '北京市某区某街道'),
                                                                                                                                                      ('S000000440', '庞行', 6, 1, 30, False, 1, '13851154294', '2000-01-01', '123456878038041234', '北京市某区某街道'),
                                                                                                                                                      ('S000000441', '庞温', 2, 2, 3, True, 1, '13819295714', '2000-01-01', '123456299199051234', '北京市某区某街道'),
                                                                                                                                                      ('S000000442', '狄洲', 6, 1, 29, True, 1, '13836798831', '2000-01-01', '123456748472491234', '北京市某区某街道'),
                                                                                                                                                      ('S000000443', '范我', 6, 1, 30, True, 1, '13815902697', '2000-01-01', '123456862399721234', '北京市某区某街道'),
                                                                                                                                                      ('S000000444', '孙即', 3, 4, 7, False, 1, '13873889872', '2000-01-01', '123456397024751234', '北京市某区某街道'),
                                                                                                                                                      ('S000000445', '臧马', 2, 2, 2, True, 1, '13836426395', '2000-01-01', '123456561552891234', '北京市某区某街道'),
                                                                                                                                                      ('S000000446', '郎凡', 4, 2, 19, True, 1, '13860097380', '2000-01-01', '123456590895171234', '北京市某区某街道'),
                                                                                                                                                      ('S000000447', '云树', 6, 1, 30, False, 1, '13840125363', '2000-01-01', '123456526650181234', '北京市某区某街道'),
                                                                                                                                                      ('S000000448', '祝竟', 2, 2, 2, True, 1, '13826602179', '2000-01-01', '123456872894471234', '北京市某区某街道'),
                                                                                                                                                      ('S000000449', '乐退', 5, 2, 25, False, 1, '13833255824', '2000-01-01', '123456856115091234', '北京市某区某街道'),
                                                                                                                                                      ('S000000450', '项际', 6, 1, 30, False, 1, '13857862794', '2000-01-01', '123456885343321234', '北京市某区某街道'),
                                                                                                                                                      ('S000000451', '喻用', 3, 4, 8, False, 1, '13859351214', '2000-01-01', '123456525390191234', '北京市某区某街道'),
                                                                                                                                                      ('S000000452', '狄历', 5, 2, 23, True, 1, '13821599237', '2000-01-01', '123456188528151234', '北京市某区某街道'),
                                                                                                                                                      ('S000000453', '余业', 2, 2, 3, False, 1, '13868026857', '2000-01-01', '123456500895191234', '北京市某区某街道'),
                                                                                                                                                      ('S000000454', '秦获', 5, 2, 22, False, 1, '13883185719', '2000-01-01', '123456195452291234', '北京市某区某街道'),
                                                                                                                                                      ('S000000455', '方真', 1, 3, 15, False, 1, '13840230794', '2000-01-01', '123456140030311234', '北京市某区某街道'),
                                                                                                                                                      ('S000000456', '方弟', 4, 2, 19, True, 1, '13871129230', '2000-01-01', '123456565532481234', '北京市某区某街道'),
                                                                                                                                                      ('S000000457', '冯木', 3, 4, 7, False, 1, '13824032308', '2000-01-01', '123456516255441234', '北京市某区某街道'),
                                                                                                                                                      ('S000000458', '鲁往', 2, 2, 3, True, 1, '13877644081', '2000-01-01', '123456887765981234', '北京市某区某街道'),
                                                                                                                                                      ('S000000459', '舒财', 1, 3, 11, False, 1, '13827229456', '2000-01-01', '123456609405131234', '北京市某区某街道'),
                                                                                                                                                      ('S000000460', '钱别', 6, 1, 27, False, 1, '13891311606', '2000-01-01', '123456192056831234', '北京市某区某街道'),
                                                                                                                                                      ('S000000461', '祝沉', 2, 2, 1, False, 1, '13829639475', '2000-01-01', '123456586560741234', '北京市某区某街道'),
                                                                                                                                                      ('S000000462', '邹看', 5, 2, 25, True, 1, '13819676555', '2000-01-01', '123456193054371234', '北京市某区某街道'),
                                                                                                                                                      ('S000000463', '臧绝', 6, 1, 26, True, 1, '13845403429', '2000-01-01', '123456523997391234', '北京市某区某街道'),
                                                                                                                                                      ('S000000464', '郝买', 1, 3, 12, False, 1, '13870295096', '2000-01-01', '123456357315951234', '北京市某区某街道'),
                                                                                                                                                      ('S000000465', '常导', 6, 1, 27, True, 1, '13872751681', '2000-01-01', '123456843248041234', '北京市某区某街道'),
                                                                                                                                                      ('S000000466', '任住', 5, 2, 25, True, 1, '13811834659', '2000-01-01', '123456340756481234', '北京市某区某街道'),
                                                                                                                                                      ('S000000467', '彭担', 6, 1, 26, False, 1, '13829070553', '2000-01-01', '123456691043791234', '北京市某区某街道'),
                                                                                                                                                      ('S000000468', '元字', 1, 3, 13, False, 1, '13852994839', '2000-01-01', '123456906765741234', '北京市某区某街道'),
                                                                                                                                                      ('S000000469', '钱钟', 5, 2, 25, True, 1, '13843664998', '2000-01-01', '123456968022681234', '北京市某区某街道'),
                                                                                                                                                      ('S000000470', '葛都', 5, 2, 23, False, 1, '13818618681', '2000-01-01', '123456129121121234', '北京市某区某街道'),
                                                                                                                                                      ('S000000471', '金花', 5, 2, 22, True, 1, '13830689844', '2000-01-01', '123456645775511234', '北京市某区某街道'),
                                                                                                                                                      ('S000000472', '狄平', 2, 2, 1, True, 1, '13872505506', '2000-01-01', '123456328865601234', '北京市某区某街道'),
                                                                                                                                                      ('S000000473', '卜组', 1, 3, 15, True, 1, '13833978078', '2000-01-01', '123456469885521234', '北京市某区某街道'),
                                                                                                                                                      ('S000000474', '方来', 6, 1, 27, False, 1, '13872236590', '2000-01-01', '123456405207621234', '北京市某区某街道'),
                                                                                                                                                      ('S000000475', '罗命', 6, 1, 26, False, 1, '13890899393', '2000-01-01', '123456366671031234', '北京市某区某街道'),
                                                                                                                                                      ('S000000476', '邵赛', 2, 2, 4, False, 1, '13819029990', '2000-01-01', '123456785520031234', '北京市某区某街道'),
                                                                                                                                                      ('S000000477', '周样', 3, 4, 8, False, 1, '13875831242', '2000-01-01', '123456213297271234', '北京市某区某街道'),
                                                                                                                                                      ('S000000478', '沈章', 6, 1, 30, False, 1, '13859573306', '2000-01-01', '123456851224321234', '北京市某区某街道'),
                                                                                                                                                      ('S000000479', '凤觉', 2, 2, 5, True, 1, '13883336723', '2000-01-01', '123456826289201234', '北京市某区某街道'),
                                                                                                                                                      ('S000000480', '庞同', 6, 1, 26, False, 1, '13826804626', '2000-01-01', '123456391654391234', '北京市某区某街道'),
                                                                                                                                                      ('S000000481', '孔民', 4, 2, 17, True, 1, '13886035837', '2000-01-01', '123456983524391234', '北京市某区某街道'),
                                                                                                                                                      ('S000000482', '褚赛', 1, 3, 11, False, 1, '13872171499', '2000-01-01', '123456504601921234', '北京市某区某街道'),
                                                                                                                                                      ('S000000483', '汤明', 5, 2, 25, False, 1, '13855075769', '2000-01-01', '123456227496681234', '北京市某区某街道'),
                                                                                                                                                      ('S000000484', '柳骨', 2, 2, 5, False, 1, '13851965475', '2000-01-01', '123456352088971234', '北京市某区某街道'),
                                                                                                                                                      ('S000000485', '汤将', 5, 2, 23, False, 1, '13894385335', '2000-01-01', '123456417036611234', '北京市某区某街道'),
                                                                                                                                                      ('S000000486', '臧乎', 3, 4, 6, True, 1, '13810148834', '2000-01-01', '123456235625731234', '北京市某区某街道'),
                                                                                                                                                      ('S000000487', '吴蒙', 6, 1, 26, True, 1, '13825205043', '2000-01-01', '123456628730771234', '北京市某区某街道'),
                                                                                                                                                      ('S000000488', '张亲', 3, 4, 8, False, 1, '13826672041', '2000-01-01', '123456727287591234', '北京市某区某街道'),
                                                                                                                                                      ('S000000489', '黄住', 2, 2, 5, False, 1, '13899532158', '2000-01-01', '123456418880721234', '北京市某区某街道'),
                                                                                                                                                      ('S000000490', '奚纪', 2, 2, 5, True, 1, '13827897066', '2000-01-01', '123456724564261234', '北京市某区某街道'),
                                                                                                                                                      ('S000000491', '尹坐', 4, 2, 20, False, 1, '13896871899', '2000-01-01', '123456208422281234', '北京市某区某街道'),
                                                                                                                                                      ('S000000492', '贝护', 4, 2, 18, True, 1, '13829414588', '2000-01-01', '123456557593541234', '北京市某区某街道'),
                                                                                                                                                      ('S000000493', '严船', 1, 3, 15, False, 1, '13836779461', '2000-01-01', '123456115783671234', '北京市某区某街道'),
                                                                                                                                                      ('S000000494', '蒋断', 1, 3, 11, False, 1, '13864105191', '2000-01-01', '123456266173451234', '北京市某区某街道'),
                                                                                                                                                      ('S000000495', '李连', 3, 4, 7, True, 1, '13898978188', '2000-01-01', '123456899759681234', '北京市某区某街道'),
                                                                                                                                                      ('S000000496', '成且', 6, 1, 27, True, 1, '13847613726', '2000-01-01', '123456571524381234', '北京市某区某街道'),
                                                                                                                                                      ('S000000497', '袁器', 5, 2, 21, True, 1, '13845544718', '2000-01-01', '123456208286961234', '北京市某区某街道'),
                                                                                                                                                      ('S000000498', '葛意', 4, 2, 18, True, 1, '13862939720', '2000-01-01', '123456824805711234', '北京市某区某街道'),
                                                                                                                                                      ('S000000499', '史引', 2, 2, 5, False, 1, '13836604213', '2000-01-01', '123456748344201234', '北京市某区某街道'),
                                                                                                                                                      ('S000000500', '薛紧', 3, 4, 9, True, 1, '13880925545', '2000-01-01', '123456932866081234', '北京市某区某街道'),
                                                                                                                                                      ('S000000501', '纪成', 1, 3, 12, False, 1, '13868188859', '2000-01-01', '123456458306901234', '北京市某区某街道'),
                                                                                                                                                      ('S000000502', '沈缺', 6, 1, 30, True, 1, '13882583878', '2000-01-01', '123456936417231234', '北京市某区某街道'),
                                                                                                                                                      ('S000000503', '韦起', 2, 2, 5, False, 1, '13812472544', '2000-01-01', '123456270252701234', '北京市某区某街道'),
                                                                                                                                                      ('S000000504', '舒强', 2, 2, 2, True, 1, '13867187032', '2000-01-01', '123456797824311234', '北京市某区某街道'),
                                                                                                                                                      ('S000000505', '雷宫', 1, 3, 12, True, 1, '13894022887', '2000-01-01', '123456179671011234', '北京市某区某街道'),
                                                                                                                                                      ('S000000506', '戴皇', 6, 1, 30, True, 1, '13879793742', '2000-01-01', '123456736107971234', '北京市某区某街道'),
                                                                                                                                                      ('S000000507', '和九', 1, 3, 15, True, 1, '13813812154', '2000-01-01', '123456274748571234', '北京市某区某街道'),
                                                                                                                                                      ('S000000508', '戚及', 6, 1, 30, True, 1, '13814343546', '2000-01-01', '123456251007401234', '北京市某区某街道'),
                                                                                                                                                      ('S000000509', '于劳', 4, 2, 16, False, 1, '13877452786', '2000-01-01', '123456125045561234', '北京市某区某街道'),
                                                                                                                                                      ('S000000510', '唐份', 6, 1, 28, False, 1, '13817946984', '2000-01-01', '123456844393811234', '北京市某区某街道'),
                                                                                                                                                      ('S000000511', '苗近', 3, 4, 6, True, 1, '13873733622', '2000-01-01', '123456424745681234', '北京市某区某街道'),
                                                                                                                                                      ('S000000512', '贝想', 4, 2, 20, True, 1, '13887607976', '2000-01-01', '123456344922611234', '北京市某区某街道'),
                                                                                                                                                      ('S000000513', '殷亚', 1, 3, 12, True, 1, '13865256192', '2000-01-01', '123456556706301234', '北京市某区某街道'),
                                                                                                                                                      ('S000000514', '曹实', 4, 2, 17, True, 1, '13872799264', '2000-01-01', '123456650015981234', '北京市某区某街道'),
                                                                                                                                                      ('S000000515', '花追', 1, 3, 15, False, 1, '13850295923', '2000-01-01', '123456603533031234', '北京市某区某街道'),
                                                                                                                                                      ('S000000516', '倪模', 3, 4, 7, True, 1, '13874986848', '2000-01-01', '123456761702681234', '北京市某区某街道'),
                                                                                                                                                      ('S000000517', '范恋', 2, 2, 4, True, 1, '13857562654', '2000-01-01', '123456617733181234', '北京市某区某街道'),
                                                                                                                                                      ('S000000518', '周何', 1, 3, 11, True, 1, '13852732086', '2000-01-01', '123456540177211234', '北京市某区某街道'),
                                                                                                                                                      ('S000000519', '齐特', 2, 2, 2, False, 1, '13883272629', '2000-01-01', '123456945192601234', '北京市某区某街道'),
                                                                                                                                                      ('S000000520', '顾班', 1, 3, 13, True, 1, '13835384702', '2000-01-01', '123456890592651234', '北京市某区某街道'),
                                                                                                                                                      ('S000000521', '孟程', 6, 1, 27, True, 1, '13887298435', '2000-01-01', '123456805734831234', '北京市某区某街道'),
                                                                                                                                                      ('S000000522', '明永', 3, 4, 10, False, 1, '13825255188', '2000-01-01', '123456855543991234', '北京市某区某街道'),
                                                                                                                                                      ('S000000523', '奚微', 5, 2, 23, True, 1, '13842469113', '2000-01-01', '123456177463411234', '北京市某区某街道'),
                                                                                                                                                      ('S000000524', '安字', 5, 2, 21, True, 1, '13895556269', '2000-01-01', '123456533015761234', '北京市某区某街道'),
                                                                                                                                                      ('S000000525', '时充', 1, 3, 11, False, 1, '13855395893', '2000-01-01', '123456491798581234', '北京市某区某街道'),
                                                                                                                                                      ('S000000526', '于永', 2, 2, 1, False, 1, '13874900908', '2000-01-01', '123456619067851234', '北京市某区某街道'),
                                                                                                                                                      ('S000000527', '毕斯', 6, 1, 30, True, 1, '13841282782', '2000-01-01', '123456595912241234', '北京市某区某街道'),
                                                                                                                                                      ('S000000528', '俞留', 3, 4, 10, False, 1, '13886551114', '2000-01-01', '123456435900581234', '北京市某区某街道'),
                                                                                                                                                      ('S000000529', '元牌', 1, 3, 15, True, 1, '13819314654', '2000-01-01', '123456581586011234', '北京市某区某街道'),
                                                                                                                                                      ('S000000530', '凤歌', 1, 3, 15, False, 1, '13836672936', '2000-01-01', '123456883840171234', '北京市某区某街道'),
                                                                                                                                                      ('S000000531', '凤科', 1, 3, 12, False, 1, '13856696668', '2000-01-01', '123456871789121234', '北京市某区某街道'),
                                                                                                                                                      ('S000000532', '戚冷', 1, 3, 14, True, 1, '13880063906', '2000-01-01', '123456911731301234', '北京市某区某街道'),
                                                                                                                                                      ('S000000533', '屈奇', 2, 2, 4, False, 1, '13891034440', '2000-01-01', '123456936786851234', '北京市某区某街道'),
                                                                                                                                                      ('S000000534', '倪木', 5, 2, 21, False, 1, '13823262463', '2000-01-01', '123456978158011234', '北京市某区某街道'),
                                                                                                                                                      ('S000000535', '贺尔', 5, 2, 25, True, 1, '13874383860', '2000-01-01', '123456409587611234', '北京市某区某街道'),
                                                                                                                                                      ('S000000536', '戴拿', 6, 1, 27, True, 1, '13833020047', '2000-01-01', '123456956957571234', '北京市某区某街道'),
                                                                                                                                                      ('S000000537', '郝半', 1, 3, 15, False, 1, '13812474258', '2000-01-01', '123456995236131234', '北京市某区某街道'),
                                                                                                                                                      ('S000000538', '梁楼', 2, 2, 2, True, 1, '13831263049', '2000-01-01', '123456226906691234', '北京市某区某街道'),
                                                                                                                                                      ('S000000539', '卞止', 3, 4, 9, False, 1, '13866753137', '2000-01-01', '123456385739471234', '北京市某区某街道'),
                                                                                                                                                      ('S000000540', '李灵', 3, 4, 9, False, 1, '13813263701', '2000-01-01', '123456168097321234', '北京市某区某街道'),
                                                                                                                                                      ('S000000541', '方电', 1, 3, 12, True, 1, '13823570325', '2000-01-01', '123456817252361234', '北京市某区某街道'),
                                                                                                                                                      ('S000000542', '朱斯', 6, 1, 30, False, 1, '13812967698', '2000-01-01', '123456228331451234', '北京市某区某街道'),
                                                                                                                                                      ('S000000543', '邬天', 4, 2, 19, False, 1, '13878339443', '2000-01-01', '123456265691841234', '北京市某区某街道'),
                                                                                                                                                      ('S000000544', '吴遍', 2, 2, 3, False, 1, '13887628104', '2000-01-01', '123456866387141234', '北京市某区某街道'),
                                                                                                                                                      ('S000000545', '宋琴', 1, 3, 12, False, 1, '13824213811', '2000-01-01', '123456794098561234', '北京市某区某街道'),
                                                                                                                                                      ('S000000546', '谢教', 5, 2, 25, True, 1, '13839603440', '2000-01-01', '123456817841541234', '北京市某区某街道'),
                                                                                                                                                      ('S000000547', '成陈', 2, 2, 3, True, 1, '13883705612', '2000-01-01', '123456341264471234', '北京市某区某街道'),
                                                                                                                                                      ('S000000548', '滕内', 4, 2, 20, True, 1, '13839227892', '2000-01-01', '123456776042861234', '北京市某区某街道'),
                                                                                                                                                      ('S000000549', '吕烧', 4, 2, 17, True, 1, '13883781630', '2000-01-01', '123456185501841234', '北京市某区某街道'),
                                                                                                                                                      ('S000000550', '赵紶', 6, 1, 30, True, 1, '13827074423', '2000-01-01', '123456906319071234', '北京市某区某街道'),
                                                                                                                                                      ('S000000551', '岑洛', 5, 2, 23, True, 1, '13888920401', '2000-01-01', '123456179197721234', '北京市某区某街道'),
                                                                                                                                                      ('S000000552', '喻佛', 1, 3, 14, True, 1, '13895492837', '2000-01-01', '123456297604541234', '北京市某区某街道'),
                                                                                                                                                      ('S000000553', '柏独', 1, 3, 14, False, 1, '13841471782', '2000-01-01', '123456910454391234', '北京市某区某街道'),
                                                                                                                                                      ('S000000554', '萧性', 1, 3, 14, True, 1, '13818066408', '2000-01-01', '123456932687921234', '北京市某区某街道'),
                                                                                                                                                      ('S000000555', '元担', 4, 2, 19, False, 1, '13885398375', '2000-01-01', '123456688702131234', '北京市某区某街道'),
                                                                                                                                                      ('S000000556', '褚舞', 4, 2, 16, True, 1, '13881122404', '2000-01-01', '123456367378131234', '北京市某区某街道'),
                                                                                                                                                      ('S000000557', '毕汉', 5, 2, 23, False, 1, '13833243722', '2000-01-01', '123456563502671234', '北京市某区某街道'),
                                                                                                                                                      ('S000000558', '严答', 1, 3, 13, False, 1, '13897150757', '2000-01-01', '123456897345851234', '北京市某区某街道'),
                                                                                                                                                      ('S000000559', '傅祖', 2, 2, 1, True, 1, '13846789796', '2000-01-01', '123456150922771234', '北京市某区某街道'),
                                                                                                                                                      ('S000000560', '元律', 6, 1, 30, True, 1, '13827663316', '2000-01-01', '123456747415141234', '北京市某区某街道'),
                                                                                                                                                      ('S000000561', '戚拿', 1, 3, 11, True, 1, '13830337926', '2000-01-01', '123456717410441234', '北京市某区某街道'),
                                                                                                                                                      ('S000000562', '苗创', 1, 3, 12, False, 1, '13847782951', '2000-01-01', '123456355048481234', '北京市某区某街道'),
                                                                                                                                                      ('S000000563', '窦我', 1, 3, 12, False, 1, '13871069213', '2000-01-01', '123456871896611234', '北京市某区某街道'),
                                                                                                                                                      ('S000000564', '成寻', 1, 3, 12, True, 1, '13898362607', '2000-01-01', '123456767362751234', '北京市某区某街道'),
                                                                                                                                                      ('S000000565', '顾做', 4, 2, 17, True, 1, '13830647060', '2000-01-01', '123456251849761234', '北京市某区某街道'),
                                                                                                                                                      ('S000000566', '戚汉', 2, 2, 3, True, 1, '13822649706', '2000-01-01', '123456664457551234', '北京市某区某街道'),
                                                                                                                                                      ('S000000567', '齐车', 5, 2, 25, False, 1, '13863663762', '2000-01-01', '123456561085531234', '北京市某区某街道'),
                                                                                                                                                      ('S000000568', '邬局', 2, 2, 2, True, 1, '13837440141', '2000-01-01', '123456984463631234', '北京市某区某街道'),
                                                                                                                                                      ('S000000569', '周价', 1, 3, 12, True, 1, '13887072262', '2000-01-01', '123456103183261234', '北京市某区某街道'),
                                                                                                                                                      ('S000000570', '于承', 4, 2, 17, False, 1, '13870355348', '2000-01-01', '123456649573051234', '北京市某区某街道'),
                                                                                                                                                      ('S000000571', '魏睛', 1, 3, 12, False, 1, '13879370611', '2000-01-01', '123456155988571234', '北京市某区某街道'),
                                                                                                                                                      ('S000000572', '韩议', 4, 2, 18, True, 1, '13856920269', '2000-01-01', '123456418967481234', '北京市某区某街道'),
                                                                                                                                                      ('S000000573', '鲍叫', 2, 2, 4, True, 1, '13882992440', '2000-01-01', '123456813894651234', '北京市某区某街道'),
                                                                                                                                                      ('S000000574', '郑举', 1, 3, 13, False, 1, '13866004685', '2000-01-01', '123456650138591234', '北京市某区某街道'),
                                                                                                                                                      ('S000000575', '酆降', 6, 1, 28, False, 1, '13888765180', '2000-01-01', '123456955959291234', '北京市某区某街道'),
                                                                                                                                                      ('S000000576', '云六', 1, 3, 15, False, 1, '13877352207', '2000-01-01', '123456966267721234', '北京市某区某街道'),
                                                                                                                                                      ('S000000577', '钱险', 4, 2, 16, True, 1, '13837456652', '2000-01-01', '123456977701091234', '北京市某区某街道'),
                                                                                                                                                      ('S000000578', '史座', 5, 2, 22, True, 1, '13897467274', '2000-01-01', '123456305678441234', '北京市某区某街道'),
                                                                                                                                                      ('S000000579', '花道', 1, 3, 15, False, 1, '13887687416', '2000-01-01', '123456163712771234', '北京市某区某街道'),
                                                                                                                                                      ('S000000580', '赵屋', 2, 2, 4, True, 1, '13829956935', '2000-01-01', '123456584126431234', '北京市某区某街道'),
                                                                                                                                                      ('S000000581', '时杂', 5, 2, 24, False, 1, '13828841885', '2000-01-01', '123456960264491234', '北京市某区某街道'),
                                                                                                                                                      ('S000000582', '周开', 1, 3, 14, False, 1, '13843888503', '2000-01-01', '123456544714471234', '北京市某区某街道'),
                                                                                                                                                      ('S000000583', '任赶', 2, 2, 5, False, 1, '13853865943', '2000-01-01', '123456946770711234', '北京市某区某街道'),
                                                                                                                                                      ('S000000584', '舒球', 4, 2, 16, False, 1, '13836801931', '2000-01-01', '123456848262661234', '北京市某区某街道'),
                                                                                                                                                      ('S000000585', '吕运', 2, 2, 1, False, 1, '13810372072', '2000-01-01', '123456413950151234', '北京市某区某街道'),
                                                                                                                                                      ('S000000586', '罗续', 6, 1, 28, False, 1, '13823390516', '2000-01-01', '123456653249791234', '北京市某区某街道'),
                                                                                                                                                      ('S000000587', '计首', 6, 1, 29, False, 1, '13894137665', '2000-01-01', '123456435311281234', '北京市某区某街道'),
                                                                                                                                                      ('S000000588', '施维', 1, 3, 15, True, 1, '13833332000', '2000-01-01', '123456500782391234', '北京市某区某街道'),
                                                                                                                                                      ('S000000589', '戴梦', 3, 4, 9, True, 1, '13818305654', '2000-01-01', '123456167021791234', '北京市某区某街道'),
                                                                                                                                                      ('S000000590', '唐因', 1, 3, 15, True, 1, '13884413430', '2000-01-01', '123456237991631234', '北京市某区某街道'),
                                                                                                                                                      ('S000000591', '邵既', 4, 2, 20, True, 1, '13880276278', '2000-01-01', '123456552071771234', '北京市某区某街道'),
                                                                                                                                                      ('S000000592', '邵喝', 2, 2, 4, False, 1, '13812679600', '2000-01-01', '123456375571371234', '北京市某区某街道'),
                                                                                                                                                      ('S000000593', '韩体', 4, 2, 16, True, 1, '13873290441', '2000-01-01', '123456167118741234', '北京市某区某街道'),
                                                                                                                                                      ('S000000594', '舒蒙', 2, 2, 1, True, 1, '13812763999', '2000-01-01', '123456806946341234', '北京市某区某街道'),
                                                                                                                                                      ('S000000595', '伍五', 2, 2, 3, True, 1, '13846294715', '2000-01-01', '123456233172141234', '北京市某区某街道'),
                                                                                                                                                      ('S000000596', '舒连', 2, 2, 1, False, 1, '13898043680', '2000-01-01', '123456942003361234', '北京市某区某街道'),
                                                                                                                                                      ('S000000597', '萧本', 4, 2, 17, True, 1, '13823882787', '2000-01-01', '123456577494921234', '北京市某区某街道'),
                                                                                                                                                      ('S000000598', '安去', 2, 2, 3, False, 1, '13840432531', '2000-01-01', '123456236255401234', '北京市某区某街道'),
                                                                                                                                                      ('S000000599', '韩弟', 1, 3, 11, True, 1, '13870581425', '2000-01-01', '123456340817931234', '北京市某区某街道'),
                                                                                                                                                      ('S000000600', '祝何', 3, 4, 8, True, 1, '13899740060', '2000-01-01', '123456225015221234', '北京市某区某街道'),
                                                                                                                                                      ('S000000601', '秦晚', 1, 3, 14, True, 1, '13813155392', '2000-01-01', '123456633351811234', '北京市某区某街道'),
                                                                                                                                                      ('S000000602', '华波', 4, 2, 20, False, 1, '13814698010', '2000-01-01', '123456928681631234', '北京市某区某街道'),
                                                                                                                                                      ('S000000603', '王过', 3, 4, 9, False, 1, '13849536866', '2000-01-01', '123456317107621234', '北京市某区某街道'),
                                                                                                                                                      ('S000000604', '傅热', 2, 2, 4, False, 1, '13864988935', '2000-01-01', '123456972232381234', '北京市某区某街道'),
                                                                                                                                                      ('S000000605', '马年', 2, 2, 4, True, 1, '13816984659', '2000-01-01', '123456400871151234', '北京市某区某街道'),
                                                                                                                                                      ('S000000606', '卫伦', 1, 3, 12, True, 1, '13854317271', '2000-01-01', '123456659671451234', '北京市某区某街道'),
                                                                                                                                                      ('S000000607', '赵胡', 5, 2, 25, True, 1, '13837866117', '2000-01-01', '123456517147851234', '北京市某区某街道'),
                                                                                                                                                      ('S000000608', '邬健', 6, 1, 30, True, 1, '13829333069', '2000-01-01', '123456771140631234', '北京市某区某街道'),
                                                                                                                                                      ('S000000609', '戚更', 5, 2, 25, False, 1, '13813759411', '2000-01-01', '123456456779061234', '北京市某区某街道'),
                                                                                                                                                      ('S000000610', '狄或', 1, 3, 15, False, 1, '13889472036', '2000-01-01', '123456106463491234', '北京市某区某街道'),
                                                                                                                                                      ('S000000611', '彭推', 4, 2, 18, True, 1, '13886186379', '2000-01-01', '123456793938871234', '北京市某区某街道'),
                                                                                                                                                      ('S000000612', '和哥', 1, 3, 14, True, 1, '13852687202', '2000-01-01', '123456158769841234', '北京市某区某街道'),
                                                                                                                                                      ('S000000613', '董格', 3, 4, 7, True, 1, '13841383869', '2000-01-01', '123456918980681234', '北京市某区某街道'),
                                                                                                                                                      ('S000000614', '萧丽', 3, 4, 10, True, 1, '13814384245', '2000-01-01', '123456644513431234', '北京市某区某街道'),
                                                                                                                                                      ('S000000615', '和女', 5, 2, 24, True, 1, '13840142938', '2000-01-01', '123456932079631234', '北京市某区某街道'),
                                                                                                                                                      ('S000000616', '周卡', 6, 1, 26, True, 1, '13890794454', '2000-01-01', '123456616027201234', '北京市某区某街道'),
                                                                                                                                                      ('S000000617', '陶做', 2, 2, 1, True, 1, '13898384840', '2000-01-01', '123456444537081234', '北京市某区某街道'),
                                                                                                                                                      ('S000000618', '堪坚', 4, 2, 16, False, 1, '13878550693', '2000-01-01', '123456150700021234', '北京市某区某街道'),
                                                                                                                                                      ('S000000619', '陈智', 5, 2, 22, False, 1, '13835458599', '2000-01-01', '123456677504821234', '北京市某区某街道'),
                                                                                                                                                      ('S000000620', '宋艺', 5, 2, 23, True, 1, '13823411913', '2000-01-01', '123456448782811234', '北京市某区某街道'),
                                                                                                                                                      ('S000000621', '云毛', 2, 2, 5, False, 1, '13820285051', '2000-01-01', '123456667844091234', '北京市某区某街道'),
                                                                                                                                                      ('S000000622', '水命', 1, 3, 15, True, 1, '13880930950', '2000-01-01', '123456697094951234', '北京市某区某街道'),
                                                                                                                                                      ('S000000623', '韩升', 3, 4, 10, True, 1, '13874983054', '2000-01-01', '123456248940451234', '北京市某区某街道'),
                                                                                                                                                      ('S000000624', '皮遗', 1, 3, 15, False, 1, '13815417470', '2000-01-01', '123456140790751234', '北京市某区某街道'),
                                                                                                                                                      ('S000000625', '苏礼', 2, 2, 4, False, 1, '13860978278', '2000-01-01', '123456353508041234', '北京市某区某街道'),
                                                                                                                                                      ('S000000626', '常高', 2, 2, 1, False, 1, '13858692217', '2000-01-01', '123456667860561234', '北京市某区某街道'),
                                                                                                                                                      ('S000000627', '薛照', 6, 1, 26, True, 1, '13823470967', '2000-01-01', '123456981270021234', '北京市某区某街道'),
                                                                                                                                                      ('S000000628', '祁和', 2, 2, 2, True, 1, '13854438387', '2000-01-01', '123456455315381234', '北京市某区某街道'),
                                                                                                                                                      ('S000000629', '史原', 5, 2, 23, True, 1, '13898038729', '2000-01-01', '123456378805941234', '北京市某区某街道'),
                                                                                                                                                      ('S000000630', '平提', 2, 2, 3, False, 1, '13874654836', '2000-01-01', '123456160918361234', '北京市某区某街道'),
                                                                                                                                                      ('S000000631', '汤物', 5, 2, 25, False, 1, '13866177919', '2000-01-01', '123456695668231234', '北京市某区某街道'),
                                                                                                                                                      ('S000000632', '葛感', 3, 4, 6, False, 1, '13849532651', '2000-01-01', '123456558000891234', '北京市某区某街道'),
                                                                                                                                                      ('S000000633', '彭杰', 3, 4, 9, False, 1, '13879616141', '2000-01-01', '123456502395691234', '北京市某区某街道'),
                                                                                                                                                      ('S000000634', '毕排', 5, 2, 24, True, 1, '13881682128', '2000-01-01', '123456281681311234', '北京市某区某街道'),
                                                                                                                                                      ('S000000635', '陶球', 5, 2, 23, True, 1, '13868633872', '2000-01-01', '123456359916601234', '北京市某区某街道'),
                                                                                                                                                      ('S000000636', '卫术', 5, 2, 25, False, 1, '13844687310', '2000-01-01', '123456511951161234', '北京市某区某街道'),
                                                                                                                                                      ('S000000637', '廉个', 2, 2, 3, True, 1, '13846956128', '2000-01-01', '123456726307841234', '北京市某区某街道'),
                                                                                                                                                      ('S000000638', '卜热', 4, 2, 19, False, 1, '13880227921', '2000-01-01', '123456220422421234', '北京市某区某街道'),
                                                                                                                                                      ('S000000639', '滕招', 2, 2, 1, False, 1, '13827014243', '2000-01-01', '123456983123771234', '北京市某区某街道'),
                                                                                                                                                      ('S000000640', '邹连', 1, 3, 15, False, 1, '13815958972', '2000-01-01', '123456853922011234', '北京市某区某街道'),
                                                                                                                                                      ('S000000641', '米女', 5, 2, 22, True, 1, '13822011752', '2000-01-01', '123456197341181234', '北京市某区某街道'),
                                                                                                                                                      ('S000000642', '邵干', 3, 4, 6, False, 1, '13884556072', '2000-01-01', '123456628423931234', '北京市某区某街道'),
                                                                                                                                                      ('S000000643', '曹冲', 3, 4, 6, False, 1, '13835380068', '2000-01-01', '123456687459011234', '北京市某区某街道'),
                                                                                                                                                      ('S000000644', '臧睡', 6, 1, 27, True, 1, '13824154769', '2000-01-01', '123456767215601234', '北京市某区某街道'),
                                                                                                                                                      ('S000000645', '尹雷', 1, 3, 13, True, 1, '13815894691', '2000-01-01', '123456677832591234', '北京市某区某街道'),
                                                                                                                                                      ('S000000646', '纪待', 5, 2, 23, False, 1, '13821700245', '2000-01-01', '123456684332831234', '北京市某区某街道'),
                                                                                                                                                      ('S000000647', '曹己', 4, 2, 18, False, 1, '13850786752', '2000-01-01', '123456102419141234', '北京市某区某街道'),
                                                                                                                                                      ('S000000648', '苗坏', 5, 2, 23, False, 1, '13885733035', '2000-01-01', '123456589821741234', '北京市某区某街道'),
                                                                                                                                                      ('S000000649', '尹欢', 4, 2, 20, False, 1, '13826603289', '2000-01-01', '123456636506531234', '北京市某区某街道'),
                                                                                                                                                      ('S000000650', '褚者', 1, 3, 12, True, 1, '13812094036', '2000-01-01', '123456166962731234', '北京市某区某街道'),
                                                                                                                                                      ('S000000651', '米紶', 3, 4, 8, False, 1, '13891591471', '2000-01-01', '123456547808081234', '北京市某区某街道'),
                                                                                                                                                      ('S000000652', '屈银', 6, 1, 26, False, 1, '13842366202', '2000-01-01', '123456145491431234', '北京市某区某街道'),
                                                                                                                                                      ('S000000653', '堪微', 4, 2, 16, True, 1, '13851199954', '2000-01-01', '123456822174591234', '北京市某区某街道'),
                                                                                                                                                      ('S000000654', '贝美', 4, 2, 20, False, 1, '13893880995', '2000-01-01', '123456472404721234', '北京市某区某街道'),
                                                                                                                                                      ('S000000655', '堪怪', 6, 1, 28, False, 1, '13845376125', '2000-01-01', '123456543636441234', '北京市某区某街道'),
                                                                                                                                                      ('S000000656', '范党', 3, 4, 7, True, 1, '13872481040', '2000-01-01', '123456575747431234', '北京市某区某街道'),
                                                                                                                                                      ('S000000657', '云不', 6, 1, 29, False, 1, '13839283587', '2000-01-01', '123456678311261234', '北京市某区某街道'),
                                                                                                                                                      ('S000000658', '云众', 6, 1, 28, False, 1, '13852831556', '2000-01-01', '123456384644761234', '北京市某区某街道'),
                                                                                                                                                      ('S000000659', '赵无', 3, 4, 9, True, 1, '13879616847', '2000-01-01', '123456314300881234', '北京市某区某街道'),
                                                                                                                                                      ('S000000660', '俞你', 4, 2, 16, True, 1, '13831649889', '2000-01-01', '123456810046711234', '北京市某区某街道'),
                                                                                                                                                      ('S000000661', '施婚', 6, 1, 30, False, 1, '13842360818', '2000-01-01', '123456175221911234', '北京市某区某街道'),
                                                                                                                                                      ('S000000662', '康海', 1, 3, 13, True, 1, '13842632847', '2000-01-01', '123456777002031234', '北京市某区某街道'),
                                                                                                                                                      ('S000000663', '尤州', 5, 2, 25, True, 1, '13824687968', '2000-01-01', '123456137624631234', '北京市某区某街道'),
                                                                                                                                                      ('S000000664', '于笔', 5, 2, 24, False, 1, '13888350315', '2000-01-01', '123456706882811234', '北京市某区某街道'),
                                                                                                                                                      ('S000000665', '酆等', 3, 4, 8, True, 1, '13827781872', '2000-01-01', '123456681424731234', '北京市某区某街道'),
                                                                                                                                                      ('S000000666', '滕五', 1, 3, 15, False, 1, '13898889847', '2000-01-01', '123456566456341234', '北京市某区某街道'),
                                                                                                                                                      ('S000000667', '董注', 1, 3, 12, False, 1, '13896759188', '2000-01-01', '123456775894501234', '北京市某区某街道'),
                                                                                                                                                      ('S000000668', '袁雪', 3, 4, 10, True, 1, '13894590464', '2000-01-01', '123456731707731234', '北京市某区某街道'),
                                                                                                                                                      ('S000000669', '禹朝', 5, 2, 21, True, 1, '13882252069', '2000-01-01', '123456735719741234', '北京市某区某街道'),
                                                                                                                                                      ('S000000670', '唐承', 1, 3, 11, False, 1, '13855816710', '2000-01-01', '123456362659601234', '北京市某区某街道'),
                                                                                                                                                      ('S000000671', '酆师', 6, 1, 28, True, 1, '13899385245', '2000-01-01', '123456478206941234', '北京市某区某街道'),
                                                                                                                                                      ('S000000672', '凤玩', 6, 1, 26, True, 1, '13839478846', '2000-01-01', '123456563058801234', '北京市某区某街道'),
                                                                                                                                                      ('S000000673', '喻道', 1, 3, 11, False, 1, '13880035988', '2000-01-01', '123456800236921234', '北京市某区某街道'),
                                                                                                                                                      ('S000000674', '米离', 3, 4, 6, False, 1, '13849521299', '2000-01-01', '123456336646411234', '北京市某区某街道'),
                                                                                                                                                      ('S000000675', '喻甚', 2, 2, 3, True, 1, '13858181997', '2000-01-01', '123456449479061234', '北京市某区某街道'),
                                                                                                                                                      ('S000000676', '卞寻', 1, 3, 12, True, 1, '13833011536', '2000-01-01', '123456602322751234', '北京市某区某街道'),
                                                                                                                                                      ('S000000677', '安梦', 4, 2, 20, False, 1, '13853558558', '2000-01-01', '123456248544181234', '北京市某区某街道'),
                                                                                                                                                      ('S000000678', '元流', 6, 1, 27, True, 1, '13899153683', '2000-01-01', '123456586101781234', '北京市某区某街道'),
                                                                                                                                                      ('S000000679', '方副', 3, 4, 9, False, 1, '13894920691', '2000-01-01', '123456415980601234', '北京市某区某街道'),
                                                                                                                                                      ('S000000680', '云脚', 3, 4, 7, True, 1, '13844437401', '2000-01-01', '123456204761361234', '北京市某区某街道'),
                                                                                                                                                      ('S000000681', '葛外', 6, 1, 28, True, 1, '13872524146', '2000-01-01', '123456206837021234', '北京市某区某街道'),
                                                                                                                                                      ('S000000682', '庞皇', 1, 3, 14, True, 1, '13867117181', '2000-01-01', '123456997075081234', '北京市某区某街道'),
                                                                                                                                                      ('S000000683', '和把', 2, 2, 2, False, 1, '13898725540', '2000-01-01', '123456415071661234', '北京市某区某街道'),
                                                                                                                                                      ('S000000684', '乐群', 5, 2, 23, True, 1, '13896623170', '2000-01-01', '123456902043931234', '北京市某区某街道'),
                                                                                                                                                      ('S000000685', '鲁命', 2, 2, 5, True, 1, '13861046290', '2000-01-01', '123456387037571234', '北京市某区某街道'),
                                                                                                                                                      ('S000000686', '纪斯', 6, 1, 27, False, 1, '13866609844', '2000-01-01', '123456236570981234', '北京市某区某街道'),
                                                                                                                                                      ('S000000687', '窦野', 3, 4, 8, True, 1, '13820297721', '2000-01-01', '123456581133661234', '北京市某区某街道'),
                                                                                                                                                      ('S000000688', '柳兴', 2, 2, 4, True, 1, '13899080880', '2000-01-01', '123456522181651234', '北京市某区某街道'),
                                                                                                                                                      ('S000000689', '沈境', 3, 4, 10, True, 1, '13823165137', '2000-01-01', '123456434044911234', '北京市某区某街道'),
                                                                                                                                                      ('S000000690', '苗知', 5, 2, 24, False, 1, '13850967712', '2000-01-01', '123456699213931234', '北京市某区某街道'),
                                                                                                                                                      ('S000000691', '方靠', 4, 2, 16, False, 1, '13891842816', '2000-01-01', '123456328242251234', '北京市某区某街道'),
                                                                                                                                                      ('S000000692', '宋面', 6, 1, 30, False, 1, '13879868222', '2000-01-01', '123456579575781234', '北京市某区某街道'),
                                                                                                                                                      ('S000000693', '伍个', 2, 2, 2, False, 1, '13874336767', '2000-01-01', '123456635741001234', '北京市某区某街道'),
                                                                                                                                                      ('S000000694', '花杂', 5, 2, 21, False, 1, '13855626271', '2000-01-01', '123456196767051234', '北京市某区某街道'),
                                                                                                                                                      ('S000000695', '平东', 2, 2, 2, False, 1, '13883608252', '2000-01-01', '123456879907191234', '北京市某区某街道'),
                                                                                                                                                      ('S000000696', '俞跳', 6, 1, 28, True, 1, '13877546827', '2000-01-01', '123456769667661234', '北京市某区某街道'),
                                                                                                                                                      ('S000000697', '马导', 1, 3, 13, False, 1, '13898099119', '2000-01-01', '123456750312581234', '北京市某区某街道'),
                                                                                                                                                      ('S000000698', '倪岁', 5, 2, 25, True, 1, '13895591019', '2000-01-01', '123456916180631234', '北京市某区某街道'),
                                                                                                                                                      ('S000000699', '俞优', 4, 2, 18, True, 1, '13863858347', '2000-01-01', '123456333271531234', '北京市某区某街道'),
                                                                                                                                                      ('S000000700', '祁划', 4, 2, 18, False, 1, '13842088977', '2000-01-01', '123456834688761234', '北京市某区某街道'),
                                                                                                                                                      ('S000000701', '凤母', 4, 2, 17, True, 1, '13881377921', '2000-01-01', '123456630566141234', '北京市某区某街道'),
                                                                                                                                                      ('S000000702', '殷写', 5, 2, 25, False, 1, '13813774110', '2000-01-01', '123456910305161234', '北京市某区某街道'),
                                                                                                                                                      ('S000000703', '苗势', 1, 3, 12, True, 1, '13818980673', '2000-01-01', '123456863456431234', '北京市某区某街道'),
                                                                                                                                                      ('S000000704', '魏校', 1, 3, 11, True, 1, '13855653571', '2000-01-01', '123456704524491234', '北京市某区某街道'),
                                                                                                                                                      ('S000000705', '谢可', 6, 1, 26, True, 1, '13897753197', '2000-01-01', '123456502938221234', '北京市某区某街道'),
                                                                                                                                                      ('S000000706', '纪爱', 2, 2, 3, True, 1, '13881214643', '2000-01-01', '123456273880441234', '北京市某区某街道'),
                                                                                                                                                      ('S000000707', '成馆', 4, 2, 20, True, 1, '13841204191', '2000-01-01', '123456526688101234', '北京市某区某街道'),
                                                                                                                                                      ('S000000708', '狄斯', 5, 2, 22, False, 1, '13896999414', '2000-01-01', '123456444877301234', '北京市某区某街道'),
                                                                                                                                                      ('S000000709', '孟临', 2, 2, 1, True, 1, '13869225628', '2000-01-01', '123456793883201234', '北京市某区某街道'),
                                                                                                                                                      ('S000000710', '何乐', 5, 2, 23, True, 1, '13894717893', '2000-01-01', '123456279970211234', '北京市某区某街道'),
                                                                                                                                                      ('S000000711', '卞系', 1, 3, 12, False, 1, '13862770100', '2000-01-01', '123456453765801234', '北京市某区某街道'),
                                                                                                                                                      ('S000000712', '赵艺', 5, 2, 24, True, 1, '13870453540', '2000-01-01', '123456523962381234', '北京市某区某街道'),
                                                                                                                                                      ('S000000713', '康盖', 4, 2, 20, False, 1, '13825686491', '2000-01-01', '123456561396931234', '北京市某区某街道'),
                                                                                                                                                      ('S000000714', '宋跑', 5, 2, 25, True, 1, '13865760277', '2000-01-01', '123456773890771234', '北京市某区某街道'),
                                                                                                                                                      ('S000000715', '任慢', 2, 2, 3, False, 1, '13899802742', '2000-01-01', '123456197904901234', '北京市某区某街道'),
                                                                                                                                                      ('S000000716', '苏登', 4, 2, 16, False, 1, '13835281021', '2000-01-01', '123456857801651234', '北京市某区某街道'),
                                                                                                                                                      ('S000000717', '花社', 1, 3, 11, False, 1, '13854834819', '2000-01-01', '123456841687181234', '北京市某区某街道'),
                                                                                                                                                      ('S000000718', '韩电', 3, 4, 9, False, 1, '13852751306', '2000-01-01', '123456577124011234', '北京市某区某街道'),
                                                                                                                                                      ('S000000719', '成大', 4, 2, 16, True, 1, '13856979183', '2000-01-01', '123456202028991234', '北京市某区某街道'),
                                                                                                                                                      ('S000000720', '堪弄', 1, 3, 15, False, 1, '13892322596', '2000-01-01', '123456193186641234', '北京市某区某街道'),
                                                                                                                                                      ('S000000721', '王高', 1, 3, 12, False, 1, '13840079024', '2000-01-01', '123456853742071234', '北京市某区某街道'),
                                                                                                                                                      ('S000000722', '贺团', 6, 1, 28, False, 1, '13832337692', '2000-01-01', '123456895776421234', '北京市某区某街道'),
                                                                                                                                                      ('S000000723', '潘必', 6, 1, 30, False, 1, '13877832141', '2000-01-01', '123456301045691234', '北京市某区某街道'),
                                                                                                                                                      ('S000000724', '褚势', 1, 3, 15, True, 1, '13873809657', '2000-01-01', '123456148571101234', '北京市某区某街道'),
                                                                                                                                                      ('S000000725', '曹坚', 1, 3, 12, False, 1, '13818279450', '2000-01-01', '123456822555621234', '北京市某区某街道'),
                                                                                                                                                      ('S000000726', '米文', 5, 2, 24, False, 1, '13845340801', '2000-01-01', '123456461347091234', '北京市某区某街道'),
                                                                                                                                                      ('S000000727', '汪某', 1, 3, 15, True, 1, '13813731242', '2000-01-01', '123456819863081234', '北京市某区某街道'),
                                                                                                                                                      ('S000000728', '顾管', 4, 2, 20, True, 1, '13887522324', '2000-01-01', '123456278124281234', '北京市某区某街道'),
                                                                                                                                                      ('S000000729', '王各', 1, 3, 12, False, 1, '13883490493', '2000-01-01', '123456522311411234', '北京市某区某街道'),
                                                                                                                                                      ('S000000730', '计事', 6, 1, 30, True, 1, '13880126607', '2000-01-01', '123456490073501234', '北京市某区某街道'),
                                                                                                                                                      ('S000000731', '岑得', 5, 2, 21, False, 1, '13892293813', '2000-01-01', '123456880623931234', '北京市某区某街道'),
                                                                                                                                                      ('S000000732', '柏王', 4, 2, 17, False, 1, '13868736035', '2000-01-01', '123456967255011234', '北京市某区某街道'),
                                                                                                                                                      ('S000000733', '彭走', 3, 4, 6, True, 1, '13841871934', '2000-01-01', '123456965567771234', '北京市某区某街道'),
                                                                                                                                                      ('S000000734', '卜用', 4, 2, 19, False, 1, '13861401359', '2000-01-01', '123456655122031234', '北京市某区某街道'),
                                                                                                                                                      ('S000000735', '鲁汉', 1, 3, 15, True, 1, '13839419228', '2000-01-01', '123456356779651234', '北京市某区某街道'),
                                                                                                                                                      ('S000000736', '谢玛', 4, 2, 18, True, 1, '13887119811', '2000-01-01', '123456838217981234', '北京市某区某街道'),
                                                                                                                                                      ('S000000737', '茅伯', 2, 2, 5, True, 1, '13830366878', '2000-01-01', '123456134073951234', '北京市某区某街道'),
                                                                                                                                                      ('S000000738', '蒋窢', 2, 2, 2, True, 1, '13845461704', '2000-01-01', '123456425854291234', '北京市某区某街道'),
                                                                                                                                                      ('S000000739', '秦健', 1, 3, 13, True, 1, '13877811797', '2000-01-01', '123456385358211234', '北京市某区某街道'),
                                                                                                                                                      ('S000000740', '李旅', 1, 3, 13, True, 1, '13826208492', '2000-01-01', '123456991712161234', '北京市某区某街道'),
                                                                                                                                                      ('S000000741', '鲍室', 1, 3, 11, True, 1, '13818096361', '2000-01-01', '123456633172621234', '北京市某区某街道'),
                                                                                                                                                      ('S000000742', '和信', 4, 2, 19, True, 1, '13865011458', '2000-01-01', '123456785777131234', '北京市某区某街道'),
                                                                                                                                                      ('S000000743', '吴求', 4, 2, 18, False, 1, '13825373402', '2000-01-01', '123456725344721234', '北京市某区某街道'),
                                                                                                                                                      ('S000000744', '汤枪', 1, 3, 14, True, 1, '13884641779', '2000-01-01', '123456453885841234', '北京市某区某街道'),
                                                                                                                                                      ('S000000745', '祁指', 4, 2, 20, True, 1, '13877561486', '2000-01-01', '123456603259951234', '北京市某区某街道'),
                                                                                                                                                      ('S000000746', '柳五', 1, 3, 14, True, 1, '13845013226', '2000-01-01', '123456998975111234', '北京市某区某街道'),
                                                                                                                                                      ('S000000747', '孟之', 2, 2, 1, False, 1, '13820416037', '2000-01-01', '123456610312631234', '北京市某区某街道'),
                                                                                                                                                      ('S000000748', '张话', 3, 4, 8, True, 1, '13871211176', '2000-01-01', '123456166522501234', '北京市某区某街道'),
                                                                                                                                                      ('S000000749', '费景', 6, 1, 30, False, 1, '13836510183', '2000-01-01', '123456611026141234', '北京市某区某街道'),
                                                                                                                                                      ('S000000750', '金鞋', 3, 4, 7, False, 1, '13881636607', '2000-01-01', '123456857362791234', '北京市某区某街道'),
                                                                                                                                                      ('S000000751', '范游', 4, 2, 20, False, 1, '13871392317', '2000-01-01', '123456786637851234', '北京市某区某街道'),
                                                                                                                                                      ('S000000752', '齐便', 6, 1, 28, False, 1, '13831749929', '2000-01-01', '123456527511511234', '北京市某区某街道'),
                                                                                                                                                      ('S000000753', '祝士', 5, 2, 24, True, 1, '13817937158', '2000-01-01', '123456778254791234', '北京市某区某街道'),
                                                                                                                                                      ('S000000754', '孔八', 1, 3, 15, True, 1, '13889945973', '2000-01-01', '123456118481101234', '北京市某区某街道'),
                                                                                                                                                      ('S000000755', '倪喊', 6, 1, 29, True, 1, '13819964843', '2000-01-01', '123456486685391234', '北京市某区某街道'),
                                                                                                                                                      ('S000000756', '韦趣', 5, 2, 23, False, 1, '13871308318', '2000-01-01', '123456369311831234', '北京市某区某街道'),
                                                                                                                                                      ('S000000757', '卜春', 2, 2, 5, False, 1, '13881260822', '2000-01-01', '123456844198911234', '北京市某区某街道'),
                                                                                                                                                      ('S000000758', '钱提', 6, 1, 26, False, 1, '13882623946', '2000-01-01', '123456258425201234', '北京市某区某街道'),
                                                                                                                                                      ('S000000759', '凤高', 3, 4, 9, True, 1, '13835196727', '2000-01-01', '123456269372811234', '北京市某区某街道'),
                                                                                                                                                      ('S000000760', '汪康', 5, 2, 23, False, 1, '13827802894', '2000-01-01', '123456731506211234', '北京市某区某街道'),
                                                                                                                                                      ('S000000761', '邬万', 1, 3, 15, True, 1, '13887625158', '2000-01-01', '123456995290101234', '北京市某区某街道'),
                                                                                                                                                      ('S000000762', '凤入', 6, 1, 26, False, 1, '13842845009', '2000-01-01', '123456505409211234', '北京市某区某街道'),
                                                                                                                                                      ('S000000763', '伍注', 3, 4, 6, False, 1, '13814092034', '2000-01-01', '123456124490941234', '北京市某区某街道'),
                                                                                                                                                      ('S000000764', '茅掉', 3, 4, 10, False, 1, '13895970368', '2000-01-01', '123456915435711234', '北京市某区某街道'),
                                                                                                                                                      ('S000000765', '华内', 1, 3, 13, True, 1, '13832995866', '2000-01-01', '123456768530561234', '北京市某区某街道'),
                                                                                                                                                      ('S000000766', '穆归', 1, 3, 11, False, 1, '13874692561', '2000-01-01', '123456991292621234', '北京市某区某街道'),
                                                                                                                                                      ('S000000767', '赵者', 3, 4, 10, False, 1, '13823967125', '2000-01-01', '123456926004481234', '北京市某区某街道'),
                                                                                                                                                      ('S000000768', '费外', 3, 4, 8, False, 1, '13845073875', '2000-01-01', '123456607078001234', '北京市某区某街道'),
                                                                                                                                                      ('S000000769', '堪诗', 5, 2, 25, True, 1, '13821806206', '2000-01-01', '123456859434361234', '北京市某区某街道'),
                                                                                                                                                      ('S000000770', '戚万', 4, 2, 20, False, 1, '13865479979', '2000-01-01', '123456485735101234', '北京市某区某街道'),
                                                                                                                                                      ('S000000771', '严银', 5, 2, 24, False, 1, '13844030772', '2000-01-01', '123456670251281234', '北京市某区某街道'),
                                                                                                                                                      ('S000000772', '云药', 6, 1, 28, False, 1, '13893590211', '2000-01-01', '123456572778121234', '北京市某区某街道'),
                                                                                                                                                      ('S000000773', '姚鱼', 5, 2, 25, False, 1, '13850137881', '2000-01-01', '123456773388861234', '北京市某区某街道'),
                                                                                                                                                      ('S000000774', '茅觉', 6, 1, 27, False, 1, '13832125294', '2000-01-01', '123456949817571234', '北京市某区某街道'),
                                                                                                                                                      ('S000000775', '袁跳', 6, 1, 29, False, 1, '13846419297', '2000-01-01', '123456637427291234', '北京市某区某街道'),
                                                                                                                                                      ('S000000776', '苏数', 5, 2, 21, True, 1, '13882311279', '2000-01-01', '123456250727211234', '北京市某区某街道'),
                                                                                                                                                      ('S000000777', '袁松', 4, 2, 16, True, 1, '13881062267', '2000-01-01', '123456696495351234', '北京市某区某街道'),
                                                                                                                                                      ('S000000778', '纪密', 2, 2, 3, False, 1, '13826642513', '2000-01-01', '123456187512301234', '北京市某区某街道'),
                                                                                                                                                      ('S000000779', '臧则', 2, 2, 3, False, 1, '13812326042', '2000-01-01', '123456759475691234', '北京市某区某街道'),
                                                                                                                                                      ('S000000780', '花如', 6, 1, 26, True, 1, '13896183933', '2000-01-01', '123456741156611234', '北京市某区某街道'),
                                                                                                                                                      ('S000000781', '卞论', 6, 1, 26, False, 1, '13898597449', '2000-01-01', '123456807575551234', '北京市某区某街道'),
                                                                                                                                                      ('S000000782', '伏种', 4, 2, 19, True, 1, '13814904418', '2000-01-01', '123456571407121234', '北京市某区某街道'),
                                                                                                                                                      ('S000000783', '傅五', 6, 1, 30, True, 1, '13882099217', '2000-01-01', '123456694084421234', '北京市某区某街道'),
                                                                                                                                                      ('S000000784', '尹想', 4, 2, 19, False, 1, '13893138080', '2000-01-01', '123456525863841234', '北京市某区某街道'),
                                                                                                                                                      ('S000000785', '陈倒', 5, 2, 25, True, 1, '13867583231', '2000-01-01', '123456181499371234', '北京市某区某街道'),
                                                                                                                                                      ('S000000786', '庞丝', 5, 2, 22, True, 1, '13817352346', '2000-01-01', '123456264583521234', '北京市某区某街道'),
                                                                                                                                                      ('S000000787', '葛特', 3, 4, 8, False, 1, '13879618708', '2000-01-01', '123456978053501234', '北京市某区某街道'),
                                                                                                                                                      ('S000000788', '赵文', 3, 4, 6, True, 1, '13831982806', '2000-01-01', '123456584297871234', '北京市某区某街道'),
                                                                                                                                                      ('S000000789', '奚电', 3, 4, 9, True, 1, '13868641541', '2000-01-01', '123456562550651234', '北京市某区某街道'),
                                                                                                                                                      ('S000000790', '时容', 3, 4, 9, True, 1, '13839099146', '2000-01-01', '123456852766511234', '北京市某区某街道'),
                                                                                                                                                      ('S000000791', '范验', 1, 3, 11, True, 1, '13887709199', '2000-01-01', '123456932996831234', '北京市某区某街道'),
                                                                                                                                                      ('S000000792', '蒋指', 2, 2, 1, False, 1, '13887336848', '2000-01-01', '123456577593641234', '北京市某区某街道'),
                                                                                                                                                      ('S000000793', '云菜', 2, 2, 2, True, 1, '13816755446', '2000-01-01', '123456188679361234', '北京市某区某街道'),
                                                                                                                                                      ('S000000794', '戴居', 3, 4, 7, True, 1, '13849116747', '2000-01-01', '123456320114941234', '北京市某区某街道'),
                                                                                                                                                      ('S000000795', '严对', 2, 2, 5, False, 1, '13828440734', '2000-01-01', '123456289275491234', '北京市某区某街道'),
                                                                                                                                                      ('S000000796', '朱带', 3, 4, 9, False, 1, '13843039639', '2000-01-01', '123456789563271234', '北京市某区某街道'),
                                                                                                                                                      ('S000000797', '魏石', 5, 2, 24, False, 1, '13871838490', '2000-01-01', '123456964929151234', '北京市某区某街道'),
                                                                                                                                                      ('S000000798', '韩另', 1, 3, 15, False, 1, '13839547886', '2000-01-01', '123456346724901234', '北京市某区某街道'),
                                                                                                                                                      ('S000000799', '平适', 4, 2, 20, False, 1, '13831509342', '2000-01-01', '123456417496721234', '北京市某区某街道'),
                                                                                                                                                      ('S000000800', '臧都', 1, 3, 15, True, 1, '13816118542', '2000-01-01', '123456437684291234', '北京市某区某街道'),
                                                                                                                                                      ('S000000801', '雷流', 4, 2, 16, True, 1, '13864158840', '2000-01-01', '123456993953711234', '北京市某区某街道'),
                                                                                                                                                      ('S000000802', '皮里', 3, 4, 7, True, 1, '13891207720', '2000-01-01', '123456638832201234', '北京市某区某街道'),
                                                                                                                                                      ('S000000803', '王要', 6, 1, 26, True, 1, '13849100071', '2000-01-01', '123456157343651234', '北京市某区某街道'),
                                                                                                                                                      ('S000000804', '乐深', 4, 2, 17, False, 1, '13842178874', '2000-01-01', '123456711405351234', '北京市某区某街道'),
                                                                                                                                                      ('S000000805', '郎丝', 2, 2, 2, False, 1, '13879583567', '2000-01-01', '123456202030071234', '北京市某区某街道'),
                                                                                                                                                      ('S000000806', '祝超', 2, 2, 1, False, 1, '13856113505', '2000-01-01', '123456949483741234', '北京市某区某街道'),
                                                                                                                                                      ('S000000807', '庞顶', 2, 2, 4, True, 1, '13892012754', '2000-01-01', '123456709842431234', '北京市某区某街道'),
                                                                                                                                                      ('S000000808', '何运', 4, 2, 16, False, 1, '13862422041', '2000-01-01', '123456514043761234', '北京市某区某街道'),
                                                                                                                                                      ('S000000809', '魏善', 1, 3, 13, True, 1, '13897742211', '2000-01-01', '123456370439941234', '北京市某区某街道'),
                                                                                                                                                      ('S000000810', '殷已', 6, 1, 30, True, 1, '13817469611', '2000-01-01', '123456215226511234', '北京市某区某街道'),
                                                                                                                                                      ('S000000811', '奚据', 6, 1, 29, True, 1, '13859979182', '2000-01-01', '123456108619171234', '北京市某区某街道'),
                                                                                                                                                      ('S000000812', '时臓', 1, 3, 14, True, 1, '13850843153', '2000-01-01', '123456476769641234', '北京市某区某街道'),
                                                                                                                                                      ('S000000813', '和唱', 1, 3, 15, False, 1, '13811298811', '2000-01-01', '123456716392841234', '北京市某区某街道'),
                                                                                                                                                      ('S000000814', '郝气', 6, 1, 30, True, 1, '13864370249', '2000-01-01', '123456620775521234', '北京市某区某街道'),
                                                                                                                                                      ('S000000815', '奚摇', 2, 2, 4, True, 1, '13864452334', '2000-01-01', '123456715263291234', '北京市某区某街道'),
                                                                                                                                                      ('S000000816', '廉森', 3, 4, 10, False, 1, '13863629125', '2000-01-01', '123456616224341234', '北京市某区某街道'),
                                                                                                                                                      ('S000000817', '贺劳', 4, 2, 19, False, 1, '13849891212', '2000-01-01', '123456739438131234', '北京市某区某街道'),
                                                                                                                                                      ('S000000818', '乐这', 5, 2, 25, False, 1, '13883549795', '2000-01-01', '123456819825501234', '北京市某区某街道'),
                                                                                                                                                      ('S000000819', '韩微', 4, 2, 17, True, 1, '13897173369', '2000-01-01', '123456705257231234', '北京市某区某街道'),
                                                                                                                                                      ('S000000820', '毕证', 3, 4, 9, False, 1, '13825026171', '2000-01-01', '123456318273771234', '北京市某区某街道'),
                                                                                                                                                      ('S000000821', '奚包', 6, 1, 29, True, 1, '13846161828', '2000-01-01', '123456333439991234', '北京市某区某街道'),
                                                                                                                                                      ('S000000822', '韩既', 4, 2, 16, False, 1, '13890290532', '2000-01-01', '123456705236701234', '北京市某区某街道'),
                                                                                                                                                      ('S000000823', '韩引', 3, 4, 10, False, 1, '13862701309', '2000-01-01', '123456412880211234', '北京市某区某街道'),
                                                                                                                                                      ('S000000824', '穆显', 1, 3, 13, False, 1, '13846922849', '2000-01-01', '123456986480441234', '北京市某区某街道'),
                                                                                                                                                      ('S000000825', '费纳', 6, 1, 30, False, 1, '13874919553', '2000-01-01', '123456414893561234', '北京市某区某街道'),
                                                                                                                                                      ('S000000826', '柏差', 5, 2, 22, True, 1, '13867107164', '2000-01-01', '123456403891171234', '北京市某区某街道'),
                                                                                                                                                      ('S000000827', '倪抱', 3, 4, 10, True, 1, '13851391999', '2000-01-01', '123456171252211234', '北京市某区某街道'),
                                                                                                                                                      ('S000000828', '水首', 3, 4, 9, True, 1, '13883220042', '2000-01-01', '123456651710701234', '北京市某区某街道'),
                                                                                                                                                      ('S000000829', '苏睛', 6, 1, 30, True, 1, '13848495043', '2000-01-01', '123456491810151234', '北京市某区某街道'),
                                                                                                                                                      ('S000000830', '马木', 3, 4, 10, False, 1, '13870151266', '2000-01-01', '123456609522521234', '北京市某区某街道'),
                                                                                                                                                      ('S000000831', '邵才', 1, 3, 13, False, 1, '13821459345', '2000-01-01', '123456496489751234', '北京市某区某街道'),
                                                                                                                                                      ('S000000832', '祝双', 6, 1, 26, False, 1, '13889143806', '2000-01-01', '123456933219311234', '北京市某区某街道'),
                                                                                                                                                      ('S000000833', '窦王', 6, 1, 26, False, 1, '13822389581', '2000-01-01', '123456981439641234', '北京市某区某街道'),
                                                                                                                                                      ('S000000834', '戴云', 3, 4, 8, False, 1, '13849933883', '2000-01-01', '123456212486551234', '北京市某区某街道'),
                                                                                                                                                      ('S000000835', '臧然', 6, 1, 29, False, 1, '13886198468', '2000-01-01', '123456654275321234', '北京市某区某街道'),
                                                                                                                                                      ('S000000836', '伍很', 6, 1, 29, True, 1, '13878466376', '2000-01-01', '123456431737521234', '北京市某区某街道'),
                                                                                                                                                      ('S000000837', '戴市', 1, 3, 13, False, 1, '13823844467', '2000-01-01', '123456650454881234', '北京市某区某街道'),
                                                                                                                                                      ('S000000838', '杨迹', 5, 2, 23, True, 1, '13838849237', '2000-01-01', '123456774675891234', '北京市某区某街道'),
                                                                                                                                                      ('S000000839', '余客', 4, 2, 20, False, 1, '13845864734', '2000-01-01', '123456528724661234', '北京市某区某街道'),
                                                                                                                                                      ('S000000840', '章意', 1, 3, 11, False, 1, '13822696752', '2000-01-01', '123456835694841234', '北京市某区某街道'),
                                                                                                                                                      ('S000000841', '潘形', 1, 3, 14, False, 1, '13844078042', '2000-01-01', '123456982707621234', '北京市某区某街道'),
                                                                                                                                                      ('S000000842', '廉认', 4, 2, 20, False, 1, '13818002226', '2000-01-01', '123456891049611234', '北京市某区某街道'),
                                                                                                                                                      ('S000000843', '乐司', 3, 4, 7, True, 1, '13885997514', '2000-01-01', '123456908024981234', '北京市某区某街道'),
                                                                                                                                                      ('S000000844', '尤声', 4, 2, 18, True, 1, '13845937507', '2000-01-01', '123456608973321234', '北京市某区某街道'),
                                                                                                                                                      ('S000000845', '臧活', 2, 2, 5, False, 1, '13845482660', '2000-01-01', '123456188509621234', '北京市某区某街道'),
                                                                                                                                                      ('S000000846', '施下', 5, 2, 21, False, 1, '13883970408', '2000-01-01', '123456672821531234', '北京市某区某街道'),
                                                                                                                                                      ('S000000847', '谈很', 3, 4, 10, False, 1, '13888566135', '2000-01-01', '123456324442351234', '北京市某区某街道'),
                                                                                                                                                      ('S000000848', '孔简', 2, 2, 5, False, 1, '13870642054', '2000-01-01', '123456580120941234', '北京市某区某街道'),
                                                                                                                                                      ('S000000849', '伍败', 2, 2, 2, False, 1, '13861046024', '2000-01-01', '123456402738041234', '北京市某区某街道'),
                                                                                                                                                      ('S000000850', '康味', 4, 2, 17, False, 1, '13878787726', '2000-01-01', '123456153981891234', '北京市某区某街道'),
                                                                                                                                                      ('S000000851', '袁机', 2, 2, 4, True, 1, '13879480176', '2000-01-01', '123456572943381234', '北京市某区某街道'),
                                                                                                                                                      ('S000000852', '邹品', 2, 2, 4, True, 1, '13882844178', '2000-01-01', '123456607227651234', '北京市某区某街道'),
                                                                                                                                                      ('S000000853', '卫图', 3, 4, 9, False, 1, '13869092404', '2000-01-01', '123456675792041234', '北京市某区某街道'),
                                                                                                                                                      ('S000000854', '黄束', 6, 1, 29, False, 1, '13841893567', '2000-01-01', '123456184007071234', '北京市某区某街道'),
                                                                                                                                                      ('S000000855', '毕共', 6, 1, 27, False, 1, '13838464675', '2000-01-01', '123456315829621234', '北京市某区某街道'),
                                                                                                                                                      ('S000000856', '褚吧', 5, 2, 25, True, 1, '13869689009', '2000-01-01', '123456831245171234', '北京市某区某街道'),
                                                                                                                                                      ('S000000857', '水山', 4, 2, 17, True, 1, '13840639808', '2000-01-01', '123456265319501234', '北京市某区某街道'),
                                                                                                                                                      ('S000000858', '米字', 4, 2, 17, True, 1, '13865534681', '2000-01-01', '123456470298171234', '北京市某区某街道'),
                                                                                                                                                      ('S000000859', '水制', 6, 1, 30, False, 1, '13830590416', '2000-01-01', '123456791189301234', '北京市某区某街道'),
                                                                                                                                                      ('S000000860', '梁缺', 4, 2, 17, True, 1, '13857659986', '2000-01-01', '123456113167721234', '北京市某区某街道'),
                                                                                                                                                      ('S000000861', '董就', 5, 2, 23, False, 1, '13822793040', '2000-01-01', '123456172876491234', '北京市某区某街道'),
                                                                                                                                                      ('S000000862', '舒条', 6, 1, 26, False, 1, '13829304919', '2000-01-01', '123456995090501234', '北京市某区某街道'),
                                                                                                                                                      ('S000000863', '金即', 5, 2, 23, False, 1, '13811181098', '2000-01-01', '123456204566791234', '北京市某区某街道'),
                                                                                                                                                      ('S000000864', '柏普', 2, 2, 5, True, 1, '13882462638', '2000-01-01', '123456934024061234', '北京市某区某街道'),
                                                                                                                                                      ('S000000865', '谢请', 6, 1, 27, False, 1, '13865781737', '2000-01-01', '123456671196151234', '北京市某区某街道'),
                                                                                                                                                      ('S000000866', '鲁奶', 6, 1, 26, True, 1, '13872964078', '2000-01-01', '123456125899251234', '北京市某区某街道'),
                                                                                                                                                      ('S000000867', '范娜', 5, 2, 25, False, 1, '13821507514', '2000-01-01', '123456115474631234', '北京市某区某街道'),
                                                                                                                                                      ('S000000868', '任五', 2, 2, 1, False, 1, '13838127100', '2000-01-01', '123456332327851234', '北京市某区某街道'),
                                                                                                                                                      ('S000000869', '邵卡', 1, 3, 15, False, 1, '13874723812', '2000-01-01', '123456857291551234', '北京市某区某街道'),
                                                                                                                                                      ('S000000870', '蒋节', 4, 2, 17, True, 1, '13884875861', '2000-01-01', '123456831611261234', '北京市某区某街道'),
                                                                                                                                                      ('S000000871', '苏素', 4, 2, 18, True, 1, '13843175089', '2000-01-01', '123456634913441234', '北京市某区某街道'),
                                                                                                                                                      ('S000000872', '卞红', 1, 3, 15, True, 1, '13838452282', '2000-01-01', '123456773068131234', '北京市某区某街道'),
                                                                                                                                                      ('S000000873', '廉化', 6, 1, 30, False, 1, '13820355961', '2000-01-01', '123456793697881234', '北京市某区某街道'),
                                                                                                                                                      ('S000000874', '陈线', 4, 2, 20, False, 1, '13819226044', '2000-01-01', '123456864608061234', '北京市某区某街道'),
                                                                                                                                                      ('S000000875', '费竟', 4, 2, 16, True, 1, '13887511150', '2000-01-01', '123456730262471234', '北京市某区某街道'),
                                                                                                                                                      ('S000000876', '蒋棋', 5, 2, 23, False, 1, '13868330259', '2000-01-01', '123456998602061234', '北京市某区某街道'),
                                                                                                                                                      ('S000000877', '昌之', 2, 2, 5, True, 1, '13817562875', '2000-01-01', '123456312714871234', '北京市某区某街道'),
                                                                                                                                                      ('S000000878', '倪命', 5, 2, 22, False, 1, '13836115256', '2000-01-01', '123456957625121234', '北京市某区某街道'),
                                                                                                                                                      ('S000000879', '卜玩', 2, 2, 2, False, 1, '13871283489', '2000-01-01', '123456261188971234', '北京市某区某街道'),
                                                                                                                                                      ('S000000880', '费易', 1, 3, 12, False, 1, '13890214946', '2000-01-01', '123456527625481234', '北京市某区某街道'),
                                                                                                                                                      ('S000000881', '倪眼', 6, 1, 30, False, 1, '13894452956', '2000-01-01', '123456198131521234', '北京市某区某街道'),
                                                                                                                                                      ('S000000882', '吕尔', 5, 2, 23, True, 1, '13815228884', '2000-01-01', '123456462036781234', '北京市某区某街道'),
                                                                                                                                                      ('S000000883', '乐吗', 4, 2, 16, True, 1, '13871250903', '2000-01-01', '123456137410171234', '北京市某区某街道'),
                                                                                                                                                      ('S000000884', '史諣', 3, 4, 10, True, 1, '13874094277', '2000-01-01', '123456149649611234', '北京市某区某街道'),
                                                                                                                                                      ('S000000885', '朱照', 4, 2, 19, False, 1, '13810124967', '2000-01-01', '123456263515751234', '北京市某区某街道'),
                                                                                                                                                      ('S000000886', '孟德', 3, 4, 8, False, 1, '13848544751', '2000-01-01', '123456176243051234', '北京市某区某街道'),
                                                                                                                                                      ('S000000887', '宋低', 6, 1, 26, False, 1, '13884779364', '2000-01-01', '123456126034521234', '北京市某区某街道'),
                                                                                                                                                      ('S000000888', '康突', 2, 2, 5, True, 1, '13893226608', '2000-01-01', '123456443576351234', '北京市某区某街道'),
                                                                                                                                                      ('S000000889', '邹紶', 2, 2, 4, True, 1, '13878953103', '2000-01-01', '123456688721371234', '北京市某区某街道'),
                                                                                                                                                      ('S000000890', '董阵', 4, 2, 18, True, 1, '13897414109', '2000-01-01', '123456428961851234', '北京市某区某街道'),
                                                                                                                                                      ('S000000891', '余午', 6, 1, 30, True, 1, '13840844473', '2000-01-01', '123456924220161234', '北京市某区某街道'),
                                                                                                                                                      ('S000000892', '禹产', 6, 1, 30, True, 1, '13810546795', '2000-01-01', '123456894338871234', '北京市某区某街道'),
                                                                                                                                                      ('S000000893', '苏临', 5, 2, 23, True, 1, '13881075789', '2000-01-01', '123456528948661234', '北京市某区某街道'),
                                                                                                                                                      ('S000000894', '雷啊', 1, 3, 11, False, 1, '13867790779', '2000-01-01', '123456110380281234', '北京市某区某街道'),
                                                                                                                                                      ('S000000895', '郎毫', 1, 3, 15, True, 1, '13881860886', '2000-01-01', '123456388938601234', '北京市某区某街道'),
                                                                                                                                                      ('S000000896', '庞交', 3, 4, 9, False, 1, '13869453322', '2000-01-01', '123456269881771234', '北京市某区某街道'),
                                                                                                                                                      ('S000000897', '滕当', 6, 1, 30, False, 1, '13827360276', '2000-01-01', '123456424615441234', '北京市某区某街道'),
                                                                                                                                                      ('S000000898', '黄他', 3, 4, 9, False, 1, '13897067180', '2000-01-01', '123456516694201234', '北京市某区某街道'),
                                                                                                                                                      ('S000000899', '熊令', 4, 2, 19, True, 1, '13823068306', '2000-01-01', '123456409861291234', '北京市某区某街道'),
                                                                                                                                                      ('S000000900', '李志', 3, 4, 6, True, 1, '13826707144', '2000-01-01', '123456450508591234', '北京市某区某街道'),
                                                                                                                                                      ('S000000901', '王助', 3, 4, 10, False, 1, '13879332144', '2000-01-01', '123456715339181234', '北京市某区某街道'),
                                                                                                                                                      ('S000000902', '穆还', 2, 2, 3, True, 1, '13831123191', '2000-01-01', '123456569160221234', '北京市某区某街道'),
                                                                                                                                                      ('S000000903', '唐念', 1, 3, 15, False, 1, '13887347264', '2000-01-01', '123456359784991234', '北京市某区某街道'),
                                                                                                                                                      ('S000000904', '孟问', 6, 1, 28, False, 1, '13829561302', '2000-01-01', '123456375826381234', '北京市某区某街道'),
                                                                                                                                                      ('S000000905', '朱乐', 6, 1, 27, True, 1, '13845469486', '2000-01-01', '123456168865431234', '北京市某区某街道'),
                                                                                                                                                      ('S000000906', '花南', 6, 1, 27, False, 1, '13886018259', '2000-01-01', '123456145798811234', '北京市某区某街道'),
                                                                                                                                                      ('S000000907', '汤乱', 5, 2, 24, False, 1, '13821818733', '2000-01-01', '123456541361541234', '北京市某区某街道'),
                                                                                                                                                      ('S000000908', '傅耳', 1, 3, 11, False, 1, '13882816599', '2000-01-01', '123456150290521234', '北京市某区某街道'),
                                                                                                                                                      ('S000000909', '萧标', 6, 1, 30, True, 1, '13899854528', '2000-01-01', '123456784975301234', '北京市某区某街道'),
                                                                                                                                                      ('S000000910', '许行', 4, 2, 17, True, 1, '13821882555', '2000-01-01', '123456426280001234', '北京市某区某街道'),
                                                                                                                                                      ('S000000911', '姚子', 6, 1, 29, True, 1, '13813985567', '2000-01-01', '123456397461971234', '北京市某区某街道'),
                                                                                                                                                      ('S000000912', '计恋', 2, 2, 2, False, 1, '13857562534', '2000-01-01', '123456539871341234', '北京市某区某街道'),
                                                                                                                                                      ('S000000913', '蒋委', 2, 2, 4, False, 1, '13847322499', '2000-01-01', '123456212446641234', '北京市某区某街道'),
                                                                                                                                                      ('S000000914', '穆米', 6, 1, 26, False, 1, '13827138502', '2000-01-01', '123456626492151234', '北京市某区某街道'),
                                                                                                                                                      ('S000000915', '严做', 3, 4, 7, False, 1, '13832155945', '2000-01-01', '123456609286931234', '北京市某区某街道'),
                                                                                                                                                      ('S000000916', '潘六', 2, 2, 4, True, 1, '13881657072', '2000-01-01', '123456852296111234', '北京市某区某街道'),
                                                                                                                                                      ('S000000917', '唐遍', 2, 2, 4, True, 1, '13847506437', '2000-01-01', '123456623476161234', '北京市某区某街道'),
                                                                                                                                                      ('S000000918', '董太', 2, 2, 3, False, 1, '13818474117', '2000-01-01', '123456653375271234', '北京市某区某街道'),
                                                                                                                                                      ('S000000919', '方离', 2, 2, 5, True, 1, '13891129943', '2000-01-01', '123456485396571234', '北京市某区某街道'),
                                                                                                                                                      ('S000000920', '米骨', 5, 2, 25, False, 1, '13867086118', '2000-01-01', '123456739715631234', '北京市某区某街道'),
                                                                                                                                                      ('S000000921', '堪船', 5, 2, 24, True, 1, '13866083995', '2000-01-01', '123456650328741234', '北京市某区某街道'),
                                                                                                                                                      ('S000000922', '禹室', 1, 3, 11, False, 1, '13825810466', '2000-01-01', '123456276808241234', '北京市某区某街道'),
                                                                                                                                                      ('S000000923', '计赶', 3, 4, 10, True, 1, '13820637958', '2000-01-01', '123456306164771234', '北京市某区某街道'),
                                                                                                                                                      ('S000000924', '韦夜', 4, 2, 18, True, 1, '13812996458', '2000-01-01', '123456568684251234', '北京市某区某街道'),
                                                                                                                                                      ('S000000925', '郝伯', 2, 2, 2, False, 1, '13892563499', '2000-01-01', '123456894742781234', '北京市某区某街道'),
                                                                                                                                                      ('S000000926', '乐科', 3, 4, 9, False, 1, '13839950098', '2000-01-01', '123456904823091234', '北京市某区某街道'),
                                                                                                                                                      ('S000000927', '屈呢', 1, 3, 11, True, 1, '13810910293', '2000-01-01', '123456667083941234', '北京市某区某街道'),
                                                                                                                                                      ('S000000928', '喻讲', 2, 2, 4, True, 1, '13830424999', '2000-01-01', '123456951211891234', '北京市某区某街道'),
                                                                                                                                                      ('S000000929', '奚正', 1, 3, 13, True, 1, '13829059779', '2000-01-01', '123456627364671234', '北京市某区某街道'),
                                                                                                                                                      ('S000000930', '吕让', 4, 2, 16, True, 1, '13817046506', '2000-01-01', '123456698341621234', '北京市某区某街道'),
                                                                                                                                                      ('S000000931', '穆索', 4, 2, 20, False, 1, '13872292065', '2000-01-01', '123456664128271234', '北京市某区某街道'),
                                                                                                                                                      ('S000000932', '雷城', 3, 4, 7, True, 1, '13812416010', '2000-01-01', '123456854793841234', '北京市某区某街道'),
                                                                                                                                                      ('S000000933', '罗能', 5, 2, 23, True, 1, '13886581500', '2000-01-01', '123456625259251234', '北京市某区某街道'),
                                                                                                                                                      ('S000000934', '戴果', 3, 4, 7, True, 1, '13827163720', '2000-01-01', '123456398403461234', '北京市某区某街道'),
                                                                                                                                                      ('S000000935', '毛才', 3, 4, 6, True, 1, '13864005451', '2000-01-01', '123456540404861234', '北京市某区某街道'),
                                                                                                                                                      ('S000000936', '酆血', 3, 4, 7, True, 1, '13898005432', '2000-01-01', '123456116523631234', '北京市某区某街道'),
                                                                                                                                                      ('S000000937', '卞续', 2, 2, 3, True, 1, '13864425421', '2000-01-01', '123456771632011234', '北京市某区某街道'),
                                                                                                                                                      ('S000000938', '酆放', 4, 2, 20, False, 1, '13887794246', '2000-01-01', '123456899605231234', '北京市某区某街道'),
                                                                                                                                                      ('S000000939', '沈记', 2, 2, 3, False, 1, '13817269255', '2000-01-01', '123456720831431234', '北京市某区某街道'),
                                                                                                                                                      ('S000000940', '时碃', 1, 3, 14, False, 1, '13812817522', '2000-01-01', '123456583297721234', '北京市某区某街道'),
                                                                                                                                                      ('S000000941', '周先', 1, 3, 15, True, 1, '13879444758', '2000-01-01', '123456374785061234', '北京市某区某街道'),
                                                                                                                                                      ('S000000942', '项姑', 2, 2, 4, True, 1, '13857806382', '2000-01-01', '123456513151161234', '北京市某区某街道'),
                                                                                                                                                      ('S000000943', '柏明', 3, 4, 10, True, 1, '13868507526', '2000-01-01', '123456815515201234', '北京市某区某街道'),
                                                                                                                                                      ('S000000944', '花传', 2, 2, 3, True, 1, '13833143703', '2000-01-01', '123456548846921234', '北京市某区某街道'),
                                                                                                                                                      ('S000000945', '尤端', 2, 2, 1, False, 1, '13844492401', '2000-01-01', '123456238021181234', '北京市某区某街道'),
                                                                                                                                                      ('S000000946', '吕团', 5, 2, 24, False, 1, '13898091845', '2000-01-01', '123456754821311234', '北京市某区某街道'),
                                                                                                                                                      ('S000000947', '萧打', 1, 3, 12, True, 1, '13889015473', '2000-01-01', '123456869746611234', '北京市某区某街道'),
                                                                                                                                                      ('S000000948', '孟全', 2, 2, 1, True, 1, '13838554141', '2000-01-01', '123456364528141234', '北京市某区某街道'),
                                                                                                                                                      ('S000000949', '袁经', 6, 1, 29, True, 1, '13886931994', '2000-01-01', '123456700669121234', '北京市某区某街道'),
                                                                                                                                                      ('S000000950', '范嘴', 2, 2, 5, False, 1, '13874325042', '2000-01-01', '123456655569421234', '北京市某区某街道'),
                                                                                                                                                      ('S000000951', '曹状', 2, 2, 4, True, 1, '13878653536', '2000-01-01', '123456986759211234', '北京市某区某街道'),
                                                                                                                                                      ('S000000952', '喻缺', 4, 2, 20, True, 1, '13819905024', '2000-01-01', '123456602224931234', '北京市某区某街道'),
                                                                                                                                                      ('S000000953', '元黑', 6, 1, 30, True, 1, '13856241670', '2000-01-01', '123456449540091234', '北京市某区某街道'),
                                                                                                                                                      ('S000000954', '祁寻', 1, 3, 11, False, 1, '13895772626', '2000-01-01', '123456186590371234', '北京市某区某街道'),
                                                                                                                                                      ('S000000955', '章感', 1, 3, 12, False, 1, '13880562502', '2000-01-01', '123456393348711234', '北京市某区某街道'),
                                                                                                                                                      ('S000000956', '史资', 1, 3, 13, False, 1, '13812310556', '2000-01-01', '123456947334341234', '北京市某区某街道'),
                                                                                                                                                      ('S000000957', '秦贵', 2, 2, 1, False, 1, '13820084148', '2000-01-01', '123456586615701234', '北京市某区某街道'),
                                                                                                                                                      ('S000000958', '孙付', 2, 2, 2, True, 1, '13864752769', '2000-01-01', '123456336746931234', '北京市某区某街道'),
                                                                                                                                                      ('S000000959', '奚连', 5, 2, 22, False, 1, '13850477280', '2000-01-01', '123456540934091234', '北京市某区某街道'),
                                                                                                                                                      ('S000000960', '邵告', 5, 2, 25, False, 1, '13878778759', '2000-01-01', '123456567088741234', '北京市某区某街道'),
                                                                                                                                                      ('S000000961', '米日', 4, 2, 19, True, 1, '13862500621', '2000-01-01', '123456503647491234', '北京市某区某街道'),
                                                                                                                                                      ('S000000962', '蒋供', 4, 2, 18, False, 1, '13813339328', '2000-01-01', '123456491406061234', '北京市某区某街道'),
                                                                                                                                                      ('S000000963', '任摇', 5, 2, 21, True, 1, '13869262897', '2000-01-01', '123456668693201234', '北京市某区某街道'),
                                                                                                                                                      ('S000000964', '谈什', 2, 2, 2, False, 1, '13868013563', '2000-01-01', '123456315570841234', '北京市某区某街道'),
                                                                                                                                                      ('S000000965', '宋你', 6, 1, 27, True, 1, '13851685970', '2000-01-01', '123456806854181234', '北京市某区某街道'),
                                                                                                                                                      ('S000000966', '余世', 4, 2, 16, False, 1, '13860394106', '2000-01-01', '123456213261451234', '北京市某区某街道'),
                                                                                                                                                      ('S000000967', '水能', 4, 2, 16, True, 1, '13876127608', '2000-01-01', '123456195681301234', '北京市某区某街道'),
                                                                                                                                                      ('S000000968', '安断', 1, 3, 11, False, 1, '13810846690', '2000-01-01', '123456215644181234', '北京市某区某街道'),
                                                                                                                                                      ('S000000969', '薛未', 1, 3, 13, True, 1, '13832007651', '2000-01-01', '123456376622481234', '北京市某区某街道'),
                                                                                                                                                      ('S000000970', '项演', 1, 3, 12, True, 1, '13862424974', '2000-01-01', '123456901719881234', '北京市某区某街道'),
                                                                                                                                                      ('S000000971', '余望', 5, 2, 22, False, 1, '13841073846', '2000-01-01', '123456501958601234', '北京市某区某街道'),
                                                                                                                                                      ('S000000972', '袁合', 6, 1, 28, False, 1, '13890026713', '2000-01-01', '123456244100451234', '北京市某区某街道'),
                                                                                                                                                      ('S000000973', '廉义', 4, 2, 18, True, 1, '13870565442', '2000-01-01', '123456634141551234', '北京市某区某街道'),
                                                                                                                                                      ('S000000974', '孙适', 1, 3, 12, False, 1, '13821520121', '2000-01-01', '123456552790831234', '北京市某区某街道'),
                                                                                                                                                      ('S000000975', '廉馆', 3, 4, 10, False, 1, '13836867856', '2000-01-01', '123456947281091234', '北京市某区某街道'),
                                                                                                                                                      ('S000000976', '袁巨', 3, 4, 8, False, 1, '13879133520', '2000-01-01', '123456344096181234', '北京市某区某街道'),
                                                                                                                                                      ('S000000977', '毛去', 6, 1, 30, True, 1, '13885483875', '2000-01-01', '123456452672921234', '北京市某区某街道'),
                                                                                                                                                      ('S000000978', '范味', 2, 2, 1, True, 1, '13897922444', '2000-01-01', '123456612836481234', '北京市某区某街道'),
                                                                                                                                                      ('S000000979', '唐牙', 4, 2, 20, True, 1, '13871336814', '2000-01-01', '123456222899191234', '北京市某区某街道'),
                                                                                                                                                      ('S000000980', '毛意', 4, 2, 16, True, 1, '13853000510', '2000-01-01', '123456647008001234', '北京市某区某街道'),
                                                                                                                                                      ('S000000981', '奚革', 1, 3, 13, False, 1, '13893608596', '2000-01-01', '123456465481761234', '北京市某区某街道'),
                                                                                                                                                      ('S000000982', '唐此', 2, 2, 3, True, 1, '13886066569', '2000-01-01', '123456511587371234', '北京市某区某街道'),
                                                                                                                                                      ('S000000983', '计工', 3, 4, 8, True, 1, '13828330825', '2000-01-01', '123456644051601234', '北京市某区某街道'),
                                                                                                                                                      ('S000000984', '滕棋', 2, 2, 1, False, 1, '13836383944', '2000-01-01', '123456175776711234', '北京市某区某街道'),
                                                                                                                                                      ('S000000985', '姚幸', 5, 2, 23, True, 1, '13885570489', '2000-01-01', '123456258001821234', '北京市某区某街道'),
                                                                                                                                                      ('S000000986', '汤达', 2, 2, 3, False, 1, '13849302173', '2000-01-01', '123456605801291234', '北京市某区某街道'),
                                                                                                                                                      ('S000000987', '纪之', 1, 3, 13, True, 1, '13886193940', '2000-01-01', '123456237351421234', '北京市某区某街道'),
                                                                                                                                                      ('S000000988', '柏口', 2, 2, 4, False, 1, '13877436571', '2000-01-01', '123456485894581234', '北京市某区某街道'),
                                                                                                                                                      ('S000000989', '张养', 1, 3, 14, False, 1, '13863607379', '2000-01-01', '123456706061831234', '北京市某区某街道'),
                                                                                                                                                      ('S000000990', '茅满', 4, 2, 19, True, 1, '13829056607', '2000-01-01', '123456930026391234', '北京市某区某街道'),
                                                                                                                                                      ('S000000991', '平顺', 5, 2, 25, True, 1, '13899741959', '2000-01-01', '123456978904811234', '北京市某区某街道'),
                                                                                                                                                      ('S000000992', '狄闻', 6, 1, 27, True, 1, '13838699620', '2000-01-01', '123456986623501234', '北京市某区某街道'),
                                                                                                                                                      ('S000000993', '邹圣', 2, 2, 1, False, 1, '13817374502', '2000-01-01', '123456957845021234', '北京市某区某街道'),
                                                                                                                                                      ('S000000994', '孔黑', 2, 2, 3, True, 1, '13862394670', '2000-01-01', '123456368389891234', '北京市某区某街道'),
                                                                                                                                                      ('S000000995', '薛首', 5, 2, 22, True, 1, '13886289025', '2000-01-01', '123456872072241234', '北京市某区某街道'),
                                                                                                                                                      ('S000000996', '禹阳', 4, 2, 17, True, 1, '13854324133', '2000-01-01', '123456361251691234', '北京市某区某街道'),
                                                                                                                                                      ('S000000997', '范社', 2, 2, 5, True, 1, '13876959582', '2000-01-01', '123456724927501234', '北京市某区某街道'),
                                                                                                                                                      ('S000000998', '薛存', 1, 3, 11, False, 1, '13813112563', '2000-01-01', '123456506513011234', '北京市某区某街道'),
                                                                                                                                                      ('S000000999', '时玛', 5, 2, 25, False, 1, '13837805469', '2000-01-01', '123456327380211234', '北京市某区某街道'),
                                                                                                                                                      ('S000001000', '何阿', 3, 4, 9, True, 1, '13878195382', '2000-01-01', '123456438284851234', '北京市某区某街道');







INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('42955851', 'Kara Garcia', '2009-10-16', '72883254749', 3, True, 8, 9, 2, 1, 'burgesstina@example.com', 'Development sea life poor upon lot difference. Article each morning culture to art can.', 'Important magazine increase design particularly last. Others eat deep receive loss those keep. Call southern spring growth Congress test national.','782390528597025688', '8611 Blackwell Overpass
North Kimberlybury, ID 33253');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('44369921', 'Pamela Patel', '2015-11-08', '36483770423', 2, False, 8, 9, 5, 2, 'peter19@example.org', 'Sort adult able so lawyer. Thought specific our whether who stuff argue.
Physical building hair. Begin book everybody southern.', 'Road population painting series. Culture blue day not bag feel.
Step consider only. Return finish pick vote book when of fact.','245324164936835510', '60121 Reid Station
South Cassandrabury, MH 51090');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('81502778', 'Jeremy Schmidt', '2016-02-24', '10369484712', 2, True, 1, 1, 5, 4, 'jonathan12@example.org', 'Cause box size ever. Ever mean best leg.
Truth election fund everything road. Every into reach. Could there their run run. Machine value appear security despite.', 'Front car front factor by. Effect quality build clear few parent. Five prove away share environment side.','599101352459777516', '527 Michael Estate Suite 162
South Daniel, TN 10434');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('72295429', 'John Ward', '2018-03-29', '19788148404', 3, False, 6, 8, 4, 1, 'douglassellers@example.org', 'Brother avoid debate take customer country. Pressure second face only. Together purpose value life feel speak. Produce use final mention model new.', 'End throw professional unit. Ahead letter couple need chair left claim.
Own with red have. Care away show right traditional. Cover relate explain look policy share.','352465280042420042', '0238 Stephanie Lodge Apt. 516
West Kellymouth, OH 95419');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('23702202', 'Alan Lowe', '2015-12-02', '64294493864', 2, False, 2, 2, 3, 2, 'chenjeffrey@example.com', 'Impact rest alone sort opportunity note. Theory government particular discover. Yourself strong likely air.', 'Still significant wait. Light above various great TV. Still anything race art figure.
Crime series forward. Firm people bring.','774177262179235530', '2556 Shannon Fields
Lake Stephanie, IN 61476');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('18347639', 'Christina Bernard', '2023-10-10', '17934303012', 1, True, 7, 4, 2, 5, 'rodriguezbeth@example.org', 'Tell response minute central team center. Consider indeed move start data. Song per loss study course west suggest mind.', 'Sometimes in though. Future woman court late your detail. North white far business believe. Key movie not institution at again south.
Then throw recent. Kitchen see daughter pull.','830444537620704564', '03132 Shawn Shoals Suite 584
Brianhaven, VI 13342');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('75000777', 'Sheri Jackson', '2020-09-17', '14926617162', 1, True, 2, 2, 3, 2, 'jakeglenn@example.net', 'Ever here will company beautiful along. Happy only voice live this product.
Oil yes language city attorney rather couple. Book more high pretty. Happen main region line break drug.', 'Any source according raise admit read. Create difference support one.
Contain rock knowledge owner billion but level. Reflect though however sense themselves. Safe man get keep strong.','194043975421726875', '43264 Long Causeway
Lake David, CO 14088');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('34211519', 'James Jensen MD', '2019-09-16', '45712504912', 2, True, 4, 4, 4, 5, 'ulara@example.com', 'Success eat star. Can improve campaign produce. Son member American.
Item page clear song lose person. Generation baby bit standard degree truth.', 'About according her American information billion here. Another mouth anyone us man house.
Camera serious green really. Training spend true responsibility including today on adult.','585489816778421328', '7229 Laura Oval Suite 453
Floresberg, KS 60143');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('67703246', 'James Charles', '2014-04-07', '55843162374', 3, False, 8, 9, 3, 1, 'adam59@example.org', 'Need notice road son what black. Art later relate fund.
Never light season social matter. Stock value first. Opportunity front feeling discover describe.
Among recently half live.', 'He yard many I organization conference. Sense find issue standard under. Hope impact maintain.','169384426083747765', '2711 Gloria Street Suite 534
Perryfort, NH 86935');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('31388514', 'Linda Gonzales', '2007-12-08', '55197803443', 1, True, 7, 4, 1, 2, 'smithmary@example.com', 'Mrs hair article son. Process though technology hold tax thus. Available specific foreign blood quality.', 'Republican face people good itself. Almost employee during return. He reveal alone line value management degree. Over source certain owner low difference.','846002046600586063', '075 Jones Harbor Suite 828
Dodsonport, AR 95125');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('72021292', 'Christina Sutton', '2014-07-23', '32217793902', 3, True, 9, 7, 5, 3, 'john93@example.org', 'Citizen then trip set area especially. Green past picture back lose become above foot.
Rich together American. Next piece future free southern mention language same.', 'Scientist remember wear specific side. Need happy eye realize listen investment mother artist.','512437019886096576', '89074 Rios Road Apt. 122
Kellyview, VT 38855');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('73154092', 'Kenneth Wiggins', '2020-08-04', '72352069517', 3, False, 9, 7, 3, 3, 'ssanders@example.net', 'Medical usually forget ask make particularly money. Fast pay only pick about. Describe these rise evening eat need owner law.', 'Bad particularly middle report. Go certain middle real. Subject garden feeling walk matter pretty clear brother. Computer simply back many.','147217707897989096', '293 Christine Rapids
Clarkview, MP 06227');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('64433681', 'Catherine Zuniga', '1996-03-13', '09349346472', 1, True, 6, 8, 3, 3, 'cobbchristopher@example.com', 'Result economy edge quite. Side radio let. Sense base enough executive go.
Protect left anyone lose garden tough. Another democratic letter.
Nice detail provide office. Right floor front question.', 'Meeting tree none else few. Challenge ago remember student.
Agree present finally some. Smile use catch hotel.
Century future seat. Write our authority change.','826532121230934482', '226 Tanner Wells
Jeffreyburgh, IA 13998');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('39044930', 'Dustin Sanchez', '1996-03-08', '12663274591', 2, True, 2, 2, 3, 4, 'sanderssteven@example.com', 'Also born debate his brother.
Home story coach assume. Contain whose before know teach. According language us wrong bring enter yourself.', 'Hotel thank PM decide experience. Wind peace home effort push.
Wrong hard against just price drug. Yes sort painting.','339616708402239804', 'USNV Gonzalez
FPO AP 39311');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('86157539', 'Candice Porter', '2002-04-24', '15574866274', 3, True, 8, 9, 3, 3, 'wigginsanthony@example.org', 'Political like last reason fight cell. Back light pass attack small special west.
Seat article nature sit. Our process too risk significant rock.', 'Sell its guess forget. Power represent page himself class. Work buy key order country manager cut.
Increase their power. Step end billion. She sort term cover writer election.','620230068338248819', '2507 Jeffrey Mountain Apt. 475
Thomasmouth, VI 39292');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('60688714', 'Chris Greene', '2021-10-26', '72301031017', 3, True, 1, 1, 4, 4, 'iguzman@example.org', 'Education town particularly probably institution detail. Least throughout beyond authority go. Computer section nature teach ready. Final every house it whether.', 'Amount still everything down receive high service. Look bed quite offer.','133966529317426731', '88178 Church Cliffs Apt. 349
South Thomas, IN 75276');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('84157323', 'Brandon Walker', '1996-08-15', '50130537928', 1, False, 2, 2, 2, 3, 'james02@example.net', 'Painting kid think part big listen partner.
While method minute condition training race front. Season tonight heavy former more conference. Least similar class benefit.', 'Face prevent process part yeah. Admit play pretty idea.
Act issue seem information. Whose name who.
Card all lead organization standard establish hear. Attack color church impact behavior continue.','139722391766387935', '4566 Jennifer Ville Suite 994
East Melanieport, VA 07086');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('52305822', 'Debra Cox', '1997-01-27', '52959764069', 1, False, 7, 4, 2, 5, 'garciacalvin@example.com', 'Seat wonder impact instead let. Senior quickly if rock significant.
Person skill free former. Notice our hotel.
Day travel pressure agency. Have young accept behind.', 'Agreement produce meet artist not heart throw. Conference dark audience worry there traditional.
Maybe model game. Glass exist mention design early ask.
Her admit why move may risk quality.','029281591415284636', '085 Hays Dam
Port Alison, CA 75555');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('60786982', 'Ronald Johnson', '2018-07-18', '50180307431', 3, True, 3, 3, 5, 2, 'imyers@example.com', 'Protect country police. Practice spend science so father kitchen shoulder. Story avoid too debate.
Degree whole gun goal. Stuff fund knowledge old against expert stage effect.', 'Interest hot democratic carry garden later whatever. Century bank everything however leave miss great.
Beautiful pick yes huge wind sort maybe low. Owner fight owner note analysis same way.','146637618755017007', '443 Kelly Crossroad
Davisland, AS 99167');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('87153663', 'Mr. Michael Greene V', '2023-11-24', '74372377593', 3, True, 9, 7, 1, 3, 'alexanderjohnson@example.net', 'Along book teach wonder serve note your. Foreign special process early threat. Doctor rock once peace remain economy bar recognize.', 'Bag green several apply. Half film campaign if growth state actually. Represent chance clearly owner middle sure skin upon.
Different put ask method.','514901120748239223', '100 Neil Trafficway
Stephenshaven, FL 62953');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('64100931', 'Michael Morgan', '2015-07-13', '39615747702', 3, True, 8, 9, 1, 1, 'qvalentine@example.net', 'Main their church step. Beautiful still once trouble.
System sit project performance four argue building need. Statement whatever cultural point.', 'Suffer lay Democrat high improve section. Bed human side modern two. Evidence present effect attention history detail among.','134555584945096126', '06547 Kristina Brook
Lake Christopher, PA 29798');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('89324316', 'Casey Thomas', '2008-11-07', '34581336000', 3, True, 8, 9, 5, 4, 'jasonpeters@example.net', 'Easy simply fill almost agreement. Agreement quite at course dinner pretty.
Ten center young third. Sound herself movement any. Easy box management fish.
Glass entire would.', 'Control son for line hair visit. Out decision technology else never.
Attack land among summer rich already me. Risk action eight man reach. Risk season word provide thus bag tax.','378876471746027927', 'Unit 6809 Box 9677
DPO AP 39327');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('14940143', 'Jessica Krause', '2000-01-27', '48973382424', 3, False, 1, 1, 2, 5, 'pross@example.com', 'Better garden television safe because conference. Show shake decide than occur.', 'Impact edge morning authority. Away cause three from play walk. Soon reduce forward month different. Not arrive seat agency hospital letter.','087224856119447680', '90527 Eric Locks Apt. 514
Barbaraville, VA 09861');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('89088600', 'Mackenzie Hayes', '2014-01-04', '87656248985', 3, False, 3, 3, 5, 1, 'ublackburn@example.org', 'Both economy teacher bring carry lead. Society drive training others poor wrong. Describe center us one house onto actually.', 'With agree south him company not. Single interview then case.
Phone laugh painting manager. Interview PM read image set east. Cold pay exactly surface building voice charge.','624170699244855218', '556 Matthew Plains
South Pamela, CO 28202');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('80663269', 'Charles Brown', '1996-04-08', '43144457676', 2, False, 10, 10, 3, 4, 'brownbrandon@example.org', 'Build quite production five thousand water. Toward its keep soon. Sort prevent sort air five able. Father summer garden item today.', 'Case generation would choose. Use Democrat truth which. Easy industry improve daughter poor general. Drop least film or people policy their.','688099081594275098', 'Unit 3449 Box 7783
DPO AA 19381');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('40790888', 'Jon Flores', '1995-11-13', '44930975663', 1, False, 7, 4, 2, 5, 'amckee@example.net', 'Road training others sometimes executive heart. Expect station from people spend improve.', 'Same loss box firm central eye never. Dog movie list party speech hotel indeed. Finish part business build read.','141144446187487554', '4238 William Dam Apt. 436
Wardshire, IN 52344');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('35444538', 'Jennifer Garcia', '2021-04-23', '57542008463', 1, False, 4, 4, 3, 1, 'danielherrera@example.com', 'Measure reality for evidence. Data see fine Congress wonder truth Congress. Option way accept for happy better walk.', 'Production force rest involve against here. Reality clear plant image color.
Wife find clear care. Government analysis seem case.','361393671679173089', 'PSC 5164, Box 1924
APO AP 98534');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('87939594', 'Carlos Williams', '1994-10-28', '91102212095', 1, False, 9, 7, 4, 4, 'brian20@example.net', 'A opportunity newspaper senior. Thank eight leader situation information condition agree him. Safe he hair along art.', 'Yet couple civil guy. Research realize not budget on perform.','382115697187198160', '57396 Jackson Plaza
Shepardton, MH 05877');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('21524743', 'Mrs. Mariah Harmon', '2005-01-18', '54524773912', 1, True, 8, 9, 5, 4, 'zayers@example.com', 'Wish night how parent growth ten. Fight sort draw. Enough from campaign.
Pay bar institution tree maintain. Challenge million defense however all reflect standard.', 'Where without its cell husband kid if with. Budget theory fish change yes responsibility commercial. Others choice half treatment dark each sign environment.','942291507212921050', '25889 Chan Club Apt. 180
Lake Jessica, CO 35727');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('27316989', 'David Woods', '2022-06-07', '58901480267', 1, True, 9, 7, 4, 4, 'johnhunt@example.org', 'Ago strong local pick watch arrive participant. Enjoy issue fight building water.
Modern remain group your alone mission southern nature. Indeed read health nation parent game.', 'Middle talk pull station ability everyone. Break practice away network.
Start PM piece outside. Rather into tend rate. Hair side world tough relate various land country.','481998588280074075', '4233 Hughes Fall
South Christina, MT 32367');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('92073996', 'Cameron Anderson', '2018-04-12', '07215755872', 2, True, 1, 1, 3, 2, 'jacksonjerry@example.org', 'Vote feeling institution matter opportunity. Language ahead eight.
Age behind other debate car travel.
Themselves thousand no challenge consumer. Arrive top over think plan only another.', 'Community firm once. Hair forward car important ok itself project. Executive early anything similar all factor significant.','422940085965820497', '4766 Burns Rapids
Keithview, IN 93603');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('80286069', 'Michael Moran', '2014-07-22', '56503514199', 1, True, 7, 4, 3, 4, 'vjohnson@example.com', 'Condition establish allow financial industry decide Republican. Partner already scene instead.
Building do capital. Young ask sister else if.', 'Figure wear instead name with big. Friend buy heavy table. Product crime too something popular. Collection person expect fear explain recently.','021975368826539169', '81201 Nathan Ville Suite 824
Jamesborough, NJ 01028');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('10787932', 'Robert James', '2012-01-14', '72867634348', 2, False, 3, 3, 5, 1, 'rgalloway@example.net', 'Voice easy message decade. Also example together blood change war. Girl site interesting politics southern.', 'Quite sense break claim citizen allow argue speak. Act boy five study including.
This buy our find.','961783967511804428', '02270 Jennifer Course
Justinmouth, VT 88343');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('55449106', 'Linda Wright', '2013-12-30', '35632851250', 3, True, 1, 1, 1, 3, 'andrewpaul@example.org', 'List purpose technology win choice. Recent son into grow section. Few middle pressure man arrive world focus.', 'Carry material likely across court both. Day in story lot statement for address.
Trouble whatever all dream must. International sea generation believe. Fund friend for participant recognize.','917008708420448043', '45046 James Road
Sullivanville, WY 67974');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('78691708', 'Christopher French', '1997-10-29', '11149452716', 3, False, 3, 3, 2, 4, 'mvillarreal@example.com', 'Cover large every president. Available statement war at career. Movie participant investment foreign street message herself.
Candidate group become use. Mr hotel usually hear.', 'Deal surface there tax reason five. On group word. Explain social clear herself.
Garden rather already full former. Evening I wait structure financial.','489344945175836575', '80513 Michael Meadows Suite 579
East Monicashire, OK 64934');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('34362399', 'Michelle Rodriguez', '2022-02-09', '25151519764', 1, False, 8, 9, 3, 2, 'stantonjay@example.org', 'Stop relationship view western develop large. Fly successful than class star maintain reflect race. Speech drive expert focus performance. With season president authority here avoid public.', 'Commercial better another often magazine size indeed.
Appear production win themselves of event charge trouble. Space win animal once.','463802947248996705', '799 Duran Mountains Apt. 954
Lake Jenna, RI 42950');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('56558236', 'Daniel Smith', '2020-05-27', '84605443444', 3, True, 7, 4, 1, 2, 'ischneider@example.org', 'Total concern anyone. Option material vote data respond.
While effort floor society usually Mr smile. Specific local born catch happen generation.', 'Sit news main present. Animal hear issue whole must agree job child.
Economy worry majority physical. Pass actually charge body report.','614590961218330737', '47687 Lori Manors
Walkerland, AS 31794');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('97451315', 'Belinda Frank', '2005-06-01', '15420234100', 2, False, 8, 9, 3, 5, 'fitzgeraldgarrett@example.net', 'Move case notice. Above foreign others.
Serve process environmental energy. Front nature push bank help effort woman. Animal new color night direction relationship memory.', 'Increase economy carry number. Entire find event eat. Across care seem significant.
Institution east former any economic raise. Throughout red sing edge minute. Three try owner prove.','092369369345662151', '611 Perry Cliffs
Parkerside, WV 93551');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('34178487', 'Kathleen Nguyen', '2012-07-22', '04783786385', 1, False, 6, 8, 5, 3, 'danielbennett@example.org', 'Great discuss only where avoid. Out capital quickly their.
Child official amount poor around. Agree series range expect. Born fine or military.', 'Discover lot go door design site. Need student husband democratic. Attention career about mission surface cup.','233554662068304383', '46159 Andrea Ranch Apt. 227
Sylviatown, HI 72419');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('44365311', 'Jeremy Smith', '2023-01-12', '83293140160', 1, True, 9, 7, 4, 5, 'cfoster@example.com', 'Trade great kind state.
Have stuff serve from. Already remain fish. Employee election local finish.
Fact and board risk point cost international. Necessary long note along.', 'School possible common after career pick reflect. Face serve degree. Around manager that network player population identify.
Tend prove my benefit quality factor evening.','852891548690707051', '4984 Michael Spur
Angelafurt, CA 77010');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('39517064', 'Amanda Martinez', '2012-11-18', '21111618054', 1, False, 2, 2, 4, 3, 'francissheila@example.com', 'Because task material account detail. Character TV particular camera low network Mrs.
Appear property fly moment goal. Military claim door teach human. Speak bar time prove.', 'Determine our happen already. Group financial want case ago. House green fund pull peace. Attorney maintain anyone fish I energy total beyond.','779644644644843235', '157 Rogers Squares Apt. 943
South Elizabethland, PW 14744');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('81114287', 'Kevin Daniels', '1996-02-29', '47383556765', 1, True, 8, 9, 4, 2, 'david30@example.com', 'Medical administration hand four discussion forward. Father into no edge happen. Seven notice use theory enter fast my.', 'Blue special successful crime growth range appear main. Her task so since there bad above practice. Every manage right rest.','203700617433523780', '478 Warren Villages Apt. 792
Fisherbury, PW 51724');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('54420183', 'Christopher Roberts', '2006-01-13', '44117393646', 2, False, 9, 7, 3, 1, 'christina76@example.net', 'Back campaign develop visit. Red several become serve fund. Coach I market knowledge sell cup.', 'Similar far wife how perhaps threat business. Although baby research next.
Population approach Congress sister skin yet. Professional bad capital left these side me child.','893197632570162670', '4824 Nancy Freeway
Nathanburgh, MI 11158');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('28002715', 'Teresa Austin', '2015-09-27', '06487727151', 2, False, 1, 1, 5, 4, 'lalvarado@example.com', 'Cell end evidence while. Clear you large debate.
Put political coach reach establish land respond something. Skill treatment hotel stand.', 'Yes create partner common pull room return way. Once development make loss challenge usually. Entire store case suddenly dream.
Although night theory. Medical dinner specific boy research.','282661680952503906', '6120 Johnson Haven Suite 472
West Rickfurt, VA 11502');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('88313869', 'Amy Ryan', '2016-12-27', '25029560396', 1, False, 8, 9, 2, 2, 'ddodson@example.com', 'Increase large stuff case. Surface trouble cause perhaps shake radio.
Great fly beautiful standard from student style. Thought material bank despite. Computer on stuff write threat old whom speech.', 'Mission long up only spring society seven. Always role once type paper already in.','199865312343310068', '853 James Points
North Teresa, GA 43124');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('61865109', 'Charles Robinson', '2023-07-23', '62704970421', 2, True, 10, 10, 5, 5, 'david78@example.net', 'Near art fly fill day. Side sing employee not. Wide likely author do strategy bit with particular.', 'Design start mention job. Something poor no show upon. Above sit real wonder list market can.','048796980866348338', '81144 Spence Mews Suite 402
Scottfurt, VT 86122');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('91017579', 'Daniel Butler', '2013-03-19', '37711789624', 2, False, 4, 4, 4, 1, 'cbarajas@example.com', 'Hotel assume enough allow case plan. Draw tax rule price. Huge reduce second account cultural.', 'Executive let article boy effort present action. Save the rest reveal research.
Appear us bit child character go. Environmental bed page film task onto. Age near deep result majority.','138150062826581477', '3404 Paul Keys Apt. 553
West Jimmyton, IA 87994');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('85428653', 'Marc Rodriguez', '2010-11-20', '42817468189', 2, True, 5, 6, 5, 5, 'dhill@example.org', 'No nor right seven. Seat onto rise north be newspaper.
Focus break soldier should decision range space attorney. Life reason true two coach.', 'Hot vote answer option administration. Direction range control smile skin.
Remember ground available agreement design degree allow. Body early notice hope heart fund likely second. Front all gun law.','108981991161641283', '101 Christopher Pike Apt. 505
Michaelfurt, MP 64632');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('64383213', 'Tracey Reid', '2023-09-18', '27570115980', 2, True, 5, 6, 1, 3, 'davidthompson@example.net', 'Purpose white they protect grow. Pm despite firm line.', 'Number article size seem generation side today. Particular go less. Sign for worker professor hold left.','099214800015796167', '78120 Sharon Streets
Debratown, VI 20549');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('56402486', 'Amy Stanley', '1998-02-12', '71484995553', 3, False, 5, 6, 2, 1, 'awilson@example.com', 'Smile commercial I standard community economic. Big appear direction senior project safe.', 'Seat same list compare. Bed customer enter kid one. May miss according others board.
Pressure southern yard. Real agree while spend. East born mean letter stage new best.','475931497448059097', 'PSC 4295, Box 1292
APO AP 16184');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('37089449', 'Eddie Page', '2017-10-03', '28043416329', 1, True, 8, 9, 1, 1, 'aandrade@example.com', 'Others writer chair various less specific bar name. Think standard do teacher.
Cut structure poor free. Know get at learn.', 'Under art million rise. Though knowledge oil believe. Fall agreement suddenly reason. Movement who capital with least politics hour.','024816474863857698', '5997 Ellis Green
West Christina, OH 75171');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('56601075', 'Devin Bailey', '2006-07-07', '27300993467', 2, False, 7, 4, 3, 1, 'mgreen@example.com', 'Responsibility arm large wonder talk race. Effect man ok consider. Full plant attention idea one still.', 'Mention real bank them kind. Us prove down such law or. First miss available size.
Staff Mrs drug bank end. Surface me apply issue.
Share attorney program concern.','920810021037543617', '736 Austin Turnpike Suite 649
West Matthew, AR 52089');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('64476669', 'Brian Barker', '2007-11-27', '84987817202', 3, False, 8, 9, 3, 4, 'williamsmadison@example.org', 'Responsibility four investment a until none only. Shoulder white system cost real next crime.
Season bad day. Market night represent while tax.', 'Though discussion increase. Exist investment special coach world though. Lead policy address natural director. Property best age despite rock forget.','737282680013467199', '5804 Gill Creek
Port Audreytown, SC 65476');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('52942831', 'Justin Lewis', '2016-10-15', '15847568317', 1, False, 3, 3, 3, 5, 'kcollier@example.org', 'Dinner individual mention entire machine present. Receive everyone summer language.', 'Past would defense think important though professional. Decide as old right stuff past down. Point mouth wide coach.
Compare practice account ability. Third similar cup teach popular.','030352133239442192', '0563 Mata Passage
Armstrongfort, ID 12110');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('19067409', 'Trevor Cruz', '2014-01-14', '67316108491', 3, True, 4, 4, 5, 4, 'hilljohn@example.net', 'Class especially show necessary. Congress election try wrong current scientist already.', 'Me opportunity common friend check account return.
Shake important structure. Allow fly foreign event apply least become.','302067597806389546', '34854 Patricia Cliffs Apt. 571
Deborahmouth, MI 37140');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('60125126', 'Rachel Walker', '2008-12-23', '24221093562', 1, True, 1, 1, 2, 5, 'david58@example.org', 'Social herself carry evening action late. Crime challenge find growth. Suffer order executive. For else with pick.', 'Court build up great less own. Home pull appear class quality past.
Your after president skill remember yes center police. Thus student early impact plant building ten despite.','459196494497737576', '6955 Walter Station
Adamton, NJ 72094');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('84527875', 'Jennifer Brown', '1996-04-14', '95161160035', 2, False, 7, 4, 1, 2, 'tracymartinez@example.org', 'Someone quality money wrong challenge. Indicate stay development catch bad.', 'List imagine argue physical audience. Enter wind important executive agree. Structure rather economic state.
Myself tend reflect technology. Our prove participant song.','250057333268120476', '1407 Cortez Turnpike
Bassport, UT 95457');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('89048753', 'Cassidy Wright', '2014-03-18', '66278733721', 3, True, 8, 9, 2, 1, 'johnshepherd@example.org', 'Company paper dinner few create soldier improve reveal. Or medical note among modern. Financial federal throughout think president account.', 'Join deep as might. Full get training economic coach play whether tax. Plan traditional improve up true. Word just leg someone appear worker.','081892396154105148', '400 Kim Port
New Christopher, MD 68864');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('12345678', 'Lori Hunter', '2007-09-16', '78093101251', 2, False, 6, 8, 2, 3, 'stewartjennifer@example.com', 'Great quite lose program should.
Such create middle see religious thus religious. Land high standard ever and operation doctor first. Usually company create already.', 'Project economy know speak. With be sort table pressure there end. Term free election night pressure TV.
Tell feel visit site.
Half including five serious. Full child feeling eight image body key.','084711901347692330', '2365 Lisa Trail
East Shawnshire, OK 77122');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('71801141', 'Anthony Anthony', '2016-08-29', '61500399537', 2, False, 4, 4, 2, 1, 'brownjennifer@example.net', 'Help economy between. Heavy open in five hundred institution instead. Collection personal audience out gas miss night.', 'Create Congress guess within. Camera law result citizen sure job.
Phone policy reality by what nothing reach. Sea establish identify two billion because. Work stage have beat it music.','753740170569034646', '401 William Village Suite 334
Brayview, MD 13216');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('79557600', 'Sheila Roach', '2019-12-14', '55576380275', 3, True, 6, 8, 1, 2, 'sbennett@example.net', 'Tough week phone business rather deal. Brother occur floor design. Spend fear goal whom.
Company recent worker old middle those. Important doctor place loss.', 'Six including soon surface me. Turn front child face great treatment. Right leg everything entire throw.
Green provide behind point hot market much. Likely claim important good line.','047431886680894325', '196 Jones View Apt. 112
East Wayne, NV 28516');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('99759050', 'James Ortega', '2008-03-31', '81265208307', 1, False, 7, 4, 5, 5, 'shawn65@example.com', 'Girl ago today new cold data fear. Write course citizen those allow everything.
Receive author oil area what laugh. Network prepare choice.
Parent agree loss rate. Teacher wear tough loss anyone.', 'Stand all hair live stand the nation order. Cost out book middle thought. Forget according goal project among increase.','455650216033361668', '15106 Bruce Via Apt. 864
East Alexandra, ME 59526');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('74725750', 'Larry Turner', '2007-04-28', '70084574805', 2, True, 6, 8, 2, 1, 'mark88@example.com', 'Body nation decision last successful small. Most break read language test and. Rather itself behind street magazine area outside.', 'Because democratic blood create rate must.
Man nation rate although. Likely culture thus scene us trip.','247699533294748337', '569 Michael Bypass
Lake Maryton, VT 83533');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('64619063', 'Kyle Pennington', '2017-07-02', '43423542886', 1, True, 4, 4, 1, 5, 'randallgeorge@example.org', 'Us different during. Theory entire necessary wide with. Responsibility move remember trial issue item hospital. Fish first weight adult establish.', 'Audience make line couple great center young. Morning happen marriage medical. White leave few shoulder old stop.','391259000035922851', '31984 Brown Court
Laurenmouth, CT 35563');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('65151585', 'Frank Martin', '2017-03-20', '24558783512', 2, True, 5, 6, 5, 3, 'omcclure@example.net', 'Sea else good entire already. Of democratic fine stock. Firm must third source information phone those card. Student run sing.', 'Leg entire language civil drop. Yard forget west leg face sister lot own. Attack best event simple.','327169659330778762', '1232 Meyer Inlet Suite 286
North Alejandro, MP 93992');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('40544868', 'Christopher Becker', '2000-12-23', '52701241254', 1, True, 10, 10, 1, 4, 'david02@example.com', 'Nation to bank how example. Letter nor statement peace theory house these.
Drug civil staff so fall data. Final agreement involve with represent guess model. Might suggest can above.', 'Everybody ahead note loss policy. Generation particular method probably.
Marriage garden for per thousand he find. Difficult since nice happen. Pressure be none control painting open.','683624737207973770', 'PSC 7418, Box 1758
APO AE 43261');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('99375488', 'Eric Guzman', '2017-11-16', '42038020010', 3, True, 3, 3, 5, 4, 'cacevedo@example.net', 'Customer movie old positive. Identify medical during write official.
Century shoulder hot plant out anything bad. Law news rather. Talk under TV would live.', 'Support realize buy road world. Director particularly air major.
Area partner save security man billion many. Effort white relate difference. Finish just candidate happen always.','505192731465853323', '5383 Gabriel Avenue
West Michael, WY 27714');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('48290728', 'Jay Weaver', '1999-10-15', '69681508987', 2, False, 2, 2, 4, 1, 'lori02@example.com', 'That serve weight economy. Scientist any some. Own truth use partner why.
Full unit major well. Day anyone top win of their.
Last money do agent ask pull ok. Impact side front rather.', 'Night edge remember. Smile great billion mention water goal visit. Way bring along rule.
Bill director mouth white foreign various laugh. Yeah base affect fight control.','100627167504220241', '22378 Jacob Wall Suite 440
Lake Phillipstad, AZ 47456');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('30606394', 'Jasmine Fisher', '2005-03-03', '18561250190', 3, True, 3, 3, 5, 2, 'zlopez@example.net', 'Face machine television media walk particular key teacher. Too foot law wind.
Create explain church little. Actually woman their now agent apply. Keep field around wide teacher.', 'Employee we final early nothing lose sing. Get cold between. Fear she strategy his.
Arrive strong understand into position. Case fall how information daughter.','267618682730498107', 'USNV Wood
FPO AE 51574');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('83186391', 'Jacqueline Garrison', '2016-12-10', '34197257102', 2, False, 10, 10, 1, 1, 'ikey@example.net', 'Can significant term history act rich. Responsibility life recently.
Laugh discuss magazine though line. Card whatever include take affect rather. Pull suddenly travel measure control bag short.', 'Chair strategy look civil. Best list clear hit oil.
Involve food song card raise. Top she art law you.
Standard debate top stage firm body. Tonight west itself instead area front.','202388796383797466', '88947 Ashley Drives
South Anthony, VA 02629');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('53346212', 'Jennifer Anderson', '2023-06-08', '56812994494', 2, True, 10, 10, 1, 3, 'janicewalker@example.org', 'Clearly couple enough natural tough develop. Owner way yourself section until maintain. Partner smile opportunity size.', 'Respond strong test consider within decade computer down. Light suffer these fast religious letter along.
South enjoy trip find mention. Forget final believe push story election report.','525458828531529099', '94361 Estrada Flats
Lake Nicole, IL 52031');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('54429328', 'Sherry Campbell', '2006-01-06', '28572253341', 2, False, 7, 4, 1, 3, 'tshaw@example.net', 'Player institution fish example professor moment action citizen. Administration five call laugh. What assume leader whole bank each plant.', 'Class among shoulder available artist. Standard professional build dinner television hard culture. Policy everybody watch television everybody show education recently.','428350145416973946', 'PSC 1375, Box 7201
APO AA 68649');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('71803291', 'Tony Snyder', '1999-05-01', '42110593943', 3, False, 10, 10, 5, 5, 'stephanieanthony@example.net', 'Lay arm capital PM international star over. Believe research cut.
Them result again ground.', 'Each able also example condition hour. Open debate save song. Whole your tax room.
Trouble law shoulder type agree. Each page color hold difficult military. Laugh attention the bank simple.','715569582605392741', '75304 Hogan Shore Suite 758
Jeremyport, IN 90628');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('59296547', 'Melanie Miles', '2001-10-15', '39714259414', 2, True, 3, 3, 2, 1, 'alexa31@example.com', 'That think point lose than your your. Adult hope cause could manager anything.
Rock difference name rise special success want. Ago never prevent Mrs. Gas way off paper. Probably various oil.', 'Hour hotel cost fact material late east. War now population than policy. Short charge rock us school.
Total effort participant course avoid deal.','703163526294986050', '64943 Zimmerman Turnpike Apt. 501
West Laura, NE 61327');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('91604248', 'Linda Dixon', '2016-04-23', '01425579588', 3, True, 8, 9, 3, 1, 'christianzimmerman@example.org', 'Own must good others drug.
Control attention kitchen power brother boy. Major back go up art. Might cup official design dream also.', 'Market water great arrive serious consider. Attack east really own around hear wait. Today indeed want whether tell lead.','811133170363580965', 'Unit 8394 Box 2237
DPO AE 45469');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('38903989', 'Christie Boyle', '2011-12-01', '41884305665', 1, False, 7, 4, 2, 5, 'goodwinashley@example.org', 'Help position good stay own himself executive. She those reach partner film soon present. Including affect weight president trial house. Many majority prepare institution.', 'Him should fast relationship against. Indeed sometimes my change chance fish. Source major left people science.','756579105882730890', 'USNS Green
FPO AP 50361');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('66623747', 'Shawn Thompson', '2001-01-22', '29196041205', 1, True, 8, 9, 4, 4, 'karen27@example.org', 'Another city wrong mother. Investment put song argue bit. Civil lead up hot financial.
Talk interview vote might visit military can free.', 'Mission central quickly you tax material arm. Walk teacher public clear late capital.','840878678671598061', '9242 Alyssa Forges
West Johnland, SD 45911');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('23845069', 'Alisha Ferguson', '2003-08-24', '78365217907', 3, True, 5, 6, 5, 5, 'dkane@example.org', 'Eat already region heart. Fly ago director.
Town home recently final degree wind some. Nearly central treatment course listen human.', 'Accept heavy character beyond take take I. Discussion direction certain step authority start. Finish opportunity store similar almost.
Dog report coach establish. Hour group source often few middle.','520627694830369695', '2808 Theresa Fort Suite 690
Lambborough, TX 32202');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('62314604', 'Sarah Brown', '2013-06-02', '49899858343', 2, False, 3, 3, 5, 2, 'jodystafford@example.org', 'Happy miss administration. Series organization fill usually which listen improve.
Rock identify activity. War over market drop change quickly this. System one add land like land.', 'Imagine data politics recognize thought act. Realize movie worker career they second. Add market employee end line different model.','561413463319933185', '49088 Victoria Pines Apt. 449
Heatherberg, MO 54932');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('25182533', 'Michael Williams', '2023-01-15', '99008834093', 2, True, 1, 1, 4, 3, 'david29@example.com', 'Campaign laugh in then. Gun bed visit. Culture former get throw.
Collection defense fact sure. Check on three owner.
Race benefit develop bed their exist including. My write should.', 'Able kitchen whom report think get yes.
Again purpose school stock. Quite really meet care. Interview couple could performance suggest.','986473184244460004', '3544 Tyler Courts
North Timothymouth, GA 93728');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('32345882', 'Luis Jones', '2000-10-03', '47109657939', 1, False, 6, 8, 2, 2, 'alexbrown@example.net', 'Southern why great would. Opportunity contain back. Kitchen risk from.
Here system any our.
Shake return around drug federal very. Scene owner foreign. Mrs herself one doctor authority.', 'Decade suffer difficult important serious form. Management quality perhaps send above. Cut little enjoy base will without.','158256784148679616', '116 Casey Ville
Juanhaven, WY 31146');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('69439534', 'Joshua Vargas', '2007-07-26', '67358720670', 1, False, 4, 4, 4, 3, 'danaboyd@example.org', 'Thank car especially game usually. Agree state he save manage weight. Study executive accept on sister.
Own wall recognize leader. Skill letter someone different. Her policy fund.', 'Room down side. Majority travel north bag return. Concern wall ago song eye low left authority.
Industry everyone bit international. Worry enter minute hope possible other must attorney.','284989782347104855', '68944 Smith Lakes
Connieborough, TN 18631');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('28887273', 'Jeremy Delgado', '2001-05-15', '75889388453', 1, False, 3, 3, 5, 3, 'coreymccormick@example.com', 'Choose trade air require paper model threat. Particular trade believe either into great.
For contain office watch purpose special perhaps. Story hospital newspaper.', 'Human decision quality term wonder positive. Director student safe personal radio name someone.
After each future interest accept. Determine whether well nice.','791715373812917898', '43306 Webster Flat Apt. 169
Port Jotown, AR 49635');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('10719082', 'Shannon Pace', '2007-10-28', '53022228491', 3, True, 8, 9, 2, 4, 'fmurray@example.net', 'Career while lose economy growth five government pick. Child create buy father learn identify.', 'Today term pattern available peace past include. More everything exactly organization would spring study. Perform guess indeed.
Kid stop check one daughter. Green who knowledge store.','268582165958187091', '00523 Lindsay Field
New James, OH 56770');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('60382718', 'Robert Ortega', '2001-11-13', '84477475314', 3, True, 5, 6, 3, 3, 'john16@example.net', 'Huge until final fish. Stock when perform amount business foreign.
Pm point authority well point majority. Machine pass let interest example onto. Report believe receive old pretty new drive way.', 'Loss energy part. Theory life political firm. Affect tree take that before gun.
Name foot able training official front. Water last yourself himself. Religious win probably business knowledge.','651271547426695061', '4355 Michael Mountains Suite 667
Sherrybury, AS 89183');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('87128617', 'Stacey Murphy', '2006-06-19', '16295062090', 3, False, 9, 7, 3, 1, 'troyhammond@example.com', 'Recent wide face skin. Be among air affect rule. Across why home but writer.', 'Wall teacher attorney fund sure score production. Then nature human no yeah late free return.
May maybe central sometimes. Black tend personal agency edge simple.','209407872817113067', '8232 Welch Ranch
West Helenborough, AK 56321');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('67503850', 'Jeremy Fernandez', '2011-09-10', '63735754583', 2, True, 7, 4, 1, 5, 'saralloyd@example.org', 'Computer natural most probably window. Test meeting send current police.', 'No three plan floor cold field eat. High cold together eight day north information similar. Marriage morning property somebody west face financial relationship.','021493644631054917', '3848 Linda Stream
West Antonioside, VI 08539');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('57891481', 'Destiny Taylor', '2022-06-08', '88483800885', 1, True, 5, 6, 1, 2, 'hannah54@example.com', 'Cup interest population product population morning. Least office whether seek particular century. Both today blood allow building.
Tv agreement form consider.', 'Skin meet article bar consider. Able material alone fish available local machine possible. Show model green foreign partner.
Even here institution field statement.','116898961159346145', '256 Joshua Wells
Port Aaron, IL 47709');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('93422097', 'Brett Williams', '2014-10-23', '25711798308', 2, False, 4, 4, 1, 5, 'hannah55@example.net', 'Past some result media. Message black fund mouth phone important start. Now other weight.', 'Prepare his people born. These quality relationship example when.
Camera head church catch idea. Rather these could.','565653279568150404', '42996 Ramos Summit Suite 764
North Martin, KS 06520');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('99808130', 'Lisa Sharp', '2007-07-03', '35433974654', 1, True, 7, 4, 5, 2, 'angela34@example.com', 'Alone modern fire inside. Protect game eye others heavy.
Especially lay easy machine see. Ready work age light. Break would lawyer marriage. Education opportunity reach amount.', 'Provide beat sure strategy idea Mr financial. Others usually something memory able. Finish traditional environmental color region plan pattern very. Me set future remain thought difference suffer.','226850491610218427', '052 Hicks Valleys Suite 123
Banksport, FL 36498');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('22410144', 'Nathaniel Potter', '2003-08-11', '11569764513', 3, True, 3, 3, 4, 1, 'tiffany52@example.org', 'Compare into computer affect. Account game sit.
Small no partner college easy issue talk join. Will whole it water black.', 'Push performance none or beyond wide detail. Property guess hundred room company character cup.','849079431281059891', '59032 Mercado Light
Tylerport, WV 61232');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('94514955', 'Rachel Lopez', '2010-12-29', '32227006111', 2, False, 6, 8, 5, 4, 'bcabrera@example.org', 'Tonight very sort return remain. Half reality reality report film.', 'Where feeling until. Ask send write determine take.
Door seem either of. Know gun might.','148161450514641538', '05453 Brown Harbors Suite 413
Port Alice, MI 26072');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('48173165', 'Todd Hughes', '2020-05-26', '92522632261', 2, False, 4, 4, 3, 2, 'srodriguez@example.com', 'Bad also could like perform general yes training. New organization light then. Front third inside.
Generation source me.', 'Social price civil out next make chair result. Parent somebody grow eat leader light either. Join decision sort indeed have history.','341462265800204421', '547 Morris Station
Michaelfort, NM 31826');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('26101770', 'Christian Robinson', '1998-11-30', '75574651300', 1, True, 8, 9, 1, 1, 'williamspamela@example.com', 'Its on agent decision production. At size according still.
Up professor area take responsibility allow. Big security seven behind. Generation rest growth one peace your partner.', 'Scene beat behind between science event. Defense table ahead during season responsibility agency. Training civil peace attorney care military all those.','028701223357938752', '783 Wallace Brook
South Justin, OK 50860');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('63824482', 'Tiffany Riley', '2000-12-22', '85156046420', 3, True, 9, 7, 4, 3, 'oscarsanchez@example.net', 'With defense lay both walk war later American. Increase me put.
Federal name establish size skin. Program each stuff stop as onto rich.', 'Another space court become eye everyone water. Way cover occur bank voice rule their school. Case camera general say then agree.
Ago specific benefit single look interview. Talk wall let.','368592045085227590', '73197 Jasmine Manors Suite 376
South Markborough, MP 24155');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('28370650', 'Michael Massey', '2005-06-10', '17621714821', 1, True, 8, 9, 1, 3, 'jbell@example.org', 'Position side bill race require. They good evidence long fight range realize.
Hand hold picture knowledge vote. Eat white conference cut.', 'Already executive recently carry form have. Hope three company improve. School consumer sound certain commercial husband.','298256971484783790', '3800 Chelsea Island
Amytown, VT 22872');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('49229482', 'Kevin Martinez', '2018-02-04', '27903356081', 2, True, 8, 9, 5, 5, 'lelliott@example.com', 'Less hold certainly wonder citizen each west national. Away international piece west finish.
Activity provide movie go. Executive price subject campaign open. Also yes time myself ground father have.', 'Big goal read anyone decide. Anything happen during.
Else try hold close be. Technology action not film teach media sell agreement.','208662049956220407', 'USNS Mclaughlin
FPO AA 48934');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('75551279', 'Mike Hernandez', '2015-05-27', '15904469303', 1, True, 5, 6, 3, 4, 'morozco@example.com', 'Sure seek write performance figure hand whatever. Build stop pay.', 'Will recent tax expert who already son chair. Around him feel before write. Investment learn sometimes boy.','384956784047492341', '29055 Perez Port
Karifurt, OK 89482');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('92050141', 'Devin Hess', '2000-10-13', '07609982158', 3, True, 6, 8, 2, 4, 'pittmanchristopher@example.com', 'Economy director move production success pick. Market community sometimes sound. Line peace minute including tax loss.', 'Until beat reduce your story since strategy charge. Expert fight simple address beat someone. Only than wall such safe move guess.','364698378348272639', '681 Meyer Ports Suite 239
Sotochester, MA 60744');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('64673348', 'Todd Lewis', '2016-09-09', '74376842411', 1, True, 7, 4, 2, 1, 'nmartin@example.org', 'Name degree what which money piece hair.
May child travel trade wife appear that. Instead job natural work drive current challenge.', 'Past art war who. Admit choose cup only former operation describe grow. Life somebody another citizen kitchen recent region.','942802462825117427', '49032 Thomas Summit
Blackberg, IN 50697');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('86132087', 'Phillip Carey', '2002-06-23', '65932037298', 2, True, 9, 7, 2, 3, 'mcampbell@example.org', 'Firm fill up. Blue town resource sometimes new. Movement operation again policy happy.', 'Ahead enjoy reflect name second your feel.
Arrive ball build gun better. Think west want low. Whatever customer effort red modern hold.','710881604206551309', '43045 Bryan Gateway
Austintown, UT 16070');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('66026824', 'Seth Vazquez', '1995-02-25', '73890106855', 2, False, 1, 1, 4, 4, 'nguyenwanda@example.com', 'Movement truth improve risk character ball. Now region music ever certainly our could.', 'Sense center series season crime. Nation blue talk age. If move push bad.
Us resource group fall meeting. Word benefit international price week ground send fast. On indicate order six.','033822032578951298', '07656 Michael Crossing
South Kathryn, MA 51618');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('19114149', 'Amy Edwards', '2022-09-24', '40547403534', 2, True, 7, 4, 2, 5, 'deanjohnson@example.org', 'Type increase magazine although. Energy focus recent inside. Whom seven real response student behavior level.
When own up week. Lot least success clear.
Space talk character shoulder collection dark.', 'Least go building address group. Conference board world hotel time. One group message art he.','600895456355437674', '53861 Jackie Manors
New Williamside, NE 37325');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('76768362', 'Jason Williams', '2000-01-08', '92065385507', 1, False, 4, 4, 2, 2, 'diana88@example.net', 'Return some push guess. At run risk smile.
Entire site understand allow. I state foreign write opportunity service. Writer stay door radio entire any.', 'Whose cultural along size our movie they. Two effect federal single idea.
Action mother foreign state nature. Author whom improve seem hand yes. Same these customer act tax.
Identify door president.','072841797262689379', '486 Mcdaniel Point
West Michael, MS 87301');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('23129952', 'Billy Cook', '2011-05-11', '07193646103', 2, True, 5, 6, 4, 2, 'wmiller@example.org', 'Place radio office condition. Hard same cut yard hour since thousand. Tell religious rock significant.', 'Station account study magazine address production term. Alone she window. Value determine staff rule off everything push.','212800696142882484', '079 Johnson Junctions
Lake Marcusfurt, SD 32514');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('96790323', 'Calvin Henry', '1999-07-01', '94163089723', 2, True, 9, 7, 2, 5, 'wmiller@example.net', 'Most movement expect technology well far let this. These operation source summer wide defense produce. Chair turn magazine reveal never.', 'Must carry although painting sign type society drug. Land activity next special couple away draw. Heart win high significant read.','091797646711620692', '81337 Benjamin Points Apt. 942
West Sarah, MS 75244');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('35635843', 'Jesse Miller', '2010-09-18', '24489077181', 2, False, 6, 8, 2, 1, 'mccartychristopher@example.org', 'Model water gas once door join health training. About house talk reality I almost. Moment office again sport full.', 'Yourself bring avoid race public. Study while child suffer night field boy. Loss truth left wind respond tend.
Wear clear less out major. Everybody although gas.','042015333973957138', 'USCGC Nguyen
FPO AP 37446');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('53801923', 'Alexander White', '2014-12-22', '70500475035', 2, True, 8, 9, 1, 5, 'tyleramber@example.com', 'Whatever it off structure deep hard. Big reduce role.
Thus development central. South quality claim name. Probably sort quite someone election certain.', 'Number media history sister. A resource present TV form establish.
Information meeting policy war light you. Season rise so pattern hand natural focus. Strategy participant sport idea alone most.','167907316919326010', '2890 Karen Rest Apt. 145
North Cameron, PA 04166');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('20419558', 'Kristen Rodriguez', '2023-09-07', '31517043822', 1, True, 5, 6, 2, 5, 'beckerdavid@example.com', 'Knowledge forward consumer say least reason. I network feeling by industry call.', 'Huge describe identify see yet catch around away. Learn us brother when. After seat statement.
Drug smile low hold station.','340322684530569738', '8860 Johnson Shores Apt. 000
Smithtown, AK 02644');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('64286767', 'Rebecca Allen', '2019-09-30', '99225793756', 2, True, 7, 4, 5, 3, 'amanda76@example.net', 'Game land population. Seek dinner gas magazine position whom hospital.
Example sit fish thank beautiful thousand. Floor whether middle watch create minute itself. Different any performance crime.', 'Help cause kid thousand discover now magazine. Director woman check religious along political. People leader push minute note.','241852008286267089', '7340 Sullivan Cliffs
Brendaton, DC 04763');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('54127475', 'Carla Costa', '2013-06-30', '82436988356', 3, False, 8, 9, 4, 3, 'zhangbrian@example.net', 'Network road in the. Head through standard better hard either unit want.
Rise hair source public front if.', 'Suddenly son whether tough despite cover similar feeling. Main investment need. Continue lead wait call shake determine I.
Politics structure wish cup prove hand.','439292799569446298', '533 Nicholas Haven
Lake Mark, HI 84389');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('98863939', 'Jimmy Rojas', '2019-09-14', '29041183107', 2, True, 7, 4, 3, 4, 'mclaughlinscott@example.net', 'Then challenge politics exist new environmental create. Couple poor prevent all onto.', 'Expect look pay news fly cold technology toward. Child dog money song. Protect right forward team than life statement inside.','964144219574719267', '440 Andrade Vista
South Emilyton, TN 16883');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('82767820', 'Carlos Hall', '1999-10-29', '48672141221', 2, True, 3, 3, 3, 4, 'fosterjames@example.org', 'Popular add answer. Player now later white receive wear pretty. Because effort choice rest most.
Picture support that during body off American.', 'Shoulder interest nor leave. Candidate measure voice page plant.
Throughout dog approach between notice drop our reality. Land boy ball candidate real. Accept safe upon.','050437691197054328', '7688 Cohen Spur
North Stephenfurt, WY 43369');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('87966078', 'Erica Jensen', '2000-04-06', '99055592495', 1, False, 6, 8, 1, 4, 'rjohnson@example.org', 'News but art list design. Organization morning we finally bag space girl.
Spend collection deep yourself program trade. Pattern yard common on someone example country PM.', 'Protect take four perform behind simply each.
Pretty radio memory because next. Fire second note particularly yet.','263491627002482366', '6258 David Harbors Suite 854
Amyburgh, MP 15892');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('15555352', 'Laura Ferrell', '2012-02-07', '54327749999', 1, True, 1, 1, 4, 5, 'coxjulie@example.org', 'Million individual skin friend view bag I. Strong car moment in sell theory. Room high black throw official fear.', 'One better turn general environment this. Kitchen three officer similar soldier young. Wide of down itself point station worry.
Time that interview only claim owner street.','369482997473805525', 'PSC 8844, Box 8142
APO AE 20793');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('78096241', 'Steven Cross', '1999-11-08', '47492736493', 1, False, 1, 1, 2, 3, 'tochoa@example.com', 'Ready who memory owner institution hundred above.
Until receive center read media out person. Main summer western. Plan old many identify with choose.
Law loss impact knowledge color far if.', 'Collection current kitchen boy company. Begin board reveal together hundred. Somebody return begin sport figure form.','217917027488407704', '41316 Jennifer Row Apt. 689
North Rebeccabury, TX 06032');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('43573271', 'Rhonda Hess', '2000-11-23', '04493428039', 1, True, 2, 2, 5, 1, 'christopher74@example.org', 'Vote hair field interview strategy alone know. Bank edge own science four.
As worry concern out goal measure budget difference. Buy tough leg Congress place six.', 'Leg direction likely. Teacher program itself their home agent. Tv modern medical pull front group. Eye night such grow between beyond for.','967634554086847930', '84003 William Freeway Suite 244
New Robynfort, MO 55695');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('44669640', 'Robert Allen', '1997-02-05', '27180243299', 3, True, 3, 3, 4, 1, 'scott15@example.com', 'Specific practice father last value over. Health central fund democratic.
Hour discover again election.', 'Live west buy him serve floor available.
Minute see summer hospital. Exactly television move thing movie manage production. Various happen you yourself couple effort million.','998107611798937379', '758 Williams Pine
New Elizabeth, AK 27525');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('83179111', 'Laura Johnson', '2019-11-14', '36959277279', 2, True, 10, 10, 3, 4, 'carolynbanks@example.net', 'Cause throw mean authority toward. Machine early term enjoy pass program under wife. Nearly policy week resource consumer.', 'Material design during despite car. Keep southern former listen sure discussion require.
Run just discover author. Happen what citizen against face.','561142836187897156', '5937 Brittany Terrace Apt. 248
Lake Juliaberg, PW 63566');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('78082999', 'Rachael Boyd', '2002-04-12', '24330211305', 1, True, 5, 6, 5, 4, 'nathanwilliams@example.org', 'Green appear exist should environment day name well. Section development sort. Health couple radio you role thank phone.', 'Health final science simple character glass me dinner. Yet manage stand pay.','975342615014188387', '417 Christopher Valleys
Rodriguezville, WY 39156');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('96188344', 'Brandon Nguyen', '1995-06-12', '18975515622', 1, True, 1, 1, 3, 1, 'andersoncindy@example.org', 'Environment bad type without. Key born nor all beat. I itself subject trip.
Cold recent operation safe size work.
Enter billion together happy between. Onto suffer we painting other.', 'Remain home wish Mrs. Reason off white fund fund raise.
Instead light everyone. Front value industry myself we.
Management continue most else. Until she play throw computer public.','695748854166653994', '9071 Clark Common
Lake Julia, LA 14565');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('48692553', 'Joel Mitchell', '2014-10-06', '80218650413', 3, False, 2, 2, 2, 5, 'matthew47@example.net', 'Most yourself against black last culture. Coach really put rich huge report begin.', 'Four until practice agent machine happen. Easy occur increase yard drive assume. Me individual participant ok goal should office.
Too major guess somebody management. Number around game.','290731903624595267', '301 Steven Plains Suite 394
Sarahbury, LA 14173');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('83685957', 'Tyler Combs', '2001-10-20', '15595716794', 1, True, 3, 3, 2, 1, 'maryyoung@example.net', 'Throughout special draw reflect class thousand. Statement majority for red throw hour.', 'National little able. Safe safe between thus hand our always. Poor its find two.
Push source election mean station federal. Answer ability popular travel.','578125135664487563', '62283 Macdonald Inlet
Port Makayla, AS 22833');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('28962303', 'Joshua Rodriguez', '1998-07-07', '71068627993', 3, False, 6, 8, 5, 1, 'ybriggs@example.net', 'Simply science rather industry. Strong successful must although. Guy price society sometimes.
Do consider husband radio white subject. From every wife surface. Key another two I baby star.', 'Board half hard past white. Kind pattern modern. Set reality kid practice foreign west least.','477869477543096109', '71067 Megan Island Suite 357
New Jill, GU 08554');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('30078392', 'Steve Thomas', '2010-05-30', '18038660109', 1, False, 9, 7, 3, 2, 'kerrireynolds@example.net', 'Raise rather where public energy our. Four great memory we history.
Mr report above together others chair stop. Citizen hour civil though defense religious.', 'Respond price there her skill stand similar. True open stuff particular. Reach indicate ago serious but.
Member country it. Born thus make above evening could.','897008450386294923', '5161 Coleman Station Apt. 967
South Jeremyberg, OK 46994');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('42102815', 'Jenna Silva', '2021-09-21', '04504145900', 2, True, 1, 1, 3, 1, 'hyang@example.net', 'Above environmental sing notice save chair.
Off affect newspaper represent share majority. Choose old decade meet too star.
Us drive fine receive. Expect college debate off sure similar.', 'Design size dream may coach ball. Century decide speech forward community bill rate Republican.
Mother structure fact. Low every wife off.','110997563579318525', '242 Ryan Port Suite 855
Michelleland, NH 09766');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('76675399', 'Jordan Flores', '2011-09-10', '14377950193', 3, True, 3, 3, 1, 4, 'yshea@example.net', 'Word claim property agree each truth year. Specific senior important family who sister where.
Available instead mother affect seem option Republican. Nothing later wish apply only.', 'Bank option if apply.
Whatever kind these music nature film. Try either control much least leave. Foot teacher follow try however people.','678419865465262782', 'USNS Smith
FPO AA 08042');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('54765825', 'Michael Johnson', '2019-02-27', '15415471592', 2, True, 2, 2, 1, 5, 'sarahosborne@example.com', 'Family strategy how law idea themselves already. Become need by paper space than his.', 'Wrong order challenge shoulder fight doctor page. Activity me vote author. Rule note rather source. Meet couple detail middle make than.','808350405194653614', '460 Michael Summit
Port Jessica, NE 70902');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('54895103', 'Bailey Logan', '2013-08-25', '64021185418', 1, False, 7, 4, 3, 1, 'sbryant@example.com', 'Sure affect win. Doctor deep many machine.
Decade amount poor others serious administration. Guess use best shoulder officer serve soon. Us candidate protect left week technology beyond myself.', 'Us blood thought save. Interview one unit song still president figure. Camera stay lay.
Old control deal bank live sense throughout. Maintain couple program value.','109305651049129295', '8302 Crystal Bridge Apt. 925
Port Rebecca, DE 15886');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('58091810', 'Joshua Nelson', '2015-04-21', '20376011747', 2, False, 1, 1, 1, 4, 'ccampos@example.com', 'He agent worry school job hair. Sport message room page.
Out east business moment sure born. Often court student almost card Mrs. Eat cost office person probably effort too.', 'His analysis development. Simple break section effect.
Movement force customer debate name certain. Audience easy hold where oil civil worker. Plant technology imagine address professional.','976251013305316290', '447 Cook Pike Apt. 052
Paulview, NV 82345');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('93388873', 'Joshua Johnson', '2000-06-12', '84228553781', 2, False, 5, 6, 5, 4, 'robertreid@example.org', 'Station do wait. Unit practice loss.
Enter let their feeling recently deal business. Meet ability authority become knowledge. Difficult and bed or issue model.', 'Capital what turn wonder wonder now us game. Arm I hope instead. Together myself state serious.
Plan pay each staff. Stop mean join ground at officer easy. Keep consumer add good.','174828309678986087', '37579 Gonzalez Fort Suite 246
North Jessicaberg, HI 65322');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('70301937', 'Steve Baker', '2020-01-05', '45188409978', 3, False, 9, 7, 2, 3, 'thomascarl@example.com', 'Others suffer society per. Environmental community cause cover develop around box until.
His box others range drug. Year for send character century television full.', 'Wonder teach sea instead want pressure meet. Himself including remain media. Those do without box space. Read specific per say.
Behavior under raise far.
Meet song stage worker teach action.','692367092237814676', '43290 Ronnie Rapids Suite 940
North Anthony, MI 15583');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('45693863', 'Kelly Martinez', '2019-02-26', '48828307665', 1, False, 8, 9, 4, 3, 'mariajenkins@example.org', 'Forward table through market discussion tough. Trouble piece her billion.
Food side outside. Recent partner them security book trade. Air carry phone assume three account garden.', 'Training window thus company lay beautiful. Add allow decide account perform teach modern.
Weight worker read first only could.','873225638592743036', '065 Christine Street
Hamiltonburgh, MT 71265');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('90888026', 'Taylor Carlson', '2007-12-20', '08832680623', 2, False, 4, 4, 5, 1, 'cantrellhenry@example.net', 'Among summer them degree future open plant agreement. Cell indicate human order piece town course among.', 'Long production economy commercial morning financial who. Again catch pick let.
Lay public wide without. Recent international chance send several tell decide.','892902519964764156', '8560 Allen Point
Nicoleport, CT 04011');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('43291833', 'Jesse Phillips', '2015-06-03', '82542051860', 3, True, 3, 3, 5, 1, 'sherimitchell@example.net', 'Customer environment wife tend early back there. Defense design poor another mind. Game expect find create become road town.
Responsibility administration police world. Trip sort white well them dog.', 'Lose any theory sort mission image officer. Someone those force share.
Choose take necessary herself over return simple. Since support probably know son raise general.','942787318770748645', '51749 Veronica Ramp
South Kennethland, SC 08258');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('58342837', 'Chris Mclaughlin', '2005-08-30', '36706444647', 2, False, 6, 8, 5, 3, 'qgould@example.com', 'Whom girl employee ball couple. Yeah project small between do even really southern. Listen of he system say.
Doctor then main business. Fish student population deal body since partner.', 'Remember color month top win fish such. Serve part note instead protect day.
Live share his song. Rich foreign father color far child. Six interview although.','261608498534494560', 'Unit 0065 Box 5608
DPO AA 91462');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('54636719', 'Deborah Kent', '2014-09-26', '45652593586', 1, True, 8, 9, 3, 5, 'anthony43@example.org', 'Age assume cup accept doctor. Positive memory speak hot thing.
Break current maintain protect song. Through both miss view address series population.', 'Various politics task cost capital job recent.
Moment range black listen conference economic. Star cell other newspaper himself plan.
Develop no fine American rather fear.','944770151780667041', '8575 Becky Club
Garyfurt, NV 78809');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('36513865', 'Jim Small', '2019-07-24', '75507203608', 2, True, 2, 2, 1, 4, 'ojohnson@example.com', 'Today when peace suffer front might draw. Arm similar address recognize run individual available detail. Certainly prepare all.', 'Realize nature say. Cold name kid space could art. Can act campaign ball tend performance including.','905873394410395942', '833 Gomez Mountains Apt. 070
Port Henryshire, AZ 13372');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('79499938', 'Stephanie Osborn', '2002-01-11', '72588437196', 3, True, 7, 4, 2, 4, 'rothmary@example.org', 'Table citizen enjoy everybody less travel former. Later yeah say eye arm.
Or production share item yet tough first maybe. Member material mind behind.', 'Put whether purpose source. Reach only hard human.
Girl sell option week clear modern. Operation window kitchen hundred.
Central improve some technology. Thank side specific treat.','514072386721072112', '0841 Russell Station
North Charles, LA 19682');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('76402623', 'Tracy Thompson', '2015-12-23', '80194103719', 2, True, 3, 3, 4, 1, 'nbradford@example.net', 'Present order old yourself upon wonder ok. Improve finish pretty.
Low act point exist article. Next suffer rise society capital seek. Dog nor table agent.
Treatment seek drive walk then dog sell.', 'Citizen event practice arm leg doctor. Billion TV out main. Evidence else dark more develop. Fish where new perform doctor.','849372432432722667', 'PSC 0291, Box 0216
APO AE 57048');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('40359285', 'Christopher Sullivan', '2011-04-20', '08352834449', 1, True, 6, 8, 3, 2, 'michaelward@example.org', 'Seem your interesting improve beat open. Ago among run our shoulder. Military grow join recent within world turn.
American property need ground according. Scientist large out through country.', 'Data fish subject peace. Similar want source history.
Great provide during eye. And energy should citizen play section.','926696264595480113', '3326 Travis View
North Dannyshire, IL 13201');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('91621394', 'Joel Jennings', '2008-03-11', '06308372603', 3, True, 1, 1, 2, 4, 'marie21@example.org', 'Anyone year money identify. Once world national thank fear second put.
House guess decide stage others. What responsibility college many step. Claim learn law.', 'Source travel right what office energy feel. Work power cultural time possible option law.
Economic near past late structure. Necessary lawyer side bed spend more identify.','427604769934884199', '066 Logan Road Suite 351
Andersonmouth, TN 23224');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('28176761', 'Kristin Thompson', '2020-10-15', '77390501368', 1, False, 10, 10, 4, 3, 'kevinthomas@example.net', 'Wonder about someone capital until personal ok. Campaign agreement cup manage understand whole. Job whom strong thousand statement exist blue rule.
Address leader wind discuss.', 'Participant consumer successful ask hair some easy collection. Else under build series. Return level before age box.
Claim thousand floor purpose. Happen majority kind himself house help hour.','046738437849491594', '9536 Sara Meadows Apt. 080
Jenningsbury, MO 76961');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('32371509', 'Christopher Flores', '2005-09-16', '04006741762', 3, True, 4, 4, 5, 3, 'jason28@example.net', 'Form senior something and.', 'Information type director painting. Join suddenly success should quite player not smile.','227791988932248611', '62127 Moran Mill
South Colin, OR 96361');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('67366818', 'Aimee James', '2022-10-06', '53057219383', 1, True, 4, 4, 5, 5, 'russodakota@example.net', 'Myself debate few behind so lot.
Main long our tree or family strong. Morning century glass career man shoulder. Design large he simply exactly accept.', 'Mr view bed all rule.
Cut radio despite front identify drive. Information couple beat difference.
Maintain strong off two. Image feeling same apply set.','195142233792085055', 'USNV Parks
FPO AA 17105');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('98959653', 'Lisa Wilson', '2011-07-10', '20800048883', 3, True, 10, 10, 4, 1, 'patrickphillips@example.com', 'Nice fund human. Response challenge event morning whether result.
Nearly lose alone sound professor position six. Meeting expect democratic trouble alone dark.', 'Nothing mission hotel look prove hand lead yourself. Final meeting alone middle tree character push.
Chair bed weight watch agency. Task make three whether reveal these.','786786578351662440', '569 Caleb Rest
South Matthew, VI 33845');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('38668018', 'Samantha Brown', '2023-01-17', '40475052585', 1, True, 3, 3, 1, 1, 'andersonlauren@example.com', 'Operation weight program company see choose.
Official administration fact usually director issue.', 'College scientist be doctor region civil. Enter plant despite hour accept.
Many how often deal. Ok yourself rather head certainly TV. These sometimes street their shake tell expert.','778722522058000104', '257 Miller Green Apt. 290
Williamsmouth, NC 28839');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('33767010', 'Amy Mcdonald', '2012-01-14', '50778266152', 2, False, 1, 1, 2, 4, 'reedbarbara@example.com', 'Understand other thing represent billion one. Together method test try fill recently production.', 'Accept card analysis health.
Suffer oil film during group hit north president. Suffer article debate real.
Mouth conference already leave officer. Do value approach tell decade avoid policy politics.','280345045487402584', '15095 Aaron Dale
South Carolineport, PW 65267');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('90336736', 'Lisa Parker', '2002-03-28', '13569625469', 3, True, 1, 1, 4, 5, 'elliottcourtney@example.com', 'Other against approach improve too action. General statement join head listen forget. Choose yourself actually employee nation people.', 'Lose memory hundred dark. Standard they art drop important. Discuss mean what clearly cultural. Shake consider expert card.','429262937757592086', '43181 Petersen Knoll
West Sandramouth, PW 02194');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('13826834', 'Danielle Williams', '2005-11-28', '14467194823', 3, False, 10, 10, 1, 5, 'everetttracy@example.org', 'Area mouth after behind above phone evening. Player cell last offer democratic trade.
Space language guy serious she it specific. Six guess memory base. How see establish these student sport.', 'Which shake must grow relate future turn. Prevent read oil summer ago prepare then.
Black eye dark Democrat account. Who mean dog evening.','717928447177778968', '21164 Calhoun Corner Apt. 065
East Josephchester, PW 60115');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('95170978', 'Angela Morrow', '2012-06-07', '55177960372', 3, True, 2, 2, 1, 1, 'harrisbrittany@example.com', 'Never say wide outside across according machine. Them rich movie attention sea.
Product notice general where tend weight. Music statement but set lose.', 'Fill perhaps great. Thank way investment either true relationship how responsibility.','575310938901021725', '04011 Kaitlyn Hill
Brianview, IA 75426');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('97002684', 'Stephanie Harvey', '2024-04-08', '26192602421', 1, False, 1, 1, 2, 5, 'cory85@example.com', 'Threat growth seem human house. Low or administration as set environmental particularly. Party attorney near west note.
Last base after prepare. Single more war possible per see share.', 'Recent bed other nation reveal hand deal. Over their hot any think skin. Federal dog ever worker.
Defense seven provide degree like. He leg answer.','230900089364980026', '137 Vasquez Freeway
Wardfort, HI 07904');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('90139436', 'Peter Escobar', '2013-05-19', '38401054037', 3, True, 8, 9, 3, 2, 'browland@example.org', 'Member hot shoulder. Law nation item activity popular everything. Sit memory boy company number television but.', 'Participant administration bed account occur anything. Food surface beyond successful. So short gas least board produce.
Of represent interest arm public. Attack eight ok situation most.','210429650907963909', '1462 Lisa Estate Suite 114
West Kathleenton, KS 44328');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('38533924', 'Zoe Evans', '2013-10-19', '05385376777', 1, False, 5, 6, 1, 2, 'shannonshaw@example.com', 'Buy unit bill tend operation on for art. Structure policy once two themselves.
Instead full hear wife. Medical adult of cost these may commercial detail. World any compare possible level often he.', 'Word herself well dog. Goal approach miss scientist later.
Step case part condition mention data young sure. Middle everybody project lawyer. Certain career control sit sport foot.','095952726596802560', '77419 Richmond Way
Staceyberg, AS 29726');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('36371572', 'Mark Thomas', '2016-11-16', '36143901618', 1, False, 1, 1, 1, 5, 'isaiah60@example.net', 'Size or mean learn test audience same. See town light crime style political ago. Several view usually attention young.
Eye artist pattern onto. Game month very third guy claim provide.', 'Window idea news more certainly audience. Price certainly street set toward. Decide admit court turn five girl around.','888576445225522217', '9763 Wendy Manor
Bennettburgh, PR 05575');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('40070350', 'Melissa Torres', '2001-08-11', '96378908659', 2, False, 4, 4, 3, 3, 'ffrost@example.net', 'Trade common mind. Participant understand term against medical.
Attack personal economy end. Sit ahead poor himself. All relationship never career form enjoy reach.', 'Ever effort especially character pressure brother. Authority population full old knowledge shoulder.','884407902727866294', '988 Garrison Greens
Tracyfurt, WY 22719');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('62026765', 'Stephanie Carter', '2020-04-03', '90114298082', 3, True, 6, 8, 4, 4, 'xlane@example.org', 'Across as data dinner recognize recognize. Will black soldier audience shake find. Get feeling capital need.', 'Eat rock performance factor sign cold rate. Instead subject pretty middle interview road rule.','076388396444063244', '41930 Paul Oval
South William, SC 29194');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('47153493', 'Carmen Smith', '2020-10-29', '21598885514', 1, False, 6, 8, 4, 1, 'nixondarren@example.org', 'Town catch floor force type lose. Than ask understand pay usually free different analysis.
Son pay hear mother bank. Military card base instead suffer. Attack down produce tend management.', 'Full hot hold situation member effect. Record man country and company. Check plan past amount win entire remain. Color concern under perhaps easy teach explain.','798910323497588408', '9367 Donald Lane
Rogersside, KY 43651');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('45464064', 'Michelle Johnson', '2022-01-09', '12094753027', 3, True, 6, 8, 1, 5, 'martinsamuel@example.org', 'Always marriage size Mr. Voice clear court break we particular. Campaign program number college. Election up so kid western mother.', 'For onto buy off magazine goal.
Professor itself six physical. Wall your majority. Congress player worker specific. Recognize court management try strategy its five.','294101594428240066', '026 Brenda Mill
Patelmouth, WI 47868');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('65420493', 'Patrick Weiss', '2011-11-25', '91565255824', 2, True, 1, 1, 4, 2, 'floreseugene@example.net', 'Year hit beat join land north. Animal blood thus themselves organization scene. Interview benefit heavy girl add respond guy.', 'Mouth yard production hundred opportunity answer. Develop responsibility establish reality sound most. Music yes listen study job.
Box quite computer most unit. Truth Congress white act physical.','783620669420268336', '703 Lacey Roads Apt. 300
Davisport, OH 07278');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('69570761', 'Kristi Morrison', '2010-03-11', '70270014243', 3, True, 4, 4, 5, 5, 'kathleen35@example.org', 'Message position audience some. History admit compare statement.
Say free summer same from occur. Music green car hotel region various business blue.', 'Quality family accept. Mission choice owner trip author throw.
Event reason season parent value.
Also PM hope occur. Even indeed nothing certainly inside. Special board effort region mission store.','100632225432809693', '0373 Ross Ferry
Juanfurt, ME 85488');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('39449873', 'Vincent Austin', '2022-05-15', '26891123456', 3, True, 7, 4, 5, 2, 'patriciagreer@example.net', 'National special if power measure model. Hard morning summer certain. Event debate former arm home training.', 'Vote foreign newspaper reason even fast. Fish blue police evidence consider. Describe option can method view card away.
Fight street agent score special. School physical beat. Strong land form say.','327492628693138341', '62111 Shelby Loop Suite 774
Juliaberg, MD 15134');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('36719986', 'Jacqueline Andrews', '1996-09-08', '85968033672', 3, False, 4, 4, 5, 4, 'cody33@example.net', 'System wall our finally defense imagine. Than happen up.
Account word crime woman such. Traditional they media small history wrong grow.', 'Look clearly fight case produce four. Quickly economy individual. West long per drug. Use suggest consider vote between.
Direction media these culture us.','553442478926884081', '09089 Monica Inlet
Tranmouth, IL 33136');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('55926996', 'Peter Owen', '2013-06-16', '78820645215', 2, True, 8, 9, 2, 4, 'charris@example.net', 'Store ten drive above one.
Walk serious strategy save the. Have change machine of. Road scientist show base.
Live voice report difference standard. Produce especially half entire than.', 'Morning public then executive. Although consumer tough short. Check employee wear group. Democrat age drug.','784106149035583167', '300 Hayes Dale
Donaldsonhaven, DE 41239');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('90796303', 'Gary Walker', '2022-02-08', '50168657171', 1, False, 8, 9, 5, 5, 'shannonreeves@example.net', 'Able activity buy customer build quite back his. Only short real fall. With despite new PM about program bag.
Attention head improve from push it. Beautiful college I oil.', 'Recent since plant book mean. Course maybe parent. Home level it food seek clear full.','714356514714556189', 'Unit 4862 Box 9446
DPO AA 36259');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('45098162', 'Allison Brown', '2009-11-18', '29805414046', 3, True, 9, 7, 1, 2, 'romerobrian@example.com', 'Pattern single decide part music performance. Customer white black difficult special everyone most.', 'Ability model medical across per it rule.
Democrat age police. Pretty eye land face. President property always life price throw oil reveal.','933394458399178624', '62081 Stacy Highway
New William, CT 06781');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('35393927', 'Taylor Steele', '2001-04-13', '95903196531', 1, True, 10, 10, 3, 5, 'milleramanda@example.com', 'Wrong director star among democratic. Become summer score health write water. Ok performance line responsibility current significant.', 'Thus interest expect. Science court whether medical only himself. Interview without space every a.
Gas collection card industry some challenge.','006173817411432720', '294 Debra Village Apt. 211
East Emily, KY 52665');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('83717386', 'Susan Evans', '2002-09-14', '59940611676', 2, True, 7, 4, 4, 2, 'jessicafranco@example.net', 'Ground term administration protect a still. Rate treatment these factor military on.
Meeting laugh other music sing on much. Possible purpose huge hour.', 'Memory way not knowledge finally month. Also family medical assume position. Them without its meet.
Every building movement.','569707468066106909', '87881 Russell Shores Suite 211
Emilymouth, PA 21473');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('50747886', 'Kimberly Edwards', '2023-01-25', '91671809724', 2, True, 1, 1, 4, 5, 'emilyquinn@example.com', 'Development very remember test just day difference risk. Seek once specific himself fact inside reflect.
Allow tonight because. Soldier outside adult section. Behind treat whether tough trouble.', 'Anyone science successful. Behind anyone fine seek goal tree computer. From individual military color already would myself.','143057979120767501', 'Unit 3527 Box 3393
DPO AA 47018');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('41756530', 'Joseph White', '2000-03-11', '72571712650', 2, False, 1, 1, 1, 5, 'nelsonkevin@example.net', 'Instead single huge member show. Public move radio.
Method thought better industry bed between similar. Institution believe spring performance win so. Administration dark budget their relationship.', 'Style true democratic low public another. Hair watch half chance under wear be. System manager get down southern.','848094147307141949', '522 Wilson Neck Suite 162
Hopkinsview, VA 81063');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('39219344', 'Cheryl Navarro', '2005-10-16', '12643332017', 3, True, 2, 2, 5, 2, 'bruceyu@example.net', 'Appear tell free behavior. Dog else would red sell. Minute you security this project discover.
Attention Mr kind these return. Size international cause expect American.', 'Practice never pass agreement something final per. Too such story far player old. Apply whom feeling sort inside.
Fill buy meet a peace born that. Lay fast city wide ground clear.','618035547513422053', '8994 Tracy Locks Suite 654
Karinabury, MI 29133');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('13949865', 'Christina Cook', '2002-11-15', '14602024487', 2, False, 4, 4, 4, 4, 'toni98@example.net', 'Need fact white entire picture. Dream prevent top total.
Sit partner these interest. Relate last run room east.
Ask source wife television last nature. Outside audience hotel security.', 'Determine bank pull off huge. Thing skin process matter sister. Ever painting discussion international.
Line very leader nothing. Future likely stock rock hot north.','438110148881428099', '3053 Jennifer Spring Suite 912
Michaelfort, KY 03438');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('47894967', 'Elizabeth Barrett', '2009-10-18', '80170291744', 3, True, 4, 4, 4, 2, 'kelly08@example.com', 'Defense authority kitchen. Physical product quality property. Best not girl vote thank wide center.
Risk fall spend defense difference. Particular choice measure yet.', 'Hope book realize body. Exactly politics identify treat throughout leave.','962464890654136012', '6443 Shawn Lights Suite 755
New Cynthia, IL 16259');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('64632144', 'Eric Hutchinson', '2020-08-18', '11025710133', 1, False, 1, 1, 4, 5, 'jimwolf@example.com', 'Budget as forward guess hospital test open. Treatment peace it fill evening consider seven.', 'Along enter sure brother. Capital throughout when.
World spend back management no our wall. Religious government space goal anything significant country provide. Let energy cold study candidate.','847231999696392470', '0046 Marks Landing
Mcneilfurt, KS 02358');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('94345957', 'Ashley Willis', '2001-05-20', '81983860072', 1, True, 7, 4, 5, 5, 'duffyregina@example.net', 'Adult son must education too. Almost over body his some.
Institution fall organization service. Born dinner old no season teach. Fear human past second.', 'Establish maybe its there. Contain sea central stuff how.
Recently chance building under nice force. Benefit bring project little late away girl model.','252024446582918595', '021 Cantu Plain
Davidland, VT 53937');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('55522020', 'Amanda Phillips', '2019-10-30', '42507867203', 3, False, 10, 10, 3, 3, 'jacksonchristopher@example.net', 'You reason kind population rather. Both situation work be ahead. Lose company table mission late church.', 'Customer contain central guess cold. Inside involve tree measure individual citizen.
Start long leader else. Become tonight image list. Must determine their establish yes.','007089414805730848', 'PSC 6099, Box 5111
APO AE 68597');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('36596466', 'Christopher Lewis', '2008-10-10', '33986091210', 3, True, 1, 1, 5, 5, 'drice@example.com', 'Argue finally also former. Likely most fish. Sort near site agree field never.', 'Sit operation road game total dinner southern. Step off strong serve.
Discover meet until from dog consumer. Direction public his key two. Summer stop charge suggest.','773791602324979032', '1251 Amanda Isle
Dixonland, CO 06726');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('49828168', 'Tonya Romero', '2003-06-27', '89156797486', 1, False, 6, 8, 4, 1, 'rmcintyre@example.com', 'Policy interesting budget different. Street book security television. Result throw seek most.
Step staff through check.', 'Hard family interesting space yes better. Like staff quickly whom quality career. Enough wrong hospital full talk with industry.','554679400752850149', '196 Madden Estate Apt. 785
New Jamesfort, MD 36871');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('66694154', 'Steven Myers', '1995-04-23', '93740550913', 1, False, 9, 7, 3, 1, 'amber32@example.org', 'Product reality recent spring. Parent trial sound candidate sense billion option interesting.', 'Sort degree arm across speak western form run. Degree small response assume television early peace.
Since movie indeed only scene. Experience draw body. Another often media.','646999076101669321', '34728 Jessica Bypass
North Seanmouth, PR 29199');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('78253859', 'Maurice Sims IV', '2023-12-04', '48403786600', 3, False, 9, 7, 3, 5, 'josephsmith@example.org', 'Company visit old go store effect. Too less finish off. Instead do off.
Million bag bed myself method instead buy.
Next by like seven vote. Yet great for small challenge evidence parent.', 'Movement value stage reduce place deal. Question pay lead per. Manager it right. Rate back no leg section.
Book four its use we detail.','403869427808638689', '657 Angela Hill Suite 297
Michealview, AZ 02962');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('92550138', 'Tyler Lynch', '2007-10-14', '06761185086', 3, False, 6, 8, 4, 3, 'elizabeth29@example.org', 'Wind poor face fill design member. Local type eight them senior fish. Which likely degree how cell election.', 'Door sport article movement help. Level well worker.
Pretty knowledge player really night stop. Place before although together strong. Everyone carry PM south.','666195139816984970', '93114 Monica Mill
North Brandon, VA 61661');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('47219864', 'Nicole Johnston', '2023-01-13', '17797772363', 3, True, 3, 3, 5, 4, 'mark43@example.net', 'City partner save picture culture recognize follow. Several fast society.
Class coach special employee how. Just likely audience religious. Seat human main offer during thing charge simple.', 'Figure our Congress star music.
Claim watch front author. Music kitchen fine system daughter form policy.
Maintain type special serve. Mr believe certainly war base unit purpose man.','660903640986196765', '39095 Johnson Estates
East Mark, AZ 60663');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('53782566', 'Helen Martinez', '2012-10-12', '74267217385', 2, False, 1, 1, 1, 5, 'robertperez@example.net', 'Until turn surface little. Wish paper share produce around record.
Mouth author between doctor east new herself want. Anything thank seem actually cause lose. Home threat worry leader I.', 'Artist large look type.
Against different property cold wear remain. Hour industry go maybe. Southern station moment lawyer great.','835096649856713271', '32521 Flynn Plains Apt. 850
North Jose, FM 87415');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('34672990', 'Matthew Lindsey', '2012-09-20', '61625471275', 3, False, 2, 2, 1, 2, 'edwardsrobin@example.net', 'What city trial yard view step. Production Republican total outside government spring.', 'Expert man part continue off grow apply answer. Surface through heavy.
Result prepare author candidate project. Include work or new.
They number baby official rich.','785329230727007939', '541 Kevin Bypass
East Briana, PW 53722');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('30225932', 'Shelly Brown', '2008-08-31', '56320948529', 3, True, 2, 2, 4, 1, 'anthony60@example.net', 'Recognize little nothing town. Capital which agreement region we his. Skin long space very sense off expert good.
Seem explain agree stay perhaps. Report but hundred language message away human.', 'Style too tonight need degree guy thought. Nation fall difference artist. Range until water different.','089991397592875182', '3474 Kenneth Shoal Suite 254
Port Steven, WI 17130');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('86125129', 'Renee Flores', '2002-04-27', '82254561035', 3, False, 7, 4, 2, 2, 'jacksoncarol@example.org', 'Others simple marriage perform information hear question. Response boy room measure site option. Paper would school news. Matter southern pattern able wall finally Democrat on.', 'Sure public a her age attention. Exactly senior yeah dream Republican owner. Commercial interesting including debate could behavior evening.
Fast material give your magazine.
Control place only it.','117427791579956297', '4815 Dixon Mountains Suite 682
Lisatown, ID 73259');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('65409605', 'Lisa Henson', '2000-12-29', '67979456726', 1, False, 5, 6, 2, 1, 'ismith@example.com', 'Indeed really building heavy provide fly. Walk here who nothing wait travel difference space.', 'Child data study response keep day. Side mind teacher common director. State fast something thousand truth arrive fire.
Leg us war writer challenge performance. Better poor few almost our.','995822393915696096', '577 Vanessa Row Apt. 889
East Antonio, NH 15699');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('28257607', 'Michael Smith', '2017-04-21', '37158326325', 3, True, 10, 10, 3, 1, 'camachoallison@example.com', 'Outside grow walk herself challenge. Safe happy team interesting edge unit third. Reflect activity break expect force.', 'Put voice reveal always field really second. Despite probably soldier into whether ready.','834886882579295486', '9013 Susan Flat
North Pamelaborough, MO 36172');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('63633503', 'Ashley Dennis', '2009-11-13', '18893565592', 1, True, 8, 9, 4, 4, 'vanessajohnson@example.org', 'Environmental similar itself order start.
Sometimes idea answer continue interesting Mr involve. Memory over leg contain skin foreign pretty.', 'Teach enough model evidence represent. Member course owner effort they list life. Beautiful world capital rate phone role might.','735649609978361275', '6657 Vanessa Valley Suite 480
Cesarport, NC 66877');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('96187326', 'Megan Dunlap', '2006-08-13', '13440420706', 2, True, 1, 1, 3, 2, 'gregory24@example.com', 'Music after politics question. Movie show back technology vote down reveal. Newspaper hot operation reality believe.', 'Sister the sometimes assume keep pull. Number window provide wear similar music lead sure.','408496999735778595', 'USNS Hernandez
FPO AA 07156');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('56474618', 'James Nunez', '2003-12-25', '02534723191', 1, False, 5, 6, 2, 2, 'madison14@example.net', 'Include yourself along you project white. There window surface agreement outside face.
To subject worry individual seat expert. Whom happen TV.', 'Serious walk these. Image ability near interview word culture yard. Already free try write.
Just this career those ago trouble result. Fill everyone tell market.','511044251466296657', '7705 Shannon Shores
New Heathermouth, AR 48464');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('41389625', 'Kathy Spencer', '1998-03-17', '47471671432', 3, False, 5, 6, 4, 1, 'ychambers@example.org', 'Option indeed wait more impact. Trade town subject organization employee item possible. Give add tend physical beautiful service factor either. House whom kind interview.', 'Partner smile century body find later mean. Real word which research ball. Foreign hospital power sit term sense.','929301043033458328', '66453 Cassie Crossroad Apt. 966
West David, DC 47524');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('42031134', 'Cynthia Foley', '2019-01-22', '65364225174', 2, True, 1, 1, 3, 2, 'patriciabush@example.org', 'Trial position value training more green. Pass piece as majority. Strong within determine outside floor.
Authority actually understand ability born. Pattern current she into. Forget minute run both.', 'Rate raise support center. Myself number bit least language.
Structure door sister quickly before although these. Lawyer maybe open investment group represent expect.','932013804665781209', '0674 Rachel Station Apt. 797
North Kathleentown, NE 94239');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('17840591', 'Shannon Fox', '2002-04-30', '36723160937', 1, True, 10, 10, 1, 5, 'reneesanchez@example.com', 'Wait local name investment. Into feel feeling. Discussion among fight through give necessary.', 'Push specific lot accept available traditional home. Start land carry may class behavior whether.
Indeed thus series attorney cell agency sport population. Those commercial buy make with case.','631179414233263575', '84124 Tracy Rest
Teresaberg, NH 59385');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('43629271', 'Lisa Russo', '2020-12-17', '74301285996', 1, True, 5, 6, 2, 2, 'kim08@example.org', 'Test before cold manager Democrat safe. Game suddenly book network serve themselves.
Another agent without above. Answer then huge sure minute check short.', 'Company any some former phone across. War assume current together main through north.','874626191979606365', '673 Finley Green
Port Robert, LA 63592');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('99454778', 'Larry Murphy', '2001-11-30', '13853278050', 1, True, 2, 2, 2, 4, 'maciasmichael@example.org', 'Radio activity that use though all whatever matter. Phone stuff understand body suggest field term country.
Herself red campaign quite open west up. Whole morning accept however mean down bit.', 'Every although fly action into. Field thousand need almost nation.
So media serious. Seem painting behind form energy begin. Simple anything son government expert.
Try employee beat base state late.','049309207047607794', '266 David Road
New Johnmouth, WY 79566');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('83693806', 'Isaiah Thompson', '2002-06-02', '78933205578', 1, False, 5, 6, 2, 4, 'harveyjamie@example.org', 'Thus thousand business have business live. Push order true possible decade will.
Including government two method herself take. Human hit official.', 'Draw hope deal begin. Whose box should suddenly even painting draw. Himself grow music media professor.
Opportunity first for air hit drive service. Charge enough summer agree offer even find.','232312063073793121', '6840 Gates Extension Apt. 950
Carolynview, TN 00582');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('84367282', 'David Hawkins', '2019-08-11', '19465351252', 2, True, 1, 1, 5, 5, 'castilloalyssa@example.net', 'History around quality. Those head inside accept. Surface house approach the approach.
Task kind mother nation letter argue once. Education real TV attorney direction face.', 'Shoulder quickly tend leave. Green huge my state student more. Idea stay half anything. Election character including time.','502723697683674344', 'Unit 3357 Box 2136
DPO AP 46801');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('40213855', 'Amy Patrick', '2011-11-29', '30736943358', 1, False, 4, 4, 4, 5, 'patrickgray@example.org', 'Dog anything speak somebody bill. Machine mean fear where effect. Success mention hit no couple.
Physical left floor. Idea available seat clearly.', 'War will drive.
Point town participant born receive. All morning management. Others significant great adult.','357762244658002189', '17365 Harvey Harbor Apt. 394
Harmonstad, NY 12695');
INSERT INTO teacher (id, name, hire_date, phone, type, gender, major_id, school_id, title, bachelor, email, `desc`, research_focus,identity, address) VALUES ('25900155', 'Daniel White', '2009-03-07', '24151070584', 2, False, 4, 4, 5, 4, 'cmcclain@example.com', 'Wear despite teacher none western institution. Easy nor million current avoid door. Around mission probably more name rule body. End need yes especially evening garden own agreement.', 'Change along imagine learn. Seat event standard. Wall skin relate suffer.
Poor feel strong board short. Debate sense particular firm factor.','720940984888265236', '052 Williams Parks Suite 283
Jenniferton, NC 62862');

INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (12, 7, 8, 6, 3, 55, 2020, 0, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (16, 7, 8, 36, 7, 9, 2024, 0, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (10, 3, 4, 8, 2, 17, 2021, 0, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (18, 7, 8, 30, 2, 24, 2023, 0, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (2, 3, 4, 26, 2, 43, 2023, 0, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (17, 5, 6, 19, 2, 6, 2022, 1, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (12, 3, 4, 17, 5, 28, 2022, 1, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (2, 9, 10, 5, 2, 27, 2020, 1, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (14, 3, 4, 18, 6, 2, 2022, 0, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (16, 5, 6, 3, 7, 7, 2020, 1, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (15, 7, 8, 26, 4, 55, 2023, 0, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (9, 7, 8, 23, 4, 50, 2022, 1, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (17, 3, 4, 31, 3, 25, 2023, 1, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (10, 5, 6, 9, 7, 41, 2021, 1, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (17, 7, 8, 34, 7, 29, 2024, 0, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (4, 1, 2, 27, 7, 11, 2023, 1, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (8, 9, 10, 27, 7, 18, 2023, 1, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (12, 9, 10, 30, 5, 25, 2023, 0, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (5, 3, 4, 7, 2, 29, 2020, 1, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (4, 1, 2, 38, 7, 40, 2024, 0, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (13, 9, 10, 40, 2, 45, 2024, 0, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (9, 7, 8, 5, 3, 17, 2020, 1, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (7, 9, 10, 3, 6, 55, 2020, 1, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (6, 5, 6, 20, 1, 32, 2022, 0, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (12, 9, 10, 4, 1, 45, 2020, 0, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (6, 3, 4, 15, 4, 43, 2022, 1, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (4, 1, 2, 5, 4, 45, 2020, 1, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (1, 1, 2, 37, 1, 46, 2024, 1, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (14, 1, 2, 22, 3, 7, 2022, 0, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (9, 5, 6, 19, 3, 10, 2022, 1, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (7, 7, 8, 21, 3, 48, 2022, 1, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (5, 1, 2, 23, 1, 24, 2022, 1, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (15, 1, 2, 29, 6, 20, 2023, 1, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (2, 9, 10, 16, 7, 44, 2022, 0, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (9, 3, 4, 19, 7, 24, 2022, 1, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (16, 5, 6, 4, 5, 51, 2020, 0, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (1, 9, 10, 13, 5, 44, 2021, 1, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (5, 5, 6, 30, 4, 3, 2023, 0, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (12, 3, 4, 12, 4, 57, 2021, 0, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (18, 7, 8, 9, 4, 17, 2021, 1, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (13, 7, 8, 38, 3, 49, 2024, 0, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (6, 1, 2, 20, 6, 2, 2022, 0, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (6, 1, 2, 34, 5, 35, 2024, 0, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (11, 1, 2, 14, 6, 1, 2022, 0, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (14, 7, 8, 36, 1, 10, 2024, 0, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (4, 1, 2, 16, 7, 1, 2022, 0, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (11, 9, 10, 16, 4, 14, 2022, 0, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (11, 3, 4, 1, 2, 32, 2020, 1, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (3, 9, 10, 37, 5, 2, 2024, 1, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (13, 9, 10, 39, 3, 6, 2024, 1, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (15, 5, 6, 8, 5, 53, 2021, 0, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (8, 1, 2, 4, 4, 29, 2020, 0, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (1, 7, 8, 23, 1, 20, 2022, 1, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (5, 5, 6, 32, 6, 29, 2023, 0, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (8, 9, 10, 35, 1, 51, 2024, 1, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (14, 7, 8, 40, 4, 8, 2024, 0, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (4, 3, 4, 10, 5, 2, 2021, 0, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (6, 1, 2, 26, 5, 30, 2023, 0, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (3, 5, 6, 26, 1, 48, 2023, 0, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (12, 5, 6, 2, 1, 40, 2020, 0, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (16, 1, 2, 37, 2, 35, 2024, 1, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (10, 9, 10, 20, 1, 53, 2022, 0, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (8, 5, 6, 3, 2, 1, 2020, 1, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (14, 9, 10, 28, 7, 41, 2023, 0, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (16, 5, 6, 2, 4, 27, 2020, 0, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (15, 3, 4, 16, 1, 9, 2022, 0, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (16, 9, 10, 23, 5, 54, 2022, 1, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (5, 3, 4, 36, 3, 10, 2024, 0, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (18, 1, 2, 15, 5, 19, 2022, 1, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (9, 5, 6, 32, 2, 18, 2023, 0, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (8, 5, 6, 22, 3, 45, 2022, 0, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (7, 3, 4, 3, 1, 15, 2020, 1, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (2, 3, 4, 9, 5, 34, 2021, 1, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (7, 5, 6, 8, 4, 21, 2021, 0, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (16, 1, 2, 20, 3, 3, 2022, 0, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (10, 1, 2, 28, 4, 15, 2023, 0, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (8, 1, 2, 35, 6, 48, 2024, 1, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (6, 3, 4, 4, 5, 7, 2020, 0, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (13, 5, 6, 18, 2, 1, 2022, 0, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (8, 7, 8, 18, 3, 21, 2022, 0, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (11, 7, 8, 7, 6, 30, 2020, 1, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (5, 3, 4, 10, 4, 20, 2021, 0, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (12, 5, 6, 23, 1, 25, 2022, 1, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (18, 1, 2, 36, 1, 4, 2024, 0, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (13, 9, 10, 31, 1, 2, 2023, 1, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (14, 5, 6, 7, 1, 46, 2020, 1, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (13, 5, 6, 14, 1, 51, 2022, 0, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (3, 5, 6, 17, 6, 53, 2022, 1, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (11, 7, 8, 39, 6, 15, 2024, 1, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (14, 3, 4, 33, 2, 28, 2024, 1, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (9, 5, 6, 3, 6, 24, 2020, 1, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (12, 1, 2, 31, 5, 28, 2023, 1, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (9, 7, 8, 33, 6, 38, 2024, 1, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (11, 9, 10, 3, 1, 18, 2020, 1, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (18, 5, 6, 30, 1, 48, 2023, 0, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (15, 1, 2, 27, 6, 38, 2023, 1, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (11, 1, 2, 5, 6, 16, 2020, 1, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (15, 9, 10, 20, 3, 2, 2022, 0, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (12, 1, 2, 37, 5, 26, 2024, 1, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (2, 5, 6, 39, 5, 19, 2024, 1, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (5, 1, 2, 13, 6, 32, 2021, 1, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (15, 1, 2, 1, 1, 7, 2020, 1, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (16, 9, 10, 30, 5, 2, 2023, 0, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (10, 9, 10, 2, 3, 50, 2020, 0, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (6, 7, 8, 13, 3, 55, 2021, 1, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (16, 5, 6, 33, 1, 34, 2024, 1, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (12, 5, 6, 14, 3, 22, 2022, 0, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (14, 7, 8, 2, 2, 28, 2020, 0, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (6, 1, 2, 20, 3, 23, 2022, 0, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (1, 9, 10, 12, 5, 57, 2021, 0, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (10, 9, 10, 29, 1, 40, 2023, 1, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (13, 9, 10, 35, 4, 38, 2024, 1, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (2, 9, 10, 27, 6, 11, 2023, 1, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (12, 9, 10, 12, 6, 48, 2021, 0, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (9, 9, 10, 25, 4, 42, 2023, 1, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (13, 7, 8, 24, 2, 1, 2022, 0, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (16, 5, 6, 28, 2, 21, 2023, 0, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (15, 5, 6, 39, 2, 21, 2024, 1, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (6, 5, 6, 4, 5, 54, 2020, 0, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (8, 1, 2, 36, 6, 49, 2024, 0, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (14, 7, 8, 27, 4, 15, 2023, 1, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (15, 7, 8, 30, 1, 13, 2023, 0, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (8, 3, 4, 16, 4, 16, 2022, 0, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (18, 3, 4, 11, 7, 20, 2021, 1, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (7, 7, 8, 22, 5, 18, 2022, 0, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (10, 5, 6, 27, 5, 54, 2023, 1, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (13, 1, 2, 31, 5, 8, 2023, 1, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (15, 7, 8, 3, 3, 53, 2020, 1, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (5, 5, 6, 4, 6, 39, 2020, 0, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (2, 9, 10, 13, 2, 51, 2021, 1, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (7, 5, 6, 27, 2, 23, 2023, 1, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (16, 9, 10, 7, 7, 56, 2020, 1, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (2, 5, 6, 39, 7, 19, 2024, 1, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (15, 9, 10, 39, 2, 47, 2024, 1, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (4, 1, 2, 19, 2, 52, 2022, 1, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (18, 9, 10, 19, 2, 25, 2022, 1, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (5, 5, 6, 24, 5, 13, 2022, 0, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (3, 1, 2, 34, 5, 52, 2024, 0, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (5, 3, 4, 40, 4, 55, 2024, 0, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (14, 7, 8, 40, 3, 51, 2024, 0, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (3, 9, 10, 12, 6, 21, 2021, 0, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (3, 3, 4, 25, 4, 33, 2023, 1, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (14, 1, 2, 33, 1, 17, 2024, 1, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (2, 5, 6, 37, 1, 13, 2024, 1, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (11, 9, 10, 18, 7, 49, 2022, 0, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (17, 5, 6, 1, 4, 14, 2020, 1, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (12, 7, 8, 31, 1, 19, 2023, 1, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (6, 3, 4, 10, 3, 53, 2021, 0, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (15, 1, 2, 20, 7, 29, 2022, 0, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (16, 7, 8, 31, 4, 56, 2023, 1, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (1, 1, 2, 29, 4, 7, 2023, 1, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (2, 5, 6, 9, 6, 23, 2021, 1, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (9, 1, 2, 13, 5, 18, 2021, 1, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (13, 1, 2, 13, 6, 16, 2021, 1, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (5, 7, 8, 35, 6, 28, 2024, 1, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (18, 1, 2, 34, 7, 9, 2024, 0, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (10, 9, 10, 13, 7, 18, 2021, 1, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (5, 1, 2, 15, 4, 33, 2022, 1, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (9, 7, 8, 13, 1, 24, 2021, 1, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (10, 5, 6, 4, 1, 35, 2020, 0, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (11, 9, 10, 17, 7, 22, 2022, 1, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (1, 3, 4, 24, 6, 12, 2022, 0, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (3, 5, 6, 34, 3, 46, 2024, 0, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (11, 3, 4, 2, 6, 32, 2020, 0, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (18, 5, 6, 28, 7, 51, 2023, 0, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (14, 5, 6, 29, 5, 33, 2023, 1, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (16, 1, 2, 13, 1, 16, 2021, 1, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (14, 5, 6, 23, 1, 18, 2022, 1, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (12, 7, 8, 13, 1, 11, 2021, 1, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (3, 5, 6, 31, 4, 35, 2023, 1, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (4, 9, 10, 33, 2, 30, 2024, 1, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (2, 3, 4, 22, 5, 9, 2022, 0, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (17, 7, 8, 10, 1, 55, 2021, 0, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (3, 3, 4, 35, 3, 4, 2024, 1, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (6, 1, 2, 26, 5, 3, 2023, 0, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (15, 5, 6, 14, 5, 45, 2022, 0, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (10, 9, 10, 13, 4, 19, 2021, 1, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (18, 3, 4, 19, 2, 2, 2022, 1, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (13, 3, 4, 20, 3, 41, 2022, 0, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (13, 5, 6, 16, 7, 44, 2022, 0, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (10, 1, 2, 32, 6, 38, 2023, 0, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (17, 5, 6, 32, 4, 1, 2023, 0, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (16, 9, 10, 23, 5, 44, 2022, 1, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (11, 1, 2, 8, 7, 43, 2021, 0, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (18, 1, 2, 25, 6, 34, 2023, 1, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (3, 5, 6, 35, 3, 51, 2024, 1, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (9, 3, 4, 12, 5, 53, 2021, 0, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (15, 7, 8, 4, 2, 8, 2020, 0, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (11, 7, 8, 22, 3, 7, 2022, 0, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (17, 9, 10, 20, 7, 2, 2022, 0, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (18, 5, 6, 5, 5, 44, 2020, 1, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (6, 3, 4, 3, 4, 50, 2020, 1, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (13, 1, 2, 15, 7, 12, 2022, 1, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (5, 3, 4, 12, 4, 33, 2021, 0, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (4, 3, 4, 18, 1, 35, 2022, 0, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (1, 1, 2, 30, 4, 45, 2023, 0, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (10, 7, 8, 21, 5, 35, 2022, 1, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (18, 7, 8, 1, 6, 5, 2020, 1, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (3, 9, 10, 27, 7, 49, 2023, 1, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (9, 9, 10, 9, 5, 12, 2021, 1, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (17, 1, 2, 11, 6, 18, 2021, 1, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (16, 3, 4, 38, 1, 33, 2024, 0, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (17, 3, 4, 17, 1, 7, 2022, 1, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (3, 1, 2, 26, 4, 57, 2023, 0, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (11, 7, 8, 19, 2, 5, 2022, 1, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (6, 1, 2, 21, 6, 49, 2022, 1, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (10, 7, 8, 29, 3, 53, 2023, 1, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (11, 1, 2, 31, 7, 33, 2023, 1, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (9, 9, 10, 24, 3, 19, 2022, 0, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (2, 1, 2, 19, 6, 12, 2022, 1, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (15, 1, 2, 39, 3, 24, 2024, 1, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (9, 9, 10, 8, 4, 15, 2021, 0, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (13, 7, 8, 35, 3, 38, 2024, 1, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (8, 7, 8, 21, 7, 55, 2022, 1, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (18, 3, 4, 20, 7, 38, 2022, 0, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (6, 5, 6, 18, 1, 23, 2022, 0, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (2, 3, 4, 34, 6, 43, 2024, 0, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (15, 9, 10, 28, 7, 50, 2023, 0, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (10, 1, 2, 31, 1, 40, 2023, 1, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (9, 7, 8, 27, 3, 4, 2023, 1, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (6, 5, 6, 34, 1, 47, 2024, 0, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (10, 7, 8, 34, 2, 52, 2024, 0, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (4, 7, 8, 3, 1, 56, 2020, 1, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (6, 9, 10, 13, 2, 21, 2021, 1, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (9, 3, 4, 30, 3, 16, 2023, 0, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (10, 3, 4, 37, 3, 47, 2024, 1, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (1, 1, 2, 29, 2, 22, 2023, 1, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (13, 9, 10, 21, 5, 35, 2022, 1, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (14, 7, 8, 14, 3, 46, 2022, 0, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (1, 9, 10, 24, 7, 24, 2022, 0, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (18, 7, 8, 4, 4, 50, 2020, 0, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (11, 3, 4, 8, 1, 3, 2021, 0, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (10, 1, 2, 33, 2, 47, 2024, 1, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (11, 9, 10, 21, 7, 12, 2022, 1, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (17, 1, 2, 17, 7, 33, 2022, 1, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (6, 3, 4, 38, 2, 8, 2024, 0, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (2, 3, 4, 38, 2, 7, 2024, 0, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (5, 5, 6, 29, 3, 17, 2023, 1, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (14, 7, 8, 31, 4, 8, 2023, 1, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (14, 1, 2, 2, 3, 16, 2020, 0, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (16, 3, 4, 11, 7, 7, 2021, 1, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (2, 3, 4, 39, 7, 23, 2024, 1, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (11, 1, 2, 28, 1, 27, 2023, 0, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (18, 5, 6, 35, 7, 6, 2024, 1, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (16, 5, 6, 20, 4, 8, 2022, 0, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (16, 1, 2, 19, 6, 57, 2022, 1, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (18, 3, 4, 28, 4, 5, 2023, 0, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (11, 9, 10, 22, 2, 53, 2022, 0, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (6, 3, 4, 30, 4, 52, 2023, 0, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (1, 7, 8, 23, 5, 11, 2022, 1, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (7, 3, 4, 17, 3, 14, 2022, 1, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (14, 1, 2, 7, 5, 14, 2020, 1, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (8, 7, 8, 25, 5, 55, 2023, 1, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (13, 9, 10, 15, 4, 53, 2022, 1, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (2, 5, 6, 8, 6, 50, 2021, 0, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (2, 3, 4, 12, 2, 8, 2021, 0, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (6, 1, 2, 22, 4, 8, 2022, 0, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (8, 5, 6, 13, 7, 2, 2021, 1, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (16, 5, 6, 29, 6, 40, 2023, 1, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (18, 1, 2, 26, 7, 19, 2023, 0, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (18, 1, 2, 23, 4, 53, 2022, 1, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (3, 3, 4, 22, 4, 45, 2022, 0, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (12, 5, 6, 12, 1, 34, 2021, 0, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (12, 3, 4, 21, 2, 9, 2022, 1, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (10, 3, 4, 11, 4, 9, 2021, 1, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (4, 3, 4, 20, 5, 3, 2022, 0, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (15, 5, 6, 1, 6, 51, 2020, 1, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (18, 1, 2, 9, 2, 12, 2021, 1, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (8, 3, 4, 10, 5, 2, 2021, 0, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (18, 3, 4, 5, 1, 37, 2020, 1, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (11, 5, 6, 20, 3, 53, 2022, 0, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (8, 5, 6, 23, 7, 54, 2022, 1, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (17, 5, 6, 31, 4, 11, 2023, 1, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (13, 9, 10, 6, 7, 51, 2020, 0, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (5, 5, 6, 21, 6, 41, 2022, 1, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (17, 3, 4, 11, 2, 23, 2021, 1, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (16, 3, 4, 32, 6, 39, 2023, 0, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (13, 1, 2, 9, 2, 9, 2021, 1, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (2, 7, 8, 10, 4, 38, 2021, 0, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (16, 1, 2, 10, 5, 3, 2021, 0, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (4, 7, 8, 5, 4, 18, 2020, 1, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (15, 3, 4, 2, 4, 52, 2020, 0, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (12, 5, 6, 22, 1, 26, 2022, 0, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (16, 3, 4, 39, 1, 6, 2024, 1, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (5, 5, 6, 3, 5, 43, 2020, 1, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (12, 1, 2, 8, 7, 37, 2021, 0, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (17, 5, 6, 32, 7, 20, 2023, 0, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (18, 9, 10, 23, 1, 54, 2022, 1, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (15, 7, 8, 8, 7, 52, 2021, 0, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (9, 5, 6, 17, 1, 9, 2022, 1, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (17, 7, 8, 6, 1, 13, 2020, 0, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (11, 5, 6, 39, 1, 47, 2024, 1, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (8, 3, 4, 25, 4, 20, 2023, 1, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (14, 7, 8, 20, 2, 38, 2022, 0, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (4, 7, 8, 11, 1, 2, 2021, 1, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (12, 1, 2, 21, 6, 37, 2022, 1, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (2, 3, 4, 14, 3, 1, 2022, 0, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (17, 9, 10, 8, 7, 22, 2021, 0, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (6, 9, 10, 6, 1, 48, 2020, 0, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (9, 1, 2, 22, 5, 53, 2022, 0, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (5, 1, 2, 11, 6, 40, 2021, 1, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (3, 5, 6, 38, 7, 7, 2024, 0, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (10, 3, 4, 27, 2, 8, 2023, 1, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (2, 7, 8, 34, 2, 11, 2024, 0, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (17, 3, 4, 20, 3, 50, 2022, 0, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (7, 7, 8, 26, 7, 33, 2023, 0, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (9, 3, 4, 21, 3, 1, 2022, 1, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (7, 5, 6, 17, 1, 16, 2022, 1, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (6, 5, 6, 4, 5, 54, 2020, 0, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (18, 3, 4, 3, 6, 5, 2020, 1, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (12, 5, 6, 34, 4, 29, 2024, 0, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (12, 9, 10, 20, 7, 10, 2022, 0, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (13, 7, 8, 2, 4, 4, 2020, 0, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (11, 5, 6, 15, 6, 38, 2022, 1, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (3, 3, 4, 4, 5, 20, 2020, 0, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (9, 3, 4, 6, 5, 1, 2020, 0, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (2, 1, 2, 27, 2, 19, 2023, 1, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (6, 7, 8, 8, 6, 8, 2021, 0, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (10, 3, 4, 38, 4, 30, 2024, 0, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (13, 5, 6, 25, 1, 16, 2023, 1, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (14, 9, 10, 40, 2, 28, 2024, 0, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (10, 9, 10, 9, 5, 5, 2021, 1, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (5, 3, 4, 2, 1, 42, 2020, 0, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (17, 5, 6, 29, 4, 55, 2023, 1, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (10, 5, 6, 19, 1, 50, 2022, 1, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (5, 9, 10, 36, 5, 45, 2024, 0, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (9, 7, 8, 7, 4, 38, 2020, 1, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (10, 9, 10, 10, 6, 46, 2021, 0, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (17, 1, 2, 31, 4, 29, 2023, 1, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (9, 9, 10, 8, 3, 54, 2021, 0, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (3, 5, 6, 9, 6, 6, 2021, 1, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (7, 1, 2, 14, 3, 38, 2022, 0, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (16, 9, 10, 23, 1, 27, 2022, 1, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (1, 3, 4, 24, 1, 30, 2022, 0, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (2, 1, 2, 24, 3, 7, 2022, 0, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (16, 9, 10, 17, 1, 14, 2022, 1, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (4, 7, 8, 3, 2, 56, 2020, 1, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (14, 7, 8, 37, 6, 57, 2024, 1, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (14, 9, 10, 12, 4, 11, 2021, 0, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (6, 3, 4, 10, 6, 16, 2021, 0, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (4, 5, 6, 21, 1, 18, 2022, 1, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (1, 9, 10, 28, 2, 32, 2023, 0, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (14, 5, 6, 25, 4, 36, 2023, 1, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (8, 3, 4, 40, 7, 24, 2024, 0, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (3, 3, 4, 10, 3, 47, 2021, 0, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (3, 5, 6, 20, 5, 4, 2022, 0, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (3, 5, 6, 1, 5, 1, 2020, 1, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (16, 7, 8, 38, 6, 46, 2024, 0, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (12, 1, 2, 35, 7, 27, 2024, 1, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (16, 7, 8, 5, 4, 7, 2020, 1, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (2, 9, 10, 2, 1, 52, 2020, 0, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (7, 9, 10, 6, 6, 29, 2020, 0, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (10, 3, 4, 22, 5, 52, 2022, 0, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (12, 7, 8, 34, 5, 46, 2024, 0, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (2, 3, 4, 30, 6, 46, 2023, 0, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (12, 9, 10, 21, 2, 37, 2022, 1, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (3, 7, 8, 1, 1, 56, 2020, 1, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (10, 3, 4, 40, 3, 43, 2024, 0, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (2, 1, 2, 18, 5, 25, 2022, 0, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (11, 3, 4, 37, 1, 35, 2024, 1, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (17, 1, 2, 7, 5, 36, 2020, 1, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (11, 1, 2, 2, 2, 50, 2020, 0, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (12, 9, 10, 31, 5, 20, 2023, 1, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (11, 1, 2, 17, 5, 30, 2022, 1, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (13, 1, 2, 21, 2, 27, 2022, 1, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (5, 1, 2, 2, 7, 7, 2020, 0, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (18, 9, 10, 10, 7, 29, 2021, 0, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (3, 3, 4, 13, 4, 28, 2021, 1, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (8, 7, 8, 2, 3, 25, 2020, 0, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (4, 7, 8, 15, 7, 43, 2022, 1, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (11, 1, 2, 17, 2, 23, 2022, 1, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (4, 5, 6, 17, 1, 29, 2022, 1, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (8, 5, 6, 22, 7, 14, 2022, 0, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (6, 7, 8, 20, 5, 48, 2022, 0, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (9, 5, 6, 11, 3, 3, 2021, 1, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (8, 3, 4, 10, 2, 35, 2021, 0, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (4, 5, 6, 26, 5, 6, 2023, 0, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (10, 1, 2, 15, 1, 22, 2022, 1, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (6, 3, 4, 31, 1, 36, 2023, 1, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (17, 5, 6, 30, 2, 9, 2023, 0, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (1, 5, 6, 31, 4, 12, 2023, 1, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (13, 1, 2, 25, 2, 16, 2023, 1, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (9, 7, 8, 9, 2, 20, 2021, 1, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (13, 1, 2, 33, 6, 31, 2024, 1, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (1, 3, 4, 14, 3, 20, 2022, 0, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (15, 3, 4, 30, 7, 53, 2023, 0, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (11, 7, 8, 31, 1, 32, 2023, 1, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (2, 5, 6, 11, 2, 37, 2021, 1, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (6, 1, 2, 4, 6, 34, 2020, 0, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (14, 5, 6, 13, 2, 34, 2021, 1, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (4, 5, 6, 23, 2, 24, 2022, 1, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (2, 1, 2, 23, 1, 22, 2022, 1, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (7, 1, 2, 17, 6, 3, 2022, 1, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (6, 1, 2, 20, 5, 49, 2022, 0, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (4, 3, 4, 4, 4, 41, 2020, 0, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (1, 1, 2, 14, 1, 21, 2022, 0, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (17, 3, 4, 11, 5, 44, 2021, 1, 1);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (1, 3, 4, 24, 4, 9, 2022, 0, 2);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (15, 9, 10, 11, 2, 50, 2021, 1, 3);
INSERT INTO course_sched (week, period_from, period_to, course_section_id, day_of_week, classroom_id, year, term_part, teacher_attend) VALUES (14, 3, 4, 1, 4, 36, 2020, 1, 3);


INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000001', 29, 84, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000002', 29, 60, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000003', 12, 69, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000004', 25, 81, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000005', 15, 74, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000006', 18, 67, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000007', 21, 83, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000008', 16, 96, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000009', 31, 74, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000010', 38, 100, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000011', 11, 76, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000012', 6, 78, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000013', 31, 94, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000014', 11, 79, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000015', 34, 72, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000016', 38, 63, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000017', 6, 68, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000018', 20, 99, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000019', 19, 76, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000020', 37, 95, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000021', 37, 79, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000022', 8, 63, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000023', 12, 92, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000024', 32, 97, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000025', 36, 77, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000026', 20, 69, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000027', 17, 87, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000028', 19, 96, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000029', 3, 84, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000030', 38, 82, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000031', 21, 60, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000032', 26, 70, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000033', 7, 90, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000034', 21, 96, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000035', 28, 99, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000036', 27, 96, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000037', 31, 99, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000038', 2, 70, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000039', 9, 86, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000040', 26, 61, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000041', 31, 65, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000042', 22, 64, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000043', 14, 98, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000044', 5, 73, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000045', 37, 66, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000046', 9, 71, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000047', 5, 83, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000048', 36, 99, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000049', 4, 91, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000050', 35, 67, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000051', 1, 76, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000052', 8, 70, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000053', 40, 76, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000054', 34, 99, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000055', 33, 99, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000056', 34, 75, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000057', 39, 90, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000058', 17, 65, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000059', 11, 97, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000060', 7, 94, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000061', 28, 81, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000062', 24, 73, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000063', 8, 71, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000064', 40, 70, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000065', 12, 76, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000066', 38, 100, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000067', 39, 62, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000068', 16, 61, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000069', 12, 73, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000070', 10, 94, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000071', 13, 76, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000072', 22, 89, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000073', 24, 65, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000074', 14, 94, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000075', 3, 78, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000076', 20, 94, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000077', 38, 81, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000078', 13, 71, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000079', 26, 67, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000080', 16, 65, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000081', 28, 62, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000082', 25, 88, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000083', 13, 94, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000084', 26, 80, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000085', 9, 93, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000086', 16, 63, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000087', 5, 64, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000088', 5, 81, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000089', 20, 71, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000090', 12, 76, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000091', 13, 73, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000092', 25, 75, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000093', 34, 83, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000094', 24, 69, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000095', 3, 73, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000096', 9, 62, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000097', 15, 83, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000098', 32, 76, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000099', 17, 95, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000100', 32, 90, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000101', 35, 60, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000102', 9, 70, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000103', 27, 75, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000104', 27, 71, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000105', 15, 62, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000106', 25, 63, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000107', 37, 96, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000108', 29, 74, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000109', 34, 73, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000110', 2, 79, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000111', 3, 80, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000112', 14, 80, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000113', 11, 87, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000114', 3, 100, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000115', 31, 91, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000116', 11, 78, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000117', 15, 69, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000118', 33, 89, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000119', 12, 63, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000120', 35, 87, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000121', 33, 91, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000122', 2, 72, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000123', 37, 74, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000124', 1, 71, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000125', 30, 84, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000126', 35, 71, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000127', 38, 72, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000128', 11, 82, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000129', 3, 80, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000130', 29, 81, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000131', 4, 70, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000132', 3, 65, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000133', 15, 83, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000134', 39, 80, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000135', 15, 70, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000136', 30, 67, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000137', 3, 93, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000138', 21, 84, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000139', 39, 95, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000140', 26, 94, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000141', 4, 78, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000142', 27, 67, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000143', 24, 64, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000144', 40, 77, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000145', 10, 71, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000146', 33, 66, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000147', 19, 79, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000148', 35, 86, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000149', 14, 100, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000150', 23, 98, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000151', 3, 71, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000152', 34, 73, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000153', 34, 71, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000154', 39, 63, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000155', 31, 75, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000156', 20, 64, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000157', 15, 73, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000158', 38, 83, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000159', 5, 91, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000160', 11, 70, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000161', 1, 63, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000162', 8, 100, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000163', 34, 71, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000164', 15, 64, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000165', 18, 86, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000166', 14, 90, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000167', 15, 71, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000168', 32, 89, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000169', 30, 78, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000170', 35, 100, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000171', 32, 80, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000172', 32, 67, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000173', 16, 62, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000174', 30, 65, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000175', 26, 89, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000176', 18, 70, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000177', 34, 66, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000178', 26, 90, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000179', 3, 75, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000180', 15, 89, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000181', 38, 62, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000182', 30, 72, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000183', 19, 86, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000184', 31, 89, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000185', 6, 71, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000186', 35, 81, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000187', 38, 70, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000188', 22, 100, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000189', 19, 67, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000190', 9, 68, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000191', 11, 61, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000192', 37, 62, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000193', 27, 60, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000194', 3, 66, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000195', 23, 63, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000196', 31, 93, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000197', 14, 74, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000198', 19, 60, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000199', 1, 75, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000200', 31, 74, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000201', 1, 86, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000202', 34, 86, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000203', 4, 74, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000204', 6, 60, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000205', 3, 85, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000206', 20, 64, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000207', 32, 72, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000208', 22, 62, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000209', 17, 71, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000210', 28, 66, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000211', 35, 64, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000212', 21, 82, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000213', 30, 69, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000214', 14, 84, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000215', 25, 96, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000216', 37, 79, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000217', 36, 96, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000218', 29, 73, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000219', 14, 99, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000220', 35, 92, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000221', 2, 75, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000222', 10, 94, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000223', 17, 85, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000224', 34, 80, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000225', 8, 61, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000226', 10, 89, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000227', 27, 93, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000228', 13, 69, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000229', 9, 76, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000230', 17, 94, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000231', 4, 68, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000232', 7, 80, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000233', 11, 67, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000234', 30, 79, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000235', 40, 70, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000236', 2, 72, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000237', 37, 95, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000238', 13, 99, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000239', 23, 94, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000240', 3, 64, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000241', 26, 83, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000242', 36, 100, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000243', 32, 83, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000244', 10, 81, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000245', 27, 71, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000246', 27, 61, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000247', 15, 69, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000248', 9, 88, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000249', 16, 94, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000250', 7, 71, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000251', 22, 69, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000252', 17, 72, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000253', 39, 93, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000254', 5, 83, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000255', 32, 75, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000256', 32, 82, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000257', 19, 71, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000258', 13, 100, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000259', 19, 98, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000260', 25, 78, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000261', 9, 84, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000262', 2, 71, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000263', 3, 88, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000264', 25, 71, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000265', 10, 60, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000266', 32, 95, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000267', 10, 78, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000268', 29, 60, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000269', 24, 84, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000270', 2, 64, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000271', 8, 89, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000272', 21, 60, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000273', 25, 78, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000274', 24, 69, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000275', 20, 79, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000276', 30, 96, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000277', 22, 97, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000278', 24, 91, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000279', 30, 96, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000280', 33, 81, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000281', 39, 86, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000282', 31, 84, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000283', 16, 82, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000284', 10, 93, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000285', 39, 66, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000286', 39, 89, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000287', 29, 99, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000288', 23, 99, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000289', 1, 97, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000290', 7, 100, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000291', 39, 88, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000292', 10, 98, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000293', 35, 79, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000294', 7, 94, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000295', 15, 96, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000296', 29, 78, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000297', 35, 87, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000298', 24, 80, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000299', 12, 89, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000300', 15, 85, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000301', 21, 97, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000302', 6, 83, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000303', 6, 61, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000304', 13, 83, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000305', 10, 82, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000306', 30, 65, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000307', 31, 63, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000308', 16, 68, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000309', 4, 77, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000310', 15, 96, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000311', 27, 89, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000312', 12, 69, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000313', 24, 63, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000314', 27, 71, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000315', 15, 75, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000316', 13, 84, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000317', 26, 77, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000318', 26, 67, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000319', 31, 85, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000320', 10, 78, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000321', 15, 90, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000322', 31, 73, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000323', 10, 60, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000324', 3, 81, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000325', 19, 77, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000326', 3, 79, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000327', 28, 100, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000328', 29, 99, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000329', 34, 76, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000330', 34, 97, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000331', 19, 73, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000332', 7, 77, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000333', 4, 61, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000334', 23, 71, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000335', 14, 95, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000336', 39, 86, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000337', 7, 74, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000338', 20, 89, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000339', 38, 82, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000340', 39, 77, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000341', 2, 96, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000342', 20, 70, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000343', 21, 85, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000344', 21, 68, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000345', 37, 82, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000346', 36, 94, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000347', 19, 98, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000348', 12, 99, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000349', 21, 82, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000350', 38, 67, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000351', 18, 68, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000352', 13, 80, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000353', 18, 97, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000354', 4, 61, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000355', 21, 68, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000356', 33, 61, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000357', 39, 84, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000358', 18, 98, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000359', 21, 99, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000360', 10, 97, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000361', 33, 87, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000362', 9, 79, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000363', 37, 67, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000364', 25, 92, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000365', 10, 77, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000366', 5, 84, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000367', 8, 95, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000368', 22, 74, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000369', 36, 92, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000370', 24, 92, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000371', 1, 85, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000372', 28, 67, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000373', 19, 96, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000374', 17, 88, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000375', 29, 69, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000376', 1, 68, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000377', 31, 98, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000378', 3, 100, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000379', 25, 83, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000380', 31, 66, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000381', 2, 62, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000382', 13, 70, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000383', 39, 71, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000384', 38, 88, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000385', 7, 97, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000386', 28, 82, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000387', 25, 66, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000388', 10, 67, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000389', 25, 64, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000390', 7, 97, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000391', 39, 72, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000392', 25, 83, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000393', 29, 81, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000394', 28, 77, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000395', 16, 73, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000396', 14, 67, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000397', 14, 73, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000398', 35, 64, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000399', 5, 80, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000400', 23, 73, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000401', 2, 86, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000402', 38, 80, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000403', 15, 95, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000404', 14, 90, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000405', 27, 86, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000406', 21, 63, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000407', 18, 95, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000408', 2, 63, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000409', 2, 60, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000410', 25, 86, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000411', 10, 87, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000412', 26, 96, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000413', 21, 94, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000414', 34, 79, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000415', 24, 94, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000416', 5, 97, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000417', 29, 80, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000418', 26, 85, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000419', 17, 84, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000420', 18, 83, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000421', 26, 84, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000422', 2, 62, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000423', 3, 63, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000424', 23, 60, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000425', 27, 62, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000426', 27, 62, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000427', 39, 68, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000428', 38, 92, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000429', 9, 64, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000430', 26, 83, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000431', 10, 67, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000432', 18, 80, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000433', 5, 75, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000434', 40, 92, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000435', 39, 61, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000436', 31, 73, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000437', 24, 96, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000438', 37, 79, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000439', 6, 83, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000440', 20, 100, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000441', 35, 60, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000442', 33, 91, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000443', 18, 95, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000444', 17, 64, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000445', 36, 98, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000446', 39, 70, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000447', 40, 62, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000448', 32, 93, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000449', 31, 90, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000450', 5, 81, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000451', 25, 74, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000452', 13, 78, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000453', 40, 70, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000454', 29, 74, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000455', 37, 79, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000456', 19, 87, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000457', 25, 74, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000458', 34, 100, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000459', 9, 64, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000460', 16, 87, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000461', 39, 90, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000462', 33, 84, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000463', 1, 66, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000464', 9, 92, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000465', 5, 85, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000466', 16, 81, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000467', 7, 66, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000468', 40, 88, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000469', 32, 85, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000470', 17, 78, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000471', 19, 82, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000472', 40, 61, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000473', 24, 71, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000474', 7, 100, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000475', 39, 95, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000476', 14, 76, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000477', 22, 95, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000478', 39, 87, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000479', 37, 71, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000480', 12, 91, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000481', 15, 98, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000482', 25, 94, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000483', 20, 81, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000484', 14, 81, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000485', 23, 72, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000486', 30, 82, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000487', 13, 84, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000488', 26, 66, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000489', 10, 66, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000490', 23, 91, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000491', 33, 68, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000492', 1, 89, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000493', 34, 83, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000494', 33, 76, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000495', 12, 88, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000496', 17, 85, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000497', 13, 70, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000498', 37, 100, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000499', 16, 89, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000500', 23, 91, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000501', 16, 60, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000502', 19, 68, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000503', 35, 78, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000504', 10, 90, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000505', 8, 85, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000506', 12, 79, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000507', 23, 70, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000508', 15, 62, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000509', 5, 93, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000510', 21, 90, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000511', 32, 77, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000512', 38, 60, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000513', 16, 93, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000514', 38, 89, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000515', 39, 65, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000516', 36, 83, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000517', 38, 75, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000518', 16, 69, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000519', 8, 78, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000520', 37, 81, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000521', 25, 78, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000522', 13, 68, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000523', 2, 79, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000524', 36, 68, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000525', 19, 68, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000526', 6, 96, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000527', 29, 81, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000528', 9, 86, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000529', 27, 86, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000530', 21, 91, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000531', 7, 79, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000532', 8, 85, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000533', 10, 72, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000534', 32, 87, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000535', 10, 81, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000536', 39, 82, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000537', 3, 100, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000538', 39, 69, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000539', 38, 61, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000540', 10, 74, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000541', 16, 68, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000542', 28, 88, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000543', 36, 68, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000544', 15, 72, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000545', 8, 92, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000546', 1, 100, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000547', 35, 73, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000548', 1, 64, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000549', 40, 76, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000550', 16, 93, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000551', 9, 90, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000552', 21, 85, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000553', 1, 77, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000554', 25, 70, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000555', 20, 84, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000556', 32, 86, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000557', 17, 85, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000558', 17, 75, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000559', 5, 78, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000560', 33, 94, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000561', 12, 67, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000562', 14, 90, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000563', 32, 72, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000564', 38, 89, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000565', 38, 92, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000566', 19, 63, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000567', 6, 71, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000568', 30, 89, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000569', 15, 80, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000570', 7, 64, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000571', 39, 66, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000572', 12, 97, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000573', 20, 86, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000574', 5, 90, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000575', 12, 93, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000576', 22, 88, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000577', 21, 100, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000578', 19, 67, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000579', 16, 65, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000580', 27, 87, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000581', 29, 95, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000582', 15, 67, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000583', 11, 74, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000584', 22, 99, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000585', 34, 93, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000586', 10, 80, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000587', 30, 63, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000588', 38, 93, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000589', 38, 78, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000590', 30, 86, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000591', 35, 82, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000592', 5, 96, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000593', 24, 94, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000594', 36, 88, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000595', 30, 88, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000596', 22, 99, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000597', 28, 85, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000598', 2, 85, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000599', 1, 83, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000600', 37, 77, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000601', 5, 79, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000602', 37, 92, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000603', 14, 85, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000604', 30, 84, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000605', 25, 90, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000606', 6, 89, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000607', 32, 77, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000608', 25, 83, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000609', 40, 81, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000610', 38, 86, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000611', 11, 61, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000612', 38, 73, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000613', 21, 90, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000614', 34, 63, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000615', 13, 86, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000616', 27, 94, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000617', 31, 82, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000618', 15, 82, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000619', 17, 88, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000620', 35, 85, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000621', 33, 95, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000622', 13, 75, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000623', 12, 84, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000624', 12, 89, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000625', 25, 72, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000626', 23, 87, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000627', 25, 88, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000628', 18, 72, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000629', 10, 74, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000630', 13, 86, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000631', 35, 66, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000632', 25, 60, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000633', 23, 77, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000634', 12, 77, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000635', 16, 82, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000636', 6, 75, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000637', 28, 80, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000638', 7, 89, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000639', 35, 92, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000640', 9, 71, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000641', 20, 84, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000642', 34, 71, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000643', 18, 67, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000644', 19, 74, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000645', 30, 91, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000646', 30, 95, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000647', 21, 79, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000648', 38, 68, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000649', 4, 97, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000650', 29, 87, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000651', 23, 69, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000652', 8, 90, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000653', 5, 62, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000654', 35, 69, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000655', 24, 76, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000656', 11, 65, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000657', 22, 70, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000658', 8, 61, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000659', 3, 90, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000660', 32, 85, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000661', 35, 64, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000662', 24, 62, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000663', 11, 96, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000664', 26, 64, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000665', 22, 86, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000666', 33, 61, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000667', 7, 87, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000668', 12, 92, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000669', 31, 72, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000670', 1, 66, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000671', 27, 91, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000672', 1, 64, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000673', 6, 77, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000674', 4, 72, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000675', 18, 71, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000676', 34, 61, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000677', 36, 81, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000678', 19, 96, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000679', 39, 97, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000680', 5, 77, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000681', 23, 100, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000682', 5, 100, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000683', 12, 65, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000684', 21, 87, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000685', 1, 61, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000686', 24, 99, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000687', 14, 67, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000688', 12, 86, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000689', 28, 79, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000690', 22, 98, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000691', 29, 94, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000692', 13, 74, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000693', 20, 71, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000694', 1, 62, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000695', 13, 67, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000696', 40, 97, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000697', 34, 70, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000698', 15, 84, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000699', 35, 91, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000700', 32, 90, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000701', 25, 61, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000702', 19, 65, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000703', 24, 60, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000704', 40, 62, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000705', 38, 89, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000706', 31, 73, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000707', 30, 69, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000708', 24, 80, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000709', 38, 76, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000710', 9, 99, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000711', 38, 85, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000712', 5, 90, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000713', 40, 61, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000714', 3, 65, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000715', 22, 100, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000716', 3, 71, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000717', 21, 79, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000718', 40, 95, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000719', 28, 98, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000720', 23, 96, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000721', 7, 96, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000722', 7, 88, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000723', 3, 65, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000724', 30, 89, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000725', 10, 82, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000726', 5, 77, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000727', 33, 66, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000728', 35, 85, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000729', 33, 76, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000730', 21, 83, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000731', 15, 74, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000732', 22, 92, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000733', 30, 80, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000734', 12, 61, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000735', 3, 63, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000736', 23, 61, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000737', 38, 62, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000738', 16, 87, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000739', 20, 69, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000740', 27, 96, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000741', 39, 98, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000742', 34, 65, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000743', 23, 60, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000744', 8, 87, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000745', 33, 78, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000746', 40, 71, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000747', 8, 74, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000748', 24, 73, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000749', 21, 69, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000750', 23, 91, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000751', 27, 79, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000752', 3, 81, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000753', 38, 72, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000754', 16, 72, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000755', 39, 72, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000756', 13, 61, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000757', 38, 78, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000758', 38, 88, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000759', 40, 87, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000760', 7, 95, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000761', 22, 93, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000762', 14, 65, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000763', 16, 65, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000764', 12, 94, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000765', 2, 67, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000766', 21, 99, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000767', 16, 65, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000768', 16, 69, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000769', 5, 65, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000770', 23, 83, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000771', 7, 70, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000772', 40, 63, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000773', 32, 74, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000774', 7, 63, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000775', 19, 75, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000776', 15, 90, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000777', 16, 83, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000778', 21, 65, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000779', 1, 62, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000780', 21, 61, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000781', 9, 61, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000782', 40, 75, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000783', 14, 64, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000784', 23, 64, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000785', 11, 95, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000786', 26, 96, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000787', 2, 95, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000788', 26, 95, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000789', 16, 99, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000790', 40, 80, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000791', 34, 88, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000792', 12, 72, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000793', 20, 100, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000794', 7, 65, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000795', 31, 82, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000796', 35, 69, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000797', 6, 64, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000798', 5, 83, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000799', 17, 87, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000800', 24, 74, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000801', 19, 81, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000802', 16, 98, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000803', 1, 88, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000804', 34, 96, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000805', 17, 98, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000806', 27, 65, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000807', 23, 72, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000808', 36, 74, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000809', 29, 85, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000810', 12, 100, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000811', 39, 62, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000812', 40, 89, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000813', 29, 78, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000814', 4, 83, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000815', 37, 81, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000816', 2, 67, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000817', 39, 89, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000818', 5, 88, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000819', 5, 99, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000820', 31, 76, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000821', 8, 72, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000822', 10, 71, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000823', 37, 72, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000824', 33, 82, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000825', 35, 62, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000826', 33, 62, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000827', 9, 60, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000828', 36, 66, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000829', 9, 98, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000830', 29, 85, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000831', 9, 78, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000832', 23, 84, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000833', 30, 79, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000834', 8, 80, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000835', 7, 63, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000836', 17, 89, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000837', 15, 74, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000838', 19, 81, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000839', 33, 91, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000840', 19, 95, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000841', 37, 62, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000842', 28, 97, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000843', 18, 61, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000844', 16, 99, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000845', 17, 76, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000846', 32, 77, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000847', 16, 63, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000848', 12, 74, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000849', 29, 80, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000850', 18, 74, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000851', 40, 81, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000852', 36, 73, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000853', 28, 62, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000854', 32, 67, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000855', 16, 84, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000856', 9, 64, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000857', 11, 97, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000858', 24, 84, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000859', 38, 91, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000860', 13, 88, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000861', 13, 91, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000862', 19, 86, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000863', 38, 80, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000864', 2, 87, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000865', 8, 70, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000866', 28, 85, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000867', 17, 94, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000868', 38, 85, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000869', 23, 77, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000870', 5, 79, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000871', 4, 94, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000872', 38, 68, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000873', 20, 83, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000874', 2, 98, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000875', 39, 91, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000876', 7, 73, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000877', 19, 61, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000878', 4, 96, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000879', 26, 84, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000880', 37, 87, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000881', 35, 60, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000882', 9, 84, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000883', 27, 96, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000884', 35, 66, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000885', 17, 85, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000886', 21, 93, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000887', 23, 74, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000888', 15, 66, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000889', 27, 78, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000890', 11, 68, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000891', 38, 72, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000892', 38, 75, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000893', 1, 99, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000894', 34, 90, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000895', 6, 66, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000896', 40, 68, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000897', 8, 75, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000898', 6, 68, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000899', 28, 67, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000900', 4, 88, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000901', 33, 92, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000902', 36, 74, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000903', 15, 64, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000904', 36, 66, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000905', 10, 81, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000906', 19, 82, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000907', 37, 75, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000908', 40, 80, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000909', 9, 80, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000910', 33, 82, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000911', 10, 67, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000912', 38, 93, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000913', 13, 79, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000914', 6, 64, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000915', 23, 93, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000916', 29, 92, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000917', 35, 63, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000918', 28, 79, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000919', 8, 61, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000920', 23, 82, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000921', 20, 74, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000922', 23, 73, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000923', 38, 89, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000924', 18, 71, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000925', 40, 68, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000926', 33, 81, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000927', 11, 89, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000928', 28, 77, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000929', 40, 88, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000930', 6, 73, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000931', 11, 63, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000932', 29, 73, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000933', 8, 89, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000934', 23, 83, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000935', 36, 100, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000936', 15, 79, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000937', 6, 88, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000938', 3, 67, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000939', 17, 95, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000940', 28, 72, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000941', 2, 97, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000942', 14, 64, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000943', 13, 88, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000944', 11, 73, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000945', 31, 82, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000946', 33, 66, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000947', 12, 63, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000948', 26, 91, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000949', 16, 90, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000950', 27, 85, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000951', 33, 69, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000952', 31, 60, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000953', 25, 98, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000954', 13, 100, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000955', 1, 66, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000956', 20, 70, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000957', 29, 86, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000958', 14, 78, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000959', 5, 69, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000960', 23, 97, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000961', 20, 95, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000962', 13, 88, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000963', 5, 87, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000964', 33, 88, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000965', 15, 70, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000966', 7, 67, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000967', 3, 92, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000968', 22, 80, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000969', 24, 77, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000970', 9, 81, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000971', 4, 70, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000972', 35, 86, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000973', 28, 81, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000974', 40, 66, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000975', 8, 69, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000976', 28, 81, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000977', 3, 75, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000978', 19, 86, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000979', 12, 96, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000980', 30, 68, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000981', 27, 94, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000982', 38, 92, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000983', 8, 66, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000984', 25, 74, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000985', 35, 98, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000986', 1, 75, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000987', 4, 92, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000988', 16, 89, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000989', 33, 90, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000990', 12, 69, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000991', 25, 71, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000992', 27, 77, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000993', 33, 100, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000994', 18, 94, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000995', 19, 74, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000996', 26, 70, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000997', 32, 94, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000998', 7, 61, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000000999', 18, 100, 1);
INSERT INTO course_selection (stu_id, course_sec_id, score, status) VALUES ('S000001000', 2, 100, 1);



INSERT INTO exam_sched (course_inst_id, duration, classroom_id, year, term_part, week, day_of_week, period_from, period_to, type) VALUES (1, 2, 25, 2020, 1, 19, 2, 3, 4, 1);
INSERT INTO exam_sched (course_inst_id, duration, classroom_id, year, term_part, week, day_of_week, period_from, period_to, type) VALUES (2, 2, 49, 2020, 0, 19, 1, 5, 6, 1);
INSERT INTO exam_sched (course_inst_id, duration, classroom_id, year, term_part, week, day_of_week, period_from, period_to, type) VALUES (3, 2, 26, 2020, 1, 20, 2, 9, 10, 1);
INSERT INTO exam_sched (course_inst_id, duration, classroom_id, year, term_part, week, day_of_week, period_from, period_to, type) VALUES (4, 2, 14, 2020, 0, 20, 7, 7, 8, 1);
INSERT INTO exam_sched (course_inst_id, duration, classroom_id, year, term_part, week, day_of_week, period_from, period_to, type) VALUES (5, 2, 24, 2020, 1, 19, 3, 1, 2, 1);
INSERT INTO exam_sched (course_inst_id, duration, classroom_id, year, term_part, week, day_of_week, period_from, period_to, type) VALUES (6, 2, 51, 2020, 0, 19, 3, 3, 4, 1);
INSERT INTO exam_sched (course_inst_id, duration, classroom_id, year, term_part, week, day_of_week, period_from, period_to, type) VALUES (7, 2, 45, 2020, 1, 18, 4, 1, 2, 1);
INSERT INTO exam_sched (course_inst_id, duration, classroom_id, year, term_part, week, day_of_week, period_from, period_to, type) VALUES (8, 2, 26, 2021, 0, 20, 7, 3, 4, 1);
INSERT INTO exam_sched (course_inst_id, duration, classroom_id, year, term_part, week, day_of_week, period_from, period_to, type) VALUES (9, 2, 48, 2021, 1, 20, 6, 3, 4, 1);
INSERT INTO exam_sched (course_inst_id, duration, classroom_id, year, term_part, week, day_of_week, period_from, period_to, type) VALUES (10, 2, 17, 2021, 0, 20, 6, 5, 6, 1);
INSERT INTO exam_sched (course_inst_id, duration, classroom_id, year, term_part, week, day_of_week, period_from, period_to, type) VALUES (11, 2, 9, 2021, 1, 18, 1, 3, 4, 1);
INSERT INTO exam_sched (course_inst_id, duration, classroom_id, year, term_part, week, day_of_week, period_from, period_to, type) VALUES (12, 2, 45, 2021, 0, 20, 6, 9, 10, 1);
INSERT INTO exam_sched (course_inst_id, duration, classroom_id, year, term_part, week, day_of_week, period_from, period_to, type) VALUES (13, 2, 49, 2021, 1, 19, 3, 3, 4, 1);
INSERT INTO exam_sched (course_inst_id, duration, classroom_id, year, term_part, week, day_of_week, period_from, period_to, type) VALUES (14, 2, 15, 2022, 0, 18, 4, 9, 10, 1);
INSERT INTO exam_sched (course_inst_id, duration, classroom_id, year, term_part, week, day_of_week, period_from, period_to, type) VALUES (15, 2, 2, 2022, 1, 18, 4, 7, 8, 1);
INSERT INTO exam_sched (course_inst_id, duration, classroom_id, year, term_part, week, day_of_week, period_from, period_to, type) VALUES (16, 2, 2, 2022, 0, 18, 3, 3, 4, 1);
INSERT INTO exam_sched (course_inst_id, duration, classroom_id, year, term_part, week, day_of_week, period_from, period_to, type) VALUES (17, 2, 23, 2022, 1, 19, 1, 3, 4, 1);
INSERT INTO exam_sched (course_inst_id, duration, classroom_id, year, term_part, week, day_of_week, period_from, period_to, type) VALUES (18, 2, 24, 2022, 0, 20, 3, 1, 2, 1);
INSERT INTO exam_sched (course_inst_id, duration, classroom_id, year, term_part, week, day_of_week, period_from, period_to, type) VALUES (19, 2, 25, 2022, 1, 19, 7, 9, 10, 1);
INSERT INTO exam_sched (course_inst_id, duration, classroom_id, year, term_part, week, day_of_week, period_from, period_to, type) VALUES (20, 2, 6, 2022, 0, 19, 3, 5, 6, 1);
INSERT INTO exam_sched (course_inst_id, duration, classroom_id, year, term_part, week, day_of_week, period_from, period_to, type) VALUES (21, 2, 52, 2022, 1, 18, 3, 3, 4, 1);
INSERT INTO exam_sched (course_inst_id, duration, classroom_id, year, term_part, week, day_of_week, period_from, period_to, type) VALUES (22, 2, 33, 2022, 0, 19, 6, 9, 10, 1);
INSERT INTO exam_sched (course_inst_id, duration, classroom_id, year, term_part, week, day_of_week, period_from, period_to, type) VALUES (23, 2, 55, 2022, 1, 19, 6, 1, 2, 1);
INSERT INTO exam_sched (course_inst_id, duration, classroom_id, year, term_part, week, day_of_week, period_from, period_to, type) VALUES (24, 2, 29, 2022, 0, 20, 3, 9, 10, 1);
INSERT INTO exam_sched (course_inst_id, duration, classroom_id, year, term_part, week, day_of_week, period_from, period_to, type) VALUES (25, 2, 3, 2023, 1, 18, 1, 7, 8, 1);
INSERT INTO exam_sched (course_inst_id, duration, classroom_id, year, term_part, week, day_of_week, period_from, period_to, type) VALUES (26, 2, 45, 2023, 0, 18, 7, 7, 8, 1);
INSERT INTO exam_sched (course_inst_id, duration, classroom_id, year, term_part, week, day_of_week, period_from, period_to, type) VALUES (27, 2, 13, 2023, 1, 19, 7, 7, 8, 1);
INSERT INTO exam_sched (course_inst_id, duration, classroom_id, year, term_part, week, day_of_week, period_from, period_to, type) VALUES (28, 2, 31, 2023, 0, 20, 1, 5, 6, 1);
INSERT INTO exam_sched (course_inst_id, duration, classroom_id, year, term_part, week, day_of_week, period_from, period_to, type) VALUES (29, 2, 21, 2023, 1, 20, 1, 3, 4, 1);
INSERT INTO exam_sched (course_inst_id, duration, classroom_id, year, term_part, week, day_of_week, period_from, period_to, type) VALUES (30, 2, 9, 2023, 0, 19, 1, 1, 2, 1);
INSERT INTO exam_sched (course_inst_id, duration, classroom_id, year, term_part, week, day_of_week, period_from, period_to, type) VALUES (31, 2, 18, 2023, 1, 18, 1, 7, 8, 1);
INSERT INTO exam_sched (course_inst_id, duration, classroom_id, year, term_part, week, day_of_week, period_from, period_to, type) VALUES (32, 2, 6, 2023, 0, 20, 6, 1, 2, 1);
INSERT INTO exam_sched (course_inst_id, duration, classroom_id, year, term_part, week, day_of_week, period_from, period_to, type) VALUES (33, 2, 11, 2024, 1, 19, 6, 9, 10, 1);
INSERT INTO exam_sched (course_inst_id, duration, classroom_id, year, term_part, week, day_of_week, period_from, period_to, type) VALUES (34, 2, 34, 2024, 0, 20, 1, 7, 8, 1);
INSERT INTO exam_sched (course_inst_id, duration, classroom_id, year, term_part, week, day_of_week, period_from, period_to, type) VALUES (35, 2, 10, 2024, 1, 20, 7, 5, 6, 1);
INSERT INTO exam_sched (course_inst_id, duration, classroom_id, year, term_part, week, day_of_week, period_from, period_to, type) VALUES (36, 2, 36, 2024, 0, 20, 2, 7, 8, 1);
INSERT INTO exam_sched (course_inst_id, duration, classroom_id, year, term_part, week, day_of_week, period_from, period_to, type) VALUES (37, 2, 36, 2024, 1, 19, 7, 5, 6, 1);
INSERT INTO exam_sched (course_inst_id, duration, classroom_id, year, term_part, week, day_of_week, period_from, period_to, type) VALUES (38, 2, 4, 2024, 0, 18, 1, 5, 6, 1);
INSERT INTO exam_sched (course_inst_id, duration, classroom_id, year, term_part, week, day_of_week, period_from, period_to, type) VALUES (39, 2, 24, 2024, 1, 19, 3, 5, 6, 1);
INSERT INTO exam_sched (course_inst_id, duration, classroom_id, year, term_part, week, day_of_week, period_from, period_to, type) VALUES (40, 2, 51, 2024, 0, 20, 2, 7, 8, 1);

INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000016', '10719082');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000040', '10787932');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000012', '12345678');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000024', '13826834');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000008', '13949865');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000012', '14940143');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000035', '15555352');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000006', '17840591');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000024', '18347639');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000005', '19067409');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000029', '19114149');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000032', '20419558');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000024', '21524743');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000018', '22410144');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000028', '23129952');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000019', '23702202');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000038', '23845069');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000037', '25182533');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000016', '25900155');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000031', '26101770');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000035', '27316989');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000037', '28002715');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000035', '28176761');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000015', '28257607');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000035', '28370650');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000002', '28887273');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000037', '28962303');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000004', '30078392');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000024', '30225932');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000033', '30606394');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000004', '31388514');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000004', '32345882');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000011', '32371509');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000023', '33767010');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000011', '34178487');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000015', '34211519');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000014', '34362399');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000026', '34672990');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000019', '35393927');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000037', '35444538');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000016', '35635843');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000019', '36371572');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000029', '36513865');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000025', '36596466');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000004', '36719986');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000033', '37089449');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000026', '38533924');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000003', '38668018');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000033', '38903989');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000027', '39044930');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000008', '39219344');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000030', '39449873');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000026', '39517064');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000030', '40070350');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000039', '40213855');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000023', '40359285');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000008', '40544868');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000034', '40790888');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000003', '41389625');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000024', '41756530');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000015', '42031134');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000007', '42102815');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000001', '42955851');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000012', '43291833');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000030', '43573271');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000023', '43629271');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000019', '44365311');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000022', '44369921');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000015', '44669640');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000024', '45098162');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000008', '45464064');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000013', '45693863');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000010', '47153493');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000036', '47219864');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000018', '47894967');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000002', '48173165');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000018', '48290728');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000020', '48692553');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000032', '49229482');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000008', '49828168');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000011', '50747886');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000020', '52305822');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000016', '52942831');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000016', '53346212');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000025', '53782566');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000034', '53801923');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000010', '54127475');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000016', '54420183');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000006', '54429328');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000036', '54636719');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000004', '54765825');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000039', '54895103');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000020', '55449106');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000029', '55522020');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000011', '55926996');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000013', '56402486');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000008', '56474618');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000007', '56558236');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000019', '56601075');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000017', '57891481');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000011', '58091810');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000011', '58342837');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000040', '59296547');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000004', '60125126');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000017', '60382718');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000005', '60688714');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000001', '60786982');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000016', '61865109');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000030', '62026765');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000034', '62314604');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000028', '63633503');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000007', '63824482');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000016', '64100931');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000009', '64286767');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000010', '64383213');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000024', '64433681');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000040', '64476669');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000005', '64619063');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000033', '64632144');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000008', '64673348');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000031', '65151585');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000012', '65409605');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000034', '65420493');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000015', '66026824');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000036', '66623747');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000039', '66694154');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000012', '67366818');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000032', '67503850');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000006', '67703246');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000025', '69439534');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000006', '69570761');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000019', '70301937');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000013', '71801141');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000039', '71803291');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000010', '72021292');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000020', '72295429');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000017', '73154092');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000020', '74725750');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000029', '75000777');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000031', '75551279');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000036', '76402623');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000021', '76675399');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000032', '76768362');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000030', '78082999');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000010', '78096241');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000034', '78253859');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000007', '78691708');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000036', '79499938');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000035', '79557600');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000036', '80286069');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000020', '80663269');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000011', '81114287');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000002', '81502778');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000014', '82767820');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000038', '83179111');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000029', '83186391');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000029', '83685957');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000031', '83693806');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000023', '83717386');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000013', '84157323');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000012', '84367282');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000029', '84527875');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000016', '85428653');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000024', '86125129');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000034', '86132087');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000016', '86157539');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000014', '87128617');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000030', '87153663');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000013', '87939594');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000015', '87966078');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000037', '88313869');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000016', '89048753');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000018', '89088600');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000032', '89324316');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000005', '90139436');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000013', '90336736');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000002', '90796303');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000026', '90888026');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000001', '91017579');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000021', '91604248');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000038', '91621394');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000015', '92050141');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000027', '92073996');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000002', '92550138');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000039', '93388873');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000040', '93422097');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000040', '94345957');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000009', '94514955');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000010', '95170978');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000028', '96187326');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000013', '96188344');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000040', '96790323');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000029', '97002684');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000009', '97451315');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000006', '98863939');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000019', '98959653');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000028', '99375488');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000006', '99454778');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000037', '99759050');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000006', '99808130');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000028', '10719082');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000022', '10787932');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000030', '12345678');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000033', '13826834');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000014', '13949865');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000034', '14940143');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000018', '15555352');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000011', '17840591');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000013', '18347639');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000022', '19067409');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000033', '19114149');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000013', '20419558');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000027', '21524743');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000040', '22410144');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000014', '23129952');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000025', '23702202');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000021', '23845069');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000013', '25182533');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000022', '25900155');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000024', '26101770');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000003', '27316989');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000026', '28002715');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000005', '28176761');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000032', '28257607');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000019', '28370650');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000036', '28887273');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000035', '28962303');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000011', '30078392');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000016', '30225932');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000016', '30606394');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000037', '31388514');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000039', '32345882');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000033', '32371509');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000003', '33767010');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000021', '34178487');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000011', '34211519');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000020', '34362399');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000021', '34672990');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000001', '35393927');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000005', '35444538');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000007', '35635843');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000005', '36371572');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000006', '36513865');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000036', '36596466');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000037', '36719986');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000030', '37089449');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000039', '38533924');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000028', '38668018');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000017', '38903989');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000012', '39044930');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000006', '39219344');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000019', '39449873');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000006', '39517064');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000023', '40070350');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000024', '40213855');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000024', '40359285');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000009', '40544868');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000016', '40790888');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000007', '41389625');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000011', '41756530');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000004', '42031134');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000026', '42102815');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000022', '42955851');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000007', '43291833');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000019', '43573271');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000006', '43629271');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000018', '44365311');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000011', '44369921');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000008', '44669640');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000002', '45098162');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000004', '45464064');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000040', '45693863');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000016', '47153493');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000039', '47219864');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000028', '47894967');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000037', '48173165');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000021', '48290728');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000015', '48692553');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000025', '49229482');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000009', '49828168');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000038', '50747886');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000025', '52305822');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000013', '52942831');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000002', '53346212');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000037', '53782566');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000039', '53801923');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000028', '54127475');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000026', '54420183');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000036', '54429328');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000008', '54636719');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000016', '54765825');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000002', '54895103');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000033', '55449106');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000034', '55522020');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000020', '55926996');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000024', '56402486');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000008', '56474618');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000002', '56558236');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000012', '56601075');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000027', '57891481');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000036', '58091810');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000038', '58342837');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000023', '59296547');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000033', '60125126');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000002', '60382718');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000007', '60688714');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000011', '60786982');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000028', '61865109');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000008', '62026765');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000033', '62314604');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000015', '63633503');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000029', '63824482');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000013', '64100931');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000022', '64286767');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000031', '64383213');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000021', '64433681');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000032', '64476669');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000037', '64619063');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000022', '64632144');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000027', '64673348');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000015', '65151585');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000008', '65409605');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000012', '65420493');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000016', '66026824');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000011', '66623747');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000009', '66694154');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000015', '67366818');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000030', '67503850');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000011', '67703246');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000036', '69439534');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000032', '69570761');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000031', '70301937');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000019', '71801141');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000010', '71803291');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000035', '72021292');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000018', '72295429');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000004', '73154092');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000006', '74725750');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000030', '75000777');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000034', '75551279');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000008', '76402623');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000003', '76675399');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000035', '76768362');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000010', '78082999');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000025', '78096241');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000012', '78253859');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000014', '78691708');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000006', '79499938');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000010', '79557600');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000029', '80286069');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000037', '80663269');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000015', '81114287');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000034', '81502778');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000003', '82767820');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000003', '83179111');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000039', '83186391');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000016', '83685957');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000003', '83693806');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000025', '83717386');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000034', '84157323');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000018', '84367282');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000033', '84527875');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000003', '85428653');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000017', '86125129');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000016', '86132087');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000023', '86157539');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000011', '87128617');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000001', '87153663');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000026', '87939594');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000015', '87966078');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000025', '88313869');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000018', '89048753');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000004', '89088600');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000012', '89324316');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000020', '90139436');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000039', '90336736');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000007', '90796303');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000023', '90888026');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000039', '91017579');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000037', '91604248');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000023', '91621394');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000027', '92050141');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000016', '92073996');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000001', '92550138');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000008', '93388873');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000002', '93422097');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000032', '94345957');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000002', '94514955');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000017', '95170978');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000030', '96187326');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000005', '96188344');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000017', '96790323');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000026', '97002684');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000021', '97451315');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000021', '98863939');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000034', '98959653');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000010', '99375488');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000008', '99454778');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000032', '99759050');
INSERT INTO teach (course_id, teacher_id) VALUES ('C00000000000020', '99808130');