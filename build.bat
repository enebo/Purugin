REM I'm building on windows using Docker to make a build environmet.
REM If you have docker installed (WIN10) you can share folders easily...
REM also install bash commands so you can use SED and PWD

@FOR /f "tokens=*" %%i IN ('docker-machine.exe env') DO %%i

rem *** uncomment next line to build the docker image  ***
rem docker build -t mvn_dev_env:latest  .

REM Compile...
pwd | sed -e s/\\/\//g | sed -e s/://g > tmpFile
set /p mydir= < tmpFile
del tmpFile

docker run -it -v //%mydir%:/src -v //%mydir%/.m2:/root/.m2 mvn_dev_env mvn clean package