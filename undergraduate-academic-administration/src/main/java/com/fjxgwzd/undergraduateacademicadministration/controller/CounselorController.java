package com.fjxgwzd.undergraduateacademicadministration.controller;

import com.fjxgwzd.undergraduateacademicadministration.entity.Counselor;
import com.fjxgwzd.undergraduateacademicadministration.service.CounselorService;

import jakarta.annotation.Resource;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;



/**
 * (Counselor)表控制层
 *
 * @author makejava
 * @since 2024-07-14 13:49:07
 */
@RestController
@RequestMapping("counselor")
public class CounselorController {
    /**
     * 服务对象
     */
    @Resource
    private CounselorService counselorService;

    /**
     * 分页查询
     *
     * @param counselor 筛选条件
     * @param pageRequest      分页对象
     * @return 查询结果
     */
    @GetMapping
    public ResponseEntity<Page<Counselor>> queryByPage(Counselor counselor, PageRequest pageRequest) {
        return ResponseEntity.ok(this.counselorService.queryByPage(counselor, pageRequest));
    }

    /**
     * 通过主键查询单条数据
     *
     * @param id 主键
     * @return 单条数据
     */
    @GetMapping("{id}")
    public ResponseEntity<Counselor> queryById(@PathVariable("id") String id) {
        return ResponseEntity.ok(this.counselorService.queryById(id));
    }

    /**
     * 新增数据
     *
     * @param counselor 实体
     * @return 新增结果
     */
    @PostMapping
    public ResponseEntity<Counselor> add(Counselor counselor) {
        return ResponseEntity.ok(this.counselorService.insert(counselor));
    }

    /**
     * 编辑数据
     *
     * @param counselor 实体
     * @return 编辑结果
     */
    @PutMapping
    public ResponseEntity<Counselor> edit(Counselor counselor) {
        return ResponseEntity.ok(this.counselorService.update(counselor));
    }

    /**
     * 删除数据
     *
     * @param id 主键
     * @return 删除是否成功
     */
    @DeleteMapping
    public ResponseEntity<Boolean> deleteById(String id) {
        return ResponseEntity.ok(this.counselorService.deleteById(id));
    }

}

