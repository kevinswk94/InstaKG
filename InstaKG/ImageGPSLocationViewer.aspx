<%@ Page Title="" Language="C#" MasterPageFile="~/InstaKG.Master" AutoEventWireup="true" CodeBehind="ImageGPSLocationViewer.aspx.cs" Inherits="InstaKG.ImgLocation" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <script src="https://maps.googleapis.com/maps/api/js?v=3.exp"></script>

    <script type="text/javascript">

        $(document).ready(function() {
            function initialize() {
            
                var myLatlng = new google.maps.LatLng(<% =latitude %>, <% =longitude %>);
                var mapOptions = {
                    zoom: 12,
                    center: myLatlng
                }
                var map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
                var marker = new google.maps.Marker({
                    position: myLatlng,
                    map: map,
                    title: 'Photo taken here!'
                });
            }

            google.maps.event.addDomListener(window, 'load', initialize);
        });
    </script>

    <div class="container">
        <div class="col-lg-6">
            <h3>Browsing Image: <span><% =imageTitle %></span></h3>
            <asp:Image ID="img_image" runat="server" CssClass="img-responsive" style="max-height:450px;" />
        </div>
        <div class="col-lg-6">
            <h3>EXIF data from <span><% =imageTitle %></span>:</h3>
            <div id="map-canvas" class="img-responsive" style="max-height:300px;height:300px;"></div>
            <h4>Latitude: <% =latitude %></h4>
            <h4>Longitude: <% =longitude %></h4>
        </div>
    </div>
    
</asp:Content>
