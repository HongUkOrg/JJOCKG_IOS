<?php header('Content-type: text/plain; charset=utf-8');
    
    
    $json = file_get_contents('php://input');
    $data = json_decode($json);
    
    $receiver_phone = "010-4592-4061";
    $w3w_address = "hidden,strictly,epic";
    
    $receiver_phone = $data->{'receiver_phone'};
    $w3w_address = $data->{'w3w_address'};
   
    
    
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

    $sql = "SELECT latitude,longitude,title, message,time_lock FROM SSS WHERE receiver_phone='$receiver_phone' AND w3w_address='$w3w_address'";
    $result = $conn->query($sql);
    $count = 1;
    if ($result->num_rows > 0) {
        // output data of each row
        echo "{\"letter\":[";
        while($row = $result->fetch_assoc()) {
            echo "{\"title\":\"". $row["title"]."\",\"message\":\"".$row["message"]. "\",\"latitude\":\"".$row["latitude"]."\",\"longitude\":\"". $row["longitude"]."\",\"time_lock\":\"".$row["time_lock"]."\"}";
            if($result->num_rows != $count) echo ",";
            else echo "]}";
            $count++;
        }
    } else {
        echo "{\"letter\":[{\"title\":\"find_fail\"}]}";
    }
    $conn->close();
    ?>
