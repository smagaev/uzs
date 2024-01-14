@Set /P No=Serial number of UZS2/3c:

sqlcmd -q "declare @name varchar(40)"
@echo "declare @DeviceID int"
pause
exit
declare @serNo int
declare @ip int
declare @PortNo int
declare @DeviceName varchar(40)
declare @lineName varchar(20)
declare @phone int
Declare @SZDeviceID int
Declare @SZDeviceName varchar(40)
Declare @serNoSZDevice int

Set @serNoSZDevice =  $(No)+@i;
--Set @serNoSZDevice =  99999+@i;

Set @SZDeviceName = 'Терминал - '  + CONVERT(varchar, @serNoSZDevice)
set @name = 'Управление - '+ CONVERT(varchar, @serNoSZDevice)
set @ip = 100 + @serNoSZDevice % 100
set @phone = @ip
set @lineName = 'Линия - ' + CONVERT(varchar, @serNoSZDevice)
set @serNo = -1062731520 + @ip
set @PortNo = @serNo
set @DeviceName = 'COM'
set @DeviceName += CONVERT(varchar,@serNo)
set @DeviceName += ' - HSCOM TCP Xport'

-- 1. Creat Device --
insert GSO.dbo.Device(SubsystemID, ComputerID, Status, AsoTypeConnect, AsoConnID, DeviceName, DeviceComm, SerNo, PortNo, OrderOnPort, ChannelsCount) values(2,0,1,NULL,NULL,@DeviceName,'',NULL,@PortNo,0,0);
set @DeviceID = @@IDENTITY

-- 2. Create Channel --
insert GSO.dbo.SZSChannelBoard(DeviceID, Status, Name, DevType, DevVer, SerNo, PortNo, OrderOnPort, ChannelsCount) values(@DeviceID,1,@name,45584,2,@serNo,@PortNo,0,1)

-- 3. Create line --
declare @ChanBoardDevID int
set @ChanBoardDevID = @@IDENTITY

INSERT INTO GSO.dbo.Line (SubsystemID,LocationID,LocationStaffID,ChannelType,GlobalRestrictMask,UserRestrictMask,PropertyMask,LineName,Phone,Status,LineState,ExtParam)
VALUES(2,NULL,NULL,5,0,0,0,@lineName,@phone,1,NULL,NULL)

-- 4. Line binding --

INSERT INTO GSO.dbo.LinesBinding(LineID,ChanBoardDevID,ChanBoardID,DeviceID,ChannelNumber,RdmDeviceID) VALUES(@@IDENTITY,@DeviceID,@ChanBoardDevID,NULL,NULL,NULL)

Declare @StaffID int = ( select max(StaffID)  FROM GSO.dbo.Staff)

-- 5. Terminal device --
INSERT INTO GSO.dbo.SZSDevice (SZSDevID,StaffID,DevName,Priority,Status,GlobalNum,[Level],ParentStaffID,ParentSZSDevID,OrderOnParent,Visiable,ActivationCode,GPS)           
VALUES(@serNoSZDevice, @StaffID,@SZDeviceName, 1, 1, 0, 0, 0, 0, 0, 1, '','') 

--6. Terminal device --

INSERT INTO GSO.dbo.SZSShedule(SZSDevID,DevStaffID,DevClassID,BaseType,GlobalType,UserType,ConnParam,PriorType,CurrCall) VALUES(@serNoSZDevice,@StaffID,22,5,0,0,@DeviceID,1,0)

--7. --
INSERT INTO GSO.dbo.SZSSgsInfo(SZSDevID,StaffID,ZoneCount)
     VALUES(@serNoSZDevice,@StaffID,1)

@REG ADD HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\SensorM\GSO\Ports /v "TCP192.168.1.1%No:~-2%" /t REG_DWORD /d 0x0001b210 > null
@REG ADD HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\SensorM\GSO\Ports\Params /v "TCP192.168.1.1%No:~-2%" /t REG_BINARY /d 000000008501a8c011270000000000000000 /f > null 
@echo "UZS2/3c created"
del null
@pause
