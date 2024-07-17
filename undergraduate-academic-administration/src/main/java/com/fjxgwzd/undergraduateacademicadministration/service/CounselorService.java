package com.fjxgwzd.undergraduateacademicadministration.service;

import com.fjxgwzd.undergraduateacademicadministration.entity.Counselor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;

/**
 * (Counselor)表服务接口
 *
 * @author makejava
 * @since 2024-07-14 13:49:14
 */
public interface CounselorService {

    /**
     * 通过ID查询单条数据
     *
     * @param id 主键
     * @return 实例对象
     */
    Counselor queryById(String id);

    /**
     * 分页查询
     *
     * @param counselor 筛选条件
     * @param pageRequest      分页对象
     * @return 查询结果
     */
    Page<Counselor> queryByPage(Counselor counselor, PageRequest pageRequest);

    /**
     * 新增数据
     *
     * @param counselor 实例对象
     * @return 实例对象
     */
    Counselor insert(Counselor counselor);

    /**
     * 修改数据
     *
     * @param counselor 实例对象
     * @return 实例对象
     */
    Counselor update(Counselor counselor);

    /**
     * 通过主键删除数据
     *
     * @param id 主键
     * @return 是否成功
     */
    boolean deleteById(String id);

}
