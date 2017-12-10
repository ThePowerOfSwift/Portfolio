<?php
if(isset($_POST['logout'])){
     if(isset($_COOKIE[ session_name()])){
        
        //Emtpy cookie
        setcookie( session_name(), '', time()-86400, '/');
    }
    //Clear all session variables
    session_unset();

    //Destroy session
    session_destroy();
    
    //redirect to index
    header('Location: ../index.php');
}
?>