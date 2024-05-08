# Usa la imagen de OpenJDK 17 como base
FROM maven:3.9-eclipse-temurin-17-alpine

# Establece el directorio de trabajo en /app
WORKDIR /app

# Copia el archivo pom.xml al directorio de trabajo
COPY pom.xml .

# Descarga todas las dependencias de Maven (esto se hace primero para aprovechar el caché? de Docker)
RUN mvn dependency:go-offline -B

# Copia javaagent para opentelemetry
COPY lib ./lib

# Copia el resto de los archivos de la aplicacion
COPY src ./src

# Compila la aplicació?n
RUN mvn package -DskipTests

# Configuracion de variables de entorno para instrumentacion automatica de app
ENV JAVA_TOOL_OPTIONS=-javaagent:lib/opentelemetry-javaagent-all.jar

ENV OTEL_SERVICE_NAME=app-service
ENV OTEL_TRACES_EXPORTER=jaeger
ENV OTEL_EXPORTER_JAEGER_ENDPOINT=http://jaeger:14250

ENV OTEL_METRICS_EXPORTER=logging
ENV OTEL_LOGS_EXPORTER=logging

# ENV OTEL_TRACES_EXPORTER=logging
# ENV OTEL_METRICS_EXPORTER=logging
# ENV OTEL_LOGS_EXPORTER=logging

ENV OTEL_METRIC_EXPORT_INTERVAL=15000

# Expone el puerto 8080 en el contenedor
EXPOSE 8080

# Comando para ejecutar la aplicació?n cuando se inicie el contenedor
CMD ["java", "-jar", "target/opentelemetry-springboot-javaagent-0.0.1-SNAPSHOT.jar"]
