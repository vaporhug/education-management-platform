package com.fjxgwzd.academicmanagement.service;

import co.elastic.clients.elasticsearch._types.query_dsl.BoolQuery.Builder;
import co.elastic.clients.elasticsearch._types.query_dsl.QueryBuilders;
import com.fjxgwzd.academicmanagement.entity.*;
import com.fjxgwzd.academicmanagement.mapper.*;
import org.springframework.data.domain.Page;
import org.springframework.data.elasticsearch.client.elc.ElasticsearchTemplate;
import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Autowired;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.StreamSupport;



@Service
public class ArchitectureService {
    @Autowired
    private ArchitectureMapper architectureMapper;

    @Autowired
    private  ClassroomMapper classroomRepository;

    @Autowired
    private  SchoolMapper schoolRepository;

    @Autowired
    private ClassroomStatusMapper classroomStatusMapper;

    @Autowired
    private ClassroomReservationMapper classroomReservationMapper;

    @Autowired
    private ClassroomReservationMapperForSql classroomReservationMapperForSql;

    @Autowired
    private ElasticsearchTemplate elasticsearchTemplate;




    public Map<Integer, String> getAllBuildings() {
        return StreamSupport.stream(classroomRepository.findAll().spliterator(), false)
                .collect(Collectors.toMap(
                        Classroom::getCampusId,
                        Classroom::getBuildingName,
                        (existing, replacement) -> existing
                ));
    }

    public School findSchoolById(Integer schoolId) {
        return schoolRepository.findSchoolById(schoolId);
    }


    public Classroom saveClassroom(Classroom classroom) {
        return classroomRepository.save(classroom);
    }

    public List<Classroom> findAllClassrooms() {
        return (List<Classroom>) classroomRepository.findAll();
    }

//    public List<Classroom> findClassroomsByBuildingName(String buildingName) {
//        return classroomRepository.findBybuilding_name(buildingName);
//    }

    public void deleteClassroom(Integer id) {
        classroomRepository.deleteById(id);
    }

    public List<Campus> getAllCampuses() {
        return architectureMapper.findAllCampuses();
    }
    public Campus getCampusById(Integer campusId){
        return architectureMapper.findCampusById(campusId);
    }

    public List<Classroom> getAllClassroom() {
        Page<Classroom> page = (Page<Classroom>) classroomRepository.findAll();
        return page.getContent();
    }

    public List<Classroom> getClassroomByCampusId(Integer campusId) {
        return classroomRepository.findClassroomByCampusId(campusId);
    }

//    public List<Classroom> getClassroomByCampusIdAndBuildingName(Integer campusId,String buildingName) {
//
//        return classroomRepository.findClassroomsByCampusIdAndBuildingName(campusId,buildingName);
//    }
    public List<Classroom> getClassroomByCampusIdAndBuildingName(Integer campusId,String buildingName) {
        if(campusId == null && buildingName == null){
            return (List<Classroom>) classroomRepository.findAll();
        }
        if(campusId != null && buildingName == null){
            return classroomRepository.findClassroomsByCampusId(campusId);
        }
        if (campusId == null){
            return classroomRepository.findClassroomsByBuildingName(buildingName);
        }
        return classroomRepository.findClassroomsByCampusIdAndBuildingName(campusId, buildingName);
    }

    public Classroom getClassroomById(Integer id){
        return classroomRepository.findClassroomsById(id);
    }

    public List<ClassroomStatus> getClassroomStatusBySpecificTimeRegion(Integer year,Integer classroomId,Integer week,Integer termPart,Integer dayOfWeek,Integer periodFrom,Integer periodTo ){
        return classroomStatusMapper.findClassroomStatusesByYearAndClassroomIdAndWeekAndTermPartAndDayOfWeekAndPeriodFromGreaterThanEqualAndPeriodToLessThanEqual(year,classroomId,week,termPart,dayOfWeek,periodFrom,periodTo);
    }

    public List<ClassroomReservation> getClassroomReservationByClassroomIdAndResult(Integer classroomId,Integer result){
        if(result == null)
            return classroomReservationMapper.getClassroomReservationsByClassroomId(classroomId);
        return classroomReservationMapper.getClassroomReservationsByClassroomIdAndResult(classroomId,result);
    }

    public boolean updateClassroomReservationByResult(Integer result ,Integer id){
        try{
            classroomReservationMapperForSql.updateClassroomReservationByResult(result,id);
            return true;
        }catch (Exception e){
            e.printStackTrace();
            return false;
        }
    }

    public ClassroomStatus getClassroomStatusById(Integer id){
        return classroomStatusMapper.findClassroomStatusById(id).get(0);
    }

}
