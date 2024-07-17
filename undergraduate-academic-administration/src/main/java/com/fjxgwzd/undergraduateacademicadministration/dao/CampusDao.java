package com.fjxgwzd.undergraduateacademicadministration.dao;

import com.fjxgwzd.undergraduateacademicadministration.entity.Campus;
import org.apache.ibatis.annotations.Param;
import org.springframework.data.domain.Pageable;
import java.util.List;

/**
 * (Campus)表数据库访问层
 *
 * @author makejava
 * @since 2024-07-14 13:49:15
 */
public interface CampusDao {

    /**
     * 通过ID查询单条数据
     *
     * @param id 主键
     * @return 实例对象
     */
    Campus queryById(short id);

    /**
     * 查询指定行数据
     *
     * @param campus 查询条件
     * @param pageable         分页对象
     * @return 对象列表
     */
    List<Campus> queryAllByLimit(Campus campus, @Param("pageable") Pageable pageable);

    /**
     * 统计总行数
     *
     * @param campus 查询条件
     * @return 总行数
     */
    long count(Campus campus);

    /**
     * 新增数据
     *
     * @param campus 实例对象
     * @return 影响行数
     */
    int insert(Campus campus);

    /**
     * 批量新增数据（MyBatis原生foreach方法）
     *
     * @param entities List<Campus> 实例对象列表
     * @return 影响行数
     */
    int insertBatch(@Param("entities") List<Campus> entities);

    /**
     * 批量新增或按主键更新数据（MyBatis原生foreach方法）
     *
     * @param entities List<Campus> 实例对象列表
     * @return 影响行数
     * @throws org.springframework.jdbc.BadSqlGrammarException 入参是空List的时候会抛SQL语句错误的异常，请自行校验入参
     */
    int insertOrUpdateBatch(@Param("entities") List<Campus> entities);

    /**
     * 修改数据
     *
     * @param campus 实例对象
     * @return 影响行数
     */
    int update(Campus campus);

    /**
     * 通过主键删除数据
     *
     * @param id 主键
     * @return 影响行数
     */
    int deleteById(Integer id);

}

