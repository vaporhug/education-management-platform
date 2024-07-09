package com.fjxgwzd.academicmanagement;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class TestRepository {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public List<String> findAllNames() {
        return jdbcTemplate.queryForList("SELECT name FROM test_table", String.class);
    }
}