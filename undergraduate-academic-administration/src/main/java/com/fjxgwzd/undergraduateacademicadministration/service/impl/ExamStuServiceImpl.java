package com.fjxgwzd.undergraduateacademicadministration.service.impl;

import com.fjxgwzd.undergraduateacademicadministration.entity.ExamStu;
import com.fjxgwzd.undergraduateacademicadministration.dao.ExamStuDao;
import com.fjxgwzd.undergraduateacademicadministration.service.ExamStuService;
import com.fjxgwzd.undergraduateacademicadministration.vo.ProctorExamVo;
import com.fjxgwzd.undergraduateacademicadministration.vo.StuExamVo;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;



/**
 * (ExamStu)表服务实现类
 *
 * @author makejava
 * @since 2024-07-16 06:17:15
 */
@Service("examStuService")
public class ExamStuServiceImpl implements ExamStuService {
    @Resource
    private ExamStuDao examStuDao;

    /**
     * 通过ID查询单条数据
     *
     * @param id 主键
     * @return 实例对象
     */
    @Override
    public ExamStu queryById(Integer id) {
        return this.examStuDao.queryById(id);
    }

    /**
     * 分页查询
     *
     * @param examStu 筛选条件
     * @param pageRequest      分页对象
     * @return 查询结果
     */
    @Override
    public Page<ExamStu> queryByPage(ExamStu examStu, PageRequest pageRequest) {
        long total = this.examStuDao.count(examStu);
        return new PageImpl<>(this.examStuDao.queryAllByLimit(examStu, pageRequest), pageRequest, total);
    }

    /**
     * 新增数据
     *
     * @param examStu 实例对象
     * @return 实例对象
     */
    @Override
    public ExamStu insert(ExamStu examStu) {
        this.examStuDao.insert(examStu);
        return examStu;
    }

    /**
     * 修改数据
     *
     * @param examStu 实例对象
     * @return 实例对象
     */
    @Override
    public ExamStu update(ExamStu examStu) {
        this.examStuDao.update(examStu);
        return this.queryById(examStu.getId());
    }

    /**
     * 通过主键删除数据
     *
     * @param id 主键
     * @return 是否成功
     */
    @Override
    public boolean deleteById(Integer id) {
        return this.examStuDao.deleteById(id) > 0;
    }

    @Override
    public StuExamVo getStuExamVoByStuId(String studentId) {
        StuExamVo StuExamVo = new StuExamVo();
        StuExamVo.setNowYear(this.examStuDao.getYear(studentId));
        StuExamVo.setNowTermPart(this.examStuDao.getTermPart(studentId));
        StuExamVo.setExams(this.examStuDao.getExams(studentId));
        return StuExamVo;
    }
}
