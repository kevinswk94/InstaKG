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

    <link href="Styles/bootstrap.min.css" rel="stylesheet" />
    <link href="Styles/full-slider.css" rel="stylesheet" />
    <link href="Styles/bootstrap.min.css" rel="stylesheet" />
    <link href="Styles/custom.css" rel="stylesheet" />
    <script src="Scripts/jquery-1.10.2.min.js"></script>
    <script src="Scripts/bootstrap.min.js"></script>
    <script src="Scripts/respond.min.js"></script>

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
                <a class="navbar-brand" href="Home.aspx">InstaKilogram</a>
            </div>

            <!-- Full sized navbar -->
            <div class="collapse navbar-collapse" id="nav-collapse">
                <!-- Left-side of navbar -->
                <ul class="nav navbar-nav">
                    <li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown">Browse <span class="caret"></span></a>
                        <ul class="dropdown-menu">
                            <li><a href="#">Browse Images</a></li>
                            <li><a href="#">Search Images</a></li>
                        </ul>
                    </li>
                    <li><a href="#">Upload</a></li>
                </ul>

                <!-- Right-side of navbar -->
                <ul class="nav navbar-nav navbar-right">
                    <%
                        if (Session["username"] == null)
                        {
                    %>
                            <li><a href="Register.aspx">Register</a></li>
                            <li><a href="Login.aspx">Login</a></li>
                    <%
                        }
                        else
                        {
                    %>
                            <li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown"><% =(string)Session["username"] %> <span class="caret"></span></a>
                                <ul class="dropdown-menu">
                                    <li><a href="#">View Profile</a></li>
                                    <li><a href="#">Report User</a></li>
                                </ul>
                            </li>
                            <li><a href="#">Logout</a></li>
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
                <div class="fill" style="background-image:url('Images/lky.jpg');"></div>
                <div class="carousel-caption">
                    <h3>Lee Kuan Yew Memorial</h3>
                    <p>Exhibition held at Singapore National Museum in honour of the late Mr Lee Kuan Yew</p>
                </div>
            </div>
            <div class="item">
                <!-- Set the second background image using inline CSS below. -->
                <div class="fill" style="background-image:url('Images/marinabay.jpg');"></div>
                <div class="carousel-caption">
                    <h3>Marina Bay Sands</h3>
                    <p>An integrated resort in Singapore with features such as a casiono, ice skating rink...</p>
                </div>
            </div>
            <div class="item">
                <!-- Set the third background image using inline CSS below. -->
                <div class="fill" style="background-image:url('Images/nyp.jpg');"></div>
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
