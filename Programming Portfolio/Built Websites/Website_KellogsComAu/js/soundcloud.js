// API KEY 065c3c1cbe1c52c7f689d2f50c0bd2ac

$(function() {
    
    SC.initialize({
    client_id: "065c3c1cbe1c52c7f689d2f50c0bd2ac"
  });
    

    
//          SC.get("/tracks",{
//        user_id: 4466125
//    }).then(function(res) {
//      for (var i = 0; i < 1; i++) {  
//          SC.oEmbed(res[i].permalink_url, {
//              auto_play: true,
//              maxheight: 300,
//            }).then(function(embed){
//              $('#autoPlay').append(embed.html);
//              $('#trackTitle').append(res[0].title);
//              $('#trackDesc').append(res[0].description);
//            //console.log(embed);
//            });
//
//      } 
////        console.log(res);
//    });
 
    });

$(document).ready(function(){
    

     $.getJSON("../JSON/soundContent.json",function(soundData){
    $('#itemActive').append("<a href='#sc"+soundData[0][0].id+"'><img id='trackImg0' class='first-slide' alt='first-slide' src='"+soundData[0][0].artwork_url.replace('large','t300x300')+"'><div class='container'><div id='caption' class='carousel-caption'><h4>"+soundData[0][0].title+"</h4><hr>"+soundData[0][0].description+"<hr><p id='trackData'><span class='glyphicon glyphicon glyphicon-play'></span> "+soundData[0][0].playback_count+" | <span class='glyphicon glyphicon glyphicon-save'></span></span> "+soundData[0][0].download_count+" | <span class='glyphicon glyphicon-comment'></span> "+soundData[0][0].comment_count+" | <span class='glyphicon glyphicon-heart'></span> "+soundData[0][0].favoritings_count+"</p></div></div><div id='sc"+soundData[0][0].id+"' class='white-popup-soundcloud mfp-hide clearfix'>"+soundData[0][0].embed.html+"</div></a>");
    
    $('#item0').append("<a href='#sc"+soundData[0][10].id+"'><img id='trackImg0' class='second-slide' alt='second-slide' src='"+soundData[0][10].artwork_url.replace('large','t300x300')+"'><div class='container'><div id='caption' class='carousel-caption'><h4>"+soundData[0][10].title+"</h4><hr>"+soundData[0][10].description.substring(0,237)+"<hr><p id='trackData'><span class='glyphicon glyphicon glyphicon-play'></span> "+soundData[0][10].playback_count+" | <span class='glyphicon glyphicon glyphicon-save'></span> "+soundData[0][10].download_count+" | <span class='glyphicon glyphicon-comment'></span> "+soundData[0][10].comment_count+" | <span class='glyphicon glyphicon-heart'></span> "+soundData[0][10].favoritings_count+"</p></div></div><div id='sc"+soundData[0][10].id+"' class='white-popup-soundcloud mfp-hide clearfix'>"+soundData[0][10].embed.html+"</div></a>");
    
    $('#item1').append("<a href='#sc"+soundData[0][1].id+"'><img id='trackImg0' class='second-slide' alt='second-slide' src='"+soundData[0][1].artwork_url.replace('large','t300x300')+"'><div class='container'><div id='caption' class='carousel-caption'><h4>"+soundData[0][1].title+"</h4><hr>"+soundData[0][1].description.substring(0,267)+"<hr><p id='trackData'><span class='glyphicon glyphicon glyphicon-play'></span> "+soundData[0][1].playback_count+" | <span class='glyphicon glyphicon glyphicon-save'></span> "+soundData[0][1].download_count+" | <span class='glyphicon glyphicon-comment'></span> "+soundData[0][1].comment_count+" | <span class='glyphicon glyphicon-heart'></span> "+soundData[0][1].favoritings_count+"</p></div></div><div id='sc"+soundData[0][1].id+"' class='white-popup-soundcloud mfp-hide clearfix container'>"+soundData[0][1].embed.html+"</div></a>");
           $.each(soundData[0],function(k,v){
               if(v.artwork_url == null){
                $('#tracks ul').append('<a href="#sc'+v.id+'"><li class="media"><img class="media-left col-sm-2" src="'+v.user.avatar_url.replace('large','t300x300')+'"><div class="media-right col-sm-8"><h5 id="trackT">'+v.title+'</h5><p id="trackD">'+v.description+'</p></div><div class="stats"><span class="glyphicon glyphicon-comment" id="comments"></span><span id="comments">'+v.comment_count+'</span></div><div class="stats"><span class="glyphicon glyphicon glyphicon-play" id="plays"></span><span id="plays">'+v.playback_count+'<span class="glyphicon glyphicon glyphicon-save" id="downloads"></span><span id="downloads">'+v.download_count+'</div></div></li><div id="sc'+v.id+'" class="white-popup-soundcloud mfp-hide clearfix">'+v.embed.html+'</div></a>');
               }else{
               $('#tracks ul').append('<a href="#sc'+v.id+'"><li class="media"><img class="media-left col-sm-2" src="'+v.artwork_url.replace('large','t300x300')+'"><div class="media-right col-sm-8"><h5 id="trackT">'+v.title+'</h5><p id="trackD">'+v.description+'</p></div><div class="stats"><span class="glyphicon glyphicon-comment" id="comments"></span><span id="comments">'+v.comment_count+'</span><span class="glyphicon glyphicon glyphicon-play" id="plays"></span><span id="plays">'+v.playback_count+'</span><span class="glyphicon glyphicon glyphicon-save" id="downloads"></span><span id="downloads">'+v.download_count+'</div></div></li><div id="sc'+v.id+'" class="white-popup-soundcloud mfp-hide clearfix">'+v.embed.html+'</div></a>');
               }
           }); 
     });
    
        $('#autoWidth').lightSlider({
        autoWidth:true,
        loop:true,
        controls: true,
        onSliderLoad: function() {
            $('#autoWidth').removeClass('cS-hidden');
        } 
    });
    
    $('#tracks ul').magnificPopup({
    delegate: 'a',
   type:'inline',
   midClick: true
});
        $('.item').magnificPopup({
    delegate: 'a',
    preloader: true,
   type:'inline',
   midClick: true
});
});