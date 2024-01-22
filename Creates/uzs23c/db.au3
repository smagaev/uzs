#include <_sql.au3>

_SQL_RegisterErrorHandler()

; Create ADODB.Connection object
$oADODB = _SQL_Startup()
If @error Then
    MsgBox(0x10, 'Error', 'Failed to create ADODB.Connection object')
    Exit
EndIf

; Create an array to store connection credentials (2 servers in my case)
; This array can be obtained from an ini file like in your case
; [Server, Database, Username, Password]
Local $aServerInfo[1][4] = [['localhost', 'GSO', 'sa', 'l0017']]

$Connect = Connect($oADODB, $aServerInfo, 2)
If @error Or ($Connect = $SQL_ERROR) Then
    MsgBox(0x10, 'Error', 'Could not estabilish a connection to any server.')
Else
    MsgBox(0x40, 'Yayyy', 'Connection estabilished with ' & $aServerInfo[@extended][0] & '.')
 EndIf

;~ 	declare @name varchar(40)
;~ 	declare @DeviceID int
;~ 	declare @serNo int
;~ 	declare @ip int
;~ 	declare @PortNo int
;~ 	declare @DeviceName varchar(40)
;~ 	declare @lineName varchar(20)
;~ 	declare @phone int
;~ 	Declare @SZDeviceID int
;~ 	Declare @SZDeviceName varchar(40)
;~ 	Declare @serNoSZDevice int


    $serNoSZDevice =  55536;

	const $ZDeviceName = "Terminal - "  & $serNoSZDevice
	const $name = 'Управление - '  & $serNoSZDevice
    const $ip = 1 & StringRight($serNoSZDevice,2)
    const $phone = $ip
	const $lineName = 'Линия - ' & $serNoSZDevice
	const $serNo = -1062731520 + Int($ip)
	const $PortNo = $serNo
	const $DeviceName = 'COM' & $serNo & ' - HSCOM TCP XPORT'
	;const $DeviceName = "83945322"
MsgBox(0, "HI", $DeviceName)
If _SQL_Execute(-1,"insert GSO.dbo.Device(SubsystemID, ComputerID, Status, AsoTypeConnect, AsoConnID, DeviceName, DeviceComm, SerNo, PortNo, OrderOnPort, ChannelsCount) values(2,0,1,NULL,NULL,"&$DeviceName&",'',NULL,"&$PortNo&",0,0);") = $SQL_ERROR then Msgbox(0 + 16 +262144,"Error",_SQL_GetErrMsg())
	;set @DeviceID = @@IDENTITY

_SQL_Close($oADODB)
_SQL_UnRegisterErrorHandler()

Func Connect($oADODB, $aServerInfo, $iTimeout = 15)
    ; Connect to first available server for a connections pool
    If Not IsObj($oADODB) Then Return SetError(1, 0, Null)
    If Not IsArray($aServerInfo) Then Return SetError(2, 0, Null)
    _SQL_ConnectionTimeout($oADODB, $iTimeout)
    For $Index = 0 To UBound($aServerInfo) - 1
        If _SQL_Connect($oADODB, $aServerInfo[$Index][0], $aServerInfo[$Index][1], $aServerInfo[$Index][2], $aServerInfo[$Index][3]) = $SQL_OK Then
            ; If we successfully connect to a server
            Return SetError(0, $Index, $SQL_OK)
        EndIf
    Next
    ; If we couldn't connect to any server
    Return SetError(0, 0, $SQL_ERROR)
EndFunc