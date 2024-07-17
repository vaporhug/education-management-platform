package com.fjxgwzd.academicmanagement.mapper;

import com.fjxgwzd.academicmanagement.entity.ClassroomReservation;
import org.springframework.data.elasticsearch.repository.ElasticsearchRepository;

import java.util.List;

public interface ClassroomReservationMapper extends ElasticsearchRepository<ClassroomReservation,Integer> {
    List<ClassroomReservation> getClassroomReservationsByClassroomIdAndResult(Integer classroomId, Integer result);
    List<ClassroomReservation> getClassroomReservationsByClassroomId(Integer classroomId);
}
