<?php
session_start();
ob_start();
if($_SESSION['loggedInUser']){
    header("Location: ../includes/admin.php");
}
if($_GET['alert'] == 'success'){
        $alertMessage = "<div class='alert alert-success'>Message Sent<a class='close' data-dismiss='alert'>&times;</a></div>";
}
if($_GET['alert'] == 'failed'){
        $alertMessage = "<div class='alert alert-success'>Failed! Check Inputs<a class='close' data-dismiss='alert'>&times;</a></div>";
}
include('header.php');
include('login.php');
?>
<div class="container">
                <div class="blogHead">
                    <h2>Get In Touch</h2>
                    <hr>
                </div>
    <div class="row">
                          <div class="col-md-12">
                            <?php echo $alertMessage; ?>
                          </div>
                            
                        
<div class="col-sm-12">

    <p id="contact_blurb" class="lead">If you would like to get in contact with me for Web Development or Sound Produciton, you may even want me to work for you! fill out he form below and I will get back to you as soon as possible.</p>
<hr>
    <form class="form-horizontal" action=" " method="post"  id="contact_form">
<fieldset>

<!-- Text input-->

<div class="form-group">
  <label class="col-md-4 control-label">First Name</label>  
  <div class="col-md-4 inputGroupContainer">
  <div class="input-group">
  <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
  <input  name="first_name" placeholder="First Name" class="form-control"  type="text">
    </div>
  </div>
</div>



<!-- Text input-->
       <div class="form-group">
  <label class="col-md-4 control-label">E-Mail</label>  
    <div class="col-md-4 inputGroupContainer">
    <div class="input-group">
        <span class="input-group-addon"><i class="glyphicon glyphicon-envelope"></i></span>
  <input name="email" placeholder="E-Mail Address" class="form-control"  type="text">
    </div>
  </div>
</div>

<!-- Text area -->
  
<div class="form-group">
  <label class="col-md-4 control-label"></label>
    <div class="col-md-4 inputGroupContainer">
    <div class="input-group">
<div id="captcha" class="g-recaptcha" data-sitekey="6Le5oScTAAAAAGgMN7JpQUDBZENB7qfaagf4n_3k"></div>
  </div>
  </div>
</div>
<!-- Text area -->
  
<div class="form-group">
  <label class="col-md-4 control-label">Message</label>
    <div class="col-md-4 inputGroupContainer">
    <div class="input-group">
        <span class="input-group-addon"><i class="glyphicon glyphicon-pencil"></i></span>
        	<textarea class="form-control" name="comment" placeholder="Message"></textarea>
  </div>
  </div>
</div>

<!-- Button -->
<div class="form-group">
  <label class="col-md-4 control-label"></label>
  <div class="col-md-4">
    <button type="submit" class="btn btn-danger" >Send <span class="glyphicon glyphicon-send"></span></button>
  </div>
</div>

</fieldset>
</form>
</div>

                            

                        </div>


<hr>
</div>
<script src='https://www.google.com/recaptcha/api.js'></script>
<?php
include('footer.php');
?>