declare @p25 int
set @p25=4
exec sp_executesql N'declare @sitID int 
select @sitID=max(SitID) from GSO.dbo.Situation where StaffID=@P1 and SubsystemID=@P2 
if @sitID is null 
  set @sitID=0 
insert GSO.dbo.Situation(SitID, StaffID, SubsystemID, SitTypeID, SitName, CodeName, Comm, SitPrior, SystemSet, CountCall, TimeoutAbon,
 CountSess, TimeoutSess, TimeNotify, ScriptParam, Status, CountRepeat, AllowTTS, AbDtmfResultCommit, AbDtmfTotalTimeout, AbDtmfRepeatCount) 
values(@sitID+1,@P3,@P4,@P5,@P6,@P7,@P8,@P9,@P10,@P11,@P12,@P13,@P14,@P15,@P16,@P17,@P18,@P19,@P20,@P21,@P22) 
select @P23=@sitID+1',N'@P1 int,@P2 int,@P3 int,@P4 int,@P5 int,@P6 nvarchar(14),@P7 nvarchar(1),@P8 nvarchar(1),@P9 int,@P10 int,@P11 int,@P12 int,@P13 int,@P14 int,@P15 int,@P16 int,@P17 int,@P18 int,@P19 int,@P20int,@P21 int,@P22 int,@P23 int OUTPUT',67764010,2,67764010,2,1,N'Тестирование 3',N'',N'',1,1,0,0,0,0,0,0,1,1,0,0,0,0,@p25 output
select @p25

*****************************************************************************************************************************

exec sp_executesql N'DECLARE @Num INT
IF (@P1 <> 0)
  SELECT @Num = GlobalNum
  FROM GSO.dbo.AsoAbonent
  WHERE (ID_ab = @P2) AND (StaffID = @P3)
ELSE
  SELECT @Num = GlobalNum
  FROM GSO.dbo.SZSDevice
  WHERE (SZSDevID = @P4) AND (StaffID = @P5)

INSERT GSO.dbo.SitItem (SitID, SitStaffID, SitSubsystemID, AsoAbonStaffID, AsoAbonID, SZSDevStaffID, SZSDevID, SZSGroupStaffID, SZSGroupID, CmdID, CmdSubsystemID, CmdParam, MsgID, MsgStaffID, ListID, ListStaffID, ListSubsystemID, Param1, Param2, GlobalNum)
VALUES (@P6, @P7, @P8, @P9, @P10, @P11, @P12, @P13, @P14, @P15, @P16, @P17, @P18, @P19, @P20, @P21, @P22, @P23, @P24, @Num)
',N'@P1 int,@P2 int,@P3 int,@P4 int,@P5 int,@P6 int,@P7 int,@P8 int,@P9 int,@P10 int,@P11 int,@P12 int,@P13 int,@P14 int,@P15 int,@P16 int,@P17 int,@P18 int,@P19 int,@P20 int,@P21 int,@P22 int,@P23 int,@P24 int',0,0,0,11001,67764010,4,67764010,2,0,0,67764010,11001,0,0,8,2,0,0,0,0,0,0,786432,0


*******************************************************************************************************************************

exec sp_executesql N'DECLARE	@AsoAbonID INT, @SitID INT, @SitStaffID INT, @SitSubsystemID INT, @SZSDevID INT, @SZSDevStaffID INT, @SZSGroupID INT, @SZSGroupStaffID INT
SELECT @AsoAbonID = @P1, @SitID = @P2, @SitStaffID = @P3, @SitSubsystemID = @P4, @SZSDevID = @P5, @SZSDevStaffID = @P6, @SZSGroupID = @P7, @SZSGroupStaffID = @P8

