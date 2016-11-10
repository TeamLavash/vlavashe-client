@echo off

setlocal enableextensions enabledelayedexpansion

for /f %%v in ('git describe --tags --long') do set version=%%v

echo package com.example.kormick.vlavashe_client^; > app\src\main\java\com\example\kormick\vlavashe_client\Version.java
echo // Version: "%version%" >> app\src\main\java\com\example\kormick\vlavashe_client\Version.java
echo public class Version { >> app\src\main\java\com\example\kormick\vlavashe_client\Version.java
echo     public static final String version = "%version%"^; >> app\src\main\java\com\example\kormick\vlavashe_client\Version.java
echo } >> app\src\main\java\com\example\kormick\vlavashe_client\Version.java