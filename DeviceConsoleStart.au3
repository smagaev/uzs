;http://www.oszone.net/display.php?id=3663
;If WinExists(@ScriptName) Then Exit
;AutoItWinSetTitle(@ScriptName)

#include<MsgBoxConstants.au3>
#include <AutoItConstants.au3>
#RequireAdmin
BlockInput(1)
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


ProcessWaitClose($iPID , 1000)


;block mouse and keyboard
BlockInput(1)


ShellExecute("DeviceConsole.lnk",@ScriptDir)
WinWaitActive("[CLASS:DeviceConsole]", "", 5)
MouseClick("left", 18, 197)

WinWaitActive("[CLASS:DeviceConsole]","Определение польязователя", 5)
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
MouseMove(258, 579)
MouseDown($MOUSE_CLICK_LEFT) ; Set the left mouse button state as down.
Sleep(100)
MouseUp($MOUSE_CLICK_LEFT) ; Set the left mouse button state as up.
Sleep(1000)

MouseMove(258, 579)
MouseDown($MOUSE_CLICK_LEFT) ; Set the left mouse button state as down.
Sleep(100)
MouseUp($MOUSE_CLICK_LEFT) ; Set the left mouse button state as up.
Sleep(1000)

MouseMove(258, 579)
MouseDown($MOUSE_CLICK_LEFT) ; Set the left mouse button state as down.
Sleep(100)
MouseUp($MOUSE_CLICK_LEFT) ; Set the left mouse button state as up.
 
 BlockInput(0)
 
 
 




