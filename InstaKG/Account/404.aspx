<%@ Page Title="" Language="C#" MasterPageFile="~/InstaKG.Master" AutoEventWireup="true" CodeBehind="404.aspx.cs" Inherits="InstaKG.Account._404" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <div class="well">
            <asp:Image ID="Image1" runat="server" ImageUrl="~/Images/trouble-afoot.png" CssClass="img-responsive center-block" />
            <h3 class="text-center">Oops! Page Not Found! Please try again.</h3>
        </div>
    </div>
</asp:Content>
