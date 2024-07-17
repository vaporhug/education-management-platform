package com.fjxgwzd.undergraduateacademicadministration.service;

import com.fjxgwzd.undergraduateacademicadministration.entity.StuCourseSched;
import com.fjxgwzd.undergraduateacademicadministration.vo.TotalAttendanceVo;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;

/**
 * (StuCourseSched)表服务接口
 *
 * @author makejava
 * @since 2024-07-16 11:21:42
 */
public interface StuCourseSchedService {

    /**
     * 通过ID查询单条数据
     *
     * @param id 主键
     * @return 实例对象
     */
    StuCourseSched queryById(Integer id);

    /**
     * 分页查询
     *
     * @param stuCourseSched 筛选条件
     * @param pageRequest      分页对象
     * @return 查询结果
     */
    Page<StuCourseSched> queryByPage(StuCourseSched stuCourseSched, PageRequest pageRequest);

    /**
     * 新增数据
     *
     * @param stuCourseSched 实例对象
     * @return 实例对象
     */
    StuCourseSched insert(StuCourseSched stuCourseSched);

    /**
     * 修改数据
     *
     * @param stuCourseSched 实例对象
     * @return 实例对象
     */
    StuCourseSched update(StuCourseSched stuCourseSched);

    /**
     * 通过主键删除数据
     *
     * @param id 主键
     * @return 是否成功
     */
    boolean deleteById(Integer id);

    int[] getStuAttendanceByStuId(String stuId, Integer year, Boolean termPart);

    int[] getTeaAttendanceByTeaId(String teacherId, Integer year, Boolean termPart);

    TotalAttendanceVo getToatalAttendance(Integer year, Boolean termPart);
}
