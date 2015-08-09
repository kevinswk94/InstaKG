<%@ Page Title="" Language="C#" MasterPageFile="~/InstaKG.Master" AutoEventWireup="true" CodeBehind="Error.aspx.cs" Inherits="InstaKG.Error" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <div class="well">
            <asp:Image ID="Image1" runat="server" ImageUrl="~/Images/trouble-afoot.png" CssClass="img-responsive center-block" />
            <h3 class="text-center">Oops! An unexpected error has occurred. Please try again later.</h3>
        </div>
    </div>
</asp:Content>
