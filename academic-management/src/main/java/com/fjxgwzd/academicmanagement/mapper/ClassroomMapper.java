package com.fjxgwzd.academicmanagement.mapper;

import com.fjxgwzd.academicmanagement.entity.Classroom;
import org.springframework.data.elasticsearch.annotations.Query;
import org.springframework.data.elasticsearch.repository.ElasticsearchRepository;

import java.util.List;

public interface ClassroomMapper extends ElasticsearchRepository<Classroom,Integer> {
//    List<Classroom> findBybuilding_name(String buildingName);
    List<Classroom> findClassroomByCampusId(Integer campus_id);

    List<Classroom> findClassroomsByCampusIdAndBuildingName(Integer campusId, String buildingName);
    Classroom findClassroomsById(Integer id);

    List<Classroom> findClassroomsByCampusId(Integer campusId);
    List<Classroom> findClassroomsByBuildingName(String buildingName);

}
