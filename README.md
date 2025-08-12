# DDL to JSON Converter

A Spring Boot command-line application that converts DDL (Data Definition Language) SQL files to JSON schema format, compatible with the json-to-dot-converter project.

## Features

- Parses CREATE TABLE statements from DDL SQL files
- Extracts table names, columns, data types, constraints
- Converts to structured JSON format with metadata
- Identifies primary keys and foreign keys
- Maps SQL data types to JSON schema types
- Separates audit fields into special sections
- Command-line interface with verbose output option

## Usage

### Build the Project
```bash
mvn clean compile
```

### Run the Converter
```bash
mvn spring-boot:run -Dspring-boot.run.arguments="<input-ddl-file> <output-json-file> [options]"
```

### Example
```bash
mvn spring-boot:run -Dspring-boot.run.arguments="schema-files/schema.sql schema-files/schema.json --verbose"
```

### Command Line Options
- `--verbose, -v` - Enable detailed output
- `--pretty` - Pretty-print JSON output (enabled by default)
- `--help, -h` - Show help message

## Input Format

The converter expects DDL SQL files with CREATE TABLE statements:

```sql
CREATE TABLE facility_master (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    facility_code VARCHAR(255),
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id, tenant)
);
```

## Output Format

The converter generates JSON files with the following structure:

```json
{
  "metadata": {
    "title": "Converted DDL Schema",
    "version": "1.0",
    "description": "Schema converted from DDL SQL file",
    "created_date": "2025-08-12T16:31:42.891119",
    "created_by": "DDL Parser"
  },
  "diagram_settings": {
    "rankdir": "TB",
    "node_defaults": {
      "fontname": "Arial",
      "shape": "none"
    }
  },
  "entities": [
    {
      "id": "facility_master",
      "name": "FacilityMaster",
      "domain": "Facility",
      "description": "Entity representing FacilityMaster data",
      "fields": [...],
      "unique_keys": {...},
      "special_sections": [...]
    }
  ],
  "relationships": []
}
```

## Data Type Mapping

| SQL Type | JSON Type |
|----------|-----------|
| VARCHAR, TEXT, CHAR | string |
| INTEGER, INT, BIGINT | int |
| BOOLEAN, BOOL | bool |
| TIMESTAMP, DATETIME | timestamp |
| DATE | date |
| DECIMAL, NUMERIC, FLOAT | decimal |
| UUID | UUID |

## Special Handling

- Audit fields (created_time, updated_time, created_by, updated_by, deleted, archived, version) are moved to `special_sections`
- Primary keys are identified and marked with `is_key: true`
- Table names are converted to PascalCase for entity names
- Domain names are extracted from table prefixes

## Project Structure

```
src/main/java/com/example/converter/
├── ConverterApplication.java          # Main Spring Boot application
├── cli/
│   └── DdlToJsonCommand.java         # Command-line interface
├── model/
│   ├── DDLTable.java                 # DDL parsing records
│   └── SchemaModel.java              # JSON schema records
├── service/
│   ├── DDLParserService.java         # DDL parsing logic
│   └── SchemaConversionService.java  # DDL to JSON conversion
└── util/
    └── FileUtils.java                # File utility methods
```

## Requirements

- Java 21+
- Maven 3.6+
- Spring Boot 3.5.4