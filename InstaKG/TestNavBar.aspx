<%@ Page Title="" Language="C#" MasterPageFile="~/InstaKG.Master" AutoEventWireup="true" CodeBehind="TestNavBar.aspx.cs" Inherits="InstaKG.Test" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Alert placeholder, alter attributes in CodeBehind -->
    <div id="alert_placeholder" runat="server" visible="false">
        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
        <asp:Literal runat="server" ID="alertText" />
    </div>

    <asp:Button ID="Button1" runat="server" Text="Login" OnClick="Button1_Click" />
</asp:Content>