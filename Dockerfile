FROM java:8
WORKDIR /
ADD target/addressbook.war addressbook.war
EXPOSE 8080
CMD java -jar addressbook.war
