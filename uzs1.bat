echo off
reg import DeviceConsole.reg
reg import UZSManager.reg
reg delete HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\SensorM\GSO\Ports /f
Set /a No = %1
Set /a Co = %2
sqlcmd -v serNo=%No% count=%Co% -i uzs1.sql
net stop SCSChLService
net start SCSChLService

