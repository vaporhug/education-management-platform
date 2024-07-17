package com.fjxgwzd.undergraduateacademicadministration.service;

import com.fjxgwzd.undergraduateacademicadministration.entity.Campus;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;

/**
 * (Campus)表服务接口
 *
 * @author makejava
 * @since 2024-07-14 13:49:15
 */
public interface CampusService {

    /**
     * 通过ID查询单条数据
     *
     * @param id 主键
     * @return 实例对象
     */
    Campus queryById(short id);

    /**
     * 分页查询
     *
     * @param campus 筛选条件
     * @param pageRequest      分页对象
     * @return 查询结果
     */
    Page<Campus> queryByPage(Campus campus, PageRequest pageRequest);

    /**
     * 新增数据
     *
     * @param campus 实例对象
     * @return 实例对象
     */
    Campus insert(Campus campus);

    /**
     * 修改数据
     *
     * @param campus 实例对象
     * @return 实例对象
     */
    Campus update(Campus campus);

    /**
     * 通过主键删除数据
     *
     * @param id 主键
     * @return 是否成功
     */
    boolean deleteById(Integer id);

}
