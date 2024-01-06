@echo off
rem Setlocal EnableDelayedExpansion
Set /P No=Serial number of UZS1:
Set /p Co=Count of UZS1:
sqlcmd -v serNo=%No% count=%Co% -i uzs1.sql

