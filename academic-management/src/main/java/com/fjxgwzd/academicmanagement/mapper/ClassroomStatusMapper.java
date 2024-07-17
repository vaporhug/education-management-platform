package com.fjxgwzd.academicmanagement.mapper;

import com.fjxgwzd.academicmanagement.entity.ClassroomStatus;
import org.springframework.data.elasticsearch.repository.ElasticsearchRepository;

import java.util.List;

public interface ClassroomStatusMapper extends ElasticsearchRepository<ClassroomStatus,Integer>{
    List<ClassroomStatus> findClassroomStatusesByYearAndClassroomIdAndWeekAndTermPartAndDayOfWeekAndPeriodFromIsAfterAndPeriodToBefore(Integer year, Integer classroomId, Integer week, Integer termPart, Integer dayOfWeek, Integer periodFrom, Integer periodTo);
    List<ClassroomStatus> findClassroomStatusesByYearAndClassroomIdAndWeekAndTermPartAndDayOfWeekAndPeriodFromGreaterThanEqualAndPeriodToLessThanEqual(Integer year, Integer classroomId, Integer week, Integer termPart, Integer dayOfWeek, Integer periodFrom, Integer periodTo);
    List<ClassroomStatus> findClassroomStatusesByYearAndClassroomIdAndWeekAndTermPartAndDayOfWeek(Integer year, Integer classroomId, Integer week, Integer termPart, Integer dayOfWeek);
    List<ClassroomStatus> findClassroomStatusById(Integer id);


}
