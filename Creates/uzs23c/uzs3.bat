@Set /P No=Serial number of UZS2/3c:
@certutil -decode u3.cert uzs23c.sql 
@sqlcmd -v serNo=%No% -i uzs23c.sql 
@REG ADD HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\SensorM\GSO\Ports /v "TCP192.168.1.1%No:~-2%" /t REG_DWORD /d 0x0001b210 
@REG ADD HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\SensorM\GSO\Ports\Params /v "TCP192.168.1.1%No:~-2%" /t REG_BINARY /d 000000008501a8c011270000000000000000 /f 
@del uzs23c.sql 
@echo "UZS2/3c created"
@net stop SCSChLService
@net start SCSChLService


