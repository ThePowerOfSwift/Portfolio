<?php 

session_start();
ob_start();
if(!$_SESSION['loggedInUser']){
    header("Location: ../index.php");
}
include('logout.php');
include('header.php');
include('posts.php');


$client_id = 'ENTER ID HERE';
$client_secret = 'ENTER SECRET HERE';
$redirect_uri = 'http://localhost:8888/includes/instagram_login.php';
$scope = 'basic+likes+comments+relationships';

$url = "https://api.instagram.com/oauth/authorize?client_id=$client_id&redirect_uri=$redirect_uri&scope=$scope&response_type=code";
if($_GET['alert'] == 'success'){
        $alertMessage = "<div class='alert alert-success'>Article Added<a class='close' data-dismiss='alert'>&times;</a></div>";
}

if($_GET['alert'] == "InstagramUpdated"){

echo '<script type="text/javascript">



</script>';

}

?>
  <body>

    <div class="container">
    <div class="blogHead">
                    <h2>Blog Update</h2>
                   <hr>
        <?php
        echo $alertMessage;
        ?>
        <div id="alert">
        </div>
                </div>
        <div class="side-bar container col-sm-3">
            <form class="form-group">
            <label><h5>Selected text to be surrounded with: </h5></label><br>
                <input type="button" id="blockquote" class="btn btn-danger" value="<blockquote>">
                <input type="button" id="italic" class="btn btn-danger" value="<em>">
                <input type="button" id="underline" class="btn btn-danger" value="<u>">
                
                <input type="button" id="h4" class="btn btn-danger" value="<h4>">
                <input type="button" id="h5" class="btn btn-danger" value="<h5>">
                <input type="button" id="h6" class="btn btn-danger" value="<h6>">
                <input type="button" id="ul" class="btn btn-danger" value="<ul>">
                <input type="button" id="ol" class="btn btn-danger" value="<ol>">
                <input type="button" id="li" class="btn btn-danger" value="<li>">
                </form>
            <form class="form-group clearfix">
                <label><h5>Create Code Block:</h5><div id="lAlert" class"alert alert-danger"></div></label>
                <select id="codeSelect" class="form-control" name="bootstrapCSS">
                    <option value="lang-html">HTML</option>
                    <option value="lang-php">PHP</option>
                    <option value="lang-js">javaScript</option>
                    <option value="lang-css">CSS</option>
                </select>
                <input type="button" id="code" class="btn btn-danger" value="<code>">
            </form>
            <form class="form-group clearfix">
                <label><h5>Create HTTP Link:</h5><div id="lAlert" class"alert alert-danger"></div></label>
                <input type="text" id="lName" class="form-control" placeholder="place link name here">
                <input type="text" id="href" class="form-control" placeholder="full http address">
                <input type="button" id="a" class="btn btn-danger" value="Create Link">
                </form>
            <form class="form-group clearfix">
                <label><h5>Login to FB and Update JSON Post data:</h5></label>
                            <div class="fb-login-button clearfix" data-max-rows="2" data-size="xlarge" data-show-faces="false" data-auto-logout-link="true"></div>
                <input type="button" value="Post" id="updateJSON" class="btn btn-danger">
                <input type="button" value="Get" id="postData" class="btn btn-danger">
                
            </form>
           
            <div>
                    

                    <div id="status">
                    </div>
            </div>
             </div>
        <div class="moreTracks container col-sm-6">
            
            
            <form action="<?php echo htmlspecialchars($_SERVER['PHP_SELF'])?>" method="post" class="row">
                <div class="form-group col-sm-12">
                    <label for="client-name">Article Title</label>
                    <input type="text" class="form-control input-lg" id="articleTitle" name="articleTitle">
                    <label for="date">Date</label>
                    <input type="text" class="date form-control input-lg" name="date" id="articleDate">
                    <label>Article Content</label>
                    <textarea class="form-control input-lg" id="content" name="articleContent" rows="20"></textarea>
                    
                    <hr>
                     <input type="submit" class="btn btn-danger" name="cancel" value="Cancel">
                    <input type="submit" class="btn btn-danger" name="addArticle" value="Post Article">
                </div>
             </form>
          </div>
        
        
        <div class="side-bar container col-sm-3">
            <span id="uploadAlert"></span>
            <label><h5>Upload an Image</h5></label>
            <form class="form-group" id="upload" method="post" action="upload.php" enctype="multipart/form-data">
			<div class="form-control" id="drop">
				Drop Here
                <br><br>
                <a class="btn btn-danger">Browse</a>
				<input class="form-control clearfix" type="file" name="upl" multiple />
		</form>   
        </div>
            <br><br>
         <form class="form-group">
                <label><h5>Embed Image:</h5><div id="lAlert" class"alert alert-danger"></div></label>
                <input type="text" id="imgName" class="form-control" placeholder="Name the image here...">
                <input type="text" id="imgSrc" class="form-control" placeholder="Image source here...(local only)">
                <select id="imgCss" class="form-control" name="bootstrapCSS">
                    <option>Select CSS img type (bootstrap)...</option>
                  <option value="img-responsive">Responsive</option>
                  <option value="img-thumbnail">Thumbnail</option>
                  <option value="img-rounded">Rounded</option>
                  <option value="img-circle">Circle</option>
                </select>
                <input type="text" id="imgHeight" class="form-control" placeholder="Enter image height...">
                <input type="text" id="imgWidth" class="form-control" placeholder="Enter image width here...">
                <input type="button" id="createImg" class="btn btn-danger" value="Create Image">
                </form>
             <form class="form-group clearfix">
                <label><h5>Update Soundcloud JSON data:</h5></label>
                <input type="button" value="Get & Post" id="getSoundcloud" class="btn btn-danger">
                 
            </form>
            <form class="form-group clearfix">
                <label><h5>Update Twitter JSON data:</h5></label><br>
                
                <input type="button" value="Post" id="updateTwhtml" class="btn btn-danger">
                <input type="button" value="Get" id="updateTwitter" class="btn btn-danger">
            </form>
            <form class="form-group clearfix">
                <label><h5>Update Instagram JSON data:</h5></label><br>
               <?php 
                    echo '<a type="button" href="'.$url.'" id="getInstagram" class="btn btn-danger">Login &amp; Post</a>'; 
                ?> 
            </form>
      </div>
        
      </div>
<script src="../js/admin.js"></script>
<script src="../js/upload.js"></script>
<?php include('footer.php');?>
