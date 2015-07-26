﻿<%@ Page Title="" Language="C#" MasterPageFile="~/InstaKG.Master" AutoEventWireup="true" CodeBehind="Steg_Encode.aspx.cs" Inherits="InstaKG.Steg_Encode" ValidateRequest="false" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script type="text/javascript">
        function readURL(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    $('#file').attr('src', e.target.result);
                    $('#file').css({"visibility" : "visible"});
                }
                reader.readAsDataURL(input.files[0]);
            }
        }
        $("#img").change(function () {
            readURL(this);
        });
    </script>

    <div class="container">
        <div class="well">
            <fieldset class="form-horizontal">
                <div class="row">
                    <legend class="col-lg-offset-2 col-lg-5">Hide message in image:</legend>
                </div>
                <div class="form-group">
                    <asp:Label ID="lbl_fileName" CssClass="col-lg-3 control-label" runat="server">Choose File:</asp:Label>
                    <div class="col-lg-6">
                        <asp:FileUpload ID="fu_Image" runat="server" accept="image/*" onchange="readURL(this)" /> <%--Only allows image filetypes--%>
                    </div>
                </div>
                <div class="form-group">
                    <asp:Label ID="lbl_message" CssClass="col-lg-3 control-label" runat="server">Message:</asp:Label>
                    <div class="col-lg-6">
                        <asp:TextBox ID="tb_message" CssClass="form-control" runat="server" TextMode="MultiLine"></asp:TextBox>
                    </div>
                </div>

                <div class="form-group">
                    <asp:Label ID="lbl_imagePreview" CssClass="col-lg-3 control-label" runat="server">Preview:</asp:Label>
                    <div class="col-lg-6">
                        <img id="file" src="#" class="img-responsive center-block" style="max-width:400px;max-height:400px;" onerror="this.style.visibility='hidden'" />
                    </div>
                </div>

                <div class="form-group">
                    <div class="col-lg-4 col-lg-offset-7">
                        <asp:Button ID="btn_cancel" CssClass="btn btn-default" Text="Cancel" runat="server" OnClick="btn_cancel_Click" CausesValidation="false" />
                        <asp:Button ID="btn_submit" runat="server" OnClick="btn_submit_Click" Text="Submit" CssClass="btn btn-primary" />
                    </div>
                </div>
            </fieldset>
        </div>
    </div>
</asp:Content>
