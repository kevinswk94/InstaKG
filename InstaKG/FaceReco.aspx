<%@ Page Title="" Language="C#" MasterPageFile="~/InstaKG.Master" AutoEventWireup="true" CodeBehind="FaceReco.aspx.cs" Inherits="InstaKG.test" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script language="JavaScript" src="//ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
    <script language="JavaScript" src="//ajax.googleapis.com/ajax/libs/swfobject/2.2/swfobject.js"></script>
    <script language="JavaScript" src="/Scripts/scriptcam.js"></script>

    <%--for webcam--%>
    <script language="JavaScript">
        $(document).ready(function () {
            $("#webcam").scriptcam({
                showMicrophoneErrors: false,
                onError: onError,
                cornerRadius: 20,
                disableHardwareAcceleration: 1,
                cornerColor: 'e3e5e2',
                onWebcamReady: onWebcamReady,
                //uploadImage: '/Styles/webcam/upload.gif',
                //onPictureAsBase64: base64_tofield_and_image
            });
        });
        function base64_tofield() {
            $('#formfield1').val($.scriptcam.getFrameAsBase64());
            var hdnfldVariable = document.getElementById('HiddenField1');
            hdnfldVariable.value = ($.scriptcam.getFrameAsBase64());


        };
        function base64_toimage() {
            $('#image1').attr("src", "data:image/png;base64," + $.scriptcam.getFrameAsBase64());
        };
        function base64_tofield_and_image(b64) {
            $('#formfield1').val(b64);
            $('#image1').attr("src", "data:image/png;base64," + b64);


        };
        function changeCamera() {
            $.scriptcam.changeCamera($('#cameraNames').val());
        }
        function onError(errorId, errorMsg) {
            //$("#btn1").attr("disabled", true);
            //$("#btn2").attr("disabled", true);
            $("#btn_Capture").attr("disabled", true);
            alert(errorMsg);
        }
        function onWebcamReady(cameraNames, camera, microphoneNames, microphone, volume) {
            $.each(cameraNames, function (index, text) {
                $('#cameraNames').append($('<option></option>').val(index).html(text))
            });
            $('#cameraNames').val(camera);
        }
    </script>
    <%--reading files--%>
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
    <%--for view tabs--%>
    <style type="text/css">
        .Initial {
            display: block;
            padding: 4px 18px 4px 18px;
            float: left;
            background: url("../Images/InitialImage.png") no-repeat right top;
            color: Black;
            font-weight: bold;
        }

            .Initial:hover {
                color: White;
                background: url("../Images/SelectedButton.png") no-repeat right top;
            }

        .Clicked {
            float: left;
            display: block;
            background: url("../Images/SelectedButton.png") no-repeat right top;
            padding: 4px 18px 4px 18px;
            color: Black;
            font-weight: bold;
            color: White;
        }
    </style>


    <div class="container">
        <!-- Alert placeholder, alter attributes in CodeBehind -->
        <div id="alert_placeholder" runat="server" visible="false">
            <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
            <asp:Literal runat="server" ID="alertText" />
        </div>

        <div class="well">
            <fieldset class="form-horizontal">

                <div class="form-group">
                    <div class="col-lg-2">
                        <asp:Button Text="Live Camera" BorderStyle="None" ID="Tab1" CssClass="Initial" runat="server"
                            OnClick="Tab1_Click" />
                        <asp:Button Text="Upload Profile Picture" BorderStyle="None" ID="Tab2" CssClass="Initial" runat="server"
                            OnClick="Tab2_Click" />
                    </div>
                </div>
                <asp:MultiView ID="MainView" runat="server">
                    <asp:View ID="View1" runat="server">
                        <div class="form-group">
                            <asp:Label ID="lbl_CameraUsed" CssClass="col-lg-4 control-label" runat="server">Camera Used:</asp:Label>
                            <img src="/Styles/webcam/webcamlogo.png" style="vertical-align: text-top" />
                            <select id="cameraNames" size="1" onchange="changeCamera()" style="width: 245px; font-size: 10px; height: 25px;">
                            </select>

                        </div>

                        <div class="form-group">
                            <asp:Label ID="lbl_Camera" CssClass="col-lg-4 control-label" runat="server">Live Camera:</asp:Label>
                            <div id="webcam">
                            </div>
                        </div>

                        <div class="form-group">

                            <textarea id="formfield1" style="width: 190px; height: 70px;" hidden="hidden"></textarea>
                            <asp:Label ID="lbl_ImageCaptured" CssClass="col-lg-4 control-label" runat="server">Image Captured:</asp:Label>

                            <asp:HiddenField ID="HiddenField1" runat="server" ClientIDMode="Static" Value="test" />
                            <asp:Image ID="Image1" runat="server" class="img-responsive" src="#" />

                        </div>

                        <div class="form-group">
                            <div class="col-lg-4 col-lg-offset-7">
                                <asp:Button ID="btn_Capture" runat="server" Text="Capture" OnClick="Button2_Click" OnClientClick="base64_tofield()" CssClass="btn btn-primary" />
                                <asp:Button ID="btn_Use" runat="server" Text="Use as profile image" CssClass="btn btn-primary" OnClick="btn_Use_Click" />
                            </div>
                        </div>

                    </asp:View>
                    <%--end of view 1--%>

                    <asp:View ID="View2" runat="server">
                        <div class="form-group">
                            <asp:Label ID="lbl_FromCom" CssClass="col-lg-4 control-label" runat="server">Select Image:</asp:Label>
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
                                <asp:Button ID="btn_UseFromCom" runat="server" Text="Use as profile image" CssClass="btn btn-primary" OnClick="btn_UseFromCom_Click" />
                            </div>
                        </div>

                    </asp:View>
                </asp:MultiView>
                <%--end of view--%>
            </fieldset>
        </div>
    </div>

</asp:Content>
