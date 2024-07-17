package com.fjxgwzd.undergraduateacademicadministration.controller;

import com.fjxgwzd.undergraduateacademicadministration.entity.Campus;
import com.fjxgwzd.undergraduateacademicadministration.service.CampusService;

import jakarta.annotation.Resource;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;


/**
 * (Campus)表控制层
 *
 * @author makejava
 * @since 2024-07-14 13:49:15
 */
@RestController
@RequestMapping("campus")
public class CampusController {
    /**
     * 服务对象
     */
    @Resource
    private CampusService campusService;

    /**
     * 分页查询
     *
     * @param campus 筛选条件
     * @param pageRequest      分页对象
     * @return 查询结果
     */
    @GetMapping
    public ResponseEntity<Page<Campus>> queryByPage(Campus campus, PageRequest pageRequest) {
        return ResponseEntity.ok(this.campusService.queryByPage(campus, pageRequest));
    }

    /**
     * 通过主键查询单条数据
     *
     * @param id 主键
     * @return 单条数据
     */
    @GetMapping("{id}")
    public ResponseEntity<Campus> queryById(@PathVariable("id") short id) {
        return ResponseEntity.ok(this.campusService.queryById(id));
    }

    /**
     * 新增数据
     *
     * @param campus 实体
     * @return 新增结果
     */
    @PostMapping
    public ResponseEntity<Campus> add(Campus campus) {
        return ResponseEntity.ok(this.campusService.insert(campus));
    }

    /**
     * 编辑数据
     *
     * @param campus 实体
     * @return 编辑结果
     */
    @PutMapping
    public ResponseEntity<Campus> edit(Campus campus) {
        return ResponseEntity.ok(this.campusService.update(campus));
    }

    /**
     * 删除数据
     *
     * @param id 主键
     * @return 删除是否成功
     */
    @DeleteMapping
    public ResponseEntity<Boolean> deleteById(Integer id) {
        return ResponseEntity.ok(this.campusService.deleteById(id));
    }

}

