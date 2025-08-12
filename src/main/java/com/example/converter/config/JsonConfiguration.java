package com.example.converter.config;

import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.core.util.DefaultIndenter;
import com.fasterxml.jackson.core.util.DefaultPrettyPrinter;
import com.fasterxml.jackson.core.util.Separators;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.ObjectWriter;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;

@Configuration
public class JsonConfiguration {

    @Bean
    @Primary
    public ObjectMapper objectMapper() {
        ObjectMapper mapper = new ObjectMapper();
        mapper.registerModule(new JavaTimeModule());
        return mapper;
    }

    @Bean
    public ObjectWriter compactFieldWriter() {
        return objectMapper().writer(new CompactFieldPrettyPrinter());
    }

    public static class CompactFieldPrettyPrinter extends DefaultPrettyPrinter {
        private boolean inCompactObject = false;
        private int objectDepth = 0;
        
        public CompactFieldPrettyPrinter() {
            super();
            _arrayIndenter = DefaultIndenter.SYSTEM_LINEFEED_INSTANCE;
            _objectIndenter = DefaultIndenter.SYSTEM_LINEFEED_INSTANCE;
            _separators = Separators.createDefaultInstance();
        }

        @Override
        public CompactFieldPrettyPrinter createInstance() {
            return new CompactFieldPrettyPrinter();
        }

        @Override
        public void writeStartObject(JsonGenerator g) throws java.io.IOException {
            objectDepth++;
            // Make all objects at depth 2 and above compact (includes field and relationship objects)
            inCompactObject = objectDepth >= 2;
            
            g.writeRaw('{');
            if (!_objectIndenter.isInline() && !inCompactObject) {
                ++_nesting;
            }
        }

        @Override
        public void writeEndObject(JsonGenerator g, int nrOfEntries) throws java.io.IOException {
            if (!_objectIndenter.isInline() && !inCompactObject) {
                --_nesting;
            }
            if (nrOfEntries > 0 && !inCompactObject) {
                _objectIndenter.writeIndentation(g, _nesting);
            }
            g.writeRaw('}');
            objectDepth--;
            inCompactObject = objectDepth >= 2;
        }

        @Override
        public void writeObjectEntrySeparator(JsonGenerator g) throws java.io.IOException {
            g.writeRaw(',');
            if (inCompactObject) {
                g.writeRaw(' ');
            } else {
                _objectIndenter.writeIndentation(g, _nesting);
            }
        }

        @Override
        public void beforeObjectEntries(JsonGenerator g) throws java.io.IOException {
            if (!inCompactObject) {
                _objectIndenter.writeIndentation(g, _nesting);
            }
        }

        @Override
        public void writeObjectFieldValueSeparator(JsonGenerator g) throws java.io.IOException {
            g.writeRaw(" : ");
        }

        @Override
        public void writeStartArray(JsonGenerator g) throws java.io.IOException {
            if (!_arrayIndenter.isInline()) {
                ++_nesting;
            }
            g.writeRaw("[");
            _arrayIndenter.writeIndentation(g, _nesting);
        }

        @Override  
        public void writeEndArray(JsonGenerator g, int nrOfValues) throws java.io.IOException {
            if (!_arrayIndenter.isInline()) {
                --_nesting;
            }
            if (nrOfValues > 0) {
                _arrayIndenter.writeIndentation(g, _nesting);
            }
            g.writeRaw(']');
        }

        @Override
        public void writeArrayValueSeparator(JsonGenerator g) throws java.io.IOException {
            g.writeRaw(",");
            _arrayIndenter.writeIndentation(g, _nesting);
        }

        @Override
        public void beforeArrayValues(JsonGenerator g) throws java.io.IOException {
            // Array values will be indented properly now
        }
    }
}