package com.fjxgwzd.academicmanagement;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.jdbc.core.JdbcTemplate;

import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;

@SpringBootTest
class AcademicManagementApplicationTests {

    @Autowired
    private JdbcTemplate jdbcTemplate;
    @Test
    void contextLoads() {
    }

    @Test
    public void whenInitialized_thenDataSourceIsNotNull() {
        assertThat(jdbcTemplate.getDataSource()).isNotNull();
    }

    @Autowired
    private TestRepository testRepository;

    @Test
    public void whenQuery_thenReturnsNames() {
        List<String> names = testRepository.findAllNames();
        System.out.println(names);
        assertThat(names).containsExactlyInAnyOrder("Test1", "Test2", "Test3");
    }

}
