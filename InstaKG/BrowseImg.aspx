<%@ Page Title="" Language="C#" MasterPageFile="~/InstaKG.Master" AutoEventWireup="true" CodeBehind="BrowseImg.aspx.cs" Inherits="InstaKG.BrowseImg" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <asp:ListView ID="ListView1" runat="server" DataKeyNames="imageID" DataSourceID="AllImageSource" GroupItemCount="3">
        <EditItemTemplate>
            <td runat="server" style="">imageTitle:
                <asp:TextBox ID="imageTitleTextBox" runat="server" Text='<%# Bind("imageTitle") %>' />
                <br />imageData:
                <asp:TextBox ID="imageDataTextBox" runat="server" Text='<%# Bind("imageData") %>' />
                <br />uploadDateTime:
                <asp:TextBox ID="uploadDateTimeTextBox" runat="server" Text='<%# Bind("uploadDateTime") %>' />
                <br />accountID:
                <asp:TextBox ID="accountIDTextBox" runat="server" Text='<%# Bind("accountID") %>' />
                <br />imageID:
                <asp:Label ID="imageIDLabel1" runat="server" Text='<%# Eval("imageID") %>' />
                <br />
                <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Update" />
                <br />
                <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" />
                <br /></td>
        </EditItemTemplate>
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
                <a href="<%#"/CommentViewer.aspx?imageID=" + Eval("imageID") %>"><asp:Image ID="img_Photo" CssClass="img-responsive" style="max-width:250px; margin-left:20%"  runat="server" ImageUrl='<%#"ImageViewerHandler.ashx?id=" + Eval("imageID")%>' /></a>
                                               
                <asp:Label ID="imageTitleLabel" runat="server" Text='<%# Eval("imageTitle") %>' style="margin-left:20%;"/>

                <div style="float:right; margin-right:15%;"> 
                    <asp:Label ID="uploadDateTimeLabel" runat="server" Text='<%# dateDifference(Eval("uploadDateTime")) %>' /> days ago
                </div>                
                <br />
                <br />
                <asp:Label ID="accountIDLabel" runat="server" Text='<%# getUsernameByAccountID(Eval("accountID").ToString()) %>' style="float:right;margin-right:15%;" />
                <br />
            </td>
        </ItemTemplate>
        <LayoutTemplate>
            <table runat="server" style="width:100%;">
                <tr runat="server" >
                    <td runat="server" >
                        <table id="groupPlaceholderContainer" runat="server" border="0" style=" width:100%;">
                            <tr id="groupPlaceholder" runat="server">
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr runat="server">
                    <td runat="server" style="text-align:center">
                        <asp:DataPager ID="DataPager1" runat="server" PageSize="9">
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
            <td runat="server" style="">imageTitle:
                <asp:Label ID="imageTitleLabel" runat="server" Text='<%# Eval("imageTitle") %>' />
                <br />imageData:
                <asp:Label ID="imageDataLabel" runat="server" Text='<%# Eval("imageData") %>' />
                <br />uploadDateTime:
                <asp:Label ID="uploadDateTimeLabel" runat="server" Text='<%# Eval("uploadDateTime") %>' />
                <br />accountID:
                <asp:Label ID="accountIDLabel" runat="server" Text='<%# Eval("accountID") %>' />
                <br />imageID:
                <asp:Label ID="imageIDLabel" runat="server" Text='<%# Eval("imageID") %>' />
                <br /></td>
        </SelectedItemTemplate>
    </asp:ListView>
    <asp:SqlDataSource ID="AllImageSource" runat="server" ConnectionString="<%$ ConnectionStrings:InstaKG %>" SelectCommand="SELECT [imageTitle], [imageData], [uploadDateTime], [accountID], [imageID] FROM [Image]"></asp:SqlDataSource>
    </div>
</asp:Content>
