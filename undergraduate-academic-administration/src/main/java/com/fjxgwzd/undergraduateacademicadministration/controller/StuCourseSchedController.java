package com.fjxgwzd.undergraduateacademicadministration.controller;

import com.fjxgwzd.common.result.Result;
import com.fjxgwzd.undergraduateacademicadministration.entity.StuCourseSched;
import com.fjxgwzd.undergraduateacademicadministration.service.StuCourseSchedService;
import com.fjxgwzd.undergraduateacademicadministration.vo.TotalAttendanceVo;
import com.fjxgwzd.undergraduateacademicadministration.vo.Rates;
import jakarta.annotation.Resource;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;


/**
 * (StuCourseSched)表控制层
 *
 * @author makejava
 * @since 2024-07-16 11:21:42
 */
@RestController
@RequestMapping("stuCourseSched")
public class StuCourseSchedController {
    /**
     * 服务对象
     */
    @Resource
    private StuCourseSchedService stuCourseSchedService;

    @PostMapping("attendanceStu")
    public Result<Rates> queryStuAttendanceByStuId(@RequestHeader("PrimaryInfo") String primaryInfo,@RequestBody Map<String, Object> conditions){
        try {
//            String stuId = (String) conditions.get("stuId");
            Integer year = (Integer) conditions.get("year");
//            Boolean termPart;
//            if ( ( (Integer)conditions.get("termPart")).intValue() == 1 ){
//                termPart=true;
//            } else {
//                termPart=false;
//            }
            Boolean termPart = (Boolean) conditions.get("termPart");
            int[] stuAttendance = this.stuCourseSchedService.getStuAttendanceByStuId(primaryInfo,year,termPart);
            Rates rates = new Rates();
            rates.setRates(stuAttendance);
            return Result.ok(rates);
        }catch (Exception e){
            e.printStackTrace();
            return Result.fail();
        }
    }

    @PostMapping("attendanceTea")
    public Result<Rates> queryTeaAttendanceByTeaId(@RequestHeader("PrimaryInfo") String primaryInfo,@RequestBody Map<String, Object> conditions){
        try {
//            String teacherId = (String) conditions.get("teacherId");

            Integer year = (Integer) conditions.get("year");
//            Boolean termPart;
//            if ( ( (Integer)conditions.get("termPart")).intValue() == 1 ){
//                termPart=true;
//            } else {
//                termPart=false;
//            }
            Boolean termPart = (Boolean) conditions.get("termPart");
            int[] stuAttendance = this.stuCourseSchedService.getTeaAttendanceByTeaId(primaryInfo,year,termPart);
            Rates rates = new Rates();
            rates.setRates(stuAttendance);
            return Result.ok(rates);
        }catch (Exception e){
            e.printStackTrace();
            return Result.fail();
        }
    }

    @PostMapping("attendanceTotal")
    public Result<TotalAttendanceVo> queryTeaAttendanceByTotalId(@RequestBody Map<String, Object> conditions){
        try {
            Integer year = (Integer) conditions.get("year");
//            Boolean termPart;
//            if ( ( (Integer)conditions.get("termPart")).intValue() == 1 ){
//                termPart=true;
//            } else {
//                termPart=false;
//            }
            Boolean termPart = (Boolean) conditions.get("termPart");
            TotalAttendanceVo stuAttendance = this.stuCourseSchedService.getToatalAttendance(year,termPart);
            return Result.ok(stuAttendance);
        }catch (Exception e){
            e.printStackTrace();
            return Result.fail();
        }
    }


    /**
     * 分页查询
     *
     * @param stuCourseSched 筛选条件
     * @param pageRequest      分页对象
     * @return 查询结果
     */
    @GetMapping
    public ResponseEntity<Page<StuCourseSched>> queryByPage(StuCourseSched stuCourseSched, PageRequest pageRequest) {
        return ResponseEntity.ok(this.stuCourseSchedService.queryByPage(stuCourseSched, pageRequest));
    }

    /**
     * 通过主键查询单条数据
     *
     * @param id 主键
     * @return 单条数据
     */
    @GetMapping("{id}")
    public ResponseEntity<StuCourseSched> queryById(@PathVariable("id") Integer id) {
        return ResponseEntity.ok(this.stuCourseSchedService.queryById(id));
    }

    /**
     * 新增数据
     *
     * @param stuCourseSched 实体
     * @return 新增结果
     */
    @PostMapping
    public ResponseEntity<StuCourseSched> add(StuCourseSched stuCourseSched) {
        return ResponseEntity.ok(this.stuCourseSchedService.insert(stuCourseSched));
    }

    /**
     * 编辑数据
     *
     * @param stuCourseSched 实体
     * @return 编辑结果
     */
    @PutMapping
    public ResponseEntity<StuCourseSched> edit(StuCourseSched stuCourseSched) {
        return ResponseEntity.ok(this.stuCourseSchedService.update(stuCourseSched));
    }

    /**
     * 删除数据
     *
     * @param id 主键
     * @return 删除是否成功
     */
    @DeleteMapping
    public ResponseEntity<Boolean> deleteById(Integer id) {
        return ResponseEntity.ok(this.stuCourseSchedService.deleteById(id));
    }
}

