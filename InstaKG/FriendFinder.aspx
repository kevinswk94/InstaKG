<%@ Page Title="" Language="C#" MasterPageFile="~/InstaKG.Master" AutoEventWireup="true" CodeBehind="FriendFinder.aspx.cs" Inherits="InstaKG.FriendFinder" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <asp:GridView ID="gv_users" runat="server"></asp:GridView>
        <!-- Added a test comment here -->
    </div>
</asp:Content>
