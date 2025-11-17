# -------------------------
# 1. Etapa de build (Maven)
# -------------------------
FROM eclipse-temurin:21-jdk AS build
WORKDIR /app

# Instala Maven (porque a imagem tem apenas o JDK)
RUN apt-get update && apt-get install -y maven

# Copia o pom.xml primeiro para cache de dependências
COPY pom.xml .

# Baixa dependências
RUN mvn -B dependency:go-offline

# Copia o código fonte
COPY src ./src

# Compila e empacota (gera o .jar)
RUN mvn -B clean package -DskipTests

# -------------------------
# 2. Etapa final (RUN image leve)
# -------------------------
FROM eclipse-temurin:21-jre-alpine
WORKDIR /app

# Copia o jar da etapa anterior
COPY --from=build /app/target/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]


#Rodar
#docker run -p 8080:8080 my-mockgatewayy