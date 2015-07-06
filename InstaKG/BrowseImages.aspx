<%@ Page Title="" Language="C#" MasterPageFile="~/InstaKG.Master" AutoEventWireup="true" CodeBehind="BrowseImages.aspx.cs" Inherits="InstaKG.BrowseImages" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <!-- Alert placeholder, alter attributes in CodeBehind -->
        <div id="alert_placeholder" runat="server" visible="false">
            <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
            <asp:Literal runat="server" ID="alertText" />
        </div>

        <asp:GridView ID="gv_browseImages" CssClass="table table-responsive" runat="server" AutoGenerateColumns="False">
            <Columns>
                <asp:BoundField DataField="imageID" HeaderText="imageID" InsertVisible="False" ReadOnly="True" SortExpression="imageID" Visible="false" />
                <asp:BoundField DataField="imageTitle" HeaderText="imageTitle" SortExpression="imageTitle" />
                <asp:TemplateField>
                    <ItemTemplate>
                        <a href="<%#"CommentViewer.aspx?imageID=" + Eval("imageID") %>"><asp:Image ID="img_Photo" CssClass="img-responsive" style="max-height:200px;" runat="server" ImageUrl='<%#"ImageViewerHandler.ashx?id=" + Eval("imageID")%>' /></a>
                        
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="uploadDateTime" HeaderText="uploadDateTime" SortExpression="uploadDateTime" />
                <asp:BoundField DataField="accountID" HeaderText="accountID" SortExpression="accountID" />
            </Columns>
        </asp:GridView>
    </div>

    <asp:SqlDataSource ID="sds_Images" runat="server" ConnectionString="<%$ ConnectionStrings:InstaKG %>" SelectCommand="SELECT DISTINCT [imageID], [imageTitle], [uploadDateTime], [accountID] FROM [Image] ORDER BY [uploadDateTime]"></asp:SqlDataSource>
</asp:Content>