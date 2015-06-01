<%@ Page Title="" Language="C#" MasterPageFile="~/InstaKG.Master" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="InstaKG.WebForm1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>



<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


     <div>
        <asp:DataList ID="DataList1" runat="server" 
            RepeatColumns="3" RepeatDirection="Horizontal">
            <ItemTemplate>
                <table>
                    <tr>
                        <td valign="middle" align="center" style="background-color:#cccccc;border:1px solid gray;width:150px;height:150px;"><%#DataBinder.Eval(Container.DataItem, "images") %></td>
                    </tr>
                </table>
                
            </ItemTemplate>
        </asp:DataList>
    </div>



</asp:Content>
