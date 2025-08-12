package com.example.converter.service;

import com.example.converter.model.DDLTable;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Service
public class DDLParserService {

    private static final Pattern CREATE_TABLE_PATTERN = Pattern.compile(
        "CREATE\\s+TABLE\\s+(\\w+)\\s*\\((.*?)\\);", 
        Pattern.CASE_INSENSITIVE | Pattern.DOTALL
    );
    
    
    private static final Pattern PRIMARY_KEY_PATTERN = Pattern.compile(
        "PRIMARY\\s+KEY\\s*\\(([^)]+)\\)", 
        Pattern.CASE_INSENSITIVE
    );
    
    private static final Pattern FOREIGN_KEY_PATTERN = Pattern.compile(
        "FOREIGN\\s+KEY\\s*\\((\\w+)\\)\\s+REFERENCES\\s+(\\w+)\\s*\\((\\w+)\\)",
        Pattern.CASE_INSENSITIVE
    );
    
    private static final Pattern ALTER_TABLE_FK_PATTERN = Pattern.compile(
        "ALTER\\s+TABLE\\s+(\\w+)\\s+ADD\\s+CONSTRAINT\\s+\\w+\\s+FOREIGN\\s+KEY\\s*\\(([^)]+)\\)\\s+REFERENCES\\s+(\\w+)\\s*\\(([^)]+)\\)",
        Pattern.CASE_INSENSITIVE
    );

    public List<DDLTable> parseDDLFile(Path filePath) throws IOException {
        String content = Files.readString(filePath);
        return parseDDLContent(content);
    }

    public List<DDLTable> parseDDLContent(String content) {
        List<DDLTable> tables = new ArrayList<>();
        Matcher tableMatcher = CREATE_TABLE_PATTERN.matcher(content);
        
        while (tableMatcher.find()) {
            String tableName = tableMatcher.group(1);
            String tableContent = tableMatcher.group(2);
            
            DDLTable table = parseTable(tableName, tableContent);
            tables.add(table);
        }
        
        // Parse ALTER TABLE foreign key constraints and add them to existing tables
        Map<String, List<DDLTable.ForeignKey>> alterTableForeignKeys = parseAlterTableForeignKeys(content);
        tables = addForeignKeysToTables(tables, alterTableForeignKeys);
        
        return tables;
    }
    
    private DDLTable parseTable(String tableName, String tableContent) {
        List<DDLTable.DDLColumn> columns = parseColumns(tableContent);
        List<String> primaryKeys = parsePrimaryKeys(tableContent);
        List<DDLTable.ForeignKey> foreignKeys = parseForeignKeys(tableContent);
        
        columns = markPrimaryKeyColumns(columns, primaryKeys);
        
        return new DDLTable(tableName, columns, primaryKeys, foreignKeys);
    }
    
    private List<DDLTable.DDLColumn> parseColumns(String tableContent) {
        List<DDLTable.DDLColumn> columns = new ArrayList<>();
        String[] lines = tableContent.split("\n");
        
        for (String line : lines) {
            line = line.trim();
            if (line.isEmpty() || 
                line.startsWith("PRIMARY KEY") || 
                line.startsWith("FOREIGN KEY") ||
                line.startsWith("CONSTRAINT") ||
                line.equals(",")) {
                continue;
            }
            
            // Remove trailing comma
            if (line.endsWith(",")) {
                line = line.substring(0, line.length() - 1);
            }
            
            DDLTable.DDLColumn column = parseColumn(line);
            if (column != null) {
                columns.add(column);
            }
        }
        
        return columns;
    }
    
    private DDLTable.DDLColumn parseColumn(String columnDef) {
        String[] parts = columnDef.trim().split("\\s+");
        if (parts.length < 2) {
            return null;
        }
        
        String name = parts[0];
        String type = parts[1];
        boolean notNull = columnDef.toUpperCase().contains("NOT NULL");
        String defaultValue = extractDefaultValue(columnDef);
        
        return new DDLTable.DDLColumn(name, type, notNull, defaultValue, false);
    }
    
