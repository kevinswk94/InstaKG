<%@ Page Title="" Language="C#" MasterPageFile="~/InstaKG.Master" AutoEventWireup="true" CodeBehind="Search.aspx.cs" Inherits="InstaKG.Search" %>
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
                        <asp:Label ID="lb_searchWord" runat="server" Text="Search: " />
                        <asp:TextBox ID="tb_searchWord" runat="server" AutoPostBack="true" OnTextChanged="tb_searchWord_TextChanged"></asp:TextBox>
                
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
                                                        <asp:ListView ID="lv_ImageResult" runat="server" GroupItemCount="3">
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
                                                                <td runat="server" style="border: 1px solid grey;width:70%">
                                                                    <br />
                                                                    <b>ImageTitle:</b>
                                                                    <asp:Label ID="ImageTitleLabel" runat="server" Text='<%# Eval("ImageTitle") %>' />
                                                                    <br />
                                                                    <b>Description:</b>
                                                                    <asp:Label ID="DescriptionLabel" runat="server" Text='<%# Eval("Description") %>' />
                                                                    <br />
                                                                    <b>Creation:</b>
                                                                    <asp:Label ID="CreationLabel" runat="server" Text='<%# Eval("Creation") %>' />
                                                                    <br />
                                                                </td>

                                                                <td style="border: 1px solid grey;width:70%">
                                                                    <b>Content:</b>
                                                                    <asp:Label ID="ContentLabel" runat="server" Text='<%# Eval("Content") %>' />
                                                                </td>
                                                            </ItemTemplate>
                                                            <LayoutTemplate>
                                                                <table runat="server" style=" width: 100%">
                                                                    <tr runat="server" style="border: 1px solid white">
                                                                        <td runat="server" style="border: 1px solid yellow">
                                                                            <table id="groupPlaceholderContainer" runat="server" border="0" style="">
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
                                                                                    <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowLastPageButton="True" />
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
                                                        <asp:ListView ID="lv_UserResult" runat="server" GroupItemCount="3"> <%-- DataSourceID="src_UserList" --%>
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
                                                                <td runat="server" style="">
                                                                    Username:
                                                                    <asp:Label ID="UsernameLabel" runat="server" Text='<%# Eval("Username") %>' />
                                                                    <br />
                                                                </td>
                                                            </ItemTemplate>
                                                            <LayoutTemplate>
                                                                <table runat="server">
                                                                    <tr runat="server">
                                                                        <td runat="server">
                                                                            <table id="groupPlaceholderContainer" runat="server" border="0" style="">
                                                                                <tr id="groupPlaceholder" runat="server">
                                                                                </tr>
                                                                            </table>
                                                                        </td>
                                                                    </tr>
                                                                    <tr runat="server">
                                                                        <td runat="server" style="">
                                                                            <asp:DataPager ID="DataPager1" runat="server" PageSize="12">
                                                                                <Fields>
                                                                                    <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowLastPageButton="True" />
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
