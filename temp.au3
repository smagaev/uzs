#include <MsgBoxConstants.au3>

$phase1 = MsgBox($MB_OK,"Warning!", "Отключите фазу 1 нагрузки и нажмите ОК")

if ($phase1) then
   MsgBox($MB_OK, "Message", $phase1)
   MouseMove(362,120)
   MouseDown("left")
   MouseMove(361,120)
   MouseUp("left")
   MouseClick("left",58,74,1)
EndIf


$phase2 = MsgBox($MB_OKCANCEL,"Warning!", "Отключите фазу 2 нагрузки и нажмите ОК")

if ($phase2) then
   MouseMove(362,120)
   MouseDown("left")
   MouseMove(361,120)
   MouseUp("left")
   MouseClick("left",58,74,1)
EndIf


$phase3 = MsgBox($MB_OK,"Warning!", "Отключите фазу 2 нагрузки и нажмите ОК")

if ($phase3) then
   MouseMove(362,120)
   MouseDown("left")
   MouseMove(361,120)
   MouseUp("left")
   MouseClick("left",58,74,1)
EndIf










