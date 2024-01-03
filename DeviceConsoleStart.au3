;http://www.oszone.net/display.php?id=3663
;If WinExists(@ScriptName) Then Exit
;AutoItWinSetTitle(@ScriptName)

#include<MsgBoxConstants.au3>
#include <AutoItConstants.au3>
#RequireAdmin
BlockInput(0)
Opt("TrayIconDebug",1) 

Opt("MouseCoordMode", 0) ;
;close running deviceconsole
$pid = ProcessExists('deviceconsole.exe')
while($pid <> 0)

		ProcessClose($pid)
		sleep(1000)
		$pid = ProcessExists('deviceconsole.exe')
WEnd

;Run(@ScriptDir,"clear_all.bat")
ShellExecute('clear_all.bat',@ScriptDir)
sleep(400)

;run scrip uzs1
Local $iPID = ShellExecute('uzs1',@ScriptDir)
sleep(100)

;unblock mouse and keyboard
BlockInput(0)


ProcessWaitClose($iPID , 300)


;block mouse and keyboard
BlockInput(0)


ShellExecute("DeviceConsole.lnk",@ScriptDir)
$winID = WinWaitActive("Настройки оповещения", "", 1)
MouseClick("left", 18, 197)

WinWaitActive("Настройки оповещения","Определение польязователя", 5)
MouseClick("left", 103, 147)


;click управляющие устройства
MouseClick("left", 88, 250)


;one click on new controll element
MouseClick("left",  306, 111)
sleep(500)
;double click on new controll element
MouseClick("left",  306, 111,2)


;Настройки диспетчера управляющих устройств отличаются от .... 

Opt("WinWaitDelay", 10)
;WinSetState(WinWait("[CLASS:MCIQTZ_Window]"), "", @SW_HIDE)

#cs sleep(8000)
; $id = WinActive("Внимание")
; ;MsgBox($MB_OK, "title", $id)
;  if $id Then 
; 	  MouseMove(219, 135)
; 	  MouseDown($MOUSE_CLICK_LEFT) ; Set the left mouse button state as down.
; 	  Sleep(100)
; 	  MouseUp($MOUSE_CLICK_LEFT) ; Set the left mouse button state as up.
; 	  Sleep(1000)
; EndIf
#ce

If WinWait("Внимание","",8) Then
WinActivate("Внимание")
WinWaitActive("Внимание")
Send("{ENTER}")
EndIf


; click Тестирование УУЗС
   MouseClick("left",  86, 230)
   sleep(500)



; click Обновить 3 раза
MouseMove(328, 626, 20 )
MouseDown($MOUSE_CLICK_LEFT) ; Set the left mouse button state as down.
Sleep(100)
MouseUp($MOUSE_CLICK_LEFT) ; Set the left mouse button state as up.
Sleep(1000)


MouseDown($MOUSE_CLICK_LEFT) ; Set the left mouse button state as down.
Sleep(100)
MouseUp($MOUSE_CLICK_LEFT) ; Set the left mouse button state as up.
Sleep(1000)


MouseDown($MOUSE_CLICK_LEFT) ; Set the left mouse button state as down.
Sleep(100)
MouseUp($MOUSE_CLICK_LEFT) ; Set the left mouse button state as up.

;потянем вниз за прокрутку
MouseMove(1082, 168,20)
MouseDown($MOUSE_CLICK_LEFT)
MouseMove(1085, 344, 50)
MouseUp($MOUSE_CLICK_LEFT)



;UZSManager_cod

$pid = ProcessExists('UZSManager_cod.exe')
while($pid <> 0)

		ProcessClose($pid)
		sleep(1000)
		$pid = ProcessExists('UZSManager_cod.exe')
WEnd

ShellExecute("UZSManager_cod.lnk",@ScriptDir)
WinWaitActive("Пульт управления УУЗС", "", 5)
WinActivate("Пульт управления УУЗС")
Exit
 ;Команды управления
 MouseMove(1914, 540)
 MouseDown($MOUSE_CLICK_LEFT) ; Set the left mouse button state as down.
Sleep(100)
MouseUp($MOUSE_CLICK_LEFT) ; Set the left mouse button state as up.

;Отркыть
WinWaitActive("Открыть", "", 5)
;Прокрутка вниз
MouseClick("left", 412, 176)
sleep(300)
MouseClick("left", 412, 176)
sleep(300)
MouseClick("left", 412, 176)

;Cписок расширенных команд
MouseClick("left", 151, 172)
sleep(400)
MouseClick("left", 375, 222)

;выбрать коммнанду
sleep(500)
MouseClick("left",1893, 541)
sleep(1000)
;MouseMove("left",1862, 564)
;sleep(1000)
MouseClick("left",1862, 564)
 BlockInput(0)
 
 ;set active выберите значение
 MouseClick("left",1499, 581)
 sleep(800)
 MouseClick("left", 1499,581,2)
 sleep(500)
 Send("1")
 
 




