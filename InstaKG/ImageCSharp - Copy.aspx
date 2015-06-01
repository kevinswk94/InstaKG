<%@ Page Language="C#" AutoEventWireup="true"  CodeFile="ImageCSharp.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        
          
    <div class="container">

        <asp:DataList ID="DataList1" runat="server"
            RepeatColumns="3" RepeatDirection="Horizontal">
            <ItemTemplate>
                <table>
                    <tr>
                        <td valign="middle" align="center" style="background-color: #cccccc; border: 1px solid gray; width: 150px; height: 150px;"><%#DataBinder.Eval(Container.DataItem, "images") %></td>
                    </tr>
                </table>
            </ItemTemplate>
        </asp:DataList>
    </div>



    </div>
    </form>
</body>
</html>
