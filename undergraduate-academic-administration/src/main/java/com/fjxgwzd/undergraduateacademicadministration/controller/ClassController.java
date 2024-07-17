package com.fjxgwzd.undergraduateacademicadministration.controller;

import com.fjxgwzd.common.result.Result;
import com.fjxgwzd.undergraduateacademicadministration.entity.Class;
import com.fjxgwzd.undergraduateacademicadministration.service.ClassService;

import com.fjxgwzd.undergraduateacademicadministration.vo.ClassDetailVo;
import com.fjxgwzd.undergraduateacademicadministration.vo.TotalClassDetailVo;
import jakarta.annotation.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;


/**
 * (Class)表控制层
 *
 * @author makejava
 * @since 2024-07-14 13:49:14
 */
@RestController
@RequestMapping("class")
public class ClassController {
    /**
     * 服务对象
     */
    @Resource
    private ClassService classService;

    /**
     * 分页查询
     *
     * @param
     * @param
     * @return 查询结果
     */
    @PostMapping("classInfo")
    public Result<TotalClassDetailVo> queryByPage(@RequestBody Map<String, Object> conditions) {
        try {
            Integer schoolId = conditions.containsKey("schoolId") ? ((Integer) conditions.get("schoolId")) : null;
            Integer majorId = conditions.containsKey("majorId") ? (Integer) conditions.get("majorId") : null;
            Integer startYear = conditions.containsKey("startYear") ? ((Integer) conditions.get("startYear")) : null;
            int offset = ((Number) conditions.get("offset")).intValue();
            int num = ((Number) conditions.get("num")).intValue();
            TotalClassDetailVo totalClassDetailVo = this.classService.getTotalClassDetail(schoolId,majorId,startYear,offset,num);
            return Result.ok(totalClassDetailVo);
        }catch (Exception e){
            e.printStackTrace();
            return Result.fail();
        }
    }

    /**
     * 通过主键查询单条数据
     *
     * @param id 主键
     * @return 单条数据
     */
    @GetMapping("{id}")
    public ResponseEntity<Class> queryById(@PathVariable("id") Integer id) {
        return ResponseEntity.ok(this.classService.queryById(id));
    }

    /**
     * 新增数据
     *
     * @param classes 实体
     * @return 新增结果
     */
    @PostMapping
    public ResponseEntity<Class> add(Class classes) {
        return ResponseEntity.ok(this.classService.insert(classes));
    }

    /**
     * 编辑数据
     *
     * @param classes 实体
     * @return 编辑结果
     */
    @PutMapping
    public ResponseEntity<Class> edit(Class classes) {
        return ResponseEntity.ok(this.classService.update(classes));
    }

    /**
     * 删除数据
     *
     * @param id 主键
     * @return 删除是否成功
     */
    @DeleteMapping
    public ResponseEntity<Boolean> deleteById(Integer id) {
        return ResponseEntity.ok(this.classService.deleteById(id));
    }

}

