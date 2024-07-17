package com.fjxgwzd.undergraduateacademicadministration.dao;

import com.fjxgwzd.undergraduateacademicadministration.entity.StuCourseSched;
import com.fjxgwzd.undergraduateacademicadministration.vo.AttendanceStudentVO;
import org.apache.ibatis.annotations.Param;
import org.springframework.data.domain.Pageable;

import java.util.ArrayList;
import java.util.List;

/**
 * (StuCourseSched)表数据库访问层
 *
 * @author makejava
 * @since 2024-07-16 11:21:42
 */
public interface StuCourseSchedDao {

    /**
     * 通过ID查询单条数据
     *
     * @param id 主键
     * @return 实例对象
     */
    StuCourseSched queryById(Integer id);

    /**
     * 查询指定行数据
     *
     * @param stuCourseSched 查询条件
     * @param pageable         分页对象
     * @return 对象列表
     */
    List<StuCourseSched> queryAllByLimit(StuCourseSched stuCourseSched, @Param("pageable") Pageable pageable);

    /**
     * 统计总行数
     *
     * @param stuCourseSched 查询条件
     * @return 总行数
     */
    long count(StuCourseSched stuCourseSched);

    /**
     * 新增数据
     *
     * @param stuCourseSched 实例对象
     * @return 影响行数
     */
    int insert(StuCourseSched stuCourseSched);

    /**
     * 批量新增数据（MyBatis原生foreach方法）
     *
     * @param entities List<StuCourseSched> 实例对象列表
     * @return 影响行数
     */
    int insertBatch(@Param("entities") List<StuCourseSched> entities);

    /**
     * 批量新增或按主键更新数据（MyBatis原生foreach方法）
     *
     * @param entities List<StuCourseSched> 实例对象列表
     * @return 影响行数
     * @throws org.springframework.jdbc.BadSqlGrammarException 入参是空List的时候会抛SQL语句错误的异常，请自行校验入参
     */
    int insertOrUpdateBatch(@Param("entities") List<StuCourseSched> entities);

    /**
     * 修改数据
     *
     * @param stuCourseSched 实例对象
     * @return 影响行数
     */
    int update(StuCourseSched stuCourseSched);

    /**
     * 通过主键删除数据
     *
     * @param id 主键
     * @return 影响行数
     */
    int deleteById(Integer id);


    List<AttendanceStudentVO> getCourseNumByWeek(@Param("stuId") String stuId, @Param("year") Integer year, @Param("termPart") Boolean termPart);

    List<AttendanceStudentVO> getAttendanceByStuId(@Param("stuId") String stuId, @Param("year") Integer year,@Param("termPart") Boolean termPart);

    List<AttendanceStudentVO> getCourseNumByWeekTea(@Param("teacherId") String teacherId, @Param("year") Integer year,@Param("termPart") Boolean termPart);

    List<AttendanceStudentVO> getAttendanceByTeaId(@Param("teacherId") String teacherId, @Param("year") Integer year,@Param("termPart") Boolean termPart);

    List<AttendanceStudentVO> getCourseNumByWeekStu(@Param("year") Integer year,@Param("termPart") Boolean termPart);

    List<AttendanceStudentVO> getAttendanceByWeekStu(@Param("year") Integer year,@Param("termPart") Boolean termPart);

    List<AttendanceStudentVO> getCourseNumByWeekTeacher(@Param("year") Integer year,@Param("termPart") Boolean termPart);

    List<AttendanceStudentVO> getAttendanceByWeekTeacher(@Param("year") Integer year,@Param("termPart") Boolean termPart);

}

