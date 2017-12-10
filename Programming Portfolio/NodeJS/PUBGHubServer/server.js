var express = require('express');
var fs = require('fs');
var request = require('request');
var cheerio = require('cheerio');
var bodyParser = require('body-parser');
var xpath = require('xpath');
var app     = express();
const phantom = require('phantom');
var cloudscraper = require('cloudscraper');

// configure app to use bodyParser()
// this will let us get the data from a POST
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

var port = process.env.PORT || 35478;        // set our port

var ALL_DATA = require('./JSON/ALLDATA.json');
// ROUTES FOR OUR API
// =============================================================================
var router = express.Router();     // get an instance of the express Router
// test route to make sure everything is working (accessed at GET http://localhost:8080/api)

router.get('/', function(req, res) {
    res.json(ALL_DATA);
});


router.get('/Stats/:name', function(req,res){
    var userName = req.params.name;
    var url = 'https://pubg.me/player/'+userName;
    cloudscraper.get(url, function(error, response, body) {
        if (error) {
            console.log('Error occurred');
        } else {
            res.send(body);
        }
    });
});


router.get('/Leaderboards/:season/:region/:mode', function(req,res){
    var season = req.params.season;
    var region = req.params.region;
    var mode = req.params.mode;
    var url = 'https://pubg.me/players/rating?season='+season+'&region='+region+'&match='+mode;
    cloudscraper.get(url, function(error, response, body) {
        if (error) {
            console.log('Error occurred');
        } else {
            res.send(body);
        }
    });
});

router.get('/PreviousSeasons/:name/:season/:region', function(req,res){
        var uN = req.params.name;
        var r = req.params.region;
        var s = req.params.season;
    
    var url = 'https://pubg.me/player/'+uN+'?season='+s+'&region='+r;
    cloudscraper.get(url, function(error, response, body) {
        if (error) {
            console.log('Error occurred');
        } else {
            res.send(body);
        }
    });
});


router.get('/StatsShare/:name/:season/:mode/:region', function(req,res){
    var name = req.params.name;
    var season = req.params.season;
    var mode = req.params.mode;
    var region = req.params.region;

    var url = 'https://pubg.me/player/'+name+'/'+mode+'?season='+season+'&region='+region;
    cloudscraper.get(url, function(error, response, body) {
        if (error) {
            console.log('Error occurred');
        } else {
            res.send(body);
        }
    });
});

router.get('/MatchHistory/:name/:pageNumber', function(req,res){
        var userName = req.params.name;
        var pgN = req.params.pageNumber;
    var url = 'https://pubg.me/player/'+userName+'/matches/?page='+pgN;
    cloudscraper.get(url, function(error, response, body) {
        if (error) {
            console.log('Error occurred');
        } else {
            res.send(body);
        }
    });
});

//router.get('/:pageNumber/:itemsPerPage/:filter', function (req, res) {
//    var pN = req.params.pageNumber;
//    var iPP = req.params.itemsPerPage;
//    var f = req.params.filter;
//    var u = 'https://steamcommunity.com/app/578080/homecontent/?userreviewsoffset=0&p='+pN+'&artpage='+pN+'&numperpage='+iPP+'&browsefilter='+f+'&l=english&appHubSubSection=4&filterLanguage=default&searchText=&forceanon=1';
//
//    
//    (async function() {
//    const instance = await phantom.create();
//    const page = await instance.createPage();
//    await page.on("onResourceRequested", function(requestData) {
//        console.info('Requesting', requestData.url)
//    });
//
//    const status = await page.open(u);
//
//    const content = await page.property('content');
//    const html = { htmlstring: content};
//    res.json(html);
//    await instance.exit();
//}());
//});

// more routes for our API will happen here

// REGISTER OUR ROUTES -------------------------------
// all of our routes will be prefixed with /api
app.use('/PUBGHubApi', router);
//app.use('/Gifs', router);
app.use('/PUBG/',router);
app.listen(port);
console.log('Magic happens on port ' + port); 
exports = module.exports = app;
