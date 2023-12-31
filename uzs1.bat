@echo off
rem Setlocal EnableDelayedExpansion
Set /P No=Serial number of UZS1:
Set /p Co=Count of UZS1:
FOR /L %%x IN (1, 1, %Co%) DO (
   
 call echo !~%%x! 

   

   rem sqlcmd -v serNo=%No%+%X% -i uzs1.sql
)
