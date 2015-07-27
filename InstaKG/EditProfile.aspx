<%@ Page Title="" Language="C#" MasterPageFile="~/InstaKG.Master" AutoEventWireup="true" CodeBehind="EditProfile.aspx.cs" Inherits="InstaKG.EditProfile" %>
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
                <legend><%--<%= Session["username"].ToString() %>'s--%> Profile</legend>

                <div class="form-group">
                    <asp:Label ID="lbl_email" CssClass="col-lg-4 control-label" runat="server" Text="Email: "></asp:Label>
                    <div class="col-lg-4">
                        <asp:TextBox ID="tb_email" runat="server" Enabled="false"></asp:TextBox>
                    </div>
                </div>

                <br />
                <br />

                <div class="form-group">
                    <asp:Label ID="lbl_fname" CssClass="col-lg-4 control-label" runat="server" Text="First Name: "></asp:Label>
                    <div class="col-lg-4">
                        <asp:TextBox ID="tb_fname" runat="server"></asp:TextBox>
                    </div>
                    <div class="col-lg-1">
                        <asp:RequiredFieldValidator ValidationGroup="UpdateUser" ID="rfv_fname" runat="server" ErrorMessage="First Name Required" ControlToValidate="tb_fname" CssClass="text-danger">*</asp:RequiredFieldValidator>
                    </div>
                </div>

                <br />

                <div class="form-group">
                    <asp:Label ID="lbl_lname" CssClass="col-lg-4 control-label" runat="server" Text="Last Name: "></asp:Label>

                    <div class="col-lg-4">
                        <asp:TextBox ID="tb_lname" runat="server"></asp:TextBox>
                    </div>
                    <div class="col-lg-1">
                        <asp:RequiredFieldValidator ValidationGroup="UpdateUser" ID="rfv_lname" runat="server" ErrorMessage="Last Name Required" ControlToValidate="tb_lname" CssClass="text-danger">*</asp:RequiredFieldValidator>
                    </div>
                </div>

                <br />
                <br />                

                <div class="form-group">
                    <asp:Label ID="Label1" CssClass="col-lg-4 control-label" runat="server" Text="Gender: "></asp:Label>
                    <div class="col-lg-4">
                        <asp:RadioButtonList ID="rbl_gender" runat="server" RepeatDirection="Horizontal" Height="30px" Width="153px">
                            <asp:ListItem Value="Male" Text="Male"></asp:ListItem>
                            <asp:ListItem Value="Female" Text="Female"></asp:ListItem>
                        </asp:RadioButtonList>
                    </div>
                    <div class="col-lg-1">
                        <asp:RequiredFieldValidator ValidationGroup="UpdateUser" ID="rfv_gender" runat="server" ErrorMessage="Option Required" ControlToValidate="rbl_gender" CssClass="text-danger">*</asp:RequiredFieldValidator>
                    </div>
                </div>

                <br />
                <!--
                <div class="form-group">
                    <asp:Label ID="lbl_birthday" CssClass="col-lg-4 control-label" runat="server" Text="Birthday: "></asp:Label>
                    <div class="col-lg-4">
                        <asp:TextBox ID="tb_birthday" runat="server"></asp:TextBox>
                        <br />
                        <br />
                        <asp:Calendar ID="Calendar1" runat="server" SelectionMode="DayWeekMonth"></asp:Calendar>
                    </div>
                </div>
                -->

                <div class="form-group">
                    <div class="col-lg-offset-4">
                        <asp:ValidationSummary ValidationGroup="UpdateUser" ID="validate_user" runat="server" CssClass="text-danger" />
                    </div>
                </div>

                <div class="form-group">
                    <div class="col-lg-4 col-lg-offset-9">
                        <asp:Button ID="btn_clear_user" CssClass="btn btn-default" runat="server" Text="Clear" />
                        <asp:Button ID="btn_update_user" CssClass="btn btn-primary" runat="server" Text="Update" ValidationGroup="UpdateUser" OnClick="btn_update_user_Click" />
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
                        <asp:TextBox ID="tb_currentpw" runat="server" TextMode="Password"></asp:TextBox>
                    </div>
                    <div class="col-lg-1">
                        <asp:RequiredFieldValidator ValidationGroup="UpdatePassword" ID="rfv_CurrentPassword" runat="server" ErrorMessage="Current password required" ControlToValidate="tb_currentpw" CssClass="text-danger">*</asp:RequiredFieldValidator>
                    </div>
                </div>

                <br />

                <div class="form-group">
                    <asp:Label ID="lbl_newpw" CssClass="col-lg-4 control-label" runat="server" Text="New Password: "></asp:Label>
                    <div class="col-lg-4">
                        <asp:TextBox ID="tb_newpw" runat="server" TextMode="Password"></asp:TextBox>
                    </div>
                    <div class="col-lg-1">
                        <asp:RequiredFieldValidator ValidationGroup="UpdatePassword" ID="rfv_NewPassword" runat="server" ErrorMessage="New password required" ControlToValidate="tb_newpw" CssClass="text-danger" pattern=".{8,50}" placeholder="Please enter at least 8 charaters long.">*</asp:RequiredFieldValidator>
                    </div>
                </div>

                <br />

                <div class="form-group">
                    <asp:Label ID="lbl_confirmpw" CssClass="col-lg-4 control-label" runat="server" Text="Re-Enter New Password: "></asp:Label>
                    <div class="col-lg-4">
                        <asp:TextBox ID="tb_confirmpw" runat="server" TextMode="Password"></asp:TextBox>
                    </div>
                    <div class="col-lg-1">
                        <asp:RequiredFieldValidator ValidationGroup="UpdatePassword" ID="rfv_ConfirmPassword" runat="server" ErrorMessage="Please re-enter new password" ControlToValidate="tb_confirmpw" CssClass="text-danger" pattern=".{8,50}">*</asp:RequiredFieldValidator>
                    </div>
                </div>

                <br />

                <div class="form-group">
                    <div class="col-lg-offset-4">
                        <asp:ValidationSummary ValidationGroup="UpdatePassword" ID="vs_all" runat="server" CssClass="text-danger" />
                    </div>
                </div>

                <div class="form-group">
                    <div class="col-lg-4 col-lg-offset-9">
                        <asp:Button ID="btn_clear_pw" CssClass="btn btn-default" runat="server" Text="Clear" />
                        <asp:Button ID="btn_update_pw" CssClass="btn btn-primary" runat="server" Text="Update" ValidationGroup="UpdatePassword" OnClick="btn_update_pw_Click" />
                    </div>
                </div>

            </fieldset>
        </div>
    </div>
</asp:Content>
