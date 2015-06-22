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

    <!-- Alert placeholder, alter attributes in CodeBehind -->
        <div id="alert_placeholder" runat="server" visible="false">
            <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
            <asp:Literal runat="server" ID="alertText" />
        </div>

    <div class="container">
        <div class="well">
            <fieldset class="form-horizontal">
                <div class="row">
                    <legend class="col-lg-offset-2 col-lg-3">Upload a new image:</legend>
                </div>

                <div class="form-group">
                    <asp:Label ID="lbl_ImageTitle" CssClass="col-lg-3 control-label" runat="server">Image Title:</asp:Label>
                    <div class="col-lg-6">
                        <asp:TextBox ID="tb_ImageTitle" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="col-lg-1">
                        <asp:RequiredFieldValidator ID="rfv_ImageTitle" runat="server" ErrorMessage="Title required" ControlToValidate="tb_ImageTitle" ForeColor="Red">*</asp:RequiredFieldValidator>
                    </div>
                </div>

                <div class="form-group">
                    <asp:Label ID="lbl_ImageDescription" CssClass="col-lg-3 control-label" runat="server">Image Description:</asp:Label>
                    <div class="col-lg-6">
                        <asp:TextBox ID="tb_ImageDescription" runat="server" TextMode="MultiLine" CssClass="form-control"></asp:TextBox>
                    </div>
                </div>

                <div class="form-group">
                    <asp:Label ID="lblImageUpload" CssClass="col-lg-3 control-label" runat="server">Upload File:</asp:Label>
                    <div class="col-lg-6">
                        <asp:FileUpload ID="FileUpload1" runat="server" onchange="readURL(this)" />
                    </div>
                </div>

                <div class="form-group">
                    <asp:Label ID="lbl_imagePreview" CssClass="col-lg-3 control-label" runat="server"></asp:Label>
                    <div class="col-lg-6">
                        <img id="file" src="#" class="img-responsive" />
                        <asp:Label ID="lb_EndInfo" runat="server" ForeColor="Red"></asp:Label>
                    </div>
                </div>

                <div class="form-group">
                    <div class="col-lg-4 col-lg-offset-7">
                        <asp:Button ID="btn_cancel" CssClass="btn btn-default" Text="Cancel" runat="server" OnClick="btn_cancel_Click" CausesValidation="false" />
                        <asp:Button ID="btn_Upload" runat="server" OnClick="btn_Submit_Click" Text="Upload" CssClass="btn btn-primary" />
                    </div>
                </div>

            </fieldset>
        </div>
        
    </div>

    <%--<div class="upload">
        Image Title:
    <asp:TextBox ID="tb_ImageTitle" runat="server"></asp:TextBox>
        <br />
        <br />
        Image Description:
    <asp:TextBox ID="tb_ImageDescription" runat="server" TextMode="MultiLine"></asp:TextBox>
        <br />
        <br />
        <img id="file" src="#" height="20%" width="20%" />
        <asp:FileUpload ID="FileUpload1" runat="server" onchange="readURL(this)" />
        <br />
        <asp:Button ID="btn_Upload" runat="server" OnClick="btn_Submit_Click" Text="Upload" />
        <asp:Label ID="lb_EndInfo" runat="server" ForeColor="Red"></asp:Label>
    </div>--%>
</asp:Content>
