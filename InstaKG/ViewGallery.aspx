<%@ Page Title="" Language="C#" MasterPageFile="~/InstaKG.Master" AutoEventWireup="true" CodeBehind="ViewGallery.aspx.cs" Inherits="InstaKG.ViewGallery" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%--Light Gallery Animation--%>
    <link href="Styles/lightGallery.css" rel="stylesheet" />
    <script src="Scripts/lightGallery.js"></script>

    <%-- WOW Animation--%>
    <link href="Styles/animate.css" rel="stylesheet" />
    <script src="Scripts/wow.min.js"></script>

    <script type="text/javascript">
        $(document).ready(function ()
        {
            $("#lightGallery").lightGallery();
        });
    </script>

    <style>
        /*Gallery*/
        ul 
        {
            list-style: none outside none;
        }

        .gallery li 
        {
            display: block;
            float: left;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <asp:Repeater ID="Repeater1" runat="server">
            <HeaderTemplate>
                    <ul id="lightGallery" class="gallery">
                </HeaderTemplate>
                <ItemTemplate>
                    <li class="col-lg-3 col-md-4 col-xs-6 animated fadeInUp" data-src='<%#"ImageViewerHandler.ashx?id=" + Eval("imageID")%>'>
                        <asp:Image ID="Image" runat="server" class="thumbnail img-responsive" style="max-height:180px;" ImageUrl='<%#"ImageViewerHandler.ashx?id=" + Eval("imageID")%>' />
                    </li>
                </ItemTemplate>
                <FooterTemplate>
                    </ul>
                </FooterTemplate>
        </asp:Repeater>
        <%--<div class="row">
            
        </div>--%>
    </div>
</asp:Content>
