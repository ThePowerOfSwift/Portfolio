<?php
session_start();
ob_start();
if($_SESSION['loggedInUser']){
    header("Location: ../includes/admin.php");
}
include('login.php');
include('header.php');

?>
            <div class="container">
                <div class="blogHead">
                    <h2>Software &amp; Web Development</h2>
                   <hr>
                                        <div class="col-sm-12 clearfix" id="aboutMe">
                    <div class="col-sm-4 clearfix media-left" id="img-left-development">
                    </div>
                        
                        <div id="aboutMeDesc" class="media-body">

                            <p>
                            I have always been interested in "tinkering", I started pulling everything apart from as early as I can remember! (My parents didn't appreciate that). I tell you now though if I had not done the things I did, I would not be were I am today in terms of technical knowledge.
                            </p><p>
                            Electronics repairs came first starting in 2008 through until now and beyond, including Acer, Apple, Motorolla also being Specialised in the Neworking field for management and administration. At This stage I had done some very basic scripting/programming using batch files, minor PHP/CSS and Html. 
                            </p>
                            <p>
                            It was not until 2016 that I decided to start getting serious about Programming in general, wether it is Web/Application or Mobile development I seem to be thriving on all the information wanting to absorb as much as I can.
                            </p>
                            
                            <p>
                            So far I have knowledge in the following: 
                                <p><span id="skills_tags">
                                <i>PHP</i>
                                <i>CSS/CSS3</i>
                                <i>HTML/HTML5</i>
                                <i>JavaScript</i>
                                <i>jQuery</i>
                                <i>C#</i>
                                <i>Unity3d</i>
                                <i>Swift</i>
                                <i>JSON Data</i>
                                </span>
                            </p>
                            </p>
                                <p>
                                    and I will continue untill I literally cannot hold anymore information!
                            </p>
                            <p>
                            Further learing so far will include(I think this is a pretty big list so far):
                            <p><span id="skills_tags">
                                <i>NodeJS</i>
                                <i>AngularJS</i>
                                <i>DOM</i>
                                <i>Ruby</i>
                                </span>
                            </p>
                            </p>
                            <p>
                            Below you will find link a portfolio including all my work so far as a Web/Application or Mobile developer.
                            </p>
                
                            <p>
                            If you like what you see dont hesitate to contact me and I will se if I can help fulfill your needs. Conact me <a href="contact.php">Here</a>
                            </p>
                            
                        </div>
                    </div>
                    
                </div>
                <div class="moreTracks container col-sm-12">
                    
                    
                    
                    <hr>
                    <h2>Portfolio</h2>
                    <hr>
                    <div id="portfolio">
                        <div class="col-sm-6">
                            <h4>Software Development</h4>
                            <hr>
                            <ul>
                                <li><a href="">App 1</a></li>
                                <li><a href="">App 2</a></li>
                            </ul>
                        </div>
                        <div class="col-sm-6">
                            <h4>Web Development</h4>
                            <hr>
                            <ul>
                                <li><a href="">Website 1</a></li>
                                <li><a href="">Website 2</a></li>
                            </ul>
                        </div>
                    </div>
                    
                    


                    <!-- Tab panes -->
                   
                        
             
                        
                       
                 
                    
                    <hr>
                </div>  
                

<?php
include('footer.php');        
?>          