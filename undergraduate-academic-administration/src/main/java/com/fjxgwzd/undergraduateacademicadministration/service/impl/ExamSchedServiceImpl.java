package com.fjxgwzd.undergraduateacademicadministration.service.impl;

import com.fjxgwzd.undergraduateacademicadministration.entity.ExamSched;
import com.fjxgwzd.undergraduateacademicadministration.dao.ExamSchedDao;
import com.fjxgwzd.undergraduateacademicadministration.service.ExamSchedService;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;



/**
 * (ExamSched)表服务实现类
 *
 * @author makejava
 * @since 2024-07-14 17:30:31
 */
@Service("examSchedService")
public class ExamSchedServiceImpl implements ExamSchedService {
    @Resource
    private ExamSchedDao examSchedDao;

    /**
     * 通过ID查询单条数据
     *
     * @param id 主键
     * @return 实例对象
     */
    @Override
    public ExamSched queryById(Integer id) {
        return this.examSchedDao.queryById(id);
    }

    /**
     * 分页查询
     *
     * @param examSched 筛选条件
     * @param pageRequest      分页对象
     * @return 查询结果
     */
    @Override
    public Page<ExamSched> queryByPage(ExamSched examSched, PageRequest pageRequest) {
        long total = this.examSchedDao.count(examSched);
        return new PageImpl<>(this.examSchedDao.queryAllByLimit(examSched, pageRequest), pageRequest, total);
    }

    /**
     * 新增数据
     *
     * @param examSched 实例对象
     * @return 实例对象
     */
    @Override
    public ExamSched insert(ExamSched examSched) {
        this.examSchedDao.insert(examSched);
        return examSched;
    }

    /**
     * 修改数据
     *
     * @param examSched 实例对象
     * @return 实例对象
     */
    @Override
    public ExamSched update(ExamSched examSched) {
        this.examSchedDao.update(examSched);
        return this.queryById(examSched.getId());
    }

    /**
     * 通过主键删除数据
     *
     * @param id 主键
     * @return 是否成功
     */
    @Override
    public boolean deleteById(Integer id) {
        return this.examSchedDao.deleteById(id) > 0;
    }
}
