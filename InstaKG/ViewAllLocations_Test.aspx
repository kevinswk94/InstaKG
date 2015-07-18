﻿<%@ Page Title="" Language="C#" MasterPageFile="~/InstaKG.Master" AutoEventWireup="true" CodeBehind="ViewAllLocations_Test.aspx.cs" Inherits="InstaKG.ViewAllLocations_Test" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script src="https://maps.googleapis.com/maps/api/js?v=3.exp"></script>

    <script type="text/javascript">
        
        $(document).ready(function() {
            function initialize() {

                var locations = [
                [-33.89, 151.27],
                [-33.92, 151.25],
                [-34.02, 151.15],
                [-33.80, 151.28],
                [-33.95, 151.25]
                ];

                var myLatlng = new google.maps.LatLng(-33.92, 151.25);
                var mapOptions = {
                    zoom: 1,
                    center: myLatlng
                }
                var map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);

                var marker, i;
                for (i = 0; i < locations.length; i++) {
                    marker = new google.maps.Marker({
                        position: new google.maps.LatLng(locations[i][0], locations[i][1]),
                        map: map,
                        title: 'Photos taken here!'
                    });
                }

                for (i = 0; i < locations.length; i++) {
                    console.log("Latitude: " + locations[i][0] + ", Latitude: " + locations[i][1]);
                }
            }

            google.maps.event.addDomListener(window, 'load', initialize);
        });
    </script>

    <div class="container">
        <div class="col-lg-12">
            <div id="map-canvas" class="img-responsive" style="max-height:500px;height:500px;"></div>
        </div>
    </div>
</asp:Content>
