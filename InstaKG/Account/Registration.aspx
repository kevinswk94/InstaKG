<%@ Page Title="" Language="C#" MasterPageFile="~/InstaKG.Master" AutoEventWireup="true" CodeBehind="Registration.aspx.cs" Inherits="InstaKG.Account.Registration" %>
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

                <legend>Register a new account</legend>

                <div class="form-group">
                    <asp:Label ID="lbl_username" CssClass="col-lg-3 control-label" runat="server">Username:</asp:Label>
                    <div class="col-lg-6">
                        <asp:TextBox ID="tb_username" CssClass="form-control" runat="server"></asp:TextBox>
                    </div>
                    <div class="col-lg-1">
                        <asp:RequiredFieldValidator ID="rfv_username" runat="server" ErrorMessage="Username required" ControlToValidate="tb_username" ForeColor="Red">*</asp:RequiredFieldValidator>
                    </div>
                </div>

                <div class="form-group">
                    <asp:Label ID="lbl_fName" CssClass="col-lg-3 control-label" runat="server">First Name:</asp:Label>
                    <div class="col-lg-6">
                        <asp:TextBox ID="tb_fName" CssClass="form-control" runat="server"></asp:TextBox>
                    </div>
                    <div class="col-lg-1">
                        <asp:RequiredFieldValidator ID="rfv_fName" runat="server" ErrorMessage="First Name Required" ControlToValidate="tb_fName" ForeColor="Red">*</asp:RequiredFieldValidator>
                    </div>
                </div>

                <div class="form-group">
                    <asp:Label ID="lbl_lName" CssClass="col-lg-3 control-label" runat="server">Last Name:</asp:Label>
                    <div class="col-lg-6">
                        <asp:TextBox ID="tb_lName" CssClass="form-control" runat="server"></asp:TextBox>
                    </div>
                    <div class="col-lg-1">
                        <asp:RequiredFieldValidator ID="rfv_lName" runat="server" ErrorMessage="Last Name Required" ControlToValidate="tb_lName" ForeColor="Red">*</asp:RequiredFieldValidator>
                    </div>
                </div>

                <div class="form-group">
                    <asp:Label ID="lbl_email" CssClass="col-lg-3 control-label" runat="server">Email Address:</asp:Label>
                    <div class="col-lg-6">
                        <asp:TextBox ID="tb_email" CssClass="form-control" runat="server"></asp:TextBox>
                    </div>
                    <div class="col-lg-1">
                        <asp:RequiredFieldValidator ID="rfv_email" runat="server" ErrorMessage="Email Address Required" ControlToValidate="tb_email" ForeColor="Red" Display="Dynamic">*</asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="rev_validEmail" runat="server" ErrorMessage="Not a valid email" ControlToValidate="tb_email" ForeColor="Red" Display="Dynamic" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">*</asp:RegularExpressionValidator>
                    </div>
                </div>

                <div class="form-group">
                    <asp:Label ID="lbl_password" CssClass="col-lg-3 control-label" runat="server">Password:</asp:Label>
                    <div class="col-lg-6">
                        <asp:TextBox ID="tb_password" CssClass="form-control" TextMode="Password" runat="server"></asp:TextBox>
                    </div>
                    <div class="col-lg-1">
                         <asp:RequiredFieldValidator ID="rfv_password" runat="server" ErrorMessage="Password Required" ControlToValidate="tb_password" ForeColor="Red">*</asp:RequiredFieldValidator>
                        <asp:CompareValidator ID="cv_passwords" runat="server" ErrorMessage="Passwords do not match" ControlToValidate="tb_password" ControlToCompare="tb_rePassword" Type="String" Operator="Equal" ForeColor="Red" Display="Dynamic">*</asp:CompareValidator>
                    </div>
                </div>

                <div class="form-group">
                    <asp:Label ID="lbl_rePassword" CssClass="col-lg-3 control-label" runat="server">Re-enter Password:</asp:Label>
                    <div class="col-lg-6">
                        <asp:TextBox ID="tb_rePassword" CssClass="form-control" TextMode="Password" runat="server"></asp:TextBox>
                    </div>
                    <div class="col-lg-1">
                        <asp:RequiredFieldValidator ID="rfv_rePassword" runat="server" ErrorMessage="Re-enter password" ControlToValidate="tb_rePassword" ForeColor="Red" Display="Dynamic">*</asp:RequiredFieldValidator>
                    </div>
                </div>

                <div class="form-group">
                    <div class="col-lg-offset-3">
                        <asp:ValidationSummary ID="vs_all" ForeColor="Red" runat="server" />
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
</asp:Content>
