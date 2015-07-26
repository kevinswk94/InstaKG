<%@ Page Title="" Language="C#" MasterPageFile="~/InstaKG.Master" AutoEventWireup="true" CodeBehind="ViewAllLocations.aspx.cs" Inherits="InstaKG.ViewAllLocations_Test" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script src="https://maps.googleapis.com/maps/api/js?v=3.exp"></script>

    <script type="text/javascript">
        
        $(document).ready(function() {
            function initialize() {

                var loca = <% =Serialize(returnGPSdata()) %>;

                // Note that the array cannot contain nulls, will default to 0
                //var locations = [
                //[-33.89, 151.27, "A", 1],
                //[-33.92, 151.25, "B", 2],
                //[-34.02, 151.15, "C", 3],
                //[-33.80, 151.28, "D", 5],
                //[-33.95, 151.25, "E", 6]
                //];

                //var myLatlng = new google.maps.LatLng(-33.92, 151.25);
                var myLatlng = new google.maps.LatLng(0, 0);
                var mapOptions = {
                    zoom: 1,
                    center: myLatlng
                }
                var map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);

                var infowindow = new google.maps.InfoWindow();

                var content = "CommentViewer.aspx?imageID=";

                var marker, i;
                for (i = 0; i < loca.length; i++) {
                    marker = new google.maps.Marker({
                        position: new google.maps.LatLng(loca[i][0], loca[i][1]),
                        map: map,
                        //title: 'Photos taken here!'
                        title: loca[i][2]
                    });

                    google.maps.event.addListener(marker,'click', (function(marker,content,infowindow, i){ 
                        return function() {
                            infowindow.setContent('<span style="color:black;"><b>' + loca[i][2] + '</b></span><a href="' + content + loca[i][3] + '"><div><img class="img-responsive" style="max-width:100px;max-height:100px;" src="ImageViewerHandler.ashx?id=' + loca[i][3] + '" /></div></a>');
                            infowindow.open(map,marker);
                        };
                    })(marker,content,infowindow, i));
                }

                //for (i = 0; i < locations.length; i++) {
                //    console.log("Latitude: " + locations[i][0] + ", Latitude: " + locations[i][1]);
                //}
            }

            google.maps.event.addDomListener(window, 'load', initialize);
        });
    </script>

    <div class="container">
        <div class="row">
            <h3>Overview of all image locations:</h3>
            <br />
        </div>
        <div class="col-lg-12">
            <div id="map-canvas" class="img-responsive" style="max-height:500px;height:500px;"></div>
        </div>
    </div>
</asp:Content>
