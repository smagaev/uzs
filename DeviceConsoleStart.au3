;~ "Set resolution: 1920 x1080"
;~ "Set user scale: 125%"

#include <AutoItConstants.au3>
#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <MsgBoxConstants.au3>
#RequireAdmin
Opt("TrayIconDebug",1)

Opt("MouseCoordMode", 0);
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
 #Region ### START GUI section ### Form=
 Global $hGUI = GUICreate("Введите серийный номер УЗС1", 190, 140)
 GUICtrlCreateLabel("Serial No: ", 32, 33, 60, 17)
 Global $SerNo = GUICtrlCreateInput("", 90, 28, 45, 21)
 Global $bLogin = GUICtrlCreateButton("OK", 80, 65, 59, 40)
 GUISetState(@SW_SHOW)
 #EndRegion ### START GUI section ### Form=
 Global $uUname, $uPassword, $uCountElem
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
 			GUIDelete();
 		    ExitLoop
 		EndSwitch
 	WEnd
 BlockInput(0)






;run script uzs1
;Local $iPID = ShellExecute('uzs1.bat', $uUnam &  "  " & $uCountElem ,@ScriptDir )
Local $iPID = ShellExecute('uzs1.bat', $uSerNo& " " & 1 ,@ScriptDir )

ProcessWaitClose($iPID , 300)



ShellExecute("DeviceConsole.lnk",@ScriptDir)
$winID = WinWaitActive("Настройки оповещения")
MouseMove(18, 197)
sleep(800)
MouseDown("left")
MouseDown("left")
sleep(500)
MouseUp("left")


WinWaitActive("Определение пользователя")
ControlClick("Определение пользователя", "", "Button1")


;click управляющие устройства
MouseClick("left", 88, 250)

;one click on new controll element
;~ MouseClick("left",  459, 112)
sleep(500)
ControlClick("Настройки оповещения","","CContrDeviceListView1")
send("{Down}")
sleep(600)
;double click on new controll element
send("{Enter}")

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

If WinWait("Внимание","",30) Then
;~ WinActivate("Внимание")
;~ WinWaitActive("Внимание")
Sleep(500)
;Send("{ENTER}")

ControlClick("Внимание", "" ,"Button1" )
EndIf


$winID = WinWaitActive("Настройки оповещения", "Локальный вход", 1)

; click Тестирование УУЗС
MouseMove(77, 233)
   MouseDown("left")
   sleep(400)
   MouseUp("left")
   sleep(900)


; click Обновить

MouseMove(283, 546)
ControlClick("Настройки оповещения", "", "Button3")


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
;~ MouseMove(898, 163, 20)
;~ sleep(600)
;~ ;потянем вниз за прокрутку
;~ MouseDown($MOUSE_CLICK_LEFT)
;~ MouseMove(898, 270,100)
;~ MouseUp($MOUSE_CLICK_LEFT)



;UZSManager_cod

$pid = ProcessExists('UZSManager_cod.exe')
while($pid <> 0)

		ProcessClose($pid)
		sleep(500)
		$pid = ProcessExists('UZSManager_cod.exe')
Wend

ShellExecute("UZSManager_cod.lnk",@ScriptDir)
$hWnd=WinWaitActive("Пульт управления УУЗС")
;WinActivate("Пульт управления УУЗС")

#include <WinAPISys.au3>
_WinAPI_SetKeyboardLayout($hWnd, 0x0419) ; ru
Send(@CRLF & '0x0419 RUS'& @CR)
Send("Real layout "& _WinAPI_GetKeyboardLayout($hWnd)& @CRLF)

 ;Команды управления
ControlClick("Пульт управления УУЗС", "", "Button1")

;Отркыть
WinWaitActive("Открыть")
sleep(800)
;Прокрутка вниз
ControlFocus("Открыть","","Edit1")
sleep(1000)
ControlSetText("Открыть","","Edit1","Список расширенных команд управления.scs")
sleep(1000)
ControlClick("Открыть", "", "Button2")
sleep(1000)
;~ MouseClick("left", 99, 219)
;~ sleep(300)
;~ Send("Cпи")
;~ sleep(1000)
;Cписок расширенных команд

;выбрать команду
;~ Send("{DOWN}")
;~ sleep(600)
;~ Send("{ENTER}")
;~ sleep(400)
;set active выберите значение
;WinWaitActive("[class=CBuildCmdDockingWindow]")


;~  MouseMove(885, 367,20)
;~  sleep(800)
;~  MouseDown("left")
;~  sleep(400)
;~  MouseUp("left")

;select command "Запуск сеанса оповещения с числом повторов"

MouseClick("left",881,371,1)
Send("{DOWN}{DOWN}{ENTER}")


WinActive("[class=CBuildCmdDockingWindow]")
 ;"Значение - serNO"
sleep(100)
 mouseMove(660, 404)
 sleep(200)
 MouseClick("Left")
 sleep(200)
 MouseClick("left",660, 404, 2)
 Send($uSerNo)

 sleep(400)
MouseClick("left", 674, 419, 2)
 sleep(400)
 Send("1")

  sleep(400)
MouseClick("left",665, 434, 2)
 sleep(400)
 Send("1")

  sleep(400)
MouseClick("left", 661, 447, 2)
 sleep(400)
 Send("1")

  sleep(400)
MouseClick("left", 659, 461, 2)
 sleep(400)
 Send("1")

;выбрать управляющее устройство и запустить на выполнение
MouseClick("left",81,183,1)
MouseClick("left",782,552,1)
MouseMove(362,120)
MouseDown("left")
MouseMove(361,120)
MouseUp("left")
MouseClick("left",58,74,1)

;ждем столько сколько нужно! пока 10 сек (пока отстучит нужно засесь время)
Exit
sleep (10000)

$phase1 = MsgBox($MB_OKCANCEL,"Warning!", "Отключите фазу 1 нагрузки и нажмите ОК")
if ($phase1) then
   MouseMove(362,120)
   MouseDown("left")
   MouseMove(361,120)
   MouseUp("left")
   MouseClick("left",58,74,1)
EndIf

sleep (4000)

$phase2 = MsgBox($MB_OKCANCEL,"Warning!", "Отключите фазу 2, подключите фазу 1 нагрузки и нажмите ОК")

if ($phase2) then
   MouseMove(362,120)
   MouseDown("left")
   MouseMove(361,120)
   MouseUp("left")
   MouseClick("left",58,74,1)
EndIf

sleep (4000)

$phase3 = MsgBox($MB_OK,"Warning!", "Отключите фазу 3, подключите фазу2 и нажмите ОК")

if ($phase3) then
   MouseMove(362,120)
   MouseDown("left")
   MouseMove(361,120)
   MouseUp("left")
   MouseClick("left",58,74,1)
EndIf


$ 3 = MsgBox($MB_OK,"Warning!", "Нажмите датчик открытия двери и нажмите ОК")









