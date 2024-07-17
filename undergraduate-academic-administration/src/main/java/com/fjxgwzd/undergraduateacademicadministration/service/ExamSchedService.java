package com.fjxgwzd.undergraduateacademicadministration.service;

import com.fjxgwzd.undergraduateacademicadministration.entity.ExamSched;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;

/**
 * (ExamSched)表服务接口
 *
 * @author makejava
 * @since 2024-07-14 17:30:31
 */
public interface ExamSchedService {

    /**
     * 通过ID查询单条数据
     *
     * @param id 主键
     * @return 实例对象
     */
    ExamSched queryById(Integer id);

    /**
     * 分页查询
     *
     * @param examSched 筛选条件
     * @param pageRequest      分页对象
     * @return 查询结果
     */
    Page<ExamSched> queryByPage(ExamSched examSched, PageRequest pageRequest);

    /**
     * 新增数据
     *
     * @param examSched 实例对象
     * @return 实例对象
     */
    ExamSched insert(ExamSched examSched);

    /**
     * 修改数据
     *
     * @param examSched 实例对象
     * @return 实例对象
     */
    ExamSched update(ExamSched examSched);

    /**
     * 通过主键删除数据
     *
     * @param id 主键
     * @return 是否成功
     */
    boolean deleteById(Integer id);

}
