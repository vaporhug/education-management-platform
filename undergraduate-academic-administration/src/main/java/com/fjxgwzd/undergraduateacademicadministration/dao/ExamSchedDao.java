package com.fjxgwzd.undergraduateacademicadministration.dao;

import com.fjxgwzd.undergraduateacademicadministration.entity.ExamSched;
import org.apache.ibatis.annotations.Param;
import org.springframework.data.domain.Pageable;
import java.util.List;

/**
 * (ExamSched)表数据库访问层
 *
 * @author makejava
 * @since 2024-07-18 02:54:34
 */
public interface ExamSchedDao {

    /**
     * 通过ID查询单条数据
     *
     * @param id 主键
     * @return 实例对象
     */
    ExamSched queryById(Integer id);

    /**
     * 查询指定行数据
     *
     * @param examSched 查询条件
     * @param pageable         分页对象
     * @return 对象列表
     */
    List<ExamSched> queryAllByLimit(ExamSched examSched, @Param("pageable") Pageable pageable);

    /**
     * 统计总行数
     *
     * @param examSched 查询条件
     * @return 总行数
     */
    long count(ExamSched examSched);

    /**
     * 新增数据
     *
     * @param examSched 实例对象
     * @return 影响行数
     */
    int insert(ExamSched examSched);

    /**
     * 批量新增数据（MyBatis原生foreach方法）
     *
     * @param entities List<ExamSched> 实例对象列表
     * @return 影响行数
     */
    int insertBatch(@Param("entities") List<ExamSched> entities);

    /**
     * 批量新增或按主键更新数据（MyBatis原生foreach方法）
     *
     * @param entities List<ExamSched> 实例对象列表
     * @return 影响行数
     * @throws org.springframework.jdbc.BadSqlGrammarException 入参是空List的时候会抛SQL语句错误的异常，请自行校验入参
     */
    int insertOrUpdateBatch(@Param("entities") List<ExamSched> entities);

    /**
     * 修改数据
     *
     * @param examSched 实例对象
     * @return 影响行数
     */
    int update(ExamSched examSched);

    /**
     * 通过主键删除数据
     *
     * @param id 主键
     * @return 影响行数
     */
    int deleteById(Integer id);

}

