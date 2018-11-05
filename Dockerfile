FROM java:8

COPY /target/MavenHelloWorldProject-1.0-SNAPSHOT.jar /home/MavenHelloWorldProject-1.0-SNAPSHOT.jar

CMD ["java","-jar","/home/MavenHelloWorldProject-1.0-SNAPSHOT.jar"]
