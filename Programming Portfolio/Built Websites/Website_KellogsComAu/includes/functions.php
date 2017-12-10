
<?php
session_start();
include('functions.php');
if(isset($_POST['login'])){
    $formUser = validateFormData($_POST['username']);
    $formPass = validateFormData($_POST['password']);
    
    include('connection.php');
    
   $query = "SELECT name, password FROM users WHERE name='$formUser'";
   
   $result = mysqli_query($conn, $query);
  
    if(mysqli_num_rows($result) > 0){
        
        while($row = mysqli_fetch_assoc($result)){
            $Name       = $row["name"];
            $Password = $row["password"];
        }
        if($formPass == $Password){
            $_SESSION['loggedInUser'] = $Name;
            header('Location: ../includes/admin.php');
            
        }else{
            $loginError = "<div class='alert alert-danger text-center'>Wrong Username / Password, please try again.</div>";
        }
    } else {
        $loginError = "<div class='alert alert-danger text-center'>Wrong Username / Password, please try again.<a class='close' data-dismiss='alert'>&times;</a></div>";
    }
    
    mysqli_close($conn);
}
?>