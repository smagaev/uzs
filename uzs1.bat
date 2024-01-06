echo off
reg import DeviceConsole.reg
reg import UZSManager.reg
Set /a No = %1
Set /a Co = %2
sqlcmd -v serNo=%No% count=%Co% -i uzs1.sql

