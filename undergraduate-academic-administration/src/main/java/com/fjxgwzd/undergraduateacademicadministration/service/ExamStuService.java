package com.fjxgwzd.undergraduateacademicadministration.service;

import com.fjxgwzd.undergraduateacademicadministration.entity.ExamStu;
import com.fjxgwzd.undergraduateacademicadministration.vo.StuExamVo;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;

/**
 * (ExamStu)表服务接口
 *
 * @author makejava
 * @since 2024-07-16 06:17:15
 */
public interface ExamStuService {

    /**
     * 通过ID查询单条数据
     *
     * @param id 主键
     * @return 实例对象
     */
    ExamStu queryById(Integer id);

    /**
     * 分页查询
     *
     * @param examStu 筛选条件
     * @param pageRequest      分页对象
     * @return 查询结果
     */
    Page<ExamStu> queryByPage(ExamStu examStu, PageRequest pageRequest);

    /**
     * 新增数据
     *
     * @param examStu 实例对象
     * @return 实例对象
     */
    ExamStu insert(ExamStu examStu);

    /**
     * 修改数据
     *
     * @param examStu 实例对象
     * @return 实例对象
     */
    ExamStu update(ExamStu examStu);

    /**
     * 通过主键删除数据
     *
     * @param id 主键
     * @return 是否成功
     */
    boolean deleteById(Integer id);

    StuExamVo getStuExamVoByStuId(String studentId);
}
