@echo off
rem -------------------------------------------------------------------------
rem hl7snd  Launcher
rem -------------------------------------------------------------------------

if not "%ECHO%" == ""  echo %ECHO%
if "%OS%" == "Windows_NT"  setlocal

set MAIN_CLASS=org.dcm4che3.tool.hl7snd.HL7Snd
set MAIN_JAR=dcm4che-tool-hl7snd-${project.version}.jar

set DIRNAME=.\
if "%OS%" == "Windows_NT" set DIRNAME=%~dp0%

rem Read all command line arguments

set ARGS=
:loop
if [%1] == [] goto end
        set ARGS=%ARGS% %1
        shift
        goto loop
:end

if not "%DCM4CHE_HOME%" == "" goto HAVE_DCM4CHE_HOME

set DCM4CHE_HOME=%DIRNAME%..

:HAVE_DCM4CHE_HOME

if not "%JAVA_HOME%" == "" goto HAVE_JAVA_HOME

set JAVA=java

goto SKIP_SET_JAVA_HOME

:HAVE_JAVA_HOME

set JAVA=%JAVA_HOME%\bin\java

:SKIP_SET_JAVA_HOME

set CP=%DCM4CHE_HOME%\etc\hl7snd\
set CP=%CP%;%DCM4CHE_HOME%\etc\certs\
set CP=%CP%;%DCM4CHE_HOME%\lib\%MAIN_JAR%
set CP=%CP%;%DCM4CHE_HOME%\lib\dcm4che-core-${project.version}.jar
set CP=%CP%;%DCM4CHE_HOME%\lib\dcm4che-hl7-${project.version}.jar
set CP=%CP%;%DCM4CHE_HOME%\lib\dcm4che-net-${project.version}.jar
set CP=%CP%;%DCM4CHE_HOME%\lib\dcm4che-tool-common-${project.version}.jar
set CP=%CP%;%DCM4CHE_HOME%\lib\slf4j-api-${slf4j.version}.jar
set CP=%CP%;%DCM4CHE_HOME%\lib\slf4j-log4j12-${slf4j.version}.jar
set CP=%CP%;%DCM4CHE_HOME%\lib\log4j-${log4j.version}.jar
set CP=%CP%;%DCM4CHE_HOME%\lib\commons-cli-${commons-cli.version}.jar

"%JAVA%" %JAVA_OPTS% -cp "%CP%" %MAIN_CLASS% %ARGS%
