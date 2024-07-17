package com.fjxgwzd.undergraduateacademicadministration.dao;

import com.fjxgwzd.undergraduateacademicadministration.entity.ExamStu;
import com.fjxgwzd.undergraduateacademicadministration.vo.ExamTask;
import org.apache.ibatis.annotations.Param;
import org.springframework.data.domain.Pageable;
import java.util.List;

/**
 * (ExamStu)表数据库访问层
 *
 * @author makejava
 * @since 2024-07-16 06:17:15
 */
public interface ExamStuDao {

    /**
     * 通过ID查询单条数据
     *
     * @param id 主键
     * @return 实例对象
     */
    ExamStu queryById(Integer id);

    /**
     * 查询指定行数据
     *
     * @param examStu 查询条件
     * @param pageable         分页对象
     * @return 对象列表
     */
    List<ExamStu> queryAllByLimit(ExamStu examStu, @Param("pageable") Pageable pageable);

    /**
     * 统计总行数
     *
     * @param examStu 查询条件
     * @return 总行数
     */
    long count(ExamStu examStu);

    /**
     * 新增数据
     *
     * @param examStu 实例对象
     * @return 影响行数
     */
    int insert(ExamStu examStu);

    /**
     * 批量新增数据（MyBatis原生foreach方法）
     *
     * @param entities List<ExamStu> 实例对象列表
     * @return 影响行数
     */
    int insertBatch(@Param("entities") List<ExamStu> entities);

    /**
     * 批量新增或按主键更新数据（MyBatis原生foreach方法）
     *
     * @param entities List<ExamStu> 实例对象列表
     * @return 影响行数
     * @throws org.springframework.jdbc.BadSqlGrammarException 入参是空List的时候会抛SQL语句错误的异常，请自行校验入参
     */
    int insertOrUpdateBatch(@Param("entities") List<ExamStu> entities);

    /**
     * 修改数据
     *
     * @param examStu 实例对象
     * @return 影响行数
     */
    int update(ExamStu examStu);

    /**
     * 通过主键删除数据
     *
     * @param id 主键
     * @return 影响行数
     */
    int deleteById(Integer id);

    Integer getYear(String studentId);

    Boolean getTermPart(String studentId);

    List<ExamTask> getExams(String studentId);
}

