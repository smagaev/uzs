#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.0
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here
;https://blogadminday.ru/rabota-autoit-s-mssql/
;https://www.autoitscript.com/forum/topic/203542-ms-sql-connection/

#include <_sql.au3>
#include <array.au3>

Opt ("trayIconDebug",1)
;register the error handler to prevent hard crash on COM error
Msgbox(0,"","Старт скрипта и запуск обработчика ошибок")
     _SQL_RegisterErrorHandler();register the error handler to prevent hard crash on COM error

    $oADODB = _SQL_Startup()
    If $oADODB = $SQL_ERROR then Msgbox(0 + 16 +262144,"Error",_SQL_GetErrMsg())


    If _sql_Connect(-1,"localhost","","sa","Superartcore") = $SQL_ERROR then
        Msgbox(0 + 16 +262144,"Error",_SQL_GetErrMsg())
        _SQL_Close()
        Exit
    EndIf

    If _SQL_Execute(-1,"Create database My_SQL_Test;") = $SQL_ERROR then Msgbox(0 + 16 +262144,"Error",_SQL_GetErrMsg())
    _SQL_Close()

	    $oADODB = _SQL_Startup()

    If _SQL_Connect(-1,"localhost","My_SQL_Test","sa","Superartcore") = $SQL_ERROR then Msgbox(0 + 16 +262144,"Error",_SQL_GetErrMsg())
    If _SQL_Execute(-1, "CREATE TABLE BBKS (ID INT NOT NULL IDENTITY(1,1),ComputerName VARCHAR(20) UNIQUE,Status VARCHAR(10),Error VARCHAR(10)Primary Key (ID));") = $SQL_ERROR then Msgbox(0 + 16 +262144,"Error",_SQL_GetErrMsg())
    If _SQL_Execute(-1,"INSERT INTO BBKS (ComputerName,Status,Error) VALUES ('"& @computername & "','On;li''ne','None');") = $SQL_ERROR then Msgbox(0 + 16 +262144,"Error",_SQL_GetErrMsg())
    If _SQL_Execute(-1,"INSERT INTO BBKS (ComputerName,Status,Error) VALUES ('1"& @computername & "','On;li''ne','None');") = $SQL_ERROR then Msgbox(0 + 16 +262144,"Error",_SQL_GetErrMsg())
    If _SQL_Execute(-1,"INSERT INTO BBKS (ComputerName,Status,Error) VALUES ('2"& @computername & "','Online','None');") = $SQL_ERROR then Msgbox(0 + 16 +262144,"Error",_SQL_GetErrMsg())

; это приведет к ошибке, потому что поле "ComputerName" не является уникальным!
    If _SQL_Execute(-1,"INSERT INTO BBKS (ComputerName,Status,Error) VALUES ('2"& @computername & "','Online','None');") = $SQL_ERROR then Msgbox(0 + 16 +262144,"Error","Example Error this was meant to happen!" & @crlf & @crlf & _SQL_GETErrMsg())