<%@ Page Title="" Language="C#" MasterPageFile="~/InstaKG.Master" AutoEventWireup="true" CodeBehind="Search.aspx.cs" Inherits="InstaKG.Search" EnableEventValidation="false" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        function SetEnd(TB)
        {
            if (TB.createTextRange)
            {
                var FieldRange = TB.createTextRange();
                FieldRange.moveStart('character', TB.value.length);
                FieldRange.collapse();
                FieldRange.select();
            }
        }
    </script>


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
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    
    <div class="container">
        <div id="alert_placeholder" runat="server" visible="false">
            <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
            <asp:Literal runat="server" ID="alertText" />
        </div>

        <div class="well">
            <fieldset class="form-horizontal">
                <legend>Search</legend>

                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>

                        <div id="search_design">
                            <!-- <asp:Label ID="lb_searchWord" runat="server" Text="Search: " />-->
                            <asp:TextBox ID="tb_searchWord" runat="server" AutoPostBack="true" OnTextChanged="tb_searchWord_TextChanged" Width="300px"></asp:TextBox>
                        </div>

                        
                        <br />
                        <br />

                        <table style="width: 98%">
                            <tr>
                                <td>
                                    <asp:Button Text="Images" BorderStyle="None" ID="Tab1" CssClass="initial" runat="server" OnClick="tab1_click" />
                                    <asp:Button Text="Users" BorderStyle="None" ID="Tab2" CssClass="initial" runat="server" OnClick="tab2_click" />

                                    <asp:MultiView ID="MainView" runat="server">
                                        <asp:View ID="View1" runat="server">
                                            <table class="viewTable">
                                                <tr>
                                                    <td>
                                                        <asp:ListView ID="lv_ImageResult" runat="server" GroupItemCount="1">
                                                            <AlternatingItemTemplate>
                                                                <td runat="server" class="danger" style="width:65%;">
                                                                    <asp:Label ID="ImageTitleLabel" runat="server" Text='<%# Eval("ImageTitle") %>' CssClass="lbl_title" />
                                                                    <br />
                                                                    <asp:Label ID="DescriptionLabel" runat="server" Text='<%# Eval("Description") %>' CssClass="lbl_desc" />
                                                                    <br />
                                                                    <div class="lbl_creator">By:
                                                                    <asp:Label ID="AuthorLabel" runat="server" Text='<%# getUsernameByAccountID(getAccountIDByImageID(Eval("ImageID"))) %>'></asp:Label>
                                                                    </div>
                                                                </td>
                                                                    
                                                                <td runat="server" class="danger" style="text-align:center">
                                                                    <asp:Image ID="Image" runat="server" class="thumbnail img-responsive" ImageUrl='<%#"ImageViewerHandler.ashx?id=" + Eval("imageID")%>' style="max-height:100px;" />
                                                                    <asp:LinkButton ID="LinkButton1" runat="server" CssClass="lb_fontSize" CommandArgument='<%# Eval("ImageID") %>' OnClick="LinkButton1_Click">View User Profile</asp:LinkButton>                                                                  
                                                                </td>
                                                            </AlternatingItemTemplate>
                                                            <EmptyDataTemplate>
                                                                <table runat="server" style="">
                                                                    <tr>
                                                                        <td>No data was returned.</td>
                                                                    </tr>
                                                                </table>
                                                            </EmptyDataTemplate>
                                                            <EmptyItemTemplate>
                                                                <td runat="server" />
                                                            </EmptyItemTemplate>
                                                            <GroupTemplate>
                                                                <tr id="itemPlaceholderContainer" runat="server">
                                                                    <td id="itemPlaceholder" runat="server"></td>
                                                                </tr>
                                                            </GroupTemplate>
                                                            <ItemTemplate>
                                                                <td runat="server" style="width:65%;" class="active">                                                                    
                                                                    <asp:Label ID="ImageTitleLabel" runat="server" Text='<%# Eval("ImageTitle") %>' CssClass="lbl_title" />
                                                                    <br />
                                                                    <asp:Label ID="DescriptionLabel" runat="server" Text='<%# Eval("Description") %>' CssClass="lbl_desc" />
                                                                    <br />
                                                                    <div class="lbl_creator">By:
                                                                    <asp:Label ID="AuthorLabel" runat="server" Text='<%# getUsernameByAccountID(getAccountIDByImageID(Eval("ImageID"))) %>'></asp:Label>
                                                                    </div>
                                                                    <%--
                                                                    <b>Creation:</b>
                                                                    <asp:Label ID="CreationLabel" runat="server" Text='<%# Eval("Creation") %>' />
                                                                    <br />
                                                                    --%>
                                                                </td>

                                                                <td runat="server" style="text-align:center" class="active">
                                                                    <asp:Image ID="Image" runat="server" class="thumbnail img-responsive" ImageUrl='<%#"ImageViewerHandler.ashx?id=" + Eval("imageID")%>' style="max-height:100px;" />
                                                                    <asp:LinkButton ID="LinkButton1" runat="server" CssClass="lb_fontSize" CommandArgument='<%# Eval("ImageID") %>' OnClick="LinkButton1_Click">View User Profile</asp:LinkButton>
                                                                </td>
                                                            </ItemTemplate>
                                                            <LayoutTemplate>
                                                                <table runat="server" style="width:100%;">
                                                                    <tr runat="server" style="">
                                                                        <td runat="server" style="">
                                                                            <table id="groupPlaceholderContainer" runat="server" border="0" style="" class="table table-striped table-hover">
                                                                                <tr id="groupPlaceholder" runat="server">
                                                                                </tr>
                                                                            </table>
                                                                        </td>
                                                                    </tr>
                                                                    <tr runat="server" style="text-align:center">
                                                                        <td runat="server" >
                                                                            <asp:DataPager ID="DataPager1" runat="server" PageSize="10" >
                                                                                <Fields>
                                                                                    <asp:TemplatePagerField></asp:TemplatePagerField>
                                                                                    <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowLastPageButton="True" ButtonCssClass="btn_nextPrevious"/>
                                                                                </Fields>
                                                                            </asp:DataPager>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </LayoutTemplate>
                                                            <SelectedItemTemplate>
                                                                <td runat="server" style="">
                                                                    <asp:Label ID="ImageListLabel" runat="server" Text='<%# Eval("ImageList") %>' />
                                                                    <br />
                                                                    <asp:Label ID="TitleListLabel" runat="server" Text='<%# Eval("TitleList") %>' />
                                                                    <br />
                                                                    <asp:Label ID="ImageIDLabel" runat="server" Text='<%# Eval("ImageID") %>' />
                                                                    <br />
                                                                    <asp:Label ID="ImageTitleLabel" runat="server" Text='<%# Eval("ImageTitle") %>' />
                                                                    <br />
                                                                    <asp:Label ID="DescriptionLabel" runat="server" Text='<%# Eval("Description") %>' />
                                                                    <br />
                                                                    <asp:Label ID="ContentLabel" runat="server" Text='<%# Eval("Content") %>' />
                                                                    <br />
                                                                    <asp:Label ID="ImageTypeLabel" runat="server" Text='<%# Eval("ImageType") %>' />
                                                                    <br />
                                                                    <asp:Label ID="CreationLabel" runat="server" Text='<%# Eval("Creation") %>' />
                                                                    <br />
                                                             </td>
                                                            </SelectedItemTemplate>
                                                        </asp:ListView>

                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:View>

                                        <asp:View ID="View2" runat="server">
                                            <table class="viewTable">
                                                <tr>
                                                    <td>
                                                        <asp:ListView ID="lv_UserResult" runat="server" GroupItemCount="1"> <%-- DataSourceID="src_UserList" --%>
                                                            <AlternatingItemTemplate>
                                                                <td runat="server" style="" class="danger">
                                                                    <div class="lbl_title">Username: </div>
                                                                    <asp:Label ID="UsernameLabel" runat="server" Text='<%# Eval("Username") %>' CssClass="lbl_desc"/>
                                                                </td>

                                                                <td runat="server" style="text-align:center" class="danger">
                                                                    <asp:Button ID="Button2" runat="server" Text="Add as Friend" CssClass="btn btn-default" />
                                                                    <asp:HyperLink ID="Button4" runat="server" Text="View Profile" CssClass="btn btn-default" NavigateUrl='<%# Eval("Username", "ViewProfile" + ".aspx?name={0}") %>'/>
                                                                </td>
                                                            </AlternatingItemTemplate>
                                                            <EmptyDataTemplate>
                                                                <table runat="server" style="">
                                                                    <tr>
                                                                        <td>No data was returned.</td>
                                                                    </tr>
                                                                </table>
                                                            </EmptyDataTemplate>
                                                            <EmptyItemTemplate>
                                                                <td runat="server" />
                                                            </EmptyItemTemplate>
                                                            <GroupTemplate>
                                                                <tr id="itemPlaceholderContainer" runat="server">
                                                                    <td id="itemPlaceholder" runat="server"></td>
                                                                </tr>
                                                            </GroupTemplate>
                                                            <ItemTemplate>
                                                                <td runat="server" style="width:65%;" class="active">
                                                                    <div class="lbl_title">Username: </div>
                                                                    <asp:Label ID="UsernameLabel" runat="server" Text='<%# Eval("Username") %>' CssClass="lbl_desc"/>
                                                                </td>

                                                                <td runat="server" style="text-align:center" class="active">
                                                                    <asp:Button ID="Button1" runat="server" Text="Add as friend" CssClass="btn btn-warning" />
                                                                    <asp:HyperLink ID="Button3" runat="server" Text="View Profile" CssClass="btn btn-warning" NavigateUrl='<%# Eval("Username", "ViewProfile" + ".aspx?name={0}") %>' />
                                                                </td>
                                                            </ItemTemplate>
                                                            <LayoutTemplate>
                                                                <table runat="server" style="width:100%;">
                                                                    <tr runat="server" style="">
                                                                        <td runat="server">
                                                                            <table id="groupPlaceholderContainer" runat="server" style="width:100%;" class="table table-striped table-hover">
                                                                                <tr id="groupPlaceholder" runat="server" style="" >
                                                                                </tr>
                                                                            </table>
                                                                        </td>
                                                                    </tr>
                                                                    <tr runat="server" style="text-align:center">
                                                                        <td runat="server" style="">
                                                                            <asp:DataPager ID="DataPager1" runat="server" PageSize="10">
                                                                                <Fields>
                                                                                    <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowLastPageButton="True" ButtonCssClass="btn_nextPrevious"/>
                                                                                </Fields>
                                                                            </asp:DataPager>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </LayoutTemplate>
                                                            <SelectedItemTemplate>
                                                                <td runat="server" style="">UsernameList:
                                                                    <asp:Label ID="UsernameListLabel" runat="server" Text='<%# Eval("UsernameList") %>' />
                                                                    <br />
                                                                    UserList:
                                                                    <asp:Label ID="UserListLabel" runat="server" Text='<%# Eval("UserList") %>' />
                                                                    <br />
                                                                    AccountID:
                                                                    <asp:Label ID="AccountIDLabel" runat="server" Text='<%# Eval("AccountID") %>' />
                                                                    <br />
                                                                    Username:
                                                                    <asp:Label ID="UsernameLabel" runat="server" Text='<%# Eval("Username") %>' />
                                                                    <br />
                                                                </td>
                                                            </SelectedItemTemplate>
                                                        </asp:ListView>
                                                        <%--<asp:ObjectDataSource ID="src_UserList" runat="server" SelectMethod="retrieveUserList" TypeName="InstaKG.Entity.User"></asp:ObjectDataSource>--%>
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:View>
                                    </asp:MultiView>
                                </td>
                            </tr>
                        </table>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </fieldset>
        </div>
    </div>

</asp:Content>
