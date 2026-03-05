FROM gradle:8.10.2-jdk17-alpine AS build
WORKDIR /home/gradle/project

# Копируем проект и собираем jar
COPY . .
RUN gradle bootJar --no-daemon

FROM eclipse-temurin:17-jre-alpine
WORKDIR /app

COPY --from=build /home/gradle/project/build/libs/*.jar app.jar

ENV SPRING_PROFILES_ACTIVE=docker
EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]
