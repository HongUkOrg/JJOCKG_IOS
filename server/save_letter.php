<?php header('Content-type: text/plain; charset=utf-8');
    
    $json = file_get_contents('php://input');
    $data = json_decode($json);
    
    $sender_phone = $data->{'sender_phone'};
    $receiver_phone = $data->{'receiver_phone'};
    $title = $data->{'title'};
    $message = $data->{'message'};
    $w3w_address = $data->{'w3w_address'};
    $latitude = $data->{'latitude'};
    $longitude=$data->{'longitude'};
    $time_lock=$data->{'time_lock'};
  
    $servername = "localhost";
    $username = "phwysl";
    $password = "dlxl1234";
    $dbname = "phwysl";
    
    // Create connection
    $conn = new mysqli($servername, $username, $password, $dbname);
    // Check connection
    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }

    mysqli_set_charset($conn,'utf8');
    
    $sql = "INSERT INTO SSS (id, sender_phone, receiver_phone,title,message,w3w_address,latitude,longitude,time_lock,created_date,opened_date)
    VALUES ('','$sender_phone','$receiver_phone','$title', '$message','$w3w_address','$latitude','$longitude','$time_lock','','')";
    
    if ($conn->query($sql) === TRUE) {
        echo "New record created successfully. letter message : ".$message;
    } else {
        echo "Error: " . $sql . "<br>" . $conn->error;
    }
    
    $conn->close(); ?>
