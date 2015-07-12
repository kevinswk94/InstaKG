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
            <h3>Browsing Image: </h3>
            <asp:Image ID="img_image" runat="server" ImageUrl="~/ImageViewerHandler.ashx?id=9" CssClass="img-responsive" />
            <%--<img src="http://placehold.it/400x300" />--%>
        </div>
        <div class="col-lg-6">
            <h3>EXIF data from image:</h3>
            <%--<img src="http://placehold.it/400x300" />--%>
            <%--<asp:Image ID="Image1" runat="server" />--%>
            <div id="map-canvas" class="img-responsive" style="max-height:300px;height:300px;"></div>
            <h4>Latitude: <% =latitude %></h4>
            <h4>Longitude: <% =longitude %></h4>
        </div>
    </div>
    
</asp:Content>
