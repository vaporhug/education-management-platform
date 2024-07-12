package com.fjxgwzd.teacherresourcesharing.service;

import io.minio.errors.*;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;

public interface FileService {
    String upload(MultipartFile file, Integer chapterId, String uploaderId) throws Exception;
    String deleteFile(Integer chapterId) throws Exception;
}
