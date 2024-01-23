#include <_sql.au3>
#include <array.au3>

Opt ("trayIconDebug",1)

Msgbox(0,"","Start the Script and load the error handler")
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


Msgbox(0,"","Created datatbase logging out and back in again")
    $oADODB = _SQL_Startup()



    If _SQL_Connect(-1,"localhost","My_SQL_Test","sa","Superartcore") = $SQL_ERROR then Msgbox(0 + 16 +262144,"Error",_SQL_GetErrMsg())
    If _SQL_Execute(-1, "CREATE TABLE BBKS (ID INT NOT NULL IDENTITY(1,1),ComputerName VARCHAR(20) UNIQUE,Status VARCHAR(10),Error VARCHAR(10)Primary Key (ID));") = $SQL_ERROR then Msgbox(0 + 16 +262144,"Error",_SQL_GetErrMsg())
    If _SQL_Execute(-1,"INSERT INTO BBKS (ComputerName,Status,Error) VALUES ('"& @computername & "','On;li''ne','None');") = $SQL_ERROR then Msgbox(0 + 16 +262144,"Error",_SQL_GetErrMsg())
    If _SQL_Execute(-1,"INSERT INTO BBKS (ComputerName,Status,Error) VALUES ('1"& @computername & "','On;li''ne','None');") = $SQL_ERROR then Msgbox(0 + 16 +262144,"Error",_SQL_GetErrMsg())
    If _SQL_Execute(-1,"INSERT INTO BBKS (ComputerName,Status,Error) VALUES ('2"& @computername & "','Online','None');") = $SQL_ERROR then Msgbox(0 + 16 +262144,"Error",_SQL_GetErrMsg())

; this one will cause an error because the computername is not unique!
    If _SQL_Execute(-1,"INSERT INTO BBKS (ComputerName,Status,Error) VALUES ('2"& @computername & "','Online','None');") = $SQL_ERROR then Msgbox(0 + 16 +262144,"Error","Example Error this was meant to happen!" & @crlf & @crlf & _SQL_GETErrMsg())



Msgbox(0,"","Created table and added data so lets get some data out first as a 2dArray")

    Local $aData,$iRows,$iColumns;Variables to store the array data in to and the row count and the column count
    $iRval = _SQL_GetTable2D(-1,"SELECT * FROM BBKS;",$aData,$iRows,$iColumns)
    If $iRval = $SQL_OK then _arrayDisplay($aData,"2D  (" & $iRows & " Rows) (" & $iColumns & " Columns)" )




Msgbox(0,"","Next as a 1dArray")

    Local $aData,$iRows,$iColumns;Variables to store the array data in to and the row count and the column count
    $iRval = _SQL_GetTable(-1,"SELECT * FROM BBKS;",$aData,$iRows,$iColumns)
    If $iRval = $SQL_OK then _arrayDisplay($aData,"1D (" & $iRows & " Rows) (" & $iColumns & " Columns)"  )




Msgbox(0,"","And now the same data returned 1 row at a time")

    $hData = _SQL_Execute(-1,"SELECT * FROM BBKS;")

    Local $aNames;Variable to store the array data in to
    $iRval = _SQL_FetchNames ($hData, $aNames); Read out Column Names
    If $iRval = $SQL_OK then ConsoleWrite(StringFormat(" %-10s  %-10s  %-10s  %-10s ", $aNames[0], $aNames[1], $aNames[2], $aNames[3]) & @CR)
    _ArrayDisplay($aNames,"Column Names")

    Local $aRow;Variable to store the array data in to
    While _SQL_FetchData ($hData, $aRow) = $SQL_OK; Read Out the next Row
        ConsoleWrite(StringFormat(" %-10s  %-10s  %-10s  %-10s ", $aRow[0], $aRow[1], $aRow[2], $aRow[3]) & @CR)
        _ArrayDisplay($aRow,"Single Row of Data")
    WEnd





Msgbox(0,"","And now the same data returned as a string")

    Local $vString
    If _Sql_GetTableAsString(-1,"SELECT * FROM BBKS;",$vString) = $SQL_OK then
        Msgbox(0,"Data as a String",$vString)
    Else
        Msgbox(0 + 16 +262144,"SQL Error",_SQL_GetErrMsg() )
    EndIf




Msgbox(0,"","Now just a single row")

    Local $aRow;Variable to store the row array data in
    $iRval = _SQL_QuerySingleRow(-1,"SELECT * FROM BBKS;",$aRow)
    If $iRval = $SQL_OK then _arrayDisplay($aRow,"1 Row"  )




Msgbox(0,"","Now drop the tables and the database")
    If _SQL_Execute(-1, "DROP TABLE BBKS;") = $SQL_ERROR then Msgbox(0 + 16 +262144,"Error",_SQL_GetErrMsg())

    If _SQL_Close() <> $SQL_OK then Msgbox(0 + 16 +262144,"Error",_SQL_GetErrMsg() )


;Just being lazy and not putting any error checking in now!
    $oADODB = _SQL_Startup()
    _SQL_Connect(-1,"localhost","","sa","Superartcore")
    _SQL_Execute(-1,"DROP database My_SQL_Test;")
    _SQL_Close()

Msgbox(0,"","Example Finished")