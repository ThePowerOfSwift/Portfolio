
//FACBOOK STORE TO JSON FILE
$(function(){

 // This is called with the results from from FB.getLoginStatus().
  function statusChangeCallback(response) {
    //console.log('statusChangeCallback');
    //console.log(response);
    // The response object is returned with a status field that lets the
    // app know the current login status of the person.
    // Full docs on the response object can be found in the documentation
    // for FB.getLoginStatus().
    if (response.status === 'connected') {
      // Logged into your app and Facebook.
      
       
    } else if (response.status === 'not_authorized') {
      // The person is logged into Facebook, but not your app.
     
    } else {
      // The person is not logged into Facebook, so we're not sure if
      // they are logged into this app or not.
    
    }
  }

  // This function is called when someone finishes with the Login
  // Button.  See the onlogin handler attached to it in the sample
  // code below.
  function checkLoginState() {
    FB.getLoginStatus(function(response) {
      statusChangeCallback(response);
    });
  }

  window.fbAsyncInit = function() {
  FB.init({
    appId      : '1262955577072518',
    cookie     : true,  // enable cookies to allow the server to access 
                        // the session
    xfbml      : true,  // parse social plugins on this page
    version    : 'v2.5' // use graph api version 2.5
  });

  // Now that we've initialized the JavaScript SDK, we call 
  // FB.getLoginStatus().  This function gets the state of the
  // person visiting this page and can return one of three states to
  // the callback you provide.  They can be:
  //
  // 1. Logged into your app ('connected')
  // 2. Logged into Facebook, but not your app ('not_authorized')
  // 3. Not logged into Facebook and can't tell if they are logged into
  //    your app or not.
  //
  // These three cases are handled in the callback function.

  FB.getLoginStatus(function(response) {
    statusChangeCallback(response);
  });

  };

  // Load the SDK asynchronously
  (function(d, s, id) {
    var js, fjs = d.getElementsByTagName(s)[0];
    if (d.getElementById(id)) return;
    js = d.createElement(s); js.id = id;
    js.src = "//connect.facebook.net/en_US/sdk.js";
    fjs.parentNode.insertBefore(js, fjs);
  }(document, 'script', 'facebook-jssdk'));
      
    //create new array for specific data.
    var cmsPosts = new Array();
    var fbPageContent = new Array();
    var fbContent = new Array();
    var fbLinks = new Array();
    //new fb array
    var socialContent = []; 

    var $fbPageImgSrc;
    var $fbName;
    var $fbPageName;
    var $fbUrl  = "http://facebook.com/kel.robertson1";
    var $fbPageUrl  = "http://facebook.com/kellogs10k";
    
//Function connect to fb profile and push posts to content Arrays.
function FBConnect(){
    
   
        FB.login(function(response) {
        // handle the response
        FB.api(
        '/me',
        'GET',
            {"fields":"posts{permalink_url,message,message_tags,created_time,comments,likes,shares}, name, picture"},
            function(response) {
                fbContent.push(response);
                $profileImgUrl = response.picture.data.url; 
                $fbName = response.name;
               
            
            }
        );
        FB.api('/109872449034605','GET',{"fields":"posts{permalink_url,message,created_time,object_id,comments,likes,shares}, name, picture, likes"},function(response) {
        fbPageContent.push(response);
            $fbPageImgSrc = response.picture.data.url;
            $fbPageName = response.name;
            combineFB();
  }
);
            
        }, {
        scope: 'user_posts', 
        });
   
    } 
    
    //Combine all FB content into Vailed JSON array
    function combineFB(){
        var i = 0;
        var comments = 0;
        var likes = 0;
        
        
        $.each(fbContent[0].posts.data,function(k,v){
            if(v.message == "" || v.message == "undefined" || v.message == "Kel Kellogs Robertson" || v.message == undefined){
                
            }else if(!v.comments){
                var comments = 0;
            socialContent.push({"ID": i++,"posts":v.message, "permlink":v.permalink_url, "date": moment(v.created_time).format('ll'), "title":$fbName, "imgUrl":$profileImgUrl, "profileLink": $fbUrl, "id": v.id.replace(/\d+[_]/,''),"postLikes":v.likes.data.length,"postComments":comments});
            }else{
                var comments = v.comments.data.length;
            socialContent.push({"ID": i++,"posts":v.message, "permlink":v.permalink_url, "date": moment(v.created_time).format('ll'), "title":$fbName, "imgUrl":$profileImgUrl, "profileLink": $fbUrl, "id": v.id.replace(/\d+[_]/,''),"postLikes":v.likes.data.length,"postComments":comments});
            }
        });
        $.each(fbPageContent[0].posts.data,function(k,v){
            if(v.message == "" || v.message == "undefined" || v.message == "Kellogs" || v.message == undefined){
                
            }else if(!v.comments && v.likes){
                var likes = v.likes.data.length;
                var comments = 0;
            socialContent.push({"ID": i++,"posts":v.message, "permlink":v.permalink_url, "date": moment(v.created_time).format('ll'), "title":$fbPageName, "imgUrl":$fbPageImgSrc, "profileLink": $fbPageUrl, "id": v.id.replace(/\d+[_]/,''),"postComments": comments, "postLikes": likes});
            }else if(!v.likes && v.comments){
                var comments = v.comments.data.length;
                var likes = 0;
            socialContent.push({"ID": i++,"posts":v.message, "permlink":v.permalink_url, "date": moment(v.created_time).format('ll'), "title":$fbPageName, "imgUrl":$fbPageImgSrc, "profileLink": $fbPageUrl, "id": v.id.replace(/\d+[_]/,''),"postComments": comments, "postLikes": likes}); 
            }else{
                var comments = 0;
                var likes = 0;
            socialContent.push({"ID": i++,"posts":v.message, "permlink":v.permalink_url, "date": moment(v.created_time).format('ll'), "title":$fbPageName, "imgUrl":$fbPageImgSrc, "profileLink": $fbPageUrl, "id": v.id.replace(/\d+[_]/,''),"postComments": comments, "postLikes": likes}); 
            }
        });
  
    }
    

  //SoundCLoud Complete JSON file update  
$('#getSoundcloud').click(function(){
    var soundData = new Array();
    var soundHtml = new Array();
  // initialization
  SC.initialize({
    client_id: "065c3c1cbe1c52c7f689d2f50c0bd2ac"
  });
    
//    SC.get("/tracks",{
//        user_id: 4466125
//    }).then(function(res) {
//      for (var i = 0; i < 1; i++) {  
//          //console.log(res[i].permalink_url)
//          SC.oEmbed(res[i].permalink_url, {
//              auto_play: true,
//              maxheight: 300,
//              color: "#da3333"
//            }).then(function(embed){
//              $('#autoPlay').append(embed.html);
//              $('#trackTitle').append(res[0].title);
//              $('#trackDesc').append(res[0].description)
//            //console.log(embed);
//            });
//
//      } 
////        console.log(res);
//    });
    
    SC.get("/tracks",{
        user_id: 4466125
    }).then(function(response) {
      $.each(response,function(key,val){  
          soundData.push(val);
      });
          
        embed();
    });

    function embed() {
            SC.get("/tracks",{
            user_id: 4466125
            }).then(function(res) {  
                $.each(res,function(key,val){  
                    SC.oEmbed(res[key].permalink_url, {
                        auto_play: false,
                        maxheight: 450
                    }).then(function(embed){
                        soundHtml.push(embed);
                        if (soundData.length == soundHtml.length){
                            console.log("Done Data Matches");
                            console.log(soundHtml);
                            combineSCData();
                        }
                    });
                    
                });
            });    
    }
    
function combineSCData(){
        
     $.each(soundData,function(k,v){
        v.embed = soundHtml[k]; 
       
     }); 
    Ajax();
    
  
    function Ajax(){
            $.ajax({
                 type: 'POST',
                 url: 'JSON_Save.php',
                 data: {SC: JSON.stringify(soundData)},
                 cache: false,
                 success: function(response){  

                     alert("success");
                 },
                 error:function(){
                     alert('ajax failed');    
                 }   
            }); 
    }
} 
    
});
    

    
 // Call Api - Twitter - Return response and Update JSON File
$('#updateTwitter').click(function(){
     var twitterData = new Array();
     var twhtml = new Array();
    var html = new Array();
    var allTwitterData = [];
    
$('#updateTwhtml').click(function() {
$.each(twhtml,function(k,v){
   html.push(v.html); 
});
    
 $.each(allTwitterData,function(k,v){
    v.html = html[k]; 
 }); 
sendJson();
});

	$.ajax({
		url: 'get_tweets.php',
		type: 'GET',
		success: function(response) {
			if (typeof response.errors === 'undefined' || response.errors.length < 1) {
				

				$.each(response, function(i, obj) {
                   allTwitterData.push({"ID":obj.id_str, "text":obj.text,"favs":obj.favorite_count, "created_at": obj.created_at, "name": "@Kellogs10k"});
				});
				twitterAjax();

			} else {
				console.log("No Objects");
			}
		},
		error: function(errors) {
			console.log("ERROR"+errors);
		}
	});
    

    function twitterAjax(){
             $.each(allTwitterData,function(k,v){
                        $.ajax({
                            url:'https://api.twitter.com/1.1/statuses/oembed.json?url=https%3A%2F%2Ftwitter.com%2Fkellogs10k%2Fstatus%2F'+v.ID+'',
                            dataType: 'jsonp',
                            timeout:7000,
                            error: function (x, t, r) { 
                                alert(x.response.message); 
                            },
                            success: function(data){
                                twhtml.push(data);
                            }
                            
                               });
                   
                    }); 
        console.log("done");
    }
   
    function sendJson(){

            $.ajax({
                 type: 'POST',
                 url: 'JSON_Save.php',
                 data: {Twitter: JSON.stringify(allTwitterData)},
                 cache: false,
                 success: function(response){  
                     console.log(response);
                     alert("success");
                 },
                 error:function(){
                     alert('ajax failed');    
                 }   
        }); 
    }
});
 //Call click of button in Admin to post FB data to JSON file   
$('#updateJSON').click(function(){
//    console.log(socialContent);
            $.ajax({
                 type: 'POST',
                 url: 'JSON_Save.php',
                 data: {data: JSON.stringify(socialContent)},
                 cache: false,
                 success: function(){  
                    $('#alert').html("<div class='alert alert-success'>JSON DATA ADDED!</div>");
                    $("#alert").fadeTo(2000, 100).slideUp(function(){
                    $('#alert').alert('close');
                    });
                 },
                 error:function(){
                     alert('ajax failed');    
                 }   
            }); 

});
    
$('#postData').click(function(){
   FBConnect();; 
});
});

