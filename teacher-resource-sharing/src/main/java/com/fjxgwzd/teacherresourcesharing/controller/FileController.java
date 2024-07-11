package com.fjxgwzd.teacherresourcesharing.controller;

import com.fjxgwzd.teacherresourcesharing.result.Result;
import com.fjxgwzd.teacherresourcesharing.service.FileService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@RestController
@RequestMapping("/files")
public class FileController {
    @Autowired
    private FileService fileService;

    @PostMapping("uploadFile")
    public Result<String> uploadFile(@RequestParam("file") MultipartFile file, @RequestParam("chapter_id") int chapterId, @RequestParam("teacher_id") String teacherId) {
        try {
            String url = fileService.upload(file, chapterId,teacherId);
            return Result.ok(url);
        }catch (Exception e){
            return Result.fail();
        }
    }

    @DeleteMapping("/delete")
    public Result<String> deleteFile(@RequestParam("chapter_id") int chapter_id) {
        // 在此处的API删除文件，所需上传的主要是该chapter_id，以及由网关传来的用户身份id，我由用户身份id进行课程权限查询
        try {
            String result = fileService.deleteFile(chapter_id);
            return Result.ok(result);
        } catch (Exception e) {
            return Result.fail();
        }
    }

}
