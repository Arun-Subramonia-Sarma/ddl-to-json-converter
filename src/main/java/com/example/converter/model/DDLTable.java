package com.example.converter.model;

import java.util.List;

public record DDLTable(
    String name,
    List<DDLColumn> columns,
    List<String> primaryKeys,
    List<ForeignKey> foreignKeys
) {
    
    public record DDLColumn(
        String name,
        String type,
        boolean notNull,
        String defaultValue,
        boolean isPrimaryKey
    ) {}
    
    public record ForeignKey(
        String columnName,
        String referencedTable,
        String referencedColumn
    ) {}
}