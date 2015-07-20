<%@ Page Title="" Language="C#" MasterPageFile="~/InstaKG.Master" AutoEventWireup="true" CodeBehind="ViewProfile.aspx.cs" Inherits="InstaKG.ViewProfile" %>

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
    <script src="https://maps.googleapis.com/maps/api/js?v=3.exp"></script>

    <script type="text/javascript">
        
        $(document).ready(function() {
            function initialize() {

                var loca = <% =Serialize(returnGPSdata()) %>;

                // Note that the array cannot contain nulls, will default to 0
                var locations = [
                [-33.89, 151.27, "A"],
                [-33.92, 151.25, "B"],
                [-34.02, 151.15, "C"],
                [-33.80, 151.28, "D"],
                [-33.95, 151.25, "E"]
                ];

                //var myLatlng = new google.maps.LatLng(-33.92, 151.25);
                var myLatlng = new google.maps.LatLng(0, 0);
                var mapOptions = {
                    zoom: 1,
                    center: myLatlng
                }
                var map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);

                var marker, i;
                for (i = 0; i < loca.length; i++) {
                    marker = new google.maps.Marker({
                        position: new google.maps.LatLng(loca[i][0], loca[i][1]),
                        map: map,
                        //title: 'Photos taken here!'
                        title: loca[i][2]
                    });
                }

                //for (i = 0; i < locations.length; i++) {
                //    console.log("Latitude: " + locations[i][0] + ", Latitude: " + locations[i][1]);
                //}
            }

            google.maps.event.addDomListener(window, 'load', initialize);
        });
    </script>

    <div id="alert_placeholder" runat="server" visible="false">
        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
        <asp:Literal runat="server" ID="alertText" />
    </div>
    <div class="container">
        <div class="well">
            <fieldset>
                <legend><%= queryUsername() %>'s Profile</legend>
            </fieldset>

            <div class="form-group">
                <asp:Label ID="lbl_email" CssClass="col-lg-4 control-label" runat="server" Text="Email: "></asp:Label>
                <div class="col-lg-4">
                    <asp:Label ID="lbl_email_value" runat="server"></asp:Label>
                </div>
            </div>

            <br />
            <br />

            <div class="form-group">
                <asp:Label ID="lbl_fname" CssClass="col-lg-4 control-label" runat="server" Text="First Name: "></asp:Label>
                <div class="col-lg-4">
                    <asp:Label ID="lbl_fname_value" runat="server"></asp:Label>
                </div>
            </div>

            <br />

            <div class="form-group">
                <asp:Label ID="lbl_lname" CssClass="col-lg-4 control-label" runat="server" Text="Last Name: "></asp:Label>
                <div class=" col-lg-4">
                    <asp:Label ID="lbl_lname_value" runat="server"></asp:Label>
                </div>
            </div>

            <br />
            <br />

            <div class="form-group">
                <asp:Label ID="lbl_gender" CssClass="col-lg-4 control-label" runat="server" Text="Gender: "></asp:Label>
                <div class=" col-lg-4">
                    <asp:Label ID="lbl_gender_value" runat="server"></asp:Label>
                </div>
            </div>

            <br />
            <!--
            <div class="form-group">
                <asp:Label ID="lbl_birthday" CssClass="col-lg-4 control-label" runat="server" Text="Birthday: "></asp:Label>
                <div class=" col-lg-4">
                    <asp:Label ID="lbl_birthday_value" runat="server"></asp:Label>
                </div>
            </div>
            -->

            <br />
        </div>

        <div class="well col-lg-12">
            <div class="col-lg-6">
                <fieldset>
                    <legend>Images</legend>

                    <asp:Repeater ID="Repeater1" runat="server">
                        <HeaderTemplate>
                            <ul id="lightGallery" class="gallery">
                        </HeaderTemplate>
                        <ItemTemplate>
                            <li class="col-lg-3 col-md-4 col-xs-6 animated fadeInUp" data-src='<%#"ImageViewerHandler.ashx?id=" + Eval("imageID")%>'>
                                <asp:Image ID="Image" runat="server" class="thumbnail img-responsive" ImageUrl='<%#"ImageViewerHandler.ashx?id=" + Eval("imageID")%>' Style="max-height: 100px;" />
                            </li>
                        </ItemTemplate>
                        <FooterTemplate>
                            </ul>
                        </FooterTemplate>
                    </asp:Repeater>

                    <div style="float: right; clear: left; width: 300px; font-size: 18px; text-align: right; margin-right: 30px;" class="warning">
                        <asp:LinkButton ID="lb_gallery" runat="server" OnClick="lb_gallery_Click" Text="View more..."></asp:LinkButton>
                        <br />
                        <a href="/ViewAllLocations.aspx">View GPS map</a>
                    </div>

                </fieldset>
            </div>

            <div class="col-lg-6">
                <h4>Overview of image locations:</h4>
                <div>
                    <div id="map-canvas" class="img-responsive" style="max-height: 100%; height: 20em;"></div>
                </div>
            </div>
        </div>
        
    </div>
</asp:Content>
