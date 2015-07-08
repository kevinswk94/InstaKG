<%@ Page Title="" Language="C#" MasterPageFile="~/InstaKG.Master" AutoEventWireup="true" CodeBehind="ImgLocation.aspx.cs" Inherits="InstaKG.ImgLocation" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%--<img src="http://maps.google.com/maps/api/staticmap?center=151.21,-33.85&zoom=8&size=400x300&sensor=false" style="width: 400px; height: 400px;" />--%>
    <asp:Image ID="Image1" runat="server" />

    <%--<script src="https://maps.googleapis.com/maps/api/js?v=3.exp"></script>

    <style>
        #map-canvas {
            height: 50%;
            width: 50%;
            margin: 0px;
            padding: 0px;
        }
    </style>

    <script>
        var map;
        function initialize() {
            map = new google.maps.Map(document.getElementById('map-canvas'), {
                zoom: 8,
                center: { lat: -34.397, lng: 150.644 }
            });
        }

        google.maps.event.addDomListener(window, 'load', initialize);

    </script>

    <div id="map-canvas"></div>--%>
</asp:Content>
