package com.fjxgwzd.undergraduateacademicadministration.service.impl;

import com.fjxgwzd.undergraduateacademicadministration.entity.Counselor;
import com.fjxgwzd.undergraduateacademicadministration.dao.CounselorDao;
import com.fjxgwzd.undergraduateacademicadministration.service.CounselorService;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;



/**
 * (Counselor)表服务实现类
 *
 * @author makejava
 * @since 2024-07-14 13:49:14
 */
@Service("counselorService")
public class CounselorServiceImpl implements CounselorService {
    @Resource
    private CounselorDao counselorDao;

    /**
     * 通过ID查询单条数据
     *
     * @param id 主键
     * @return 实例对象
     */
    @Override
    public Counselor queryById(String id) {
        return this.counselorDao.queryById(id);
    }

    /**
     * 分页查询
     *
     * @param counselor 筛选条件
     * @param pageRequest      分页对象
     * @return 查询结果
     */
    @Override
    public Page<Counselor> queryByPage(Counselor counselor, PageRequest pageRequest) {
        long total = this.counselorDao.count(counselor);
        return new PageImpl<>(this.counselorDao.queryAllByLimit(counselor, pageRequest), pageRequest, total);
    }

    /**
     * 新增数据
     *
     * @param counselor 实例对象
     * @return 实例对象
     */
    @Override
    public Counselor insert(Counselor counselor) {
        this.counselorDao.insert(counselor);
        return counselor;
    }

    /**
     * 修改数据
     *
     * @param counselor 实例对象
     * @return 实例对象
     */
    @Override
    public Counselor update(Counselor counselor) {
        this.counselorDao.update(counselor);
        return this.queryById(counselor.getId());
    }

    /**
     * 通过主键删除数据
     *
     * @param id 主键
     * @return 是否成功
     */
    @Override
    public boolean deleteById(String id) {
        return this.counselorDao.deleteById(id) > 0;
    }
}
