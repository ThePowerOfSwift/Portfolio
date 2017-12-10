$(function(){
    $fbName = "<a src='http://facebook.com/kel.robertson1'>Kel Kellogs Robertson</a>";
    $fbPageName = "<a src='http://facebook.com/kellogs10k'>Kellogs</a>";
    $img = "https://fbcdn-profile-a.akamaihd.net/hprofile-ak-xft1\/v\/t1.0-1\/c87.2.727.727\/s100x100\/10917820_885512734803902_4720791353732247313_n.jpg?oh=c65b70e5007713fd6095083f3008ece7&oe=5823DF3F&__gda__=1482402495_48d4c1c7f344b00366db9992e3a10151";
//create new array for specific data and append to HTML.
$.getJSON( "JSON/posts.json",function(cms){
                        $.each(cms,function(key,val){
                        $('#blog-main').append("<div class='blog-post thumbnail'><div class='caption'><h4 class='blog-post-title' id='articleTitle'>"+val.postTitle+"</h4><p class='blog-post-meta' id='articleDate'>Posted On - "+moment(val.postDate, "MM-DD-YYYY").format('ll')+" - "+val.author+"<p class='postContent' id='articleContent'>"+val.postContent.substring(0,80)+"...</p><a href='#bp"+val.id+"' id='readMore' class='open-popup-link btn btn-default' role='button'>Read More</a></div></div><div id='bp"+val.id+"' class='white-popup-post mfp-hide'><div class='blog-post'><h2 class='blog-post-title' id='articleTitle'>"+val.postTitle+"</h2><p class='blog-post-meta' id='articleDate'>Posted On - "+moment(val.postDate, "MM-DD-YYYY").format('ll')+" - "+val.author+"</p> BY <span id='author'>"+val.author+"</span><br><p class='postContent' id='articleContent'>"+val.postContent+"</p></div></div>");
                        });
                        
    });   
    
$.getJSON( "JSON/socialContent.json", function(social) {
                    $.each( social[0], function(key,v) {
                                    if(v == "undefined"){
                                        //DO NOTHING
                                    }else{
                                        if( v.title == "Kellogs"){
                                    $('#socialNews ul.media-list').append("<li class='media'><a href='#fb"+v.ID+"' class='open-popup-link clearfix'><div class='media-left'><img src='"+v.imgUrl+"'class='socailImg'><div id='fbstats'><span class='glyphicon glyphicon-thumbs-up'></span>"+v.postLikes+"<span class='glyphicon glyphicon-comment'></span>"+v.postComments+"</div></div><span class='media-body' id='socailMsg'><h6><i class='fa fa-facebook-official' aria-hidden='true'></i>"+v.title+"</h6><p id='body'>"+v.posts+"</p><p id='posted'>Posted - "+v.date+"</p></span></a><div id='fb"+v.ID+"' class='white-popup mfp-hide'><div class='fb-post' data-width='350' data-href='"+v.permlink+"'></div></div></li>");
                                        } else if( v.title == "Kel Kellogs Robertson"){
                                            $('#socialNews ul.media-list').append("<li class='media'><a href='#fb"+v.ID+"'  class='open-popup-link clearfix'><div class='media-left'><img src='"+v.imgUrl+"'class='socailImg'><div id='fbstats'><span class='glyphicon glyphicon-thumbs-up'></span>"+v.postLikes+"<span class='glyphicon glyphicon-comment'></span>"+v.postComments+"</div></div><span class='media-body' id='socailMsg'><h6><i class='fa fa-facebook-official' aria-hidden='true'></i>"+v.title+"</h6><p id='body'>"+v.posts+"</p><p id='posted'>Posted - "+v.date+"</p></span></a><div id='fb"+v.ID+"' class='white-popup mfp-hide'><div class='fb-post' data-width='350' data-href='"+v.permlink+"'></div></div></li>");
                                        }
                                    }
                                    
                            
                });
    });
 $.getJSON( "JSON/twitterContent.json", function(twitter) {
                    $.each(twitter[0], function(key,val) {
                    $('#twitterNews ul.media-list').append("<li class='media'><a href='#tw"+val.ID+"' class='open-popup-link clearfix'><span class='media-body' id='twitterMsg'><h6><i class='fa fa-twitter' aria-hidden='true'></i><div class='favs'><span class='glyphicon glyphicon-heart'></span>  <i>"+val.favs+"</i></div>"+val.name+"</h6><p id='posted'>Tweeted - "+moment(val.created_at).format('ll')+"  </p><p id='body'>"+val.text+"</p></span></a><div id='tw"+val.ID+"' class='white-popup-tweet mfp-hide clearfix'><div id='tweet'>"+val.html+"</div></div></li>");  
                       
                });
    });

$.getJSON("JSON/instagramContent.json",function(instagram){
    $.each(instagram.data,function(k,v){
        if(v.type == "video"){
            
            $('#instagramNews ul.media-list').append("<li class='media'><a href='#insta"+v.id+"' class='open-popup-link clearfix'><div class='media-body' id='instaMsg'><h4>Kellogs</h4><p id='posted'><div id='tags'><span class='glyphicon glyphicon-thumbs-up'></span>  "+v.likes.count+" <span class='glyphicon glyphicon-comment'></span> "+v.comments.count+"</p><p id='posted'> &#35 "+v.tags+"</p></div><p id='body'><video height='320' width='320' controls><source src='"+v.videos.standard_resolution.url+"' type='video/mp4'></video>"+v.caption.text+"</p></div></a><div id='insta"+v.id+"' class='white-popup-instagram mfp-hide clearfix'>"+v.htmlData+"</div></li>"); 
        }else if(v.type == "image"){
            $('#instagramNews ul.media-list').append("<li class='media'><a href='#insta"+v.id+"' class='open-popup-link clearfix'><div class='media-body' id='instaMsg'><h4>Kellogs</h4><p id='posted'><div id='tags'><span class='glyphicon glyphicon-thumbs-up'></span>  "+v.likes.count+" <span class='glyphicon glyphicon-comment'></span> "+v.comments.count+"</p><p id='posted'> &#35 "+v.tags+"</p></div><p id='body'><img src='"+v.images.low_resolution.url+"'"+v.caption.text+"</p></div></a><div id='insta"+v.id+"' class='white-popup-instagram mfp-hide clearfix'>"+v.htmlData+"</div></li>"); 
        }
    });

});

  
    
});


