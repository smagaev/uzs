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

MouseClick("left", 99, 219)
sleep(300)
Send("Cпи")
sleep(500)
;Cписок расширенных команд

;выбрать команду
Send("{DOWN}")
sleep(600)
Send("{ENTER}")
sleep(400)
;set active выберите значение
WinWaitActive("[class=CBuildCmdDockingWindow]")


MouseMove(885, 367,20)
sleep(800)
MouseDown("left")
sleep(400)
MouseUp("left")











