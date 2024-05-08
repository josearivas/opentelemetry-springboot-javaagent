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

## Ejecucion de Jaeger

```
docker run --network=opentelemetry -d --name jaeger \
  -e COLLECTOR_ZIPKIN_HOST_PORT=:9411 \
  -p 5775:5775/udp \
  -p 6831:6831/udp \
  -p 6832:6832/udp \
  -p 5778:5778 \
  -p 16686:16686 \
  -p 14250:14250 \
  -p 14268:14268 \
  -p 14269:14269 \
  -p 9411:9411 \
  jaegertracing/all-in-one:latest
```
