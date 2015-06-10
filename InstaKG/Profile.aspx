<%@ Page Title="" Language="C#" MasterPageFile="~/InstaKG.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="InstaKG.Profile1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <asp:GridView ID="GridView1" runat="server">
        <Columns>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:Image ID="Image" runat="server" ImageUrl='<%#"ImageViewerHandler.ashx?id=" + Eval("imageID")%>' />
                    <%--<asp:Image ID="Image" runat="server" ImageUrl='<%#"ImageViewerHandler.ashx?id=" + Eval("accountID")%>' />--%>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>

</asp:Content>