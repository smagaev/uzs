echo off
reg import DeviceConsole.reg
reg import UZSManager.reg
reg delete HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\SensorM\GSO\Ports /f
Set /a No = %1
Set /a Co = %2
sqlcmd -v serNo=%No% count=%Co% -i uzs1.sql
REG ADD HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\SensorM\GSO\Ports /v "TCP192.168.1.1%No:~-2%" /t REG_DWORD /d 0x0001b210
REG ADD HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\SensorM\GSO\Ports\Params /v "TCP192.168.1.1%No:~-2%" /t REG_BINARY /d 000000008501a8c011270000000000000000 /f 
net stop SCSChLService
net start SCSChLService


