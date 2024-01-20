sqlcmd -v serNo=%No% count=%Co% -i uzs3.sql
pause
exit
@REG ADD HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\SensorM\GSO\Ports /v "TCP192.168.1.1%No:~-2%" /t REG_DWORD /d 0x0002b210 
@REG ADD HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\SensorM\GSO\Ports\Params /v "TCP192.168.1.1%No:~-2%" /t REG_BINARY /d 000000008501a8c011270000000000000000 /f 
net stop SCSChLService
net start SCSChLService

