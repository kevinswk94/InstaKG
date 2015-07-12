<%@ Page Title="" Language="C#" MasterPageFile="~/InstaKG.Master" AutoEventWireup="true" CodeBehind="ImgLocation.aspx.cs" Inherits="InstaKG.ImgLocation" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%--<img src="http://maps.google.com/maps/api/staticmap?center=151.21,-33.85&zoom=8&size=400x300&sensor=false" style="width: 400px; height: 400px;" />--%>

    <script src="https://maps.googleapis.com/maps/api/js?v=3.exp"></script>

    <style>
        #map-canvas {
            height: 100%;
            width: 100%;
            margin: 0px;
            padding: 0px;
        }
    </style>

    <script>
        var map;
        var latt = <% =latitude %>;
        var longg = <% =longitude %>;
        
        console.log(longg);
        function initialize() {
            map = new google.maps.Map(document.getElementById('map-canvas'), {
                zoom: 12,
                center: { lat: latt, lng: longg }
            });

            var marker = new google.maps.Marker({
                position: { lat: latt, lng: longg },
                map: map,
                title: 'Photo taken here!'
            });
        }

        google.maps.event.addDomListener(window, 'load', initialize);

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
            <div id="map-canvas" class="img-responsive" style="max-height:300px;"></div>
        </div>
    </div>
    
</asp:Content>
