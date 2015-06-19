<%@ Page Title="" Language="C#" MasterPageFile="~/InstaKG.Master" AutoEventWireup="true" CodeBehind="CommentCreator_Test.aspx.cs" Inherits="InstaKG.CommentCreator_Test" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container">
        <!-- Alert placeholder, alter attributes in CodeBehind -->
        <div id="alert_placeholder" runat="server" visible="false">
            <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
            <asp:Literal runat="server" ID="alertText" />
        </div>

        <div class="well">
            <fieldset class="form-horizontal">
                <div class="row">
                    <legend class="col-lg-offset-2 col-lg-5">Add new comment to post:</legend>
                </div>
                <div class="form-group">
                    <asp:Label ID="lbl_imageTitle" CssClass="col-lg-3 control-label" runat="server">Image:</asp:Label>
                    <div class="col-lg-3">
                        <asp:DropDownList ID="ddl_imageTitle" runat="server" CssClass="form-control" AutoPostBack="True" DataSourceID="sds_Images" DataTextField="imageTitle" DataValueField="imageID"></asp:DropDownList>
                    </div>
                </div>

                <div class="form-group">
                    <asp:Label ID="lbl_commentContent" CssClass="col-lg-3 control-label" runat="server">Comment:</asp:Label>
                    <div class="col-lg-6">
                        <asp:TextBox ID="tb_commentContent" CssClass="form-control" TextMode="MultiLine" Rows="4" runat="server"></asp:TextBox>
                    </div>
                    <div class="col-lg-1">
                        <asp:RequiredFieldValidator ID="rfv_commentContent" runat="server" ErrorMessage="Comment required" ControlToValidate="tb_commentContent" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                </div>

                <div class="form-group">
                    <div class="col-lg-4 col-lg-offset-7">
                        <asp:Button ID="btn_cancel" CssClass="btn btn-default" Text="Cancel" runat="server" OnClick="btn_cancel_Click" CausesValidation="false" />
                        <asp:Button ID="btn_submit" CssClass="btn btn-primary" Text="Submit" runat="server" OnClick="btn_submit_Click" />
                    </div>
                </div>
            </fieldset>
        </div>
    </div>

    <asp:SqlDataSource ID="sds_Images" runat="server" ConnectionString="<%$ ConnectionStrings:InstaKG %>" SelectCommand="SELECT DISTINCT [imageID], [imageTitle] FROM [Image] ORDER BY [imageID]"></asp:SqlDataSource>
</asp:Content>
