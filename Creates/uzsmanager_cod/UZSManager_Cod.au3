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

Opt("MouseCoordMode", 3);
Opt("CaretCoordMode", 3);

;UZSManager_cod

$pid = ProcessExists('UZSManager_cod.exe')
while($pid <> 0)

		ProcessClose($pid)
		sleep(500)
		$pid = ProcessExists('UZSManager_cod.exe')
Wend

ShellExecute("UZSManager_cod.lnk",@ScriptDir)
$hWnd=WinWaitActive("Пульт управления УУЗС")

;wait while all finished uzs apper
sleep(2000)

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

;select command "Запуск сеанса оповещения с числом повторов"

MouseClick("left",443, 326,1)
Send("{DOWN}{DOWN}{ENTER}")

exit
WinWaitActive("Пульт управления УУЗС", "SysListView321")
 ;"Значение - serNO"
sleep(100)
 mouseMove(443, 347)
 sleep(200)

 MouseClick("Left")
 sleep(200)
 MouseClick("left",443, 347, 2)
 Send($uSerNo)

 sleep(400)
MouseClick("left", 443, 347, 2)
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

3 = MsgBox($MB_OK,"Warning!", "Нажмите датчик открытия двери и нажмите ОК")









