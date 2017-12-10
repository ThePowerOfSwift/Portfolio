$(document).ready(function(){
    $('#searchPost').click(function(){
        var searchVal = $('#searchPostInput').val();
        if(searchVal == ""){
                        $('#searchError').html("<div class='alert alert-danger'>Nothing to Search For!</div>");
                        $("#searchError").fadeTo(2000, 100).slideUp(function(){
                        $('#searchError').alert('close');
                     });
        }else{
        
        JSON();
            
    }

    
    function JSON(){
        var myExp = new RegExp(searchVal,"i");
        $('#socialNews ul.media-list').html("");
        $('#blog-main').html("");
        $.getJSON("JSON/posts.json", function(data){   
            $.each(data,function(key, val){
                 if ((val.postContent.search(myExp) != -1) || (val.postTitle.search(myExp) != -1 || (val.author.search(myExp) != -1))) {
                     $('#blog-main').append("<div class='blog-post'><h2 class='blog-post-title' id='articleTitle'>"+val.postTitle+"</h2><p class='blog-post-meta' id='articleDate'>"+val.postDate+"</p> BY <span id='author'>"+val.author+"</span><br><p class='postContent' id='articleContent'>"+val.postContent+"</p></div>");
                 } else {
                     
                 }
            });
            
        });
            
            $.getJSON("JSON/socialContent.json", function(social){   
            $.each(social,function(a, b){
                $.each(b,function(c,d){
                   if ((d.posts.search(myExp) != -1)) {
                     $('#socialNews ul.media-list').append("<a href='"+d.profileLink+"/posts/"+d.id+"'><li class='media'><div class='media-left'><img src='"+d.imgUrl+"'class='socailImg'></div><span class='media-body' id='socailMsg'>"+d.posts+"</span></a></li>");
                              
                   } else {
                  
                       
                   }
                });
                 
            });
            
        });
    }
  });  
    $('#recentPost').click(function(){
        recentSocial();
        recentBlog();
    });
    
    function recentSocial(){
        $('#socialNews ul.media-list').html("");
        $.getJSON( "JSON/socialContent.json", function(social) {
                    $.each( social, function(key,val) {
                            $.each(val,function(k,v){
                                    $('#socialNews ul.media-list').append("<a href='"+v.profileLink+"/posts/"+v.id+"'><li class='media'><div class='media-left'><img src='"+v.imgUrl+"'class='socailImg'></div><span class='media-body' id='socailMsg'>"+v.posts+"</span></a></li>");
                                  
                                    
                            });
                });
    });
    }
   function recentBlog(){
        $('#blog-main').html("");
        $.getJSON("JSON/posts.json", function(dataR){
            
            $.each( dataR, function( k, v) {

            
            $('#blog-main').append("<div class='blog-post'><h2 class='blog-post-title' id='articleTitle'>"+v.postTitle+"</h2><p class='blog-post-meta' id='articleDate'>"+v.postDate+"</p> BY <span id='author'>"+v.author+"</span><br><p class='postContent' id='articleContent'>"+v.postContent+"</p></div>");
  });
        });
   } 
});
