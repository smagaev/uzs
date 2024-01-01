#include<MsgBoxConstants.au3>
#RequireAdmin
BlockInput(1)

Opt("MouseCoordMode", 0) ;

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

BlockInput(0)
MsgBox( $MB_OK, "Title","all ok")
BlockInput(1)

;Настройки диспетчера управляющих устройств отличаются от .... 
 WinWaitActive("[CLASS:DeviceConsole]","Внимание", 5)
  MouseClick("left",  231, 133)
 
; click Тестирование УУЗС
   MouseClick("left",  86, 230)
   
; click Обновить
MouseClick("left",  86, 230)
sleep(1000)
MouseClick("left",  86, 230)
sleep(1000)
MouseClick("left",  86, 230)
sleep(1000)
 
 BlockInput(0)
 
 
 




