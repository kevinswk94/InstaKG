<%@ Page Title="" Language="C#" MasterPageFile="~/InstaKG.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="InstaKG.Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <!--
        Author: Erics Giovano
        Admin: 130650H
        -->

    <style>

        img {
            height: 400px;

        }

    </style>



</asp:Content>



<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="row">
        <div class="col-xs-12 col-md-4">
            <p>Poster</p>
        </div>

        <div class="col-xs-12 col-md-8">
            <img src="DummyData/Img/cS-1.jpg" class="img-responsive"/>
        </div>

        <div class="col-md-6">
             <div class="col-md-6">
            <table>
                <tr>
                    <td>Name: </td>
                    <td>
                        <asp:TextBox ID="txtName" runat="server" /></td>
                </tr>
                <tr>
                    <td>Subject: </td>
                    <td>
                        <asp:TextBox ID="txtSubject" runat="server" /></td>
                </tr>
                <tr>
                    <td >Comments:</td>
                    <td>
                        <asp:TextBox ID="txtComment" runat="server" Rows="5" Columns="20"
                            TextMode="MultiLine" Width="391px" /></td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" /></td>
                </tr>
            </table>
        </div>

            <div class="col-md-6">
            <asp:Repeater ID="RepDetails" runat="server">
                <HeaderTemplate>
                    <table style="border: 1px solid #df5015; width: 500px" cellpadding="0">
                        <tr style="background-color: #df5015; color: White">
                            <td colspan="2">
                                <b>Comment section</b>
                            </td>
                        </tr>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                        <td>
                            <asp:Label ID="lblComment" runat="server" Text='<%#Eval("commentaryContent") %>' />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table style="background-color: #808080; border-top: 1px dotted #df5015; border-bottom: 1px solid #df5015; width: 500px">
                                <tr>
                                    <td>Post By:
                                        <asp:Label ID="lblUser" runat="server" Font-Bold="true" Text='<%#Eval("commentaryAuthor") %>' /></td>
                                    <td>Created Date:<asp:Label ID="lblDate" runat="server" Font-Bold="true" Text='<%#Eval("commentaryDateTime") %>' /></td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">&nbsp;</td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                    </table>
                </FooterTemplate>
            </asp:Repeater>

        </div>

    </div>
    </div>


</asp:Content>
