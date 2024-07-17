package com.fjxgwzd.undergraduateacademicadministration.dao;

import com.fjxgwzd.undergraduateacademicadministration.entity.Class;
import com.fjxgwzd.undergraduateacademicadministration.vo.ClassDetailVo;
import org.apache.ibatis.annotations.Param;
import org.springframework.data.domain.Pageable;
import java.util.List;

/**
 * (Class)表数据库访问层
 *
 * @author makejava
 * @since 2024-07-15 10:14:58
 */
public interface ClassDao {

    /**
     * 通过ID查询单条数据
     *
     * @param id 主键
     * @return 实例对象
     */
    Class queryById(Integer id);

    /**
     * 查询指定行数据
     *
     * @param classes 查询条件
     * @param pageable         分页对象
     * @return 对象列表
     */
    List<Class> queryAllByLimit(@Param("class") Class classes, @Param("pageable") Pageable pageable);

    /**
     * 统计总行数
     *
     * @param classes 查询条件
     * @return 总行数
     */
    long count(Class classes);

    /**
     * 新增数据
     *
     * @param classes 实例对象
     * @return 影响行数
     */
    int insert(Class classes);

    /**
     * 批量新增数据（MyBatis原生foreach方法）
     *
     * @param entities List<Class> 实例对象列表
     * @return 影响行数
     */
    int insertBatch(@Param("entities") List<Class> entities);

    /**
     * 批量新增或按主键更新数据（MyBatis原生foreach方法）
     *
     * @param entities List<Class> 实例对象列表
     * @return 影响行数
     * @throws org.springframework.jdbc.BadSqlGrammarException 入参是空List的时候会抛SQL语句错误的异常，请自行校验入参
     */
    int insertOrUpdateBatch(@Param("entities") List<Class> entities);

    /**
     * 修改数据
     *
     * @param classes 实例对象
     * @return 影响行数
     */
    int update(Class classes);

    /**
     * 通过主键删除数据
     *
     * @param id 主键
     * @return 影响行数
     */
    int deleteById(Integer id);

    Integer getSum(@Param("schoolId") Integer schoolId, @Param("majorId") Integer majorId, @Param("startYear") Integer startYear);
    List<ClassDetailVo> getTotalClassDetailDao(@Param("schoolId") Integer schoolId, @Param("majorId") Integer majorId, @Param("startYear") Integer startYear,
                                            @Param("offset") int offset, @Param("num") int num);
}

