<%@ Page Title="" Language="C#" MasterPageFile="~/InstaKG.Master" AutoEventWireup="true" CodeBehind="CommentCreator_Test.aspx.cs" Inherits="InstaKG.CommentCreator_Test" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!-- Alert placeholder, alter attributes in CodeBehind -->
    <div id="alert_placeholder" runat="server" visible="false">
        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
        <asp:Literal runat="server" ID="alertText" />
    </div>

    <div class="well">
        <fieldset class="form-horizontal">
            <div class="row">
                <legend class="col-lg-offset-2 col-lg-3">Add new comment to post:</legend>
            </div>

            <div class="form-group">
                <asp:Label ID="lbl_username" CssClass="col-lg-3 control-label" runat="server">Username:</asp:Label>
                <div class="col-lg-6">
                    <asp:TextBox ID="tb_username" CssClass="form-control" runat="server"></asp:TextBox>
                </div>
                <div class="col-lg-1">
                    <asp:RequiredFieldValidator ID="rfv_username" runat="server" ErrorMessage="Username required" ControlToValidate="tb_username" ForeColor="Red">*</asp:RequiredFieldValidator>
                </div>
            </div>
        </fieldset>
    </div>

</asp:Content>
