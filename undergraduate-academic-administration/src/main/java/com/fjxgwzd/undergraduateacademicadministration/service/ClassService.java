package com.fjxgwzd.undergraduateacademicadministration.service;

import com.fjxgwzd.undergraduateacademicadministration.entity.Class;
import com.fjxgwzd.undergraduateacademicadministration.vo.TotalClassDetailVo;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.web.bind.annotation.RequestParam;

/**
 * (Class)表服务接口
 *
 * @author makejava
 * @since 2024-07-14 13:49:14
 */
public interface ClassService {

    TotalClassDetailVo getTotalClassDetail(Integer schoolId,Integer majorId,Integer startYear,
                                           int offset, int num);
    /**
     * 通过ID查询单条数据
     *
     * @param id 主键
     * @return 实例对象
     */
    Class queryById(Integer id);

    /**
     * 分页查询
     *
     * @param classes 筛选条件
     * @param pageRequest      分页对象
     * @return 查询结果
     */
    Page<Class> queryByPage(Class classes, PageRequest pageRequest);

    /**
     * 新增数据
     *
     * @param classes 实例对象
     * @return 实例对象
     */
    Class insert(Class classes);

    /**
     * 修改数据
     *
     * @param classes 实例对象
     * @return 实例对象
     */
    Class update(Class classes);

    /**
     * 通过主键删除数据
     *
     * @param id 主键
     * @return 是否成功
     */
    boolean deleteById(Integer id);

}
