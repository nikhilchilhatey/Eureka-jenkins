FROM eclipse-temurin:24-jre
ADD target/eks-eureka.jar eks-eureka.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "eks-eureka.jar"]
