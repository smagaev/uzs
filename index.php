
<?php
echo phpinfo(); die; 
$serverName = "WIN-4NDKPT8U47G\\sqlexpress"; //serverName\instanceName
$connectionInfo = array( "Database"=>"GSO");
$conn = sqlsrv_connect( $serverName, $connectionInfo);

if( $conn ) {
     echo "Соединение установлено.<br />";
}else{
     echo "Соединение не установлено.<br />";
     die( print_r( sqlsrv_errors(), true));
}
?>