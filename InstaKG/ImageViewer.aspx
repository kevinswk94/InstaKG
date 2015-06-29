<%@ Page Title="" Language="C#" MasterPageFile="~/InstaKG.Master" AutoEventWireup="true" CodeBehind="ImageViewer.aspx.cs" Inherits="InstaKG.ImageViewer" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <div class="well">
            <fieldset class="form-horizontal">
                <div class="row">
                    <legend class="col-lg-offset-2">View Image:</legend>
                </div>
                <div class="form-group">
                    <asp:Label ID="lbl_imageTitle" CssClass="col-lg-3 control-label" runat="server">Image:</asp:Label>
                    <div class="col-lg-3">
                        <asp:DropDownList ID="ddl_imageTitle" runat="server" CssClass="form-control" AutoPostBack="True" DataSourceID="sds_Images" DataTextField="imageTitle" DataValueField="imageID"></asp:DropDownList>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-lg-offset-1">
                        <asp:Image ID="img_selectedImage" runat="server" CssClass="img-responsive center-block" style="max-width:800px;"/>
                        <%--<asp:Image ID="img_selectedImage" runat="server" CssClass="img-responsive" ImageUrl='<%#"~/ImageViewerHandler.ashx?id=" + ddl_imageTitle.SelectedValue%>' />--%>
                    </div>
                </div>
            </fieldset>
        </div>
    </div>

    <asp:SqlDataSource ID="sds_Images" runat="server" ConnectionString="<%$ ConnectionStrings:InstaKG %>" SelectCommand="SELECT DISTINCT [imageID], [imageTitle] FROM [Image] ORDER BY [imageID]"></asp:SqlDataSource>
</asp:Content>
