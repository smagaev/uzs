#RequireAdmin
Opt("CaretCoordMode", 2)
Opt("MouseCoordMode", 2)
Run(@CommonFilesDir & "\SensorM\DeviceConsole.exe")
$hwnd = WinWait("Настройки оповещения","")
If Not $hWnd Then
    MsgBox(4096, 'Сообщение', 'Программа не найдена, завершаем работу скрипта')
    Exit
 EndIf
 WinActivate("Настройки оповещения","Объекты базы данных:")
 SendKeepActive("Настройки оповещения","Объекты базы данных:")
sleep(60)

MouseClick('left',10, 127,1)

WinWait("Определение пользователя","")
Send("{ENTER}")
