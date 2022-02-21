<?php

$connection = sqlsrv_connect('db', ['Database' => 'master', 'UID' => 'sa', 'PWD' => 'MySuperSecurePassword1!']);

var_dump( sqlsrv_errors() );


sqlsrv_query($connection, "CREATE TABLE users (id INT NOT NULL, name VARCHAR(80) NOT NULL, time DATETIME NOT NULL);");

sqlsrv_query($connection, 'INSERT INTO users (id, name, time) VALUES (?, ?, ?)', [2, "John Doe", "2021-01-01 12:34:56"]);

$result = sqlsrv_query($connection, "SELECT * FROM users", [], ['Scrollable' => SQLSRV_CURSOR_STATIC]);

if ( $result === FALSE ) {
    exit(1);
}

$row_count = sqlsrv_num_rows($result);

echo "Number of rows: $row_count . <br><br>";

while ( $row =  sqlsrv_fetch_array($result, SQLSRV_FETCH_ASSOC) ) {
    print_r( $row );
    echo '<br>';
}



// var_dump( $rows );
