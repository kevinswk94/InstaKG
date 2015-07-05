<%@ Page Title="" Language="C#" MasterPageFile="~/InstaKG.Master" AutoEventWireup="true" CodeBehind="ProfilePage.aspx.cs" Inherits="InstaKG.ProfilePage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <div id="alert_placeholder" runat="server" visible="false">
            <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
            <asp:Literal runat="server" ID="alertText" />
        </div>

        <div class="well">
            <fieldset>
                <legend>User's Profile</legend>

                <div class="form-group">
                    <asp:Label ID="lbl_email" CssClass="col-lg-4 control-label" runat="server" Text="Email: "></asp:Label>
                    <div class="col-lg-4">
                        <asp:TextBox ID="TextBox1" runat="server" ></asp:TextBox>
                    </div>
                </div>

                <br />
                <br />

                <div class="form-group">
                    <asp:Label ID="lbl_fname" CssClass="col-lg-4 control-label" runat="server" Text="First Name: "></asp:Label>
                    <div class="col-lg-4">
                        <asp:TextBox ID="Label2" runat="server"></asp:TextBox>
                    </div>
                </div>

                <br />

                <div class="form-group">
                    <asp:Label ID="lbl_lname" CssClass="col-lg-4 control-label" runat="server" Text="Last Name: "></asp:Label>

                    <div class="col-lg-4">
                        <asp:TextBox ID="Label4" runat="server"></asp:TextBox>
                    </div>
                </div>

                <br />
                <br />                

                <div class="form-group">
                    <asp:Label ID="Label1" CssClass="col-lg-4 control-label" runat="server" Text="Gender: "></asp:Label>
                    <div class="col-lg-4">
                        <asp:TextBox ID="tb_gender" runat="server"></asp:TextBox>
                    </div>
                </div>

                <br />

                <div class="form-group">
                    <asp:Label ID="lbl_birthday" CssClass="col-lg-4 control-label" runat="server" Text="Birthday: "></asp:Label>
                    <div class="col-lg-4">
                        <asp:TextBox ID="tb_birthday" runat="server"></asp:TextBox>
                    </div>
                </div>

                <div class="form-group">
                    <div class="col-lg-4 col-lg-offset-6">
                        <asp:Button ID="btn_clear_user" CssClass="btn btn-default" runat="server" Text="Clear" />
                        <asp:Button ID="btn_submit_user" CssClass="btn btn-primary" runat="server" Text="Submit" />
                    </div>
                </div>
            </fieldset>
        </div>

        <br />

        <div class="well">
            <fieldset>
                <legend>Change Password</legend>

                <div class="form-group">
                    <asp:Label ID="lbl_currentpw" CssClass="col-lg-4 control-label" runat="server" Text="Current Password: "></asp:Label>
                    <div class="col-lg-4">
                        <asp:TextBox ID="tb_currentpw" runat="server"></asp:TextBox>
                    </div>
                </div>

                <br />

                <div class="form-group">
                    <asp:Label ID="lbl_newpw" CssClass="col-lg-4 control-label" runat="server" Text="New Password: "></asp:Label>
                    <div class="col-lg-4">
                        <asp:TextBox ID="tb_newpw" runat="server"></asp:TextBox>
                    </div>
                </div>

                <br />

                <div class="form-group">
                    <asp:Label ID="lbl_retype_newpw" CssClass="col-lg-4 control-label" runat="server" Text="Re-Enter New Password: "></asp:Label>
                    <div class="col-lg-4">
                        <asp:TextBox ID="tb_retype_newpw" runat="server"></asp:TextBox>
                    </div>
                </div>

                <br />

                <div class="form-group">
                    <div class="col-lg-4 col-lg-offset-6">
                        <asp:Button ID="btn_clear_pw" CssClass="btn btn-default" runat="server" Text="Clear" />
                        <asp:Button ID="btn_submit_pw" CssClass="btn btn-primary" runat="server" Text="Submit" />
                    </div>
                </div>

            </fieldset>
        </div>
    </div>
</asp:Content>
