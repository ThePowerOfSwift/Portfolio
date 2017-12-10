<?php
session_start();

?>

<!DOCTYPE html>
<html>
    <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">       
        <title>Kellogs.com.au</title>
<!--Bootstrap CSS-->
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
<!--Font Awesome CSS-->
<link rel="stylesheet" href="../font-awesome/css/font-awesome.css">
<!-- jQuery UI CSS -->
<link href="../js/jquery-ui-1.11.4/jquery-ui.min.css" rel="stylesheet">
<!-- Magnific Popup CSS -->       
<link href="../dist/magnific-popup.css" rel="stylesheet" type="text/css">
<!--Custom CSS-->
<link rel="stylesheet" href="../css/style.css">     
<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
<script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
<![endif]-->
    </head>
    <body>
<!-- Ajax -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<!-- Magnific Popup JS -->
<script src="../dist/jquery.magnific-popup.js"></script>
<!-- Bootstrap -->
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
<!-- Jquery -->
<!--<script src="http://code.jquery.com/jquery-3.0.0.min.js"></script>-->
<!-- JqueryUI -->
<script src="https://code.jquery.com/ui/1.12.0/jquery-ui.min.js"></script>
        <!--Moment JS-->
<script src="../js/moment.js"></script>
<!-- Soundcloud SDK-->
<script src="https://connect.soundcloud.com/sdk/sdk-3.1.2.js"></script>
<!-- JS Plugins-->
<script src="../js/jquery.fileupload.js"></script>
<script src="../js/jquery.knob.js"></script>
<!--Pretty Code JS-->       
<script src="https://cdn.rawgit.com/google/code-prettify/master/loader/run_prettify.js"></script>

<!--END OF SCRIPT HEADER-->      
        
<!--START OF HTML CODEß--> 
        <nav class="navbar navbar-default">
             
      <div class="container">
          <?php
            if(!$_SESSION['loggedInUser']){
            ?>
        <div class="navbar-header">
                <button type="button" class="navbar-toggle" id="navigation" data-toggle="collapse" data-target="#navbar">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                </button>
          <a class="navbar-brand" href="../index.php"><strong>KELLOGS</strong>.COM.AU</a>
            <p class="slogan">Driven. Passionate. Inventive.</p>
        </div>
        <div id="navbar" class="collapse navbar-collapse">
           
            <ul class="nav navbar-nav navbar-right">
                <li class="dropdown">
                        <a class="dropdown-toggle" data-toggle="dropdown" href="#"><span class="glyphicon glyphicon-log-in"></span></a>
                            <ul class="dropdown-menu login">
                                <li>
                                    <form class="loginForm" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>" method="post">


                                    <div class="form-group">
                                        <h3>Login</h3> 
                                    <label class="sr-only" for="login-username">Username</label>
                                    <input type="text" id="login-username" class="form-control" id="login-username" placeholder="username" name="username">
                                        </div><div class="form-group">
                                    <label class="sr-only" for="login-password">Password</label>
                                    <input type="password" id="login-password" class="form-control" id="login-password" placeholder="password" name="password">
                                    </div>

                                    <input type="submit" class="btn" name="login" value="Submit">
                                    </form>
                                </li>
                            </ul>
                    </li>
            </ul>
            
            <ul class="nav navbar-nav navbar-right">
                <li><a href="../index.php">Home</a></li>
                    <li class="dropdown">
                        <a class="dropdown-toggle toggles" data-toggle="dropdown" href="#">Skills
                        <span class="caret"></span></a>
                            <ul class="dropdown-menu menus">
                                <li><a href="../includes/production.php">Sound Production</a></li>
                                <li><a href="../includes/development.php">Software/Web Development</a></li>
                            </ul>
                    </li>
                <li><a href="../includes/contact.php">Contact</a></li>
            </ul>
            
            <?php } else { ?>
            
             <div class="navbar-header">
                <button type="button" class="navbar-toggle" id="navigation" data-toggle="collapse" data-target="#navbar">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                </button>
            </div>
            <div id="navbar" class="collapse navbar-collapse">

                <div class="nav navbar-nav navbar-right">
                
                <form class="logoutForm" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>" method="post">
                                    
                        <input type="submit" class="btn" name="logout" value="logout">
                                 
                </form>
                        
                         
            </div>
            <ul class="nav navbar-nav navbar-left">
                <li><a href="admin.php">Blog Update</a></li>
                <li class="dropdown">
                        <a class="dropdown-toggle toggles" data-toggle="dropdown" href="#">Post To
                        <span class="caret"></span></a>
                            <ul class="dropdown-menu menus">
                                <li><a href="">Facebook</a></li>
                                <li><a href="">Soundcloud</a></li>
                            </ul>
                    </li>
            </ul>
            </div>
            <?php } ?>
        </div><!--/.nav-collapse -->
        
    </nav>