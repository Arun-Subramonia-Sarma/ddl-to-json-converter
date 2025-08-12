# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a Spring Boot command-line application that converts DDL (Data Definition Language) SQL files to JSON schema format. It parses CREATE TABLE statements and transforms them into structured JSON suitable for diagram generation and documentation.

## Build and Development Commands

```bash
# Build the project
mvn clean compile

# Run tests (if test directory exists)
mvn test

# Package the application
mvn package

# Run the application directly with Maven
mvn spring-boot:run -Dspring-boot.run.arguments="<input-ddl-file> <output-json-file> [options]"

# Example usage
mvn spring-boot:run -Dspring-boot.run.arguments="schema-files/schema.sql schema-files/schema.json --verbose"

# Run packaged JAR (after mvn package)
java -jar target/ddl-to-json-converter-0.0.1-SNAPSHOT.jar <input-ddl-file> <output-json-file> [options]
```

## Command Line Arguments

- First argument: Input DDL SQL file path (required)  
- Second argument: Output JSON file path (required)
- `--verbose, -v`: Enable detailed output
- `--pretty`: Pretty-print JSON output (enabled by default)
- `--help, -h`: Show help message

## Architecture

### Core Components

- **DdlToJsonCommand**: PicoCLI-based command line interface that coordinates the conversion process
- **DDLParserService**: Parses CREATE TABLE statements from SQL files, extracting table structure
- **SchemaConversionService**: Converts parsed DDL tables to structured JSON schema format
- **JsonConfiguration**: Configures Jackson ObjectMapper for JSON output formatting

### Data Flow

1. **Input**: DDL SQL files with CREATE TABLE statements
2. **Parsing**: Extract table names, columns, data types, constraints, primary/foreign keys
3. **Conversion**: Transform to JSON with metadata, entities, relationships, and special sections
4. **Output**: Structured JSON compatible with diagram generation tools

### Model Classes

- **DDLTable**: Record representing parsed table structure (name, columns, constraints)
- **SchemaModel**: Record for complete JSON schema output structure
- **FileUtils**: Utility methods for file operations

## Data Processing Rules

- SQL data types are mapped to standard JSON schema types (VARCHAR→string, INTEGER→int, etc.)
- Audit fields (created_time, updated_time, created_by, etc.) are moved to special_sections
- Primary keys are marked with `is_key: true`
- Table names are converted to PascalCase for entity names
- Domain names are extracted from table name prefixes

## Configuration

- **application.yaml**: Spring Boot configuration with logging levels
- **JsonConfiguration**: Custom Jackson configuration for pretty-printing and field ordering
- No external database or web server required - pure command-line processing

## Dependencies

- Spring Boot 3.5.4 (Java 21)
- PicoCLI 4.7.5 for command-line interface
- Jackson for JSON processing
- No test framework currently configured