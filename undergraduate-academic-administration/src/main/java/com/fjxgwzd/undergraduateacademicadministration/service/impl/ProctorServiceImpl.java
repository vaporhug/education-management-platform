package com.fjxgwzd.undergraduateacademicadministration.service.impl;

import com.fjxgwzd.undergraduateacademicadministration.entity.Proctor;
import com.fjxgwzd.undergraduateacademicadministration.dao.ProctorDao;
import com.fjxgwzd.undergraduateacademicadministration.entity.Semester;
import com.fjxgwzd.undergraduateacademicadministration.service.ProctorService;
import com.fjxgwzd.undergraduateacademicadministration.vo.ProctorExamVo;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.chrono.ChronoLocalDate;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Objects;


/**
 * (Proctor)表服务实现类
 *
 * @author makejava
 * @since 2024-07-16 03:48:18
 */
@Service("proctorService")
public class ProctorServiceImpl implements ProctorService {
    @Resource
    private ProctorDao proctorDao;

    /**
     * 通过ID查询单条数据
     *
     * @param id 主键
     * @return 实例对象
     */
    @Override
    public Proctor queryById(Integer id) {
        return this.proctorDao.queryById(id);
    }

    /**
     * 分页查询
     *
     * @param proctor 筛选条件
     * @param pageRequest      分页对象
     * @return 查询结果
     */
    @Override
    public Page<Proctor> queryByPage(Proctor proctor, PageRequest pageRequest) {
        long total = this.proctorDao.count(proctor);
        return new PageImpl<>(this.proctorDao.queryAllByLimit(proctor, pageRequest), pageRequest, total);
    }

    /**
     * 新增数据
     *
     * @param proctor 实例对象
     * @return 实例对象
     */
    @Override
    public Proctor insert(Proctor proctor) {
        this.proctorDao.insert(proctor);
        return proctor;
    }

    /**
     * 修改数据
     *
     * @param proctor 实例对象
     * @return 实例对象
     */
    @Override
    public Proctor update(Proctor proctor) {
        this.proctorDao.update(proctor);
        return this.queryById(proctor.getId());
    }

    /**
     * 通过主键删除数据
     *
     * @param id 主键
     * @return 是否成功
     */
    @Override
    public boolean deleteById(Integer id) {
        return this.proctorDao.deleteById(id) > 0;
    }

    @Override
    public ProctorExamVo getInvigilationTime(String teacherId) throws Exception {

        ProctorExamVo proctorExamVo = new ProctorExamVo();


        // 1、根据LocalDateTime获取当前学期
        LocalDateTime currentTime = LocalDateTime.now();
        LocalDate currentDate = currentTime.toLocalDate();
        // 1.1、由年份先判断应该是哪个学期
        Integer currentYear = currentDate.getYear();
        List<Semester> semesters = new ArrayList<>();
        List<Semester> semesterList = this.proctorDao.getAllSemester();

        for (Semester semester : semesterList) {
            if (Objects.equals(semester.getYear(), currentYear)) {
                semesters.add(semester);
            }
        }
        // 1.2、根据当前时间，获取学期

        Semester currentSemester = null;
        if(currentDate.isBefore(ChronoLocalDate.from(semesterList.get(0).getFrom_date()))){
            // 小于第一个
            currentSemester = semesterList.get(0);
        }
        else if (currentDate.isBefore(ChronoLocalDate.from(semesterList.get(1).getTo_date()))){
            currentSemester = semesterList.get(1);
        }else {
            for(int i =0; i < semesterList.size(); i++){
                if(semesterList.get(i).equals(semesterList.get(1))){
                    if(i+1 < semesterList.size()){
                        currentSemester = semesterList.get(i+1);
                        break;
                    }else {
                        throw new Exception();
                    }
                }
            }
        }
        System.out.println(currentSemester.getYear());

        proctorExamVo.setYear(currentSemester.getYear());
        proctorExamVo.setTermPart(currentSemester.isTerm_part());

        proctorExamVo.setExams(this.proctorDao.getExams(proctorExamVo.getYear(),proctorExamVo.getTermPart(),teacherId));
        return proctorExamVo;
    }
}
