# Stage 1: Build ShopSphere WAR with Maven
FROM maven:3.9-eclipse-temurin-21 AS build
WORKDIR /app
COPY pom.xml .
COPY web ./web
RUN mvn clean package -DskipTests

# Stage 2: Run inside Tomcat 11
FROM tomcat:11.0-jdk21-temurin
WORKDIR /usr/local/tomcat

# Remove default Tomcat ROOT webapp
RUN rm -rf webapps/ROOT webapps/ROOT.war

# Deploy ShopSphere as ROOT so it opens directly at the base URL (e.g. https://your-app.onrender.com/)
COPY --from=build /app/target/ShopSphere.war webapps/ROOT.war

# Expose standard Tomcat port
EXPOSE 8080

CMD ["catalina.sh", "run"]
