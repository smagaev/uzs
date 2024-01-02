#include <MsgBoxConstants.au3>
#RequireAdmin


 ShellExecute("DeviceConsole.lnk", @scriptdir)
$id = WinWaitActive("Внимание")

MsgBox($MB_OK, "Title", $id , 10)