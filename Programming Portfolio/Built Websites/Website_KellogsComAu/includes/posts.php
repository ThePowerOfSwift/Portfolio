<?php
include('functions.php');
include('connection.php');
if(isset($_POST['addArticle'])){
    
    $articleTitle = validateFormData($_POST['articleTitle']);
    $articleDate = validateFormData($_POST['date']);
    $articleContent = str_replace("'", '',($_POST['articleContent']));
    $author =  $_SESSION['loggedInUser'];

    $query = "INSERT INTO `posts` (id, postTitle, postDate, author, postContent) VALUES (NULL, '$articleTitle', '$articleDate','$author', '$articleContent')";
    
    $result = mysqli_query($conn, $query);
    
    if ($result) {
        header("Location: ../includes/admin.php?alert=success");
    } else {
        echo "Error: ".$query."<br>".mysqli_error($conn);
    } 
}

?>