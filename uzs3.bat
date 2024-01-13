@echo off
rem Setlocal EnableDelayedExpansion
Set /P No=Serial number of UZS1:
sqlcmd -v serNo=%No% -i uzs3.sql

