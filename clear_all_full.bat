::[Bat To Exe Converter]
::
::YAwzoRdxOk+EWAnk
::fBw5plQjdG8=
::YAwzuBVtJxjWCl3EqQJgSA==
::ZR4luwNxJguZRRnk
::Yhs/ulQjdF+5
::cxAkpRVqdFKZSDk=
::cBs/ulQjdF+5
::ZR41oxFsdFKZSDk=
::eBoioBt6dFKZSDk=
::cRo6pxp7LAbNWATEpCI=
::egkzugNsPRvcWATEpCI=
::dAsiuh18IRvcCxnZtBJQ
::cRYluBh/LU+EWAnk
::YxY4rhs+aU+JeA==
::cxY6rQJ7JhzQF1fEqQJQ
::ZQ05rAF9IBncCkqN+0xwdVs0
::ZQ05rAF9IAHYFVzEqQJQ
::eg0/rx1wNQPfEVWB+kM9LVsJDGQ=
::fBEirQZwNQPfEVWB+kM9LVsJDGQ=
::cRolqwZ3JBvQF1fEqQJQ
::dhA7uBVwLU+EWDk=
::YQ03rBFzNR3SWATElA==
::dhAmsQZ3MwfNWATElA==
::ZQ0/vhVqMQ3MEVWAtB9wSA==
::Zg8zqx1/OA3MEVWAtB9wSA==
::dhA7pRFwIByZRRnk
::Zh4grVQjdCyDJEye534TOh5VWAGRAG6iA4kf5O36/dWSuF5TUfo6GA==
::YB416Ek+ZG8=
::
::
::978f952a14a936cc963da21a135fa983
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
@echo "****** All UZS devices and lines deleted! ******"
@pause