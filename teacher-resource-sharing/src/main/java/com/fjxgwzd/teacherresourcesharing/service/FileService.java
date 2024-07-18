package com.fjxgwzd.teacherresourcesharing.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fjxgwzd.teacherresourcesharing.vo.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface FileService {
    String upload(MultipartFile file, Integer chapterId, String uploaderId) throws Exception;
    String deleteFile(Integer chapterId) throws Exception;
    CourseDetalVO courseDetailsInfo(Integer courseInstId) throws JsonProcessingException;
    List<Chapter1List> chapterList(Integer courseInstId) throws JsonProcessingException;
    List<schoolMajorList> getSchoolMajorList() throws JsonProcessingException;
    BasicInfoVO getBasicInfo() throws Exception;
}
