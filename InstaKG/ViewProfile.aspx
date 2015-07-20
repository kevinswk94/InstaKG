<%@ Page Title="" Language="C#" MasterPageFile="~/InstaKG.Master" AutoEventWireup="true" CodeBehind="ViewProfile.aspx.cs" Inherits="InstaKG.ViewProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%--Light Gallery Animation--%>
    <link href="Styles/lightGallery.css" rel="stylesheet" />
    <script src="Scripts/lightGallery.js"></script>

    <%-- WOW Animation--%>
    <link href="Styles/animate.css" rel="stylesheet" />
    <script src="Scripts/wow.min.js"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            $("#lightGallery").lightGallery();
        });
    </script>

    <style>
        /*Gallery*/
        ul {
            list-style: none outside none;
        }

        .gallery li {
            display: block;
            float: left;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="alert_placeholder" runat="server" visible="false">
        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
        <asp:Literal runat="server" ID="alertText" />
    </div>
    <div class="container">
        <div class="well">
            <fieldset>
                <legend><%= queryUsername() %>'s Profile</legend>
            </fieldset>

            <div class="form-group">
                <asp:Label ID="lbl_email" CssClass="col-lg-4 control-label" runat="server" Text="Email: "></asp:Label>
                <div class="col-lg-4">
                    <asp:Label ID="lbl_email_value" runat="server"></asp:Label>
                </div>
            </div>

            <br />
            <br />

            <div class="form-group">
                <asp:Label ID="lbl_fname" CssClass="col-lg-4 control-label" runat="server" Text="First Name: "></asp:Label>
                <div class="col-lg-4">
                    <asp:Label ID="lbl_fname_value" runat="server"></asp:Label>
                </div>
            </div>

            <br />

            <div class="form-group">
                <asp:Label ID="lbl_lname" CssClass="col-lg-4 control-label" runat="server" Text="Last Name: "></asp:Label>
                <div class=" col-lg-4">
                    <asp:Label ID="lbl_lname_value" runat="server"></asp:Label>
                </div>
            </div>

            <br />
            <br />

            <div class="form-group">
                <asp:Label ID="lbl_gender" CssClass="col-lg-4 control-label" runat="server" Text="Gender: "></asp:Label>
                <div class=" col-lg-4">
                    <asp:Label ID="lbl_gender_value" runat="server"></asp:Label>
                </div>
            </div>

            <br />
            <!--
            <div class="form-group">
                <asp:Label ID="lbl_birthday" CssClass="col-lg-4 control-label" runat="server" Text="Birthday: "></asp:Label>
                <div class=" col-lg-4">
                    <asp:Label ID="lbl_birthday_value" runat="server"></asp:Label>
                </div>
            </div>
            -->

            <br />
        </div>

        <div class="well">
            <fieldset>
                <legend>Images</legend>

                <asp:Repeater ID="Repeater1" runat="server">
                    <HeaderTemplate>
                        <ul id="lightGallery" class="gallery">
                    </HeaderTemplate>
                    <ItemTemplate>
                        <li class="col-lg-3 col-md-4 col-xs-6 animated fadeInUp" data-src='<%#"ImageViewerHandler.ashx?id=" + Eval("imageID")%>'>
                            <asp:Image ID="Image" runat="server" class="thumbnail img-responsive" ImageUrl='<%#"ImageViewerHandler.ashx?id=" + Eval("imageID")%>' style="max-height:100px;" />
                        </li>
                    </ItemTemplate>
                    <FooterTemplate>
                        </ul>
                    </FooterTemplate>
                </asp:Repeater>

                <div style="float:right;clear:left;width:300px;font-size:18px;text-align:right;margin-right:30px;" class="warning">
                    <asp:LinkButton ID="lb_gallery" runat="server" OnClick="lb_gallery_Click" Text="View more..."></asp:LinkButton>
                </div>

            </fieldset>
        </div>
    </div>

</asp:Content>
