#RequireAdmin
Opt("CaretCoordMode", 2)
Opt("MouseCoordMode", 2)
Run(@CommonFilesDir & "\SensorM\DeviceConsole.exe")
$hwnd = WinWait("��������� ����������","")
If Not $hWnd Then
    MsgBox(4096, '���������', '��������� �� �������, ��������� ������ �������')
    Exit
 EndIf
 WinActivate("��������� ����������","������� ���� ������:")
 SendKeepActive("��������� ����������","������� ���� ������:")
sleep(60)

MouseClick('left',10, 127,1)

WinWait("����������� ������������","")
Send("{ENTER}")
