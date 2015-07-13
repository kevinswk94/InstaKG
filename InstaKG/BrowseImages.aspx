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

        <h3>Browse Images:</h3>
        <br />
        
        <asp:GridView ID="gv_browseImages" CssClass="table table-responsive" runat="server" AutoGenerateColumns="False" PageSize="2" OnPageIndexChanging="gv_browseImages_PageIndexChanging">
            <Columns>
                <asp:BoundField DataField="imageID" HeaderText="imageID" InsertVisible="False" ReadOnly="True" SortExpression="imageID" Visible="false" />
                <asp:BoundField DataField="imageTitle" HeaderText="Title" SortExpression="imageTitle" />
                <asp:TemplateField>
                    <ItemTemplate>
                        <a href="<%#"/CommentViewer.aspx?imageID=" + Eval("imageID") %>"><asp:Image ID="img_Photo" CssClass="img-responsive" style="max-height:200px;" runat="server" ImageUrl='<%#"ImageViewerHandler.ashx?id=" + Eval("imageID")%>' /></a>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="View GPS Location">
                    <ItemTemplate>
                        <a href="<%#"/ImageGPSLocationViewer.aspx?imageID=" + Eval("imageID") %>">View</a>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="uploadDateTime" HeaderText="Upload Date" SortExpression="uploadDateTime" />
                <asp:BoundField DataField="fName" HeaderText="Uploader" SortExpression="fName" />
            </Columns>
        </asp:GridView>
    </div>

    <%--<asp:SqlDataSource ID="sds_Images" runat="server" ConnectionString="<%$ ConnectionStrings:InstaKG %>" SelectCommand="SELECT DISTINCT [Image.imageID], [Image.imageTitle], [Image.uploadDateTime], [Image.accountID], [Account.accountID], [Account.fName] FROM [Image] INNER JOIN Account ON Image.accountID = Account.accountID ORDER BY [uploadDateTime]"></asp:SqlDataSource>--%>
</asp:Content>