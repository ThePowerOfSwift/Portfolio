var query; 
var globalToken;
var globalTokenP;
$(function() { //search function connecting to youtube API
    
    $("form").on("submit", function(e) {
       e.preventDefault();
        //q variable
        query = encodeURIComponent($("#search").val()).replace(/%20/g, "+");
       // prepare the request
       var request = gapi.client.youtube.search.list({
            part: "snippet, id",
            type: "video",
            q: query
       }); 
       // execute the request
       request.execute(function(response) {
        var results = response.result;
        var nextPageToken = response.nextPageToken;
           var previousPageToken = response.prevPageToken;
        console.log(query);
          $("#results").html("");
          $.each(results.items, function(i, item) {
                var output = getOutput(item);
                $("#results").append(output); 
          });
          console.log(results.nextPageToken);
            globalToken = results.nextPageToken;
            globalTokenP = results.prevPageToken;
            query = query;
       });
        
        
        //display buttons
        var buttons = getButtons(globalToken,globalTokenP);
        $('#buttons').html("");
        $('#buttons').append(buttons);  
        
        
    });
});

function nextPage(){
    $("#results").html("");
    $('#buttons').html("");
    // prepare the request
       var request = gapi.client.youtube.search.list({
            part: "snippet, id",
            type: "video",
            q: query,
           pageToken: globalToken
       }); 
       // execute the request
       request.execute(function(response) {
        var results = response.result;
        var nextPageToken = response.nextPageToken;
        var previousPageToken = response.prevPageToken;
          $("#results").html("");
          $.each(results.items, function(i, item) {
                var output = getOutput(item);
                $("#results").append(output); 
          });
          globalToken = results.nextPageToken;
          globalTokenP = previousPageToken;
           query = query;
           
             //display buttons
        var buttons = getButtons(globalToken,globalTokenP);
        $('#buttons').html("");
        $('#buttons').append(buttons);  
       });
       
        
}
function previousPage(){
    $("#results").html("");
    $('#buttons').html("");
    // prepare the request
       var request = gapi.client.youtube.search.list({
            part: "snippet, id",
            type: "video",
            q: query,
           pageToken: globalTokenP
       }); 
       // execute the request
       request.execute(function(response) {
        var results = response.result;
        var nextPageToken = response.nextPageToken;
        console.log(query);
          $("#results").html("");
          $.each(results.items, function(i, item) {
                var output = getOutput(item);
                $("#results").append(output); 
          });
          globalToken = results.nextPageToken;
        globalTokenP = results.prevPageToken;
           query = query;
           
            var buttons = getButtons(globalToken,globalTokenP);
        $('#buttons').html("");
        $('#buttons').append(buttons);
       });
      //display buttons
         
        
}

function getButtons(globalToken, globalTokenP){
    if(!globalTokenP){
        var btnoutput = '<div class="buttonContainer">'+'<button id="nextButton" class="pagingButton" data-token="'+globalToken+'" data-query="'+$("#search").val()+'" onclick="return nextPage()">Next Page</button></div>'; 
    } else if(globalToken && globalTokenP) {
        var btnoutput = '<div class="buttonContainer">'+'<button id="previousButton" class="pagingButton" data-token="'+globalTokenP+'" data-query="'+$("#search").val()+'" onclick="return previousPage()">Previous Page</button>'+'<button id="nextButton" class="pagingButton" data-token="'+globalToken+'" data-query="'+$("#search").val()+'" onclick="return nextPage()">Next Page</button></div>';   
    }
    return btnoutput;
}

// Animation on Search Bar
    var searchField = $('#search');
    var icon        = $('#searchButton')
    
    //Focus Event Handler
    
    $(searchField).on('focus', function(){
        $(this).animate({
            width: '100%'
        }, 400);
        $(icon).animate({
            right: '5px'
        }, 400);
    });
    
    //Blur Event Handler
    
    $(searchField).on('blur', function(){
       if(searchField.val() == ''){
           $(searchField).animate({
               width:'45%'
           }, 400, function(){});
           $(icon).animate({
               right:'350px'
           }, 400, function(){});
       }
    });

function init() {
    gapi.client.setApiKey("AIzaSyB8l5np_DRyB6RvAOEYzzmu7HD3T6biCp8");
    gapi.client.load("youtube", "v3", function() {
        // yt api is ready
    });
}

//Bui;d Output
function getOutput(item){
    var videoId         = item.id.videoId;
    var title           = item.snippet.title;
    var description     = item.snippet.description; 
    var thumb           = item.snippet.thumbnails.high.url;
    var channelTitle    = item.snippet.channelTitle;
    var videoDate       = item.snippet.publishedAt;
    
    
    //build output string
    
    var output = '<li>'+
        '<div class="listLeft">'+
        '<img src="'+thumb+'">'+
        '</div>'+
        '<div class="listRight">'+
        '<h3><a class="fancybox fancybox.iframe" href="http://www.youtube.com/embed/'+videoId+'">'+title+'</a></h3>'+
        '<small>By <span class="cTitle">'+channelTitle+'</span> On '+videoDate+'</small>'+
        '<p>'+description+'</p>'+
        '</div>'+
        '</li>'+
        '<div class="clearFix"></div>';
    return output;
}


