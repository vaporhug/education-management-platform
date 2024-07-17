package com.fjxgwzd.undergraduateacademicadministration.controller;

import com.fjxgwzd.common.result.Result;
import com.fjxgwzd.undergraduateacademicadministration.entity.ExamStu;
import com.fjxgwzd.undergraduateacademicadministration.service.ExamStuService;
import com.fjxgwzd.undergraduateacademicadministration.vo.StuExamVo;
import com.fjxgwzd.undergraduateacademicadministration.vo.TotalClassDetailVo;
import jakarta.annotation.Resource;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;



/**
 * (ExamStu)表控制层
 *
 * @author makejava
 * @since 2024-07-16 06:17:15
 */
@RestController
@RequestMapping("examStu")
public class ExamStuController {
    /**
     * 服务对象
     */
    @Resource
    private ExamStuService examStuService;

    @PostMapping("examStuInfo")
    public Result<StuExamVo> queryByStuId(@RequestHeader("primaryInfo") String studentId) {
        try {
             StuExamVo stuExamVo = this.examStuService.getStuExamVoByStuId(studentId);
            return Result.ok(stuExamVo);
        }catch (Exception e){
            e.printStackTrace();
            return Result.fail();
        }
    }

    /**
     * 分页查询
     *
     * @param examStu 筛选条件
     * @param pageRequest      分页对象
     * @return 查询结果
     */
    @GetMapping
    public ResponseEntity<Page<ExamStu>> queryByPage(ExamStu examStu, PageRequest pageRequest) {
        return ResponseEntity.ok(this.examStuService.queryByPage(examStu, pageRequest));
    }

    /**
     * 通过主键查询单条数据
     *
     * @param id 主键
     * @return 单条数据
     */
    @GetMapping("{id}")
    public ResponseEntity<ExamStu> queryById(@PathVariable("id") Integer id) {
        return ResponseEntity.ok(this.examStuService.queryById(id));
    }

    /**
     * 新增数据
     *
     * @param examStu 实体
     * @return 新增结果
     */
    @PostMapping
    public ResponseEntity<ExamStu> add(ExamStu examStu) {
        return ResponseEntity.ok(this.examStuService.insert(examStu));
    }

    /**
     * 编辑数据
     *
     * @param examStu 实体
     * @return 编辑结果
     */
    @PutMapping
    public ResponseEntity<ExamStu> edit(ExamStu examStu) {
        return ResponseEntity.ok(this.examStuService.update(examStu));
    }

    /**
     * 删除数据
     *
     * @param id 主键
     * @return 删除是否成功
     */
    @DeleteMapping
    public ResponseEntity<Boolean> deleteById(Integer id) {
        return ResponseEntity.ok(this.examStuService.deleteById(id));
    }
}

