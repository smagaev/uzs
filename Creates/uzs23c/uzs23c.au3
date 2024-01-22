#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.0
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here

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
Opt("CarretCoordMode",3);
;close running deviceconsole
$pid = ProcessExists('deviceconsole.exe')
while($pid <> 0)

		ProcessClose($pid)
		sleep(1000)
		$pid = ProcessExists('deviceconsole.exe')
WEnd

 ;Run(@ScriptDir,"clear_all.bat")
 ;ShellExecute('clear_all.bat',@ScriptDir)
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
 	Wend
 BlockInput(0)



;run script uzs3
;Local $iPID = ShellExecute('uzs1.bat', $uUnam &  "  " & $uCountElem ,@ScriptDir )
Local $iPID = ShellExecute('uzs3.bat', $uSerNo& " " & hex(1&StringRight($uSerNo,2),2) ,@ScriptDir )

;ProcessWaitClose($iPID)

; run script regAdd



;~ ShellExecute("DeviceConsole.lnk",@ScriptDir)
;~ $winID = WinWaitActive("Настройки оповещения")
;~ MouseMove(18, 197)

;RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\SensorM\GSO\Ports", "TCP192.168.1.1"%1" ,"REG_DWORD", "0x0002b210")
;RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\SensorM\GSO\Ports\Params", "TCP192.168.1.1%2","REG_BINARY","000000008501a8c011270000000000000000")
