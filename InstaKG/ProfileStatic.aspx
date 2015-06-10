<%@ Page Title="" Language="C#" MasterPageFile="~/InstaKG.Master" AutoEventWireup="true" CodeBehind="ProfileStatic.aspx.cs" Inherits="InstaKG.Profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <%--Light Gallery Animation--%>
    <link href="Styles/lightGallery.css" rel="stylesheet" />
    <script src="Scripts/lightGallery.js"></script>

    <%-- WOW Animation--%>
    <link href="Styles/animate.css" rel="stylesheet" />
    <script src="Scripts/wow.min.js"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            $("#lightGallery").lightGallery();
        });
    </script>

    <style>
        /*Gallery*/
        ul {
            list-style: none outside none;
        }

        .gallery li {
            display: block;
            float: left;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container">
        





         <asp:DropDownList ID="ddlImages" runat="server" AppendDataBoundItems="true" AutoPostBack="true"
        OnSelectedIndexChanged="FetchImage">
        <asp:ListItem Text="Select Image" Value="0" />
    </asp:DropDownList>
    <hr />
    <asp:Image ID="Image1" runat="server" Visible="false" />























    </div>































    <div class="container">

        <div class="row">

            <h1 class="page-header">Erics Gallery</h1>

            <ul id="lightGallery" class="gallery">
                <li class="col-lg-3 col-md-4 col-xs-6 animated fadeInUp" data-src="DummyData/Img/cS-1.jpg">
                    <img class="thumbnail img-responsive" src="DummyData/Img/cS-1.jpg" />
                </li>
                <li class="col-lg-3 col-md-4 col-xs-6 animated fadeInUp" data-src="DummyData/Img/cS-2.jpg">
                    <img class="thumbnail img-responsive" src="DummyData/Img/cS-2.jpg" />
                </li>
                <li class="col-lg-3 col-md-4 col-xs-6 animated fadeInUp" data-src="DummyData/Img/cS-3.jpg">
                    <img class="thumbnail img-responsive" src="DummyData/Img/cS-3.jpg" />
                </li>
                <li class="col-lg-3 col-md-4 col-xs-6 animated fadeInUp" data-src="DummyData/Img/cS-4.jpg">
                    <img class="thumbnail img-responsive" src="DummyData/Img/cS-4.jpg" />
                </li>
                <li class="col-lg-3 col-md-4 col-xs-6 animated fadeInUp" data-src="DummyData/Img/cS-5.jpg">
                    <img class="thumbnail img-responsive" src="DummyData/Img/cS-5.jpg" />
                </li>
                <li class="col-lg-3 col-md-4 col-xs-6 animated fadeInUp" data-src="DummyData/Img/cS-6.jpg">
                    <img class="thumbnail img-responsive" src="DummyData/Img/cS-6.jpg" />
                </li>
                <li class="col-lg-3 col-md-4 col-xs-6 animated fadeInUp" data-src="DummyData/Img/cS-7.jpg">
                    <img class="thumbnail img-responsive" src="DummyData/Img/cS-7.jpg" />
                </li>
                <li class="col-lg-3 col-md-4 col-xs-6 animated fadeInUp" data-src="DummyData/Img/cS-8.jpg">
                    <img class="thumbnail img-responsive" src="DummyData/Img/cS-8.jpg" />
                </li>
                <li class="col-lg-3 col-md-4 col-xs-6 animated fadeInUp" data-src="DummyData/Img/cS-9.jpg">
                    <img class="thumbnail img-responsive" src="DummyData/Img/cS-9.jpg" />
                </li>
            </ul>
        </div>
    </div>
</asp:Content>
