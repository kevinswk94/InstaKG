<%@ Page Title="" Language="C#" MasterPageFile="~/InstaKG.Master" AutoEventWireup="true" CodeBehind="Search.aspx.cs" Inherits="InstaKG.Search" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        function SetEnd(TB) {
            if (TB.createTextRange) {
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
                            <br />
                            <asp:Label ID="ImageValue" runat="server" ForeColor="#FF6600"></asp:Label>
                            <asp:Label ID="ImageResult" runat="server" Text="Image Results" Visible="false"></asp:Label>  &nbsp &nbsp
                            <asp:Label ID="UserValue" runat="server" ForeColor="#FF6600" ></asp:Label>
                            <asp:Label ID="UserResult" runat="server" Text="User Results" Visible="false"></asp:Label>                            
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
                                                            <%-- DataSourceID="ImageResultSource" --%>
                                                            <AlternatingItemTemplate>
                                                                <td runat="server" class="danger" style="">
                                                                    <asp:Label ID="ImageTitleLabel" runat="server" Text='<%# Eval("ImageTitle") %>' CssClass="lbl_title" />
                                                                    <div class="lbl_author">
                                                                        <asp:Label ID="AuthourLabel" runat="server" Text='<%# getUsernameByAccountID(getAccountIDByImageID(Eval("ImageID"))) %>'></asp:Label>
                                                                    </div>
                                                                    <br />
                                                                    <asp:Label ID="DescriptionLabel" runat="server" Text='<%# Eval("Description") %>' CssClass="lbl_desc" />
                                                                    <br />
                                                                    <div style="text-align: right">
                                                                        <asp:Label ID="CreationLabel" runat="server" Text='<%# dateDifference(Eval("Creation")) %>' />
                                                                        days ago
                                                                    </div>

                                                                </td>
                                                                <td class="danger" style="text-align: center">
                                                                    <asp:Image ID="Image" runat="server" class="thumbnail img-responsive imageFormat" ImageUrl='<%#"ImageViewerHandler.ashx?id=" + Eval("imageID")%>' Style="max-height: 100px;" />
                                                                    <asp:LinkButton ID="LinkButton1" runat="server" CssClass="lb_fontSize" CommandArgument='<%# Eval("ImageID") %>' OnClick="LinkButton1_Click">View User Profile</asp:LinkButton>
                                                                </td>
                                                            </AlternatingItemTemplate>
                                                            <EditItemTemplate>
                                                                <td runat="server" style="background-color: #FFCC66; color: #000080;">ImageList:
                                                                   
                                                                    <asp:TextBox ID="ImageListTextBox" runat="server" Text='<%# Bind("ImageList") %>' />
                                                                    <br />
                                                                    TitleList:
                                                                   
                                                                    <asp:TextBox ID="TitleListTextBox" runat="server" Text='<%# Bind("TitleList") %>' />
                                                                    <br />
                                                                    ImageID:
                                                                   
                                                                    <asp:TextBox ID="ImageIDTextBox" runat="server" Text='<%# Bind("ImageID") %>' />
                                                                    <br />
                                                                    ImageTitle:
                                                                   
                                                                    <asp:TextBox ID="ImageTitleTextBox" runat="server" Text='<%# Bind("ImageTitle") %>' />
                                                                    <br />
                                                                    Description:
                                                                   
                                                                    <asp:TextBox ID="DescriptionTextBox" runat="server" Text='<%# Bind("Description") %>' />
                                                                    <br />
                                                                    Content:
                                                                   
                                                                    <asp:TextBox ID="ContentTextBox" runat="server" Text='<%# Bind("Content") %>' />
                                                                    <br />
                                                                    ImageType:
                                                                   
                                                                    <asp:TextBox ID="ImageTypeTextBox" runat="server" Text='<%# Bind("ImageType") %>' />
                                                                    <br />
                                                                    Creation:
                                                                   
                                                                    <asp:TextBox ID="CreationTextBox" runat="server" Text='<%# Bind("Creation") %>' />
                                                                    <br />
                                                                    <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Update" />
                                                                    <br />
                                                                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" />
                                                                    <br />
                                                                </td>
                                                            </EditItemTemplate>
                                                            <EmptyDataTemplate>
                                                                <table runat="server" style="border-collapse: collapse; border-style: none; border-width: 1px;">
                                                                    <tr>
                                                                        <td>No result found.</td>
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
                                                            <InsertItemTemplate>
                                                                <td runat="server" style="">ImageList:
                                                                   
                                                                    <asp:TextBox ID="ImageListTextBox" runat="server" Text='<%# Bind("ImageList") %>' />
                                                                    <br />
                                                                    TitleList:
                                                                   
                                                                    <asp:TextBox ID="TitleListTextBox" runat="server" Text='<%# Bind("TitleList") %>' />
                                                                    <br />
                                                                    ImageID:
                                                                   
                                                                    <asp:TextBox ID="ImageIDTextBox" runat="server" Text='<%# Bind("ImageID") %>' />
                                                                    <br />
                                                                    ImageTitle:
                                                                   
                                                                    <asp:TextBox ID="ImageTitleTextBox" runat="server" Text='<%# Bind("ImageTitle") %>' />
                                                                    <br />
                                                                    Description:
                                                                   
                                                                    <asp:TextBox ID="DescriptionTextBox" runat="server" Text='<%# Bind("Description") %>' />
                                                                    <br />
                                                                    Content:
                                                                   
                                                                    <asp:TextBox ID="ContentTextBox" runat="server" Text='<%# Bind("Content") %>' />
                                                                    <br />
                                                                    ImageType:
                                                                   
                                                                    <asp:TextBox ID="ImageTypeTextBox" runat="server" Text='<%# Bind("ImageType") %>' />
                                                                    <br />
                                                                    Creation:
                                                                   
                                                                    <asp:TextBox ID="CreationTextBox" runat="server" Text='<%# Bind("Creation") %>' />
                                                                    <br />
                                                                    <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Insert" />
                                                                    <br />
                                                                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Clear" />
                                                                    <br />
                                                                </td>
                                                            </InsertItemTemplate>
                                                            <ItemTemplate>
                                                                <td runat="server" style="width: 65%;" class="active">
                                                                    <asp:Label ID="ImageTitleLabel" runat="server" Text='<%# Eval("ImageTitle") %>' CssClass="lbl_title" />
                                                                    <div class="lbl_author">
                                                                        <asp:Label ID="AuthourLabel" runat="server" Text='<%# getUsernameByAccountID(getAccountIDByImageID(Eval("ImageID"))) %>'></asp:Label>
                                                                    </div>
                                                                    <br />
                                                                    <asp:Label ID="DescriptionLabel" runat="server" Text='<%# Eval("Description") %>' CssClass="lbl_desc" />
                                                                    <br />
                                                                    <div style="text-align: right">
                                                                        <asp:Label ID="CreationLabel" runat="server" Text='<%# dateDifference(Eval("Creation")) %>' />
                                                                        days ago
                                                                    </div>
                                                                </td>
                                                                <td class="active" style="text-align: center">
                                                                    <asp:Image ID="Image" runat="server" class="thumbnail img-responsive imageFormat" ImageUrl='<%#"ImageViewerHandler.ashx?id=" + Eval("imageID")%>' Style="max-height: 100px;" />
                                                                    <asp:LinkButton ID="LinkButton1" runat="server" CssClass="lb_fontSize" CommandArgument='<%# Eval("ImageID") %>' OnClick="LinkButton1_Click">View User Profile</asp:LinkButton>
                                                                </td>
                                                            </ItemTemplate>
                                                            <LayoutTemplate>
                                                                <table runat="server" style="width: 100%;">
                                                                    <tr runat="server">
                                                                        <td runat="server">
                                                                            <table id="groupPlaceholderContainer" runat="server" class="table table-striped table-hover">
                                                                                <tr id="groupPlaceholder" runat="server">
                                                                                </tr>
                                                                            </table>
                                                                        </td>
                                                                    </tr>
                                                                    <tr runat="server">
                                                                        <td runat="server" style="text-align: center;">
                                                                            <asp:DataPager ID="DataPager1" runat="server" PageSize="10">
                                                                                <Fields>
                                                                                    <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" />
                                                                                    <asp:NumericPagerField />
                                                                                    <asp:NextPreviousPagerField ButtonType="Button" ShowLastPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" />
                                                                                </Fields>
                                                                            </asp:DataPager>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </LayoutTemplate>
                                                            <SelectedItemTemplate>
                                                                <td runat="server" style="background-color: #FFCC66; font-weight: bold; color: #000080;">ImageList:
                                                                   
                                                                    <asp:Label ID="ImageListLabel" runat="server" Text='<%# Eval("ImageList") %>' />
                                                                    <br />
                                                                    TitleList:
                                                                   
                                                                    <asp:Label ID="TitleListLabel" runat="server" Text='<%# Eval("TitleList") %>' />
                                                                    <br />
                                                                    ImageID:
                                                                   
                                                                    <asp:Label ID="ImageIDLabel" runat="server" Text='<%# Eval("ImageID") %>' />
                                                                    <br />
                                                                    ImageTitle:
                                                                   
                                                                    <asp:Label ID="ImageTitleLabel" runat="server" Text='<%# Eval("ImageTitle") %>' />
                                                                    <br />
                                                                    Description:
                                                                   
                                                                    <asp:Label ID="DescriptionLabel" runat="server" Text='<%# Eval("Description") %>' />
                                                                    <br />
                                                                    Content:
                                                                   
                                                                    <asp:Label ID="ContentLabel" runat="server" Text='<%# Eval("Content") %>' />
                                                                    <br />
                                                                    ImageType:
                                                                   
                                                                    <asp:Label ID="ImageTypeLabel" runat="server" Text='<%# Eval("ImageType") %>' />
                                                                    <br />
                                                                    Creation:
                                                                   
                                                                    <asp:Label ID="CreationLabel" runat="server" Text='<%# Eval("Creation") %>' />
                                                                    <br />
                                                                </td>
                                                            </SelectedItemTemplate>
                                                        </asp:ListView>

                                                        <!-- <asp:ObjectDataSource ID="ImageResultSource" runat="server" SelectMethod="retrieveImageList" TypeName="InstaKG.Entity.DOA"></asp:ObjectDataSource>-->
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:View>

                                        <asp:View ID="View2" runat="server">
                                            <table class="viewTable">
                                                <tr>
                                                    <td>
                                                        <asp:ListView ID="lv_UserResult" runat="server" GroupItemCount="1">
                                                            <%-- DataSourceID="UserResultSource"  --%>
                                                            <AlternatingItemTemplate>
                                                                <td runat="server" class="danger">
                                                                    <div class="lbl_title">
                                                                        Username: 
                                                                    </div>
                                                                    <asp:Label ID="UsernameLabel" runat="server" Text='<%# Eval("Username") %>' />
                                                                </td>
                                                                <td style="text-align: center" class="danger">
                                                                    <%--<asp:Button ID="Button2" runat="server" Text="Add as Friend" CssClass="btn btn-default" />--%>
                                                                    <asp:HyperLink ID="Button4" runat="server" Text="View Profile" CssClass="btn btn-default" NavigateUrl='<%# Eval("Username", "ViewProfile" + ".aspx?name={0}") %>' />
                                                                </td>
                                                            </AlternatingItemTemplate>
                                                            <EditItemTemplate>
                                                                <td runat="server" style="background-color: #FFCC66; color: #000080;">UsernameList:
                                                                   
                                                                    <asp:TextBox ID="UsernameListTextBox" runat="server" Text='<%# Bind("UsernameList") %>' />
                                                                    <br />
                                                                    UserList:
                                                                   
                                                                    <asp:TextBox ID="UserListTextBox" runat="server" Text='<%# Bind("UserList") %>' />
                                                                    <br />
                                                                    AccountID:
                                                                   
                                                                    <asp:TextBox ID="AccountIDTextBox" runat="server" Text='<%# Bind("AccountID") %>' />
                                                                    <br />
                                                                    Username:
                                                                   
                                                                    <asp:TextBox ID="UsernameTextBox" runat="server" Text='<%# Bind("Username") %>' />
                                                                    <br />
                                                                    <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Update" />
                                                                    <br />
                                                                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" />
                                                                    <br />
                                                                </td>
                                                            </EditItemTemplate>
                                                            <EmptyDataTemplate>
                                                                <table runat="server" style="border-collapse: collapse;border-style: none; border-width: 1px;">
                                                                    <tr>
                                                                        <td>No result found.</td>
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
                                                            <InsertItemTemplate>
                                                                <td runat="server" style="">UsernameList:
                                                                   
                                                                    <asp:TextBox ID="UsernameListTextBox" runat="server" Text='<%# Bind("UsernameList") %>' />
                                                                    <br />
                                                                    UserList:
                                                                   
                                                                    <asp:TextBox ID="UserListTextBox" runat="server" Text='<%# Bind("UserList") %>' />
                                                                    <br />
                                                                    AccountID:
                                                                   
                                                                    <asp:TextBox ID="AccountIDTextBox" runat="server" Text='<%# Bind("AccountID") %>' />
                                                                    <br />
                                                                    Username:
                                                                   
                                                                    <asp:TextBox ID="UsernameTextBox" runat="server" Text='<%# Bind("Username") %>' />
                                                                    <br />
                                                                    <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Insert" />
                                                                    <br />
                                                                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Clear" />
                                                                    <br />
                                                                </td>
                                                            </InsertItemTemplate>
                                                            <ItemTemplate>
                                                                <td runat="server" style="width: 65%;" class="active">
                                                                    <div class="lbl_title">
                                                                        Username: 
                                                                    </div>
                                                                    <asp:Label ID="UsernameLabel" runat="server" Text='<%# Eval("Username") %>' />
                                                                </td>
                                                                <td runat="server" style="text-align: center" class="active">
                                                                    <%--<asp:Button ID="Button2" runat="server" Text="Add as Friend" CssClass="btn btn-warning" />--%>
                                                                    <asp:HyperLink ID="Button4" runat="server" Text="View Profile" CssClass="btn btn-warning" NavigateUrl='<%# Eval("Username", "ViewProfile" + ".aspx?name={0}") %>' />
                                                                </td>
                                                            </ItemTemplate>
                                                            <LayoutTemplate>
                                                                <table runat="server" style="width: 100%;">
                                                                    <tr runat="server">
                                                                        <td runat="server">
                                                                            <table id="groupPlaceholderContainer" runat="server" style="width: 100%;" class="table table-striped table-hover">
                                                                                <tr id="groupPlaceholder" runat="server">
                                                                                </tr>
                                                                            </table>
                                                                        </td>
                                                                    </tr>
                                                                    <tr runat="server">
                                                                        <td runat="server" style="text-align: center;">
                                                                            <asp:DataPager ID="DataPager1" runat="server" PageSize="10">
                                                                                <Fields>
                                                                                    <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" />
                                                                                    <asp:NumericPagerField />
                                                                                    <asp:NextPreviousPagerField ButtonType="Button" ShowLastPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" />
                                                                                </Fields>
                                                                            </asp:DataPager>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </LayoutTemplate>
                                                            <SelectedItemTemplate>
                                                                <td runat="server" style="background-color: #FFCC66; font-weight: bold; color: #000080;">UsernameList:
                                                                   
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

                                                        <!-- <asp:ObjectDataSource ID="UserResultSource" runat="server" SelectMethod="retrieveUserList" TypeName="InstaKG.Entity.DOA"></asp:ObjectDataSource>-->
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
