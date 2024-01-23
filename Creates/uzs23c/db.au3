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


    $serNoSZDevice =  11111;

	const $SZDeviceName = "Terminal - "  & $serNoSZDevice
	const $name = 'Управление - '  & $serNoSZDevice
    const $ip = 1 & StringRight($serNoSZDevice,2)
    const $phone = $ip
	const $lineName = 'Линия - ' & $serNoSZDevice
	const $serNo = -1062731520 + Int($ip)
	const $PortNo = $serNo
	const $DeviceName = 'COM' & $serNo & ' - HSCOM TCP XPORT'

	; --1. Created device
    If _SQL_Execute(-1,"insert GSO.dbo.Device(SubsystemID, ComputerID, Status, AsoTypeConnect, AsoConnID, DeviceName, DeviceComm, SerNo, PortNo, OrderOnPort, ChannelsCount) values(2,0,1,NULL,NULL,'"&$DeviceName&"','',NULL,"&$PortNo&",0,0);") = $SQL_ERROR then Msgbox(0 + 16 +262144,"Error",_SQL_GetErrMsg())
    $hData = _SQL_Execute(-1,"select max(DeviceID) from GSO.dbo.Device")
    Local $vString2

	if _SQL_FetchData( $hData, $vString2) = $SQL_OK then
	  Msgbox(0,"DeviceID", "Created device: " & $vString2 [0])
	Else
	  Msgbox(0 + 16 +262144,"SQL Error",_SQL_GetErrMsg() )
    EndIf
	const $DeviceID = $vString2 [0]

	;	-- 2. Create Channel --
	$query ="insert GSO.dbo.SZSChannelBoard(DeviceID, Status, Name, DevType, DevVer, SerNo, PortNo, OrderOnPort, ChannelsCount) values(" & $DeviceID & ",1,'"& $name& "',45584,2," &$serNo& "," &$PortNo& ",0,1)"
    If _SQL_Execute(-1,$query) = $SQL_ERROR then Msgbox(0 + 16 +262144,"Error",_SQL_GetErrMsg())

	$hData = _SQL_Execute(-1,"select max(ChannelBoardID) from GSO.dbo.SZSChannelBoard")
    Local $vString2
    if _SQL_FetchData( $hData, $vString2) = $SQL_OK then
	  Msgbox(0,"ChanBoardDevID", "ChanBoardDevID: " & $vString2 [0])
	Else
	  Msgbox(0 + 16 +262144,"SQL Error",_SQL_GetErrMsg() )
    EndIf
	const $ChanBoardDevID = $vString2 [0]

    ;-- 3. Create line --

	$query = "INSERT INTO GSO.dbo.Line (SubsystemID,LocationID,LocationStaffID,ChannelType,GlobalRestrictMask,UserRestrictMask,PropertyMask,LineName,Phone,Status,LineState,ExtParam)VALUES(2,NULL,NULL,5,0,0,0,'"  & $lineName &"',"&$phone&",1,NULL,NULL)"
    ;MsgBox(1, "line", $query)
    If _SQL_Execute(-1,$query) = $SQL_ERROR then Msgbox(0 + 16 +262144,"Error",_SQL_GetErrMsg())


	;-- 4. Line binding --

	$query = "INSERT INTO GSO.dbo.LinesBinding(LineID,ChanBoardDevID,ChanBoardID,DeviceID,ChannelNumber,RdmDeviceID) VALUES((Select max(LineID)from GSO.dbo.line),"   &   $DeviceID  &  "," & $ChanBoardDevID &  ",NULL,NULL,NULL)"
	;MsgBox(1, "line", $query)
    If _SQL_Execute(-1,$query) = $SQL_ERROR then Msgbox(0 + 16 +262144,"Error",_SQL_GetErrMsg())

   	;-- 5. Terminal device --
	$query = "INSERT INTO GSO.dbo.SZSDevice (SZSDevID,StaffID,DevName,Priority,Status,GlobalNum,[Level],ParentStaffID,ParentSZSDevID,OrderOnParent,Visiable,ActivationCode,GPS) VALUES(" & $serNoSZDevice & ", (select max(StaffID)FROM GSO.dbo.Staff), '" & $SZDeviceName & "' , 1, 1, 0, 0, 0, 0, 0, 1, '','')"
    ;MsgBox(1, "line", $query)
	If _SQL_Execute(-1,$query) = $SQL_ERROR then Msgbox(0 + 16 +262144,"Error",_SQL_GetErrMsg())

	;--6. Terminal device --
	;--ConnParam -> linesBinding(lineID)
	$query = "INSERT INTO GSO.dbo.SZSShedule(SZSDevID,DevStaffID,DevClassID,BaseType,GlobalType,UserType,ConnParam,PriorType,CurrCall) VALUES("& $serNoSZDevice & ",(select max(StaffID)FROM GSO.dbo.Staff),22,5,0,0,(SELECT MAX([LineID])FROM [GSO].[dbo].[LinesBinding]),1,0)"
    ;MsgBox(1, "line", $query)
	If _SQL_Execute(-1,$query) = $SQL_ERROR then Msgbox(0 + 16 +262144,"Error",_SQL_GetErrMsg())

	;--7. --
	$query = "INSERT INTO GSO.dbo.SZSSgsInfo(SZSDevID,StaffID,ZoneCount)VALUES(" & $serNoSZDevice & ",(select max(StaffID)FROM GSO.dbo.Staff),1)"
	MsgBox(1, "line", $query)
	If _SQL_Execute(-1,$query) = $SQL_ERROR then Msgbox(0 + 16 +262144,"Error",_SQL_GetErrMsg())



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