# DDL to JSON Converter

A Spring Boot command-line application that converts DDL (Data Definition Language) SQL files to structured JSON schema format, ideal for generating database diagrams and documentation.

## Features

- 🔍 **DDL Parsing**: Parses CREATE TABLE statements from SQL files
- 📊 **Schema Extraction**: Extracts table names, columns, data types, and constraints
- 🗂️ **Structured Output**: Converts to organized JSON with metadata and relationships
- 🔑 **Key Detection**: Automatically identifies primary keys and foreign keys
- 📝 **Type Mapping**: Maps SQL data types to standardized JSON schema types
- 🏷️ **Special Handling**: Separates audit fields (created_time, updated_by, etc.) into special sections
- 💻 **CLI Interface**: User-friendly command-line interface with verbose output options

## Quick Start

### Prerequisites

- Java 21 or higher
- Maven 3.6+

### Build and Run

```bash
# Build the project
mvn clean compile

# Run with Maven
mvn spring-boot:run -Dspring-boot.run.arguments="input.sql output.json --verbose"

# Or package and run JAR
mvn package
java -jar target/ddl-to-json-converter-0.0.1-SNAPSHOT.jar input.sql output.json
```

### Example Usage

```bash
# Convert schema.sql to schema.json with verbose output
mvn spring-boot:run -Dspring-boot.run.arguments="schema-files/schema.sql schema-files/schema.json --verbose"

# Using packaged JAR
java -jar target/ddl-to-json-converter-0.0.1-SNAPSHOT.jar schema-files/schema.sql output.json --pretty
```

## Command Line Options

| Option | Description | Default |
|--------|-------------|---------|
| `--verbose`, `-v` | Enable detailed output | false |
| `--pretty` | Pretty-print JSON output | true |
| `--help`, `-h` | Show help message | - |

## Input Format

The converter expects DDL SQL files with CREATE TABLE statements:

```sql
CREATE TABLE facility_master (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    facility_code VARCHAR(255),
    facility_name VARCHAR(255),
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by VARCHAR(255) NOT NULL,
    PRIMARY KEY (id, tenant)
);
```

## Output Format

Generates structured JSON with the following components:

```json
{
  "metadata": {
    "title": "Converted DDL Schema",
    "version": "1.0",
    "created_date": "2025-08-12T17:05:38.354",
    "created_by": "DDL Parser"
  },
  "entities": [
    {
      "id": "facility_master",
      "name": "FacilityMaster",
      "domain": "Facility",
      "fields": [
        {
          "name": "id",
          "type": "int",
          "is_required": true,
          "is_key": true
        }
      ],
      "special_sections": [
        {
          "name": "created_time",
          "type": "timestamp",
          "is_required": true
        }
      ]
    }
  ],
  "relationships": []
}
```

## Data Type Mapping

| SQL Type | JSON Type | Example |
|----------|-----------|---------|
| VARCHAR, TEXT, CHAR | string | `"facility_name"` |
| INTEGER, INT, BIGINT | int | `123` |
| BOOLEAN, BOOL | bool | `true` |
| TIMESTAMP, DATETIME | timestamp | `"2025-08-12T17:05:38"` |
| DATE | date | `"2025-08-12"` |
| DECIMAL, NUMERIC, FLOAT | decimal | `123.45` |
| UUID | UUID | `"550e8400-e29b-41d4-a716-446655440000"` |

## Architecture

### Core Components

- **DdlToJsonCommand**: Command-line interface using PicoCLI
- **DDLParserService**: Parses CREATE TABLE statements
- **SchemaConversionService**: Converts parsed tables to JSON schema
- **JsonConfiguration**: Configures JSON output formatting

### Processing Flow

1. **Input Validation**: Checks file existence and readability
2. **DDL Parsing**: Extracts table structure from SQL statements
3. **Schema Conversion**: Transforms to standardized JSON format
4. **Output Generation**: Writes formatted JSON with metadata

## Special Features

### Audit Field Handling
Automatically detects and separates audit fields into `special_sections`:
- `created_time`, `updated_time`
- `created_by`, `updated_by`
- `deleted`, `archived`, `version`

### Smart Naming
- Table names → PascalCase entity names (`facility_master` → `FacilityMaster`)
- Domain extraction from table prefixes (`facility_master` → domain: `"Facility"`)

### Key Detection
- Primary keys marked with `is_key: true`
- Composite keys supported
- Foreign key relationships inferred

## Development

### Project Structure

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

### Dependencies

- **Spring Boot 3.5.4**: Application framework
- **PicoCLI 4.7.5**: Command-line interface
- **Jackson**: JSON processing
- **Java 21**: Runtime platform

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request
