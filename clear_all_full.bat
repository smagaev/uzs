@sqlcmd -Q "delete FROM [GSO].[dbo].[SitItem]" > null
@sqlcmd -Q "delete FROM [GSO].[dbo].[SZSShedule]" > null
@sqlcmd -Q "delete FROM [GSO].[dbo].[SZSSgsInfo]" > null
@sqlcmd -Q "delete FROM [GSO].[dbo].[SessionItemTop]" >null
@sqlcmd -Q "delete FROM [GSO].[dbo].[SessionItem]" >null
@sqlcmd -Q "delete FROM [GSO].[dbo].[SitItem]" >null 
@sqlcmd -Q "delete FROM [GSO].[dbo].[SZSDevice] where SZSDevID <> 0" >null
@sqlcmd -Q "delete FROM [GSO].[dbo].[LinesBinding]" >null
@sqlcmd -Q "delete FROM [GSO].[dbo].[Line]" >null
@sqlcmd -Q "delete FROM [GSO].[dbo].[SZSChannelBoard]" >null
@sqlcmd -Q "delete FROM [GSO].[dbo].[Device]" >null
@reg delete HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\SensorM\GSO\Ports /f >null
@del null
net stop SCSChLService
net start SCSChLService
@echo "****** All UZS devices and lines deleted! ******"
@pause