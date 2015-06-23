<%@ Page Title="" Language="C#" MasterPageFile="~/InstaKG.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="InstaKG.Login" %>
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
                    <legend class="col-lg-offset-2 col-lg-3">Member's Login</legend>
                </div>
                
                <div class="form-group">
                    <asp:Label ID="lbl_username" CssClass="col-lg-4 control-label" runat="server">Username:</asp:Label>
                    <div class="col-lg-4">
                        <asp:Panel ID="pan_username" runat="server" DefaultButton="btn_submit">
                            <asp:TextBox ID="tb_username" CssClass="form-control" runat="server"></asp:TextBox>
                        </asp:Panel>
                    </div>
                    <div class="col-lg-1">
                        <asp:RequiredFieldValidator ID="rfv_username" runat="server" ErrorMessage="Username required" ControlToValidate="tb_username" ForeColor="Red">*</asp:RequiredFieldValidator>
                    </div>
                </div>

                <div class="form-group">
                    <asp:Label ID="lbl_password" CssClass="col-lg-4 control-label" runat="server">Password:</asp:Label>
                    <div class="col-lg-4">
                        <asp:Panel ID="pan_password" runat="server" DefaultButton="btn_submit">
                            <asp:TextBox ID="tb_password" TextMode="Password" CssClass="form-control" runat="server"></asp:TextBox>
                        </asp:Panel>
                    </div>
                    <div class="col-lg-1">
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Password required" ControlToValidate="tb_password" ForeColor="Red">*</asp:RequiredFieldValidator>
                    </div>
                </div>

                <div class="form-group">
                    <asp:Label ID="Label1" CssClass="col-lg-4 control-label" runat="server"></asp:Label>
                    <div class="col-lg-4">
                        <a href="/Account/ForgetPassword.aspx">Forget Password</a>
                    </div>
                    <div class="col-lg-1">
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Username required" ControlToValidate="tb_username" ForeColor="Red">*</asp:RequiredFieldValidator>
                    </div>
                </div>

                <div class="form-group">
                    <div class="col-lg-offset-4">
                        <asp:ValidationSummary ID="vs_all" runat="server" ForeColor="Red" />
                    </div>
                </div>

                <div class="form-group">
                    <div class="col-lg-4 col-lg-offset-6">
                        <asp:Button ID="btn_claer" CssClass="btn btn-default" Text="Clear" runat="server" OnClick="btn_clear_Click" CausesValidation="false" />
                        <asp:Button ID="btn_submit" CssClass="btn btn-primary" Text="Login" runat="server" OnClick="btn_submit_Click" />
                    </div>
                </div>

            </fieldset>
        </div>
        
    </div>
</asp:Content>
