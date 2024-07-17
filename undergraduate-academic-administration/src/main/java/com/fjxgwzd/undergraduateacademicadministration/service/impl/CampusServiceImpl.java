package com.fjxgwzd.undergraduateacademicadministration.service.impl;

import com.fjxgwzd.undergraduateacademicadministration.entity.Campus;
import com.fjxgwzd.undergraduateacademicadministration.dao.CampusDao;
import com.fjxgwzd.undergraduateacademicadministration.service.CampusService;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;


/**
 * (Campus)表服务实现类
 *
 * @author makejava
 * @since 2024-07-14 13:49:15
 */
@Service("campusService")
public class CampusServiceImpl implements CampusService {
    @Resource
    private CampusDao campusDao;

    /**
     * 通过ID查询单条数据
     *
     * @param id 主键
     * @return 实例对象
     */
    @Override
    public Campus queryById(short id) {
        return this.campusDao.queryById(id);
    }

    /**
     * 分页查询
     *
     * @param campus 筛选条件
     * @param pageRequest      分页对象
     * @return 查询结果
     */
    @Override
    public Page<Campus> queryByPage(Campus campus, PageRequest pageRequest) {
        long total = this.campusDao.count(campus);
        return new PageImpl<>(this.campusDao.queryAllByLimit(campus, pageRequest), pageRequest, total);
    }

    /**
     * 新增数据
     *
     * @param campus 实例对象
     * @return 实例对象
     */
    @Override
    public Campus insert(Campus campus) {
        this.campusDao.insert(campus);
        return campus;
    }

    /**
     * 修改数据
     *
     * @param campus 实例对象
     * @return 实例对象
     */
    @Override
    public Campus update(Campus campus) {
        this.campusDao.update(campus);
        return this.queryById(campus.getId());
    }

    /**
     * 通过主键删除数据
     *
     * @param id 主键
     * @return 是否成功
     */
    @Override
    public boolean deleteById(Integer id) {
        return this.campusDao.deleteById(id) > 0;
    }
}
