package com.fjxgwzd.academicmanagement.service;

import com.fjxgwzd.academicmanagement.entity.Teacher;
import com.fjxgwzd.academicmanagement.mapper.TeacherMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserService {
    @Autowired
    private TeacherMapper teacherMapper;


    public Teacher getTeacherById(String id) {
        return teacherMapper.findTeacherById(id);
    }
}
