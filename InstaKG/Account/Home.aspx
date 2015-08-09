<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="InstaKG.Home" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>

    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="description" content="" />
    <meta name="author" content="" />

    <title>InstaKG</title>

    <link href="../Styles/bootstrap.min.css" rel="stylesheet" />
    <link href="../Styles/full-slider.css" rel="stylesheet" />
    <link href="../Styles/bootstrap.min.css" rel="stylesheet" />
    <link href="../Styles/custom.css" rel="stylesheet" />
    <script src="../Scripts/jquery-1.10.2.min.js"></script>
    <script src="../Scripts/bootstrap.min.js"></script>
    <script src="../Scripts/respond.min.js"></script>

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>
<body>

    <nav class="navbar navbar-inverse">
        <!-- Mobile friendly navbar -->
        <div class="container">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#nav-collapse">
                    <span class="sr-only">Toggle Navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="/BrowseImages.aspx">InstaKilogram</a>
            </div>

            <!-- Full sized navbar -->
            <div class="collapse navbar-collapse" id="nav-collapse">
                <!-- Left-side of navbar -->
                <ul class="nav navbar-nav">
                    <li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown">Browse <span class="caret"></span></a>
                        <ul class="dropdown-menu">
                            <li><a href="/BrowseImages.aspx">Browse Images</a></li>
                            <li><a href="/Search.aspx">Search Images</a></li>
                        </ul>
                    </li>
                    <li><a href="/UploadImg.aspx">Upload</a></li>
                    <li><a href="/Chat.aspx">Chat</a></li>
                    <li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown">Hide & Seek <span class="caret"></span></a>
                        <ul class="dropdown-menu">
                            <li><a href="/Steg_Encode.aspx">Hide a message!</a></li>
                            <li><a href="/Steg_Decode.aspx">Reveal a message!</a></li>
                        </ul>
                    </li>
                    <li><a href="/ViewAllLocations.aspx">World Image Map</a></li>
                </ul>

                <!-- Right-side of navbar -->
                <ul class="nav navbar-nav navbar-right">
                    <%
                        if (Session["username"] == null)
                        {
                    %>
                            <li><a href="/Account/Registration.aspx">Register</a></li>
                            <li><a href="/Account/Login.aspx">Login</a></li>
                    <%
                        }
                        else
                        {
                    %>
                            <li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown"><% =(string)Session["username"] %> <span class="caret"></span></a>
                                <ul class="dropdown-menu">
                                    <li><a href="/ViewProfile.aspx?name=<%= Session["username"].ToString() %>">View Profile</a></li>
                                    <li><a href="/EditProfile.aspx">Edit Profile</a></li>
                                </ul>
                            </li>
                            <li><button type="button" id="btn_logout" runat="server" class="btn btn-danger btn-sm navbar-btn" causesvalidation="false" onserverclick="logout">Logout</button></li>
                    <%
                        }    
                    %>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Full Page Image Background Carousel Header -->
    <header id="myCarousel" class="carousel slide">
        <!-- Indicators -->
        <ol class="carousel-indicators">
            <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
            <li data-target="#myCarousel" data-slide-to="1"></li>
            <li data-target="#myCarousel" data-slide-to="2"></li>
        </ol>

        <!-- Wrapper for Slides -->
        <div class="carousel-inner">
            <div class="item active">
                <!-- Set the first background image using inline CSS below. -->
                <div class="fill" style="background-image: url('../Images/lky.jpg');"></div>
                <div class="carousel-caption">
                    <h3>Lee Kuan Yew Memorial</h3>
                    <p>Exhibition held at Singapore National Museum in honour of the late Mr Lee Kuan Yew</p>
                </div>
            </div>
            <div class="item">
                <!-- Set the second background image using inline CSS below. -->
                <div class="fill" style="background-image: url('../Images/marinabay.jpg');"></div>
                <div class="carousel-caption">
                    <h3>Marina Bay Sands</h3>
                    <p>An integrated resort in Singapore with features such as a casiono, ice skating rink...</p>
                </div>
            </div>
            <div class="item">
                <!-- Set the third background image using inline CSS below. -->
                <div class="fill" style="background-image: url('../Images/nyp.jpg');"></div>
                <div class="carousel-caption">
                    <h3>Nanyang Polytechnic Apartment</h3>
                    <p>Welcoming internationals students and providing accommodation to help adjust and adapt to what is life in Singapore like </p>
                </div>
            </div>
        </div>

        <!-- Controls -->
        <a class="left carousel-control" href="#myCarousel" data-slide="prev">
            <span class="icon-prev"></span>
        </a>
        <a class="right carousel-control" href="#myCarousel" data-slide="next">
            <span class="icon-next"></span>
        </a>

    </header>

    <div class="container">

        <!-- Marketing Icons Section -->
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">Welcome to InstaKG
                </h1>
            </div>
            <div class="col-md-12">

                <div class="panel-body">
                    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Itaque, optio corporis quae nulla aspernatur in alias at numquam rerum ea excepturi expedita tenetur assumenda voluptatibus eveniet incidunt dicta nostrum quod?</p>
                </div>

            </div>
        </div>
        <!-- /.row -->

        <!-- Portfolio Section -->
        <div class="row">
            <div class="col-lg-12">
                <h2 class="page-header">Features</h2>
            </div>
            <div class="col-md-8">
                <h3>Uploading of Images</h3>

                <p>Upload your images easily and just add a quick info about it and submit!</p>
                <p>That's easy!</p>
                <p>Also, you could try custom your watermark to have a unqiue signature to the image. This identifies and protects yourself from unauthorized use online! </p>
            </div>
            <div class="col-md-2">                
                <asp:Image runat="server"  ImageUrl="~/Images/uploadImg.PNG" Height="300" Width="400"/>
                <br />
            </div>

            <div class="col-md-5">
                <asp:Image runat="server" ImageUrl="~/Images/viewGallery.PNG" Height="300" Width="400"/>
            </div>

            <div class="col-md-6" >
                <h3>Photo Gallery</h3>

                <p>A responsive flexible photo gallery for you to view all your photos or other users photos. </p>
                <p>With each simple click of the mouse to make an endless view of photos to be discovered!</p>
            </div>
            
            <div class="col-md-7" style="clear:left;">
                <h3>Search</h3>

                <p>Our search interacts with users quickly, instant results being shown.</p>
                <p>How can you do it?</p>
                <p>You can search easily through events, description or even the user who uploaded those images! </p>
            </div>
            <div class="col-md-3">
                <%--<img class="img-responsive" src="http://placehold.it/400x300" alt="">--%>
                <asp:Image runat="server" ImageUrl="~/Images/search.PNG" Height="300" Width="500" />
                <br />
            </div>

        </div>

        <!-- Footer -->
        <footer>
            <hr />
            <!-- Call to Action Section -->
            <div class="row">
                <div class="col-md-4">
                    <h5>Images</h5>
                    <nav>
                        <ul style="list-style: none;">
                            <li><a href="/BrowseImages.aspx">Browse</a></li>
                            <li><a href="/UploadImg.aspx">Upload</a></li>
                            <li><a href="/Search.aspx">Search</a></li>
                            <li><a href="/ViewAllLocations.aspx">World Image Map</a></li>
                        </ul>
                    </nav>
                </div>

                <div class="col-md-4">
                    <h5>Chat</h5>
                    <nav>
                        <ul style="list-style: none;">
                            <li><a href="/Chat.aspx">Chat</a></li>
                        </ul>
                    </nav>
                </div>

                <div class="col-md-4">
                    <h5>Account Management</h5>
                    <nav>
                        <ul style="list-style: none;">
                            <li><a href="/ViewProfile.aspx">View Profile</a></li>
                            <li><a href="/EditProfile.aspx">Edit Profile</a></li>
                        </ul>
                    </nav>
                </div>

            </div>
            <hr />
            <br />
            <div class="row">
                <div class="col-lg-12">
                    <p>Copyright &copy; InstaKG 2015</p>

                </div>
            </div>
        </footer>

    </div>

    <!-- jQuery -->
    <script src="Scripts/jquery.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="Scripts/bootstrap.min.js"></script>

    <!-- Script to Activate the Carousel -->
    <script>
        $('.carousel').carousel({
            interval: 5000 //changes the speed
        })
    </script>

</body>
</html>
