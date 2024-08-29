#!/bin/bash


#get the parent  directory
rootDir=$(dirname $(pwd))

echo "Root directory is $rootDir"


cp app.config ../../java
cd ../../java

 ./gradlew run -PmainClass=org.example.Example2 --args="$rootDir" 
