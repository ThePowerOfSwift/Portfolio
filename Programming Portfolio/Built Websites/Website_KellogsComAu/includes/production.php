<?php
session_start();
ob_start();
if($_SESSION['loggedInUser']){
    header("Location: ../includes/admin.php");
}
include('login.php');
include('header.php');
?>
<link type="text/css" rel="stylesheet" href="../css/lightslider.min.css" />
<script src="../js/lightslider.min.js"></script>
            <div class="container">
                <div class="blogHead">
                    <h2>Kellogs</h2>
                    <hr>
                   
                    <div class="col-sm-12 clearfix" id="aboutMe">
                    <div class="col-sm-4 clearfix media-left" id="img-left-about">
                        
                    </div>
                        
                        <div id="aboutMeDesc" class="media-body">
                            <h5>About</h5>
                            <p>
                            I started chasing music at an early age of 16 after having 2 accidents skating and tearing all the ligaments in both ankles I was forced to be home bound for several months this lead me to start producing or at least playing around with loops and samples trying to see what could be done.
                            </p><p>
                            It wasn't unitl later on though that I got serious, around the age of 21 when a good mate lent me his DJ equipment and I started to flourish under what could be done on these amazing tools, pretty much the deal was sealed and the hobby started.
                            </p><p>
                            In a shart time I had amassed a large number of events and was travelling alot through the weekend and working my day jobs through the weeks (this was very draining, but hey when you want something you have to fight for it!).
                            </p><p>
                            There is an image gallery below of the events I had played.
                            </p><p>
                            Since late 2015, I have dropped off from the live DJ scene and have gone back to focusing on <span class="sProduction">Sound Produciton </span> trying to release a new track every couple of months now.
                            </p>
                            
                        </div>
                    </div>
                    <hr>
                </div>                
                <ul id="autoWidth" class="cs-hidden">
                  <li class="item-a"><img src="../img/sets/a.jpg"></li>
                  <li class="item-b"><img src="../img/sets/b.jpg"></li>
                  <li class="item-c"><img src="../img/sets/c.jpg"></li>
                  <li class="item-d"><img src="../img/sets/d.jpg"></li>
                  <li class="item-e"><img src="../img/sets/e.jpg"></li>
                    <li class="item-f"><img src="../img/sets/f.jpg"></li>
                  <li class="item-g"><img src="../img/sets/g.jpg"></li>
                  <li class="item-h"><img src="../img/sets/h.jpg"></li>
                  <li class="item-i"><img src="../img/sets/i.jpg"></li>
                  <li class="item-j"><img src="../img/sets/j.jpg"></li>
                    <li class="item-k"><img src="../img/sets/k.jpg"></li>
                  <li class="item-l"><img src="../img/sets/l.png"></li>
                  <li class="item-m"><img src="../img/sets/m.jpg"></li>
                  <li class="item-n"><img src="../img/sets/n.jpg"></li>
                  <li class="item-o"><img src="../img/sets/o.jpg"></li>
                    <li class="item-p"><img src="../img/sets/p.jpg"></li>
                  <li class="item-q"><img src="../img/sets/q.jpg"></li>
                  <li class="item-r"><img src="../img/sets/r.jpg"></li>
                  <li class="item-s"><img src="../img/sets/s.jpg"></li>
                  <li class="item-t"><img src="../img/sets/t.jpg"></li>
                    <li class="item-u"><img src="../img/sets/u.jpg"></li>
                  <li class="item-v"><img src="../img/sets/v.jpg"></li>
                  <li class="item-w"><img src="../img/sets/w.jpg"></li>
                  <li class="item-x"><img src="../img/sets/x.jpg"></li>
                  <li class="item-y"><img src="../img/sets/y.jpg"></li>
                    <li class="item-z"><img src="../img/sets/z.jpg"></li>
                </ul>
                <hr>
                <div class="blogHead">
                    <h2>Sound Production</h2>
                    
                </div>
                <hr>
                
                   

                    <!-- Carousel
                    ================================================== -->
                    <div id="myCarousel" class="carousel slide" data-ride="carousel">
                          <!-- Indicators -->
                          <ol class="carousel-indicators">
                            <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
                            <li data-target="#myCarousel" data-slide-to="1"></li>
                            <li data-target="#myCarousel" data-slide-to="2"></li>
                          </ol>
                          <div class="carousel-inner" role="listbox">
                                <div id='itemActive' class="item active">

                                </div>
                                <div id="item0" class="item">

                                </div>
                                <div id="item1" class="item">

                                </div>
                          </div>
                          <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
                                <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
                                <span class="sr-only">Previous</span>
                          </a>
                          <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
                                <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                                <span class="sr-only">Next</span>
                          </a>
                    </div><!-- /.carousel -->
         
                 
                    
                    
       
                <div class="moreTracks container col-sm-12">
                    <hr>
                    <h2>More Tracks</h2>
                    <hr>
                    <div id="tracks">
                        <ul class="col-sm-12">
                        </ul>
                    </div>
                    <hr>
                </div>
</div>
<script src="../js/soundcloud.js"></script>
<?php
include('footer.php');
?>