//Below handles html element requests.
function wrapText(elementID, openTag, closeTag) {
    var textArea = $('#' + elementID);
    var len = textArea.val().length;
    var start = textArea[0].selectionStart;
    var end = textArea[0].selectionEnd;
    var selectedText = textArea.val().substring(start, end);
    var replacement = openTag + selectedText + closeTag;
    textArea.val(textArea.val().substring(0, start) + replacement + textArea.val().substring(end, len));
}

$('#blockquote').click(function() {
    wrapText("content", "<blockquote>", "</blockquote>");
});
$('#italic').click(function() {
    wrapText("content", "<em>", "</em>");
});
$('#underline').click(function() {
    wrapText("content", "<u>", "</u>");
});
$('#code').click(function() {
    $class = $('#codeSelect').val();
    $classP = "prettyprint";
    wrapText("content", '<pre class='+$classP+'><code class='+$class+'>', "</code></pre>");
});
$('#h4').click(function() {
    wrapText("content", "<h4>", "</h4>");
});
$('#h5').click(function() {
    wrapText("content", "<h5>", "</h5>");
});
$('#h6').click(function() {
    wrapText("content", "<h6>", "</h6>");
});
$('#ul').click(function() {
    wrapText("content", "<ul>", "</ul>");
});
$('#li').click(function() {
    wrapText("content", "<li>", "</li>");
});
$('#ol').click(function() {
    wrapText("content", "<ol>", "</ol>");
});
$('#a').click(function() {
    $href = $('#href').val();
    $lName = $('#lName').val();
    if($href | $lName == "" ){
        
    }else{
     wrapText("content", "<a href="+$href+">", ""+$lName+"</a>");
        $('#href').val('');
        $('#lName').val('');
    }
    
});
$('#createImg').click(function(){
    $imgName = $('#imgName').val();
    $imgSrc = $('#imgSrc').val();
    $imgCss = $('#imgCss').val();
    $imgHeight = $('#imgHeight').val();
    $imgWidth = $('#imgWidth').val();
    
    if($imgName|$imgSrc|$imgCss == ""){
        
    }else{
        wrapText("content", '<a class="image-popup-vertical-fit" href="'+$imgSrc+'"><img src="'+$imgSrc+'" class="'+$imgCss+'" alt="'+$imgName+'" height="'+$imgHeight+'" width="'+$imgWidth+'">','</a>'); 
        $('#imgHeight').val("");
        $('#imgWidth').val("");
        $('#imgCss').val("Select CSS img type (bootstrap)...");
        $('#imgSrc').val("");
        $('#imgName').val("");
    }
    
    
});
        //Date Picker
    $('.date').datepicker({
        showOtherMonths: false,
        selectOtherMonths: false,
        showButtonPanel: false,
        changeMonth: false,
        changeYear: false,
        numberOfMonths: 1,
        minDate: new Date(),
        maxDate: new Date(),
        //monthNames: ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"],
        monthNames:[ "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec" ],
        navigationAsDateFormat: false,
        showWeek: true,
        weekHeader: "Wk",
        yearSuffix: "",
        showAnim: "slide",
        setDate: new Date()
    });

