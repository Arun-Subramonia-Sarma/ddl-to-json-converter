package com.example.converter.cli;

import com.example.converter.model.DDLTable;
import com.example.converter.model.SchemaModel;
import com.example.converter.service.DDLParserService;
import com.example.converter.service.SchemaConversionService;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.ObjectWriter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;
import picocli.CommandLine;
import picocli.CommandLine.Command;
import picocli.CommandLine.Option;
import picocli.CommandLine.Parameters;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.concurrent.Callable;

@Component
@Command(
        name = "ddl-to-json",
        description = "Convert DDL SQL files to JSON schema format",
        mixinStandardHelpOptions = true,
        version = "1.0.0"
)
public class DdlToJsonCommand implements CommandLineRunner, Callable<Integer> {

    private static final Logger logger = LoggerFactory.getLogger(DdlToJsonCommand.class);

    @Parameters(index = "0", description = "Input DDL SQL file", arity = "0..1")
    private String inputFile;

    @Parameters(index = "1", description = "Output JSON file", arity = "0..1")
    private String outputFile;

    @Option(names = {"-v", "--verbose"}, description = "Enable verbose output")
    private boolean verbose;

    @Option(names = {"--pretty"}, description = "Pretty-print JSON output", defaultValue = "true")
    private boolean prettyPrint;

    @Autowired
    private DDLParserService ddlParserService;

    @Autowired
    private SchemaConversionService schemaConversionService;

    @Autowired
    private ObjectMapper objectMapper;

    @Autowired
    @Qualifier("compactFieldWriter")
    private ObjectWriter compactFieldWriter;

    @Override
    public void run(String... args) {
        int exitCode = new CommandLine(this).execute(args);
        if (exitCode != 0) {
            System.exit(exitCode);
        }
    }

    @Override
    public Integer call() throws Exception {
        try {
            if (inputFile == null || outputFile == null) {
                System.err.println("Error: Both input DDL file and output JSON file must be specified");
                CommandLine.usage(this, System.err);
                return 1;
            }

            return convertDdlToJson();

        } catch (Exception e) {
            logger.error("Error during conversion", e);
            System.err.println("Error: " + e.getMessage());
            return 1;
        }
    }

    private Integer convertDdlToJson() throws Exception {
        Path inputPath = Paths.get(inputFile);
        Path outputPath = Paths.get(outputFile);

        // Validate input file
        if (!Files.exists(inputPath) || !Files.isReadable(inputPath)) {
            System.err.println("Error: Input file not found or not readable: " + inputFile);
            return 1;
        }

        if (verbose) {
            System.out.println("Reading DDL from: " + inputPath.toAbsolutePath());
        }

        // Parse DDL file
        List<DDLTable> tables = ddlParserService.parseDDLFile(inputPath);

        if (verbose) {
            System.out.println("Found " + tables.size() + " tables:");
            tables.forEach(table -> System.out.println("  - " + table.name() + " (" + table.columns().size() + " columns)"));
        }

        // Convert to schema model
        SchemaModel schema = schemaConversionService.convertTablesToSchema(tables);

        // Create parent directories if they don't exist
        if (outputPath.getParent() != null) {
            Files.createDirectories(outputPath.getParent());
        }

        // Write JSON output with pretty printing if requested

        // Write JSON output
        try {
            if (prettyPrint) {
                compactFieldWriter.writeValue(outputPath.toFile(), schema);
            } else {
                objectMapper.writeValue(outputPath.toFile(), schema);
            }

            System.out.println("Successfully converted " + inputFile + " to " + outputFile);

            if (verbose) {
                long fileSize = Files.size(outputPath);
                System.out.println("Output file size: " + fileSize + " bytes");
                System.out.println("Absolute path: " + outputPath.toAbsolutePath());
                System.out.println("Entities created: " + schema.entities().size());
                System.out.println("Relationships inferred: " + schema.relationships().size());
            }

            return 0;

        } catch (Exception e) {
            System.err.println("Error writing output file: " + e.getMessage());
            if (verbose) {
                e.printStackTrace();
            }
            return 1;
        }
    }
}