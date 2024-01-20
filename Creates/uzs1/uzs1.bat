@Set /P No= Serial number:
@Set /A Co=1
@certutil -decode u1.cert uzs1.sql > null
@sqlcmd -v serNo=%No% count=%Co% -i uzs1.sql > null
@del uzs1.sql > null
@REG ADD HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\SensorM\GSO\Ports /v "TCP192.168.1.1%No:~-2%" /t REG_DWORD /d 0x0001b210 >null
@REG ADD HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\SensorM\GSO\Ports\Params /v "TCP192.168.1.1%No:~-2%" /t REG_BINARY /d 000000008501a8c011270000000000000000 /f >null
@del null
@net stop SCSChLService
@net start SCSChLService


