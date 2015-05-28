<%@ Page Title="" Language="C#" MasterPageFile="~/InstaKG.Master" AutoEventWireup="true" CodeBehind="UploadImg.aspx.cs" Inherits="InstaKG.UploadImg" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script type="text/javascript">
        function readURL(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();

                reader.onload = function (e) {
                    $('#file').attr('src', e.target.result);
                }

                reader.readAsDataURL(input.files[0]);
            }
        }

        $("#img").change(function () {
            readURL(this);
        });
        </script>
    <div class="upload">
    Image Title:
    <asp:TextBox ID="tb_ImageTitle" runat="server"></asp:TextBox>
    <br />
    <br />
    Image Description:
    <asp:TextBox ID="tb_ImageDescription" runat="server" TextMode="MultiLine"></asp:TextBox>
    <br />
    <br />
    <img id="file" src="#" Height="20%" Width="20%"/>
        <asp:FileUpload ID="FileUpload1" runat="server" onchange="readURL(this)" />
    <br />
    <asp:Button ID="btn_Upload" runat="server" OnClick="btn_Submit_Click" Text="Upload" />
    <asp:Label ID="lb_EndInfo" runat="server" ForeColor="Red"></asp:Label>
</div>
</asp:Content>
