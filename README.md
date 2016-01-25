# CODElit - Learn by Doing Practical Projects


<div id="inSlider" class="carousel carousel-fade" data-ride="carousel">
    <ol class="carousel-indicators">
        <li data-target="#inSlider" data-slide-to="0" class="active"></li>
        <li data-target="#inSlider" data-slide-to="1"></li>
    <li data-target="#inSlider" data-slide-to="2"></li>
        <li data-target="#inSlider" data-slide-to="3"></li>
    </ol>
    <div class="carousel-inner" role="listbox">
        <div class="item active">
            <div class="container">
                <div class="carousel-caption">
                    <h1>We make<br/>
                        you, you,<br/>
                        make the world.<br/>
                        we build your future.</h1>
                    <p>Lets make yourself rule the world.</p>
                    <p><a class="btn btn-primary" href="<%= new_user_registration_path %>" role="button">Sign Up</a>
                                        <a class="btn btn-info" href="<%= new_user_session_path %>" role="button">Log In</a></p>
                </div>
                <div class="carousel-image wow zoomIn ">
                    <img src="<%=image_url('landing/a1-2.jpg') %>" alt="laptop" class="img-responsive" />

                </div>
            </div>
            <!-- Set background for slide in css -->
            <div class="header-back one"></div>

        </div>
        <div class="item">
            <div class="container">
                <div class="carousel-caption blank">
                    <h1>Explore the <br/>power of code.</h1>
                    <p>You can make ,the history.</p>
                    <p><a class="btn btn-primary" href="<%= new_user_registration_path %>" role="button">Sign Up</a>
                    <a class="btn btn-info" href="<%= new_user_session_path %>" role="button">Log In</a></p>
                </div>
         <div class="carousel-image wow zoomIn ">

                    <img src="<%= image_url('landing/3.jpg') %>" alt="laptop" />

                </div>
            </div>
            <!-- Set background for slide in css -->
            <div class="header-back two"></div>


        </div>



        <div class="item">
            <div class="container">
                <div class="carousel-caption">

                    <h2>INTUITIVE DESIGN IS HOW<br/> WE GIVE THE USER<br/>NEW SUPERPOWER.</h2>
                    <p><a class="btn btn-primary" href="<%= new_user_registration_path %>" role="button">Sign Up</a>
                                        <a class="btn btn-info" href="<%= new_user_session_path %>" role="button">Log In</a></p>
                </div>
         <div class="carousel-image wow zoomIn ">

                    <img src="<%= image_url('landing/17.jpg') %>" alt="laptop" />

                </div>
            </div>
            <!-- Set background for slide in css -->
            <div class="header-back three"></div>
        </div>

    <div class="item">
            <div class="container">
                <div class="carousel-caption">
                    <h3>There are three responses<br/> to a piece of design <br/>– yes, no, and WOW!</h3>
                    <h1>Wow is the one<br/> we aim for.</h1>
                    <p><a class="btn btn-primary" href="<%= new_user_registration_path %>" role="button">Sign Up</a>
                                        <a class="btn btn-info" href="<%= new_user_session_path %>" role="button">Log In</a></p>
                </div>
         <div class="carousel-image wow zoomIn ">

                    <img src="<%= image_url('landing/18.jpg') %>" alt="laptop" />

                </div>
            </div>
            <!-- Set background for slide in css -->
            <div class="header-back four"></div>
        </div>
    </div>



    </div>
    <a class="left carousel-control" href="#inSlider" role="button" data-slide="prev">
        <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
        <span class="sr-only">Previous</span>
    </a>
    <a class="right carousel-control" href="#inSlider" role="button" data-slide="next">
        <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
        <span class="sr-only">Next</span>
    </a>
</div>

