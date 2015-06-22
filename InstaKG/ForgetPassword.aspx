<%@ Page Title="" Language="C#" MasterPageFile="~/InstaKG.Master" AutoEventWireup="true" CodeBehind="ForgetPassword.aspx.cs" Inherits="InstaKG.ForgetPassword" %>
<%@ Register TagPrefix="recaptcha" Namespace="Recaptcha" Assembly="Recaptcha" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script src='https://www.google.com/recaptcha/api.js'></script>
    <script type="text/javascript">
        var onloadCallback = function () {
            grecaptcha.render('fp', {
                'sitekey': '6LdLjPYSAAAAACgXKw1nxpFEndwLVqbotnANKY4I'
            });
        };
    </script>
    <div class="container">

 <!-- Alert placeholder, alter attributes in CodeBehind -->
        <div id="alert_placeholder" runat="server" visible="false">
            <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
            <asp:Literal runat="server" ID="alertText" />
        </div>

        <div class="well">
            <fieldset class="form-horizontal">
                <div id="fp">
                    <div class="form-group">
                        <asp:Label ID="lbl_UsernameOrEmail" CssClass="col-lg-5 control-label" runat="server">Please enter your username or registered email address:</asp:Label>
                        <div class="col-lg-4">
                            <asp:TextBox ID="tb_UsernameOrEmail" runat="server"></asp:TextBox>
                        </div>
                    </div>
                    <br />
                   <div class="col-lg-5 col-lg-offset-3">
                       <div class="g-recaptcha" data-sitekey="6LdLjPYSAAAAACgXKw1nxpFEndwLVqbotnANKY4I"></div>
                   
                    </div>                
                    <br />
                    <br />
                 <div class="col-lg-5 col-lg-offset-5">
                        <asp:Button ID="btn_Reset" runat="server" OnClick="btn_Reset_Click" Text="Reset Password" class="btn btn-primary" />
                        <asp:Label ID="lb_EndInfo" runat="server" ForeColor="Red"></asp:Label>
                    </div>
                    </div>
            </fieldset>
           <script src="https://www.google.com/recaptcha/api.js?onload=onloadCallback&render=explicit"
        async defer>
    </script>
        </div>
    </div>
</asp:Content>
