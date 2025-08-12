package com.example.converter.service;

import com.example.converter.model.DDLTable;
import com.example.converter.model.SchemaModel;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.*;

@Service
public class SchemaConversionService {

    public SchemaModel convertTablesToSchema(List<DDLTable> tables) {
        SchemaModel.Metadata metadata = createMetadata();
        SchemaModel.DiagramSettings diagramSettings = createDiagramSettings();
        List<SchemaModel.Entity> entities = convertTablesToEntities(tables);
        List<SchemaModel.Relationship> relationships = inferRelationships(tables);
        
        return new SchemaModel(metadata, diagramSettings, entities, relationships);
    }
    
    private SchemaModel.Metadata createMetadata() {
        return new SchemaModel.Metadata(
            "Converted DDL Schema",
            "1.0",
            "Schema converted from DDL SQL file",
            LocalDateTime.now(),
            "DDL Parser"
        );
    }
    
    private SchemaModel.DiagramSettings createDiagramSettings() {
        Map<String, Object> nodeDefaults = new HashMap<>();
        nodeDefaults.put("fontname", "Arial");
        nodeDefaults.put("shape", "none");
        
        return new SchemaModel.DiagramSettings("TB", nodeDefaults);
    }
    
    private List<SchemaModel.Entity> convertTablesToEntities(List<DDLTable> tables) {
        return tables.stream()
            .map(this::convertTableToEntity)
            .toList();
    }
    
    private SchemaModel.Entity convertTableToEntity(DDLTable table) {
        String entityId = table.name();
        String entityName = formatTableName(table.name());
        String domain = extractDomainFromTableName(table.name());
        String description = "Entity representing " + entityName + " data";
        
        List<SchemaModel.Field> fields = convertColumnsToFields(table.columns());
        Map<String, List<String>> uniqueKeys = createUniqueKeys(table);
        List<SchemaModel.Field> specialSections = createSpecialSections();
        
        return new SchemaModel.Entity(
            entityId, entityName, domain, description, 
            fields, uniqueKeys, specialSections
        );
    }
    
    private String formatTableName(String tableName) {
        return Arrays.stream(tableName.split("_"))
            .map(word -> word.substring(0, 1).toUpperCase() + word.substring(1).toLowerCase())
            .reduce("", String::concat);
    }
    
    private String extractDomainFromTableName(String tableName) {
        if (tableName.contains("_")) {
            return formatTableName(tableName.split("_")[0]);
        }
        return "General";
    }
    
    private List<SchemaModel.Field> convertColumnsToFields(List<DDLTable.DDLColumn> columns) {
        return columns.stream()
            .filter(column -> !isAuditColumn(column.name()))
            .map(this::convertColumnToField)
            .toList();
    }
    
    private SchemaModel.Field convertColumnToField(DDLTable.DDLColumn column) {
        String type = mapSqlTypeToJsonType(column.type());
        boolean isRequired = column.notNull();
        boolean isKey = column.isPrimaryKey();
        
        return new SchemaModel.Field(column.name(), type, isRequired, isKey);
    }
    
    private String mapSqlTypeToJsonType(String sqlType) {
        String upperType = sqlType.toUpperCase();
        
        if (upperType.startsWith("VARCHAR") || upperType.startsWith("TEXT") || upperType.startsWith("CHAR")) {
            return "string";
        }
        if (upperType.startsWith("INTEGER") || upperType.startsWith("INT") || upperType.startsWith("BIGINT")) {
            return "int";
        }
        if (upperType.startsWith("BOOLEAN") || upperType.startsWith("BOOL")) {
            return "bool";
        }
        if (upperType.startsWith("TIMESTAMP") || upperType.startsWith("DATETIME")) {
            return "timestamp";
        }
        if (upperType.startsWith("DATE")) {
            return "date";
        }
        if (upperType.startsWith("DECIMAL") || upperType.startsWith("NUMERIC") || upperType.startsWith("FLOAT")) {
            return "decimal";
        }
        if (upperType.startsWith("UUID")) {
            return "UUID";
        }
        
        return "string";
    }
    
    private boolean isAuditColumn(String columnName) {
        String lowerName = columnName.toLowerCase();
        return lowerName.equals("created_time") || 
               lowerName.equals("updated_time") ||
               lowerName.equals("created_by") ||
               lowerName.equals("updated_by") ||
               lowerName.equals("deleted") ||
               lowerName.equals("archived") ||
               lowerName.equals("version");
    }
    
    private Map<String, List<String>> createUniqueKeys(DDLTable table) {
        Map<String, List<String>> uniqueKeys = new HashMap<>();
        if (!table.primaryKeys().isEmpty()) {
            uniqueKeys.put("u1", new ArrayList<>(table.primaryKeys()));
        }
        return uniqueKeys;
    }
    
    private List<SchemaModel.Field> createSpecialSections() {
        List<SchemaModel.Field> specialSections = new ArrayList<>();
        specialSections.add(new SchemaModel.Field("is_deleted", "bool", true, false));
        specialSections.add(new SchemaModel.Field("created_time", "timestamp", true, false));
        specialSections.add(new SchemaModel.Field("created_by", "string", true, false));
        specialSections.add(new SchemaModel.Field("updated_time", "timestamp", true, false));
        specialSections.add(new SchemaModel.Field("updated_by", "string", true, false));
        return specialSections;
    }
    
    private List<SchemaModel.Relationship> inferRelationships(List<DDLTable> tables) {
        List<SchemaModel.Relationship> relationships = new ArrayList<>();
        Set<String> seenRelationships = new HashSet<>();
        
        for (DDLTable table : tables) {
            for (DDLTable.ForeignKey fk : table.foreignKeys()) {
                String relationshipType = determineRelationshipType(table, fk);
                String label = formatRelationshipLabel(table.name(), fk.referencedTable(), fk.columnName());
                
                // Create unique key for deduplication
                String relationshipKey = table.name() + "->" + fk.referencedTable() + ":" + fk.columnName();
                
                if (!seenRelationships.contains(relationshipKey)) {
                    relationships.add(new SchemaModel.Relationship(
                        table.name(),           // Source: table with foreign key
                        fk.referencedTable(),   // Destination: referenced table
                        label,
                        relationshipType
                    ));
                    seenRelationships.add(relationshipKey);
                }
            }
        }
        
        return relationships;
    }
    
    private String determineRelationshipType(DDLTable table, DDLTable.ForeignKey fk) {
        boolean isForeignKeyPrimary = table.primaryKeys().contains(fk.columnName());
        return isForeignKeyPrimary ? "one_to_one" : "many_to_one";
    }
    
    private String formatRelationshipLabel(String fromTable, String toTable, String columnName) {
        return "REFERENCES_" + toTable.toUpperCase() + "_VIA_" + columnName.toUpperCase();
    }
}