IF (@AsoAbonID = 0 AND @SZSDevID <> 0)
BEGIN
  -- Добавить все зоны устройств для участия в оповещении
  INSERT GSO.dbo.SitItem (SitID, SitStaffID, SitSubsystemID, AsoAbonStaffID, AsoAbonID, SZSDevStaffID, SZSDevID, SZSGroupStaffID, SZSGroupID, CmdID, CmdSubsystemID, CmdParam, MsgID, MsgStaffID, ListID, ListStaffID, ListSubsystemID, Param1, Param2, GlobalNum, ParentSZSDevID, OrderOnParent)
  SELECT s.SitID, s.SitStaffID, s.SitSubsystemID, 0, 0, d.StaffID, d.SZSDevID, s.SZSGroupStaffID, s.SZSGroupID, s.CmdID, s.CmdSubsystemID, s.CmdParam, s.MsgID, s.MsgStaffID, s.ListID, s.ListStaffID, s.ListSubsystemID, s.Param1, s.Param2, 0, d.ParentSZSDevID, d.OrderOnParent
  FROM GSO.dbo.SitItem s INNER JOIN
    GSO.dbo.SZSDevice d ON s.SZSDevID = d.ParentSZSDevID AND s.SZSDevStaffID = d.ParentStaffID
  WHERE (d.Status >= 0) AND (s.Status >= 0) AND (s.SitID = @SitID) AND (s.SitStaffID = @SitStaffID) AND (s.SitSubsystemID = @SitSubsystemID) AND (d.ParentSZSDevID = @SZSDevID) AND (d.ParentStaffID = @SZSDevStaffID) /*AND ((s.Param1 & POWER(2, d.OrderOnParent)) <> 0)*/ AND (s.SZSGroupStaffID = @SZSGroupStaffID) AND (s.SZSGroupID = @SZSGroupID)

  -- Пометить не учавствующие зоны как неактивные
  UPDATE si2
  SET si2.Status = -1
  FROM GSO.dbo.SitItem as si1 INNER JOIN
       GSO.dbo.SitItem as si2 ON (si1.SitID = si2.SitID) AND (si1.SitStaffID = si2.SitStaffID) AND (si1.SitSubsystemID = si2.SitSubsystemID) AND (si1.SZSDevID = si2.ParentSZSDevID)
  WHERE (si1.SitID = @SitID) AND (si1.SitStaffID = @SitStaffID) AND (si1.SitSubsystemID = @SitSubsystemID) AND (si1.SZSDevID = @SZSDevID) AND (si1.ParentSZSDevID = 0) AND (si2.ParentSZSDevID = si1.SZSDevID) AND ((si1.Param1 = 0) OR ((si1.Param1 <> 0) AND ((si1.Param1 & POWER(2, si2.OrderOnParent)) = 0)))
END
',N'@P1 int,@P2 int,@P3 int,@P4 int,@P5 int,@P6 int,@P7 int,@P8 int',0,4,67764010,2,11001,67764010,0,0


-----?????

exec sp_executesql N'declare @UserID int, @TypeID int, @ObjID int, @StaffID int, @SubsystemID int, @PermitAccess int, @DenyAccess int 
select @UserID = @P1, @TypeID = @P2, @ObjID = @P3, @StaffID = @P4, @SubsystemID = @P5, @PermitAccess = @P6, @DenyAccess = @P7 
if exists (select * from GSO.dbo.GsoUserSecurityLink WHERE UserID = @UserID AND TypeID = @TypeID AND ObjID = @ObjID AND StaffID = @StaffID AND SubsystemID = @SubsystemID) 
  UPDATE GSO.dbo.GsoUserSecurityLink 
  SET PermitAccess = @PermitAccess, DenyAccess = @DenyAccess 
  WHERE UserID = @UserID AND TypeID = @TypeID AND ObjID = @ObjID AND StaffID = @StaffID AND SubsystemID = @SubsystemID 
else 
  insert into GSO.dbo.GsoUserSecurityLink (UserID, TypeID, ObjID, StaffID, SubsystemID, PermitAccess, DenyAccess) 
  values (@UserID, @TypeID, @ObjID, @StaffID, @SubsystemID, @PermitAccess, @DenyAccess) ',N'@P1 int,@P2 int,@P3 int,@P4 int,@P5 int,@P6 int,@P7 int',1,3,4,67764010,2,1,0
  
  
  
  
  
  exec sp_executesql N'insert into GSO.dbo.EventLog(SubsystemID, RegTime, Source, Type, EventCode, UserID, Info)values(@P1, @P2, @P3, @P4, @P5, @P6, @P7)',N'@P1 int,@P2 datetime,@P3 int,@P4 int,@P5 int,@P6 int,@P7 varbinary(1)',2,'2024-02-03 05:52:21',12,3,79,1,NULL