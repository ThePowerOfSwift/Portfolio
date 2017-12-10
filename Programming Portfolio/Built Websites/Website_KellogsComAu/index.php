<?php
session_start();
ob_start();
if($_SESSION['loggedInUser']){
    header("Location: includes/admin.php");
}
include('includes/header.php');
include('includes/login.php');
include('includes/connection.php');

    
    $mysqli = new mysqli($host, $username, $password, $db);
    $myQuery = "SELECT * FROM posts ORDER BY postDate DESC";
    $result = mysqli_query($mysqli, $myQuery);
    $json = array();

    if(mysqli_num_rows($result) > 0){
        while($row = mysqli_fetch_assoc($result)){
                $json[]=$row;
        }

    } else {
        $dataError = "<div class='alert alert-danger text-center'>No Posts</div>";
    }
    
    file_put_contents("JSON/posts.json",json_encode($json)); 

    mysqli_close($mysqli);
?>
<!--FB Initializer-->
<div id="fb-root"></div>
<script>(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = "//connect.facebook.net/en_US/sdk.js#xfbml=1&version=v2.7&appId=1262955577072518";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));</script>
<!--END FB Initializer-->
<!--HTML-->


<div class="container">
    <div class="row">
        <div class="blogHead">
          
        </div>

              <div class="col-sm-6 col-sm-offset-3 blog-main">

                                       <?php 
                                            echo $dataError; 
                                        ?>

                            <div id="blog-main">
                            </div>
                        </div>




<!--
        <div class="col-sm-5">

                     
                        <ul class="nav nav-tabs" role="tablist">
                        <li role="presentation"  class="active"><a href="#facebook" aria-controls="home" role="tab" data-toggle="tab">Facebook</a></li>
                        <li role="presentation"><a href="#twitter" aria-controls="profile" role="tab" data-toggle="tab">Twitter</a></li>
                        <li role="presentation"><a href="#instagram" aria-controls="messages" role="tab" data-toggle="tab">Instagram</a></li>
                        
                        </ul>
                    
            
             <div class="tab-content">
            <div role="tabpanel" class="tab-pane " id="facebook">
            <div class="col-sm-12">
            <div id="socialNews">
                <ul class="media-list">
                </ul>
            </div>
             </div>
            </div>
            <div role="tabpanel" class="tab-pane" id="twitter">
               <div class="col-sm-12">
            <div id="twitterNews">
                <ul class="media-list">
                </ul>
            </div>
             </div>
            </div>
                 <div role="tabpanel" class="tab-pane" id="instagram">
                       <div class="col-sm-12">
                            <div id="instagramNews">
                                <ul class="media-list">
                                </ul>
                            </div>
                        </div>
                 </div>
                 <div role="tabpanel" class="tab-pane active" id="blog">
                     
                 </div>
            </div>

        </div>
-->
            

        </div><!-- /#socialNews -->
    </div><!-- /.row -->
    <hr>
</div><!-- /.container -->
    

<!-- Custom Scripts -->
<script src="./js/script.js"></script>
<script src="./js/search.js"></script>
<script src="./js/fancy.js"></script>
<!--
<script>window.twttr = (function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0],
    t = window.twttr || {};
  if (d.getElementById(id)) return t;
  js = d.createElement(s);
  js.id = id;
  js.src = "https://platform.twitter.com/widgets.js";
  fjs.parentNode.insertBefore(js, fjs);
 
  t._e = [];
  t.ready = function(f) {
    t._e.push(f);
  };
 
  return t;
}(document, "script", "twitter-wjs"));</script>
-->
<?php
include('includes/footer.php');
?>