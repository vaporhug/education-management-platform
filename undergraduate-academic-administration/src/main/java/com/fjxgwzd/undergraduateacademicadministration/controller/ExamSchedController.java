package com.fjxgwzd.undergraduateacademicadministration.controller;

import com.fjxgwzd.undergraduateacademicadministration.entity.ExamSched;
import com.fjxgwzd.undergraduateacademicadministration.service.ExamSchedService;
import jakarta.annotation.Resource;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;


/**
 * (ExamSched)表控制层
 *
 * @author makejava
 * @since 2024-07-14 17:30:31
 */
@RestController
@RequestMapping("examSched")
public class ExamSchedController {
    /**
     * 服务对象
     */
    @Resource
    private ExamSchedService examSchedService;

    /**
     * 分页查询
     *
     * @param examSched 筛选条件
     * @param pageRequest      分页对象
     * @return 查询结果
     */
    @GetMapping
    public ResponseEntity<Page<ExamSched>> queryByPage(ExamSched examSched, PageRequest pageRequest) {
        return ResponseEntity.ok(this.examSchedService.queryByPage(examSched, pageRequest));
    }

    /**
     * 通过主键查询单条数据
     *
     * @param id 主键
     * @return 单条数据
     */
    @GetMapping("{id}")
    public ResponseEntity<ExamSched> queryById(@PathVariable("id") Integer id) {
        return ResponseEntity.ok(this.examSchedService.queryById(id));
    }

    /**
     * 新增数据
     *
     * @param examSched 实体
     * @return 新增结果
     */
    @PostMapping
    public ResponseEntity<ExamSched> add(ExamSched examSched) {
        return ResponseEntity.ok(this.examSchedService.insert(examSched));
    }

    /**
     * 编辑数据
     *
     * @param examSched 实体
     * @return 编辑结果
     */
    @PutMapping
    public ResponseEntity<ExamSched> edit(ExamSched examSched) {
        return ResponseEntity.ok(this.examSchedService.update(examSched));
    }

    /**
     * 删除数据
     *
     * @param id 主键
     * @return 删除是否成功
     */
    @DeleteMapping
    public ResponseEntity<Boolean> deleteById(Integer id) {
        return ResponseEntity.ok(this.examSchedService.deleteById(id));
    }

}

