<%@ Page Title="" Language="C#" MasterPageFile="~/InstaKG.Master" AutoEventWireup="true" CodeBehind="Registration.aspx.cs" Inherits="InstaKG.Account.Registration" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    
    <div class="container">
        <div class="well">
            <fieldset class="form-horizontal">

                <legend>Register a new account</legend>

                <div class="form-group">
                    <asp:Label ID="lbl_username" CssClass="col-lg-3 control-label" runat="server">Username:</asp:Label>
                    <div class="col-lg-6">
                        <asp:TextBox ID="tb_username" CssClass="form-control" runat="server"></asp:TextBox>
                    </div>
                </div>

                <div class="form-group">
                    <asp:Label ID="lbl_fName" CssClass="col-lg-3 control-label" runat="server">First Name:</asp:Label>
                    <div class="col-lg-6">
                        <asp:TextBox ID="tb_fName" CssClass="form-control" runat="server"></asp:TextBox>
                    </div>
                </div>

                <div class="form-group">
                    <asp:Label ID="lbl_lName" CssClass="col-lg-3 control-label" runat="server">Last Name:</asp:Label>
                    <div class="col-lg-6">
                        <asp:TextBox ID="tb_lName" CssClass="form-control" runat="server"></asp:TextBox>
                    </div>
                </div>

                <div class="form-group">
                    <asp:Label ID="lbl_password" CssClass="col-lg-3 control-label" runat="server">Password:</asp:Label>
                    <div class="col-lg-6">
                        <asp:TextBox ID="tb_password" CssClass="form-control" TextMode="Password" runat="server"></asp:TextBox>
                    </div>
                </div>

                <div class="form-group">
                    <asp:Label ID="lbl_rePassword" CssClass="col-lg-3 control-label" runat="server">Re-enter Password:</asp:Label>
                    <div class="col-lg-6">
                        <asp:TextBox ID="tb_rePassword" CssClass="form-control" TextMode="Password" runat="server"></asp:TextBox>
                    </div>
                </div>

                <div class="form-group">
                    <div class="col-lg-4 col-lg-offset-7">
                        <asp:Button ID="btn_cancel" CssClass="btn btn-default" Text="Cancel" runat="server" OnClick="btn_cancel_Click" />
                        <asp:Button ID="btn_submit" CssClass="btn btn-primary" Text="Submit" runat="server" OnClick="btn_submit_Click" />
                    </div>
                </div>
            </fieldset>
        </div>
    </div>
</asp:Content>
