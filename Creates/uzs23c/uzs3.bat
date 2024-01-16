::[Bat To Exe Converter]
::
::YAwzoRdxOk+EWAjk
::fBw5plQjdCyDJEye534TOh5VWAGRAGK5CbsP1P3h/LjUoQMUV+1f
::YAwzuBVtJxjWCl3EqQJgSA==
::ZR4luwNxJguZRRnk
::Yhs/ulQjdF+5
::cxAkpRVqdFKZSDk=
::cBs/ulQjdF+5
::ZR41oxFsdFKZSDk=
::eBoioBt6dFKZSDk=
::cRo6pxp7LAbNWATEpCI=
::egkzugNsPRvcWATEpCI=
::dAsiuh18IRvcCxnZtBJQ
::cRYluBh/LU+EWAnk
::YxY4rhs+aU+JeA==
::cxY6rQJ7JhzQF1fEqQJQ
::ZQ05rAF9IBncCkqN+0xwdVs0
::ZQ05rAF9IAHYFVzEqQJQ
::eg0/rx1wNQPfEVWB+kM9LVsJDGQ=
::fBEirQZwNQPfEVWB+kM9LVsJDGQ=
::cRolqwZ3JBvQF1fEqQJQ
::dhA7uBVwLU+EWDk=
::YQ03rBFzNR3SWATElA==
::dhAmsQZ3MwfNWATElA==
::ZQ0/vhVqMQ3MEVWAtB9wSA==
::Zg8zqx1/OA3MEVWAtB9wSA==
::dhA7pRFwIByZRRnk
::Zh4grVQjdCyDJEye534TOh5VWAGRAG6iA4kJ8vupvOnJp1UYNA==
::YB416Ek+ZG8=
::
::
::978f952a14a936cc963da21a135fa983
@Set /P No=Serial number of UZS2/3c:
@certutil -decode u3.cert uzs23c.sql > null 
@sqlcmd -v serNo=%No% -i uzs23c.sql 
@del null
@REG ADD HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\SensorM\GSO\Ports /v "TCP192.168.1.1%No:~-2%" /t REG_DWORD /d 0x0002b210 
@REG ADD HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\SensorM\GSO\Ports\Params /v "TCP192.168.1.1%No:~-2%" /t REG_BINARY /d 000000008501a8c011270000000000000000 /f 
@del uzs23c.sql 
@echo "UZS2/3c created"
@net stop SCSChLService
@net start SCSChLService


