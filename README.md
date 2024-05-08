# Opentelemetry with Java Spring Boot Application

Establecimiento de Opentelemetry en aplicacion Java usando auto instrumentacion a traves del agente java opentelemetry-javaagent

## Compilar aplicacion

```
docker build -t opentelmetry-spring-javaagent .
```

## Ejecutar aplicacion

```
docker run -p 8080:8080 -it opentelmetry-spring-javaagent
```

## Probar aplicacion

```
curl localhost:8080
```
