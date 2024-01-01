@echo off
QPROCESS * | find /I /N "DeviceConsol">NUL
IF "%ERRORLEVEL%"=="0" (
echo DeviceConsole is starting
)else (
	echo DeviceConsole is not running
	"C:\Program Files (x86)\Common Files\SensorM\DeviceConsole.exe"
	echo DeviceConsole is now running.
)

