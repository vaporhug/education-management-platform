package com.fjxgwzd.teachersystemmanagement.service;

import com.fjxgwzd.teachersystemmanagement.vo.TeacherDetailInfoVO;
import com.fjxgwzd.teachersystemmanagement.vo.TeacherResearchFindings;

public interface TeacherService {
    TeacherDetailInfoVO getTeacherDetailInfo(String teacherId);
    TeacherResearchFindings teacherResearchFindings(String teacherId, Integer offset, Integer num);
}