    private String extractDefaultValue(String columnDef) {
        Pattern defaultPattern = Pattern.compile("DEFAULT\\s+([^\\s,]+)", Pattern.CASE_INSENSITIVE);
        Matcher matcher = defaultPattern.matcher(columnDef);
        if (matcher.find()) {
            return matcher.group(1);
        }
        return null;
    }
    
    private List<String> parsePrimaryKeys(String tableContent) {
        List<String> primaryKeys = new ArrayList<>();
        Matcher matcher = PRIMARY_KEY_PATTERN.matcher(tableContent);
        
        if (matcher.find()) {
            String keysList = matcher.group(1);
            String[] keys = keysList.split(",");
            for (String key : keys) {
                primaryKeys.add(key.trim());
            }
        }
        
        return primaryKeys;
    }
    
    private List<DDLTable.ForeignKey> parseForeignKeys(String tableContent) {
        List<DDLTable.ForeignKey> foreignKeys = new ArrayList<>();
        Matcher matcher = FOREIGN_KEY_PATTERN.matcher(tableContent);
        
        while (matcher.find()) {
            String column = matcher.group(1);
            String referencedTable = matcher.group(2);
            String referencedColumn = matcher.group(3);
            
            foreignKeys.add(new DDLTable.ForeignKey(column, referencedTable, referencedColumn));
        }
        
        return foreignKeys;
    }
    
    private List<DDLTable.DDLColumn> markPrimaryKeyColumns(List<DDLTable.DDLColumn> columns, List<String> primaryKeys) {
        return columns.stream()
            .map(column -> {
                boolean isPrimaryKey = primaryKeys.contains(column.name());
                return new DDLTable.DDLColumn(
                    column.name(),
                    column.type(),
                    column.notNull(),
                    column.defaultValue(),
                    isPrimaryKey
                );
            })
            .toList();
    }
    
    private Map<String, List<DDLTable.ForeignKey>> parseAlterTableForeignKeys(String content) {
        Map<String, List<DDLTable.ForeignKey>> foreignKeysByTable = new HashMap<>();
        Matcher matcher = ALTER_TABLE_FK_PATTERN.matcher(content);
        
        while (matcher.find()) {
            String tableName = matcher.group(1);
            String columnList = matcher.group(2);
            String referencedTable = matcher.group(3);
            String referencedColumnList = matcher.group(4);
            
            // For now, handle single-column foreign keys (most common case)
            String[] columns = columnList.split(",");
            String[] refColumns = referencedColumnList.split(",");
            
            for (int i = 0; i < columns.length && i < refColumns.length; i++) {
                String column = columns[i].trim();
                String refColumn = refColumns[i].trim();
                
                DDLTable.ForeignKey fk = new DDLTable.ForeignKey(column, referencedTable, refColumn);
                
                foreignKeysByTable.computeIfAbsent(tableName, k -> new ArrayList<>()).add(fk);
            }
        }
        
        return foreignKeysByTable;
    }
    
    private List<DDLTable> addForeignKeysToTables(List<DDLTable> tables, Map<String, List<DDLTable.ForeignKey>> alterTableForeignKeys) {
        return tables.stream()
            .map(table -> {
                List<DDLTable.ForeignKey> additionalForeignKeys = alterTableForeignKeys.getOrDefault(table.name(), Collections.emptyList());
                if (additionalForeignKeys.isEmpty()) {
                    return table;
                }
                
                List<DDLTable.ForeignKey> allForeignKeys = new ArrayList<>(table.foreignKeys());
                allForeignKeys.addAll(additionalForeignKeys);
                
                return new DDLTable(table.name(), table.columns(), table.primaryKeys(), allForeignKeys);
            })
            .toList();
    }
}