<%@ Page Title="" Language="C#" MasterPageFile="~/InstaKG.Master" AutoEventWireup="true" CodeBehind="ProfileFinal.aspx.cs" Inherits="InstaKG.ProfileFinal" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <asp:Repeater ID="Repeater1" runat="server" DataSourceID="Image"></asp:Repeater>





    <asp:SqlDataSource ID="Image" runat="server" ConnectionString="<%$ ConnectionStrings:constr %>" SelectCommand="SELECT * FROM [Image] WHERE ([accountID] = @accountID)">
        <SelectParameters>
            <asp:SessionParameter Name="accountID" SessionField="1" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>





</asp:Content>
