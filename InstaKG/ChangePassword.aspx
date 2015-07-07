<%@ Page Title="" Language="C#" MasterPageFile="~/InstaKG.Master" AutoEventWireup="true" CodeBehind="ChangePassword.aspx.cs" Inherits="InstaKG.Account.ChangePassword" %>

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
                    <legend class="col-lg-offset-2 col-lg-5">Change your password:</legend>
                </div>

                <div class="form-group">
                    <asp:Label ID="lbl_CurrentPassword" CssClass="col-lg-3 control-label" runat="server">Current Password:</asp:Label>
                    <div class="col-lg-6">
                        <asp:TextBox ID="tb_CurrentPassword" TextMode="Password" CssClass="form-control" runat="server"></asp:TextBox>
                    </div>
                    <div class="col-lg-1">
                        <asp:RequiredFieldValidator ID="rfv_CurrentPassword" runat="server" ErrorMessage="Current password required" ControlToValidate="tb_CurrentPassword" ForeColor="Red">*</asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="form-group">
                    <asp:Label ID="lbl_NewPassword" CssClass="col-lg-3 control-label" runat="server">New Password:</asp:Label>
                    <div class="col-lg-6">
                        <asp:TextBox ID="tb_NewPassword" TextMode="Password" CssClass="form-control" runat="server"></asp:TextBox>
                    </div>
                    <div class="col-lg-1">
                        <asp:RequiredFieldValidator ID="rfv_NewPassword" runat="server" ErrorMessage="New password required" ControlToValidate="tb_NewPassword" ForeColor="Red">*</asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="form-group">
                    <asp:Label ID="lbl_ConfirmPassword" CssClass="col-lg-3 control-label" runat="server">Re-enter New Password:</asp:Label>
                    <div class="col-lg-6">
                        <asp:TextBox ID="tb_ConfirmPassword" TextMode="Password" CssClass="form-control" runat="server"></asp:TextBox>
                    </div>
                    <div class="col-lg-1">
                        <asp:RequiredFieldValidator ID="rfv_ConfirmPassword" runat="server" ErrorMessage="Please re-enter new password" ControlToValidate="tb_ConfirmPassword" ForeColor="Red">*</asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-lg-offset-4">
                        <asp:ValidationSummary ID="vs_all" runat="server" ForeColor="Red" />
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-lg-4 col-lg-offset-3">
                        <asp:Button ID="btn_Change" runat="server" OnClick="btn_Change_Click" Text="Change Password" class="btn btn-primary" />
                        <asp:Label ID="lb_EndInfo" runat="server" ForeColor="Red"></asp:Label>
                    </div>
                </div>
            </fieldset>
        </div>
    </div>
</asp:Content>