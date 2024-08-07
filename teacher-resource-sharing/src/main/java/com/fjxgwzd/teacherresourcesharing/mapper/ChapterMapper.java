package com.fjxgwzd.teacherresourcesharing.mapper;

import com.fjxgwzd.teacherresourcesharing.entity.File;
import com.fjxgwzd.teacherresourcesharing.entity.Semester;
import com.fjxgwzd.teacherresourcesharing.vo.*;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Mapper
public interface ChapterMapper {
    // 通过传入的文件和chapter的id，搜索teaching_material中的for_chapter唯一的号，再连接file的id，搜索file中相同的hash
    //@Select("SELECT EXISTS( SELECT 1  FROM file WHERE hash = #{hash} )")
    boolean findByHash(String hash);
    // 通过传入的chapter的id，找到它对应的课程号
    String findCourseIdByChapterId(Integer chapterId);

    // deleteFile中的内容
    // 查询到对应的文件，之后可以进行删除
    File getFileByChapterId(Integer chapterId);
    boolean removeTeachingMaterialByChapterId(Integer chapterId);
    boolean removeFileByFileId(Integer fileId);
    List<CourseInfoVO> findCourseInstByTeacherId(String teacherId, Integer year, boolean termPart);
//    // 修改为两部分内容，一部分为获取该课程的基础信息，另一部分为获取该课程的所有章节信息，以实现正确查询
//    CourseDetalVO findCourseDetalByCourseInstId(@Param("courseInstId") Integer courseInstId);
    CourseDetalVO findCourseBasicDetailByChapterId(Integer chapterId);
    List<ChapterVO> findParentChapter(Integer courseId);
    List<ChapterVO> findMaterialByCourseIdParent(Integer courseId, Integer parentId);
    // 将最后返回结果由本部分代码进行拼接合并返回
    void insertFileDetails(Map<String, Object> params);
    Integer teacherMaterialId(Map<String, Object> params);
    void insertTeachingMaterial(Map<String, Object> params);
    List<schoolMajorList> getSchool();
    List<MajorVO> getMajorList(Short schoolId);
    List<Semester> getAllSemester();
    List<CampusVO> getCampusVO();
}
