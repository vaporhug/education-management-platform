package com.fjxgwzd.undergraduateacademicadministration.service;

import com.fjxgwzd.undergraduateacademicadministration.entity.Proctor;
import com.fjxgwzd.undergraduateacademicadministration.vo.ProctorExamVo;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;

/**
 * (Proctor)表服务接口
 *
 * @author makejava
 * @since 2024-07-16 03:48:18
 */
public interface ProctorService {

    /**
     * 通过ID查询单条数据
     *
     * @param id 主键
     * @return 实例对象
     */
    Proctor queryById(Integer id);

    /**
     * 分页查询
     *
     * @param proctor 筛选条件
     * @param pageRequest      分页对象
     * @return 查询结果
     */
    Page<Proctor> queryByPage(Proctor proctor, PageRequest pageRequest);

    /**
     * 新增数据
     *
     * @param proctor 实例对象
     * @return 实例对象
     */
    Proctor insert(Proctor proctor);

    /**
     * 修改数据
     *
     * @param proctor 实例对象
     * @return 实例对象
     */
    Proctor update(Proctor proctor);

    /**
     * 通过主键删除数据
     *
     * @param id 主键
     * @return 是否成功
     */
    boolean deleteById(Integer id);

    ProctorExamVo getInvigilationTime(String teacherId) throws Exception;
}
