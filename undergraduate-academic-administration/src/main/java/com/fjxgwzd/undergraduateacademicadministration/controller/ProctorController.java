package com.fjxgwzd.undergraduateacademicadministration.controller;

import com.fjxgwzd.common.result.Result;
import com.fjxgwzd.undergraduateacademicadministration.entity.Proctor;
import com.fjxgwzd.undergraduateacademicadministration.service.ProctorService;
import com.fjxgwzd.undergraduateacademicadministration.vo.ProctorExamVo;

import jakarta.annotation.Resource;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;



/**
 * (Proctor)表控制层
 *
 * @author makejava
 * @since 2024-07-16 03:48:18
 */
@RestController
@RequestMapping("proctor")
public class ProctorController {
    /**
     * 服务对象
     */
    @Resource
    private ProctorService proctorService;

    /**
     * 分页查询
     *
     * @param proctor 筛选条件
     * @param pageRequest      分页对象
     * @return 查询结果
     */
    @GetMapping
    public ResponseEntity<Page<Proctor>> queryByPage(Proctor proctor, PageRequest pageRequest) {
        return ResponseEntity.ok(this.proctorService.queryByPage(proctor, pageRequest));
    }

    /**
     * 通过主键查询单条数据
     *
     * @param id 主键
     * @return 单条数据
     */
    @GetMapping("{id}")
    public ResponseEntity<Proctor> queryById(@PathVariable("id") Integer id) {
        return ResponseEntity.ok(this.proctorService.queryById(id));
    }

    /**
     * 新增数据
     *
     * @param proctor 实体
     * @return 新增结果
     */
    @PostMapping
    public ResponseEntity<Proctor> add(Proctor proctor) {
        return ResponseEntity.ok(this.proctorService.insert(proctor));
    }

    /**
     * 编辑数据
     *
     * @param proctor 实体
     * @return 编辑结果
     */
    @PutMapping
    public ResponseEntity<Proctor> edit(Proctor proctor) {
        return ResponseEntity.ok(this.proctorService.update(proctor));
    }

    /**
     * 删除数据
     *
     * @param id 主键
     * @return 删除是否成功
     */
    @DeleteMapping
    public ResponseEntity<Boolean> deleteById(Integer id) {
        return ResponseEntity.ok(this.proctorService.deleteById(id));
    }

    @PostMapping("examScheInfo")
    public Result<ProctorExamVo> queryByTeacherId(@RequestHeader("primaryInfo") String primaryInfo) {
        try {
            ProctorExamVo proctorExamVo = this.proctorService.getInvigilationTime(primaryInfo);
            return Result.ok(proctorExamVo);
        }catch (Exception e){
            e.printStackTrace();
            return Result.fail();
        }
    }

}

