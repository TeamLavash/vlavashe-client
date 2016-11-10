@echo off

setlocal enableextensions enabledelayedexpansion

for /f %%v in ('git describe --tags --long') do set version=%%v

set version_out=Version: "%version%"

echo %version_out%> version.java

pause