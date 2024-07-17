package com.fjxgwzd.undergraduateacademicadministration.service.impl;

import com.fjxgwzd.undergraduateacademicadministration.entity.StuCourseSched;
import com.fjxgwzd.undergraduateacademicadministration.dao.StuCourseSchedDao;
import com.fjxgwzd.undergraduateacademicadministration.service.StuCourseSchedService;
import com.fjxgwzd.undergraduateacademicadministration.vo.AttendanceStudentVO;
import com.fjxgwzd.undergraduateacademicadministration.vo.TotalAttendanceVo;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * (StuCourseSched)表服务实现类
 *
 * @author makejava
 * @since 2024-07-16 11:21:42
 */
@Service("stuCourseSchedService")
public class StuCourseSchedServiceImpl implements StuCourseSchedService {
    @Resource
    private StuCourseSchedDao stuCourseSchedDao;

    /**
     * 通过ID查询单条数据
     *
     * @param id 主键
     * @return 实例对象
     */
    @Override
    public StuCourseSched queryById(Integer id) {
        return this.stuCourseSchedDao.queryById(id);
    }

    /**
     * 分页查询
     *
     * @param stuCourseSched 筛选条件
     * @param pageRequest      分页对象
     * @return 查询结果
     */
    @Override
    public Page<StuCourseSched> queryByPage(StuCourseSched stuCourseSched, PageRequest pageRequest) {
        long total = this.stuCourseSchedDao.count(stuCourseSched);
        return new PageImpl<>(this.stuCourseSchedDao.queryAllByLimit(stuCourseSched, pageRequest), pageRequest, total);
    }

    /**
     * 新增数据
     *
     * @param stuCourseSched 实例对象
     * @return 实例对象
     */
    @Override
    public StuCourseSched insert(StuCourseSched stuCourseSched) {
        this.stuCourseSchedDao.insert(stuCourseSched);
        return stuCourseSched;
    }

    /**
     * 修改数据
     *
     * @param stuCourseSched 实例对象
     * @return 实例对象
     */
    @Override
    public StuCourseSched update(StuCourseSched stuCourseSched) {
        this.stuCourseSchedDao.update(stuCourseSched);
        return this.queryById(stuCourseSched.getId());
    }

    /**
     * 通过主键删除数据
     *
     * @param id 主键
     * @return 是否成功
     */
    @Override
    public boolean deleteById(Integer id) {
        return this.stuCourseSchedDao.deleteById(id) > 0;
    }

    @Override
    public int[] getStuAttendanceByStuId(String stuId, Integer year, Boolean termPart) {

        List<AttendanceStudentVO> courseNumByWeek =  this.stuCourseSchedDao.getCourseNumByWeek(stuId,year,termPart);
        List<AttendanceStudentVO> attendanceNum = this.stuCourseSchedDao.getAttendanceByStuId(stuId,year,termPart);
        int[] attendance = new int[18];
        for (int i=0;i<18;i++){
            attendance[i] = 100;
        }
        for (AttendanceStudentVO attendanceStudentVO : courseNumByWeek){
            // 总课程列表
            for(AttendanceStudentVO attendanceStudentVO1 : attendanceNum){
                //实际到课列表
                if(attendanceStudentVO.getWeek() == attendanceStudentVO1.getWeek()){
                    attendance[attendanceStudentVO.getWeek()-1] = (int)  (attendanceStudentVO1.getSum().doubleValue() / attendanceStudentVO.getSum() * 100);
                }
            }
        }
        return attendance;
    }

    @Override
    public int[] getTeaAttendanceByTeaId(String teacherId, Integer year, Boolean termPart) {
        List<AttendanceStudentVO> courseNumByWeek = this.stuCourseSchedDao.getCourseNumByWeekTea(teacherId,year,termPart);
        List<AttendanceStudentVO> attendanceNum = this.stuCourseSchedDao.getAttendanceByTeaId(teacherId,year,termPart);
        int[] attendance = new int[18];
        for (int i=0;i<18;i++){
            attendance[i] = 100;
        }
        for (AttendanceStudentVO attendanceStudentVO : courseNumByWeek){
            // 总课程列表
            for(AttendanceStudentVO attendanceStudentVO1 : attendanceNum){
                //实际到课列表
                if(attendanceStudentVO.getWeek() == attendanceStudentVO1.getWeek()){
                    attendance[attendanceStudentVO.getWeek()-1] = (int)  (attendanceStudentVO1.getSum().doubleValue() / attendanceStudentVO.getSum() * 100);
                }
            }
        }
        return attendance;
    }

    @Override
    public TotalAttendanceVo getToatalAttendance(Integer year, Boolean termPart) {
        TotalAttendanceVo totalAttendanceVo = new TotalAttendanceVo();

        List<AttendanceStudentVO> courseNumByWeek = this.stuCourseSchedDao.getCourseNumByWeekStu(year,termPart);
        List<AttendanceStudentVO> attendanceNum = this.stuCourseSchedDao.getAttendanceByWeekStu(year,termPart);
        int[] attendanceStu = new int[18];
        for (int i=0;i<18;i++){
            attendanceStu[i] = 100;
        }
        for (AttendanceStudentVO attendanceStudentVO : courseNumByWeek){
            // 总课程列表
            for(AttendanceStudentVO attendanceStudentVO1 : attendanceNum){
                //实际到课列表
                if(attendanceStudentVO.getWeek() == attendanceStudentVO1.getWeek()){
                    attendanceStu[attendanceStudentVO.getWeek()-1] = (int)  (attendanceStudentVO1.getSum().doubleValue() / attendanceStudentVO.getSum() * 100);
                }
            }
        }



        courseNumByWeek = this.stuCourseSchedDao.getCourseNumByWeekTeacher(year,termPart);
        attendanceNum = this.stuCourseSchedDao.getAttendanceByWeekTeacher(year,termPart);
        int[] attendanceTea = new int[18];
        for (int i=0;i<18;i++){
            attendanceTea[i] = 100;
        }
        for (AttendanceStudentVO attendanceStudentVO : courseNumByWeek){
            // 总课程列表
            for(AttendanceStudentVO attendanceStudentVO1 : attendanceNum){
                //实际到课列表
                if(attendanceStudentVO.getWeek() == attendanceStudentVO1.getWeek()){
                    attendanceTea[attendanceStudentVO.getWeek()-1] = (int)  (attendanceStudentVO1.getSum().doubleValue() / attendanceStudentVO.getSum() * 100);
                }
            }
        }
        totalAttendanceVo.setStuRates(attendanceStu);
        totalAttendanceVo.setTeaRates(attendanceTea);
        return totalAttendanceVo;
    }


}
