package com.fjxgwzd.undergraduateacademicadministration.dao;

import com.fjxgwzd.undergraduateacademicadministration.entity.Proctor;
import com.fjxgwzd.undergraduateacademicadministration.entity.Semester;
import com.fjxgwzd.undergraduateacademicadministration.vo.ExamSchedVo;
import org.apache.ibatis.annotations.Param;
import org.springframework.data.domain.Pageable;
import java.util.List;

/**
 * (Proctor)表数据库访问层
 *
 * @author makejava
 * @since 2024-07-16 03:48:18
 */
public interface ProctorDao {

    /**
     * 通过ID查询单条数据
     *
     * @param id 主键
     * @return 实例对象
     */
    Proctor queryById(Integer id);

    /**
     * 查询指定行数据
     *
     * @param proctor 查询条件
     * @param pageable         分页对象
     * @return 对象列表
     */
    List<Proctor> queryAllByLimit(Proctor proctor, @Param("pageable") Pageable pageable);

    /**
     * 统计总行数
     *
     * @param proctor 查询条件
     * @return 总行数
     */
    long count(Proctor proctor);

    /**
     * 新增数据
     *
     * @param proctor 实例对象
     * @return 影响行数
     */
    int insert(Proctor proctor);

    /**
     * 批量新增数据（MyBatis原生foreach方法）
     *
     * @param entities List<Proctor> 实例对象列表
     * @return 影响行数
     */
    int insertBatch(@Param("entities") List<Proctor> entities);

    /**
     * 批量新增或按主键更新数据（MyBatis原生foreach方法）
     *
     * @param entities List<Proctor> 实例对象列表
     * @return 影响行数
     * @throws org.springframework.jdbc.BadSqlGrammarException 入参是空List的时候会抛SQL语句错误的异常，请自行校验入参
     */
    int insertOrUpdateBatch(@Param("entities") List<Proctor> entities);

    /**
     * 修改数据
     *
     * @param proctor 实例对象
     * @return 影响行数
     */
    int update(Proctor proctor);

    /**
     * 通过主键删除数据
     *
     * @param id 主键
     * @return 影响行数
     */
    int deleteById(Integer id);

    Integer getYear(String teacherId);

    Boolean getTermPart(String teacherId);

    List<ExamSchedVo> getExams(@Param("year") Integer year, @Param("term_part") Boolean term_part,@Param("teacherId") String teacherId);

    List<Semester> getAllSemester();
}

