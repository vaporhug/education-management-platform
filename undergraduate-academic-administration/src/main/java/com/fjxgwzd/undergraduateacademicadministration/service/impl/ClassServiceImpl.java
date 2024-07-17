package com.fjxgwzd.undergraduateacademicadministration.service.impl;

import com.fjxgwzd.undergraduateacademicadministration.entity.Class;
import com.fjxgwzd.undergraduateacademicadministration.dao.ClassDao;
import com.fjxgwzd.undergraduateacademicadministration.service.ClassService;
import com.fjxgwzd.undergraduateacademicadministration.vo.ClassDetailVo;
import com.fjxgwzd.undergraduateacademicadministration.vo.TotalClassDetailVo;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;

import java.util.List;


/**
 * (Class)表服务实现类
 *
 * @author makejava
 * @since 2024-07-14 13:49:14
 */
@Service("classService")
public class ClassServiceImpl implements ClassService {
    @Resource
    private ClassDao classDao;

    /**
     * 通过ID查询单条数据
     *
     * @param id 主键
     * @return 实例对象
     */
    @Override
    public Class queryById(Integer id) {
        return this.classDao.queryById(id);
    }

    /**
     * 分页查询
     *
     * @param classes 筛选条件
     * @param pageRequest      分页对象
     * @return 查询结果
     */
    @Override
    public Page<Class> queryByPage(Class classes, PageRequest pageRequest) {
        long total = this.classDao.count(classes);
        return new PageImpl<>(this.classDao.queryAllByLimit(classes, pageRequest), pageRequest, total);
    }

    /**
     * 新增数据
     *
     * @param classes 实例对象
     * @return 实例对象
     */
    @Override
    public Class insert(Class classes) {
        this.classDao.insert(classes);
        return classes;
    }

    /**
     * 修改数据
     *
     * @param classes 实例对象
     * @return 实例对象
     */
    @Override
    public Class update(Class classes) {
        this.classDao.update(classes);
        return this.queryById(classes.getId());
    }

    /**
     * 通过主键删除数据
     *
     * @param id 主键
     * @return 是否成功
     */
    @Override
    public boolean deleteById(Integer id) {
        return this.classDao.deleteById(id) > 0;
    }

    @Override
    public TotalClassDetailVo getTotalClassDetail(Integer schoolId, Integer majorId, Integer startYear,
                                           int offset, int num){
        TotalClassDetailVo totalClassDetailVo= new TotalClassDetailVo();
        Integer sum = this.classDao.getSum(schoolId,majorId,startYear);
        totalClassDetailVo.setSum(sum);
        List<ClassDetailVo> classDetailVos = this.classDao.getTotalClassDetailDao(schoolId,majorId,startYear,offset,num);
        totalClassDetailVo.setClasses(classDetailVos);
        return totalClassDetailVo;
    }
}
