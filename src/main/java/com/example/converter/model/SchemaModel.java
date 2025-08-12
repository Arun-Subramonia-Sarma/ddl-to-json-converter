package com.example.converter.model;

import com.fasterxml.jackson.annotation.JsonProperty;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

public record SchemaModel(
    Metadata metadata,
    @JsonProperty("diagram_settings") DiagramSettings diagramSettings,
    List<Entity> entities,
    List<Relationship> relationships
) {
    
    public record Metadata(
        String title,
        String version,
        String description,
        @JsonProperty("created_date") LocalDateTime createdDate,
        @JsonProperty("created_by") String createdBy
    ) {}
    
    public record DiagramSettings(
        String rankdir,
        @JsonProperty("node_defaults") Map<String, Object> nodeDefaults
    ) {}
    
    public record Entity(
        String id,
        String name,
        String domain,
        String description,
        List<Field> fields,
        @JsonProperty("unique_keys") Map<String, List<String>> uniqueKeys,
        @JsonProperty("special_sections") List<Field> specialSections
    ) {}
    
    public record Field(
        String name,
        String type,
        @JsonProperty("is_required") boolean isRequired,
        @JsonProperty("is_key") boolean isKey
    ) {}
    
    public record Relationship(
        @JsonProperty("from_entity") String fromEntity,
        @JsonProperty("to_entity") String toEntity,
        String label,
        @JsonProperty("relationship_type") String relationshipType
    ) {}
}