<?php

$query = $_POST['query'];

 include "info.php";
        $dbServer = "localhost";
        $dbname = "vcardenas";

        $conn = new mysqli($dbServer, $username, $password, $dbname);

        if($conn->connect_error) {
                die("Connection failed: ". $conn->connect_error);
        }



        $result = $conn->query($query);


        if(!$result){
                echo "error description: " . mysqli_error($conn);
        }

        echo "<table border='1'><tr>";

        while ($queryRow = $result->fetch_row()) {
                echo "<tr>";
                for($i = 0; $i < $result->field_count; $i++){
                        echo "<td>$queryRow[$i]</td>";
                }
                echo "</tr>";
        }
        echo "</table>";






 $conn->close();

?>









// SECOND ONE:
<?php

$query = $_POST['query'];

 include "info.php";
        $dbServer = "localhost";
        $dbname = "vcardenas";

        $conn = new mysqli($dbServer, $username, $password, $dbname);

        if($conn->connect_error) {
                die("Connection failed: ". $conn->connect_error);
        }



        $result = $conn->query($query);


        if(!$result){
                echo "error description: " . mysqli_error($conn);
        }

        echo "<table border='1'>";




        echo "<tr>";
    while($mysql_query_fields = mysqli_fetch_field($result)){
        $mysql_fields[] = $mysql_query_fields->name;
        echo "<th align='left'>".ucfirst($mysql_query_fields->name)."</th>";
    }
    echo "</tr>";





        while ($queryRow = $result->fetch_row()) {
                echo "<tr>";
                for($i = 0; $i < $result->field_count; $i++){
                        echo "<td>$queryRow[$i]</td>";
                }
                echo "</tr>";
        }
        echo "</table>";






 $conn->close();

?>
