package com.example.converter.util;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

public class FileUtils {

    public static boolean isValidInputFile(String filePath) {
        if (filePath == null || filePath.trim().isEmpty()) {
            return false;
        }
        
        Path path = Paths.get(filePath);
        return Files.exists(path) && Files.isReadable(path) && Files.isRegularFile(path);
    }

    public static String validateFilePath(String filePath) {
        if (filePath == null || filePath.trim().isEmpty()) {
            return "File path cannot be empty";
        }
        
        try {
            Path path = Paths.get(filePath);
            Path parent = path.getParent();
            
            if (parent != null && !Files.exists(parent)) {
                return "Parent directory does not exist: " + parent;
            }
            
            if (Files.exists(path) && !Files.isWritable(path)) {
                return "File exists but is not writable: " + path;
            }
            
            return null; // Valid path
        } catch (Exception e) {
            return "Invalid file path: " + e.getMessage();
        }
    }

    public static String getAbsolutePath(String filePath) {
        return Paths.get(filePath).toAbsolutePath().toString();
    }

    public static boolean createParentDirectories(String filePath) {
        try {
            Path path = Paths.get(filePath);
            Path parent = path.getParent();
            
            if (parent != null && !Files.exists(parent)) {
                Files.createDirectories(parent);
            }
            
            return true;
        } catch (Exception e) {
            return false;
        }
    }
}