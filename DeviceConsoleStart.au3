;http://www.oszone.net/display.php?id=3663
;If WinExists(@ScriptName) Then Exit
;AutoItWinSetTitle(@ScriptName)

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


#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <MsgBoxConstants.au3>

#Region ### START GUI section ### Form=
Global $hGUI = GUICreate("Enter values", 170, 93)
GUICtrlCreateLabel("Serial No: ", 12, 10, 60, 17)
Global $SerNo = GUICtrlCreateInput("", 80, 5, 45, 21)
;~ GUICtrlCreateLabel("CountElem: ", 8, 35, 60, 17)
;~ Global $CountElem = GUICtrlCreateInput("", 80, 32, 145, 21)
;~ GUICtrlCreateLabel("Password: ", 8, 58, 56, 17)
;~ Global $iPassword = GUICtrlCreateInput("", 80, 56, 145, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_PASSWORD))
Global $bLogin = GUICtrlCreateButton("OK", 80, 35, 59, 40)
GUISetState(@SW_SHOW)
#EndRegion ### START GUI section ### Form=

Global $uUname, $uPassword, $uCountElem
BlockInput(0)
While 1
    Switch GUIGetMsg()
        Case $GUI_EVENT_CLOSE
            GUISetState(@SW_HIDE)
            Local $iAsk = MsgBox($MB_ICONWARNING + $MB_YESNO, "?", "You want to quit?")
            If $iAsk = 1 Or $iAsk = 6 Then
                MsgBox($MB_ICONWARNING, "Exit", "Operation has been cancelled" & @CRLF & "The Script will now quit.", 2)
                Exit
            EndIf
            GUISetState(@SW_SHOW)
        Case $bLogin
			$uSerNo = GUICtrlRead($SerNo)
	  	   ;$uCountElem = GUICtrlRead($CountElem)
		   ;$uPassword = GUICtrlRead($iPassword)
           ;MsgBox($MB_ICONINFORMATION, "  Your values", "Uname: " & $uUnam & @CRLF & "Password: " & $uPassword& @CRLF & "Count: " & $uCountElem, 5)
		   MsgBox($MB_ICONINFORMATION, "  Your values", "SerNo: " & $uSerNo, 5)
		    ExitLoop
		EndSwitch
		
	WEnd
BlockInput(1)






;run script uzs1
;Local $iPID = ShellExecute('uzs1.bat', $uUnam &  "  " & $uCountElem ,@ScriptDir )
Local $iPID = ShellExecute('uzs1.bat', $uSerNo& " " & 1 ,@ScriptDir )


ProcessWaitClose($iPID , 300)



ShellExecute("DeviceConsole.lnk",@ScriptDir)
$winID = WinWaitActive("Настройки оповещения", "", 1)
MouseMove(18, 197)
sleep(800)
MouseDown("left")
sleep(500)
MouseUp("left")


WinWaitActive("Настройки оповещения","Определение польязователя", 5)
MouseClick("left", 103, 147)


;click управляющие устройства
MouseClick("left", 88, 250)

;one click on new controll element
MouseClick("left",  459, 112)
sleep(500)
;double click on new controll element
MouseClick("left",  459, 112, 2)

;Настройки диспетчера управляющих устройств отличаются от .... 

;Opt("WinWaitDelay", 10)
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

If WinWait("Внимание","",14) Then
WinActivate("Внимание")
WinWaitActive("Внимание")
Sleep(1000)
;Send("{ENTER}")
MouseMove(221, 137,10)
sleep(700)
MouseDown("left")
sleep(700)
MouseUp("left")
EndIf


$winID = WinWaitActive("Настройки оповещения", "Локальный вход", 1)

; click Тестирование УУЗС
MouseMove(77, 233,20)
   MouseDown("left")
   sleep(600)
   MouseUp("left")
   sleep(800)
   

; click Обновить 3 раза

MouseMove(283, 546,10)
MouseDown("left")
sleep(400)
MouseUp("left")
sleep(1000)
MouseDown("left")
sleep(400)
MouseUp("left")
sleep(1000)
MouseDown("left")
sleep(400)
MouseUp("left")
sleep(1000)

#cs 
; 
; MouseMove(899, 163, 20 )
; MouseDown($MOUSE_CLICK_LEFT) ; Set the left mouse button state as down.
; Sleep(100)
; MouseUp($MOUSE_CLICK_LEFT) ; Set the left mouse button state as up.
; Sleep(1000)
; 
; 
; MouseDown($MOUSE_CLICK_LEFT) ; Set the left mouse button state as down.
; Sleep(100)
; MouseUp($MOUSE_CLICK_LEFT) ; Set the left mouse button state as up.
; Sleep(1000)
; 
; 
; MouseDown($MOUSE_CLICK_LEFT) ; Set the left mouse button state as down.
; Sleep(100)
; MouseUp($MOUSE_CLICK_LEFT) ; Set the left mouse button state as up.
#ce

;переведем курсор к началу прокрутки устройств
MouseMove(898, 163, 20)
sleep(600)
;потянем вниз за прокрутку
MouseDown($MOUSE_CLICK_LEFT)
MouseMove(902, 291,100)
MouseUp($MOUSE_CLICK_LEFT)



;UZSManager_cod

$pid = ProcessExists('UZSManager_cod.exe')
while($pid <> 0)

		ProcessClose($pid)
		sleep(1000)
		$pid = ProcessExists('UZSManager_cod.exe')
WEnd
exit
ShellExecute("UZSManager_cod.lnk",@ScriptDir)
WinWaitActive("Пульт управления УУЗС", "", 5)
WinActivate("Пульт управления УУЗС")

 ;Команды управления
 MouseMove(1530, 604)
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
 
 




