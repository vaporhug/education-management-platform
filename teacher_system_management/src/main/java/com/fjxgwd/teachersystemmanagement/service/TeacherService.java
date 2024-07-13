package com.fjxgwd.teachersystemmanagement.service;

import com.fjxgwd.teachersystemmanagement.vo.TeacherDetailInfoVO;
import com.fjxgwd.teachersystemmanagement.vo.TeacherResearchFindings;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

public interface TeacherService {
    TeacherDetailInfoVO getTeacherDetailInfo(String teacherId);
    TeacherResearchFindings teacherResearchFindings(String teacherId, Integer offset, Integer num);
}
