FROM java:8

COPY /target/*.jar /home/MavenHelloWorldProject-1.0-SNAPSHOT.jar

CMD ["java","-jar","/target/*.jar"]
