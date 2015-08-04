﻿<%@ Page Title="" Language="C#" MasterPageFile="~/InstaKG.Master" AutoEventWireup="true" CodeBehind="Chat.aspx.cs" Inherits="InstaKG.Chat" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <link href="Styles/ChatStyles/ChatStyle.css" rel="stylesheet" />
    <link href="Styles/ChatStyles/JQueryUI/themes/base/jquery.ui.all.css" rel="stylesheet" />

    <!--Script references. -->

    <script src="Scripts/ChatUI/jquery.ui.core.js"></script>
    <script src="Scripts/ChatUI/jquery.ui.widget.js"></script>
    <script src="Scripts/ChatUI/jquery.ui.mouse.js"></script>
    <script src="Scripts/ChatUI/jquery.ui.draggable.js"></script>
    <script src="Scripts/ChatUI/jquery.ui.resizable.js"></script>

    <!--Reference the SignalR library. -->
    <script src="Scripts/jquery.signalR-2.1.2.js"></script>

    <!--Reference the autogenerated SignalR hub script. -->
    <script src="/signalr/hubs"></script>

    <script type="text/javascript">

        $(function () {

            setScreen(false);
            var decryptedMessage;
            // Declare a proxy to reference the hub.
            var chatHub = $.connection.chatHub;

            registerClientMethods(chatHub);

            // Start Hub
            $.connection.hub.start().done(function () {

                registerEvents(chatHub)

            });

        });

        function setScreen(isLogin) {

            if (!isLogin) {

                $("#divChat").hide();
                $("#divLogin").show();
            }
            else {

                $("#divChat").show();
                $("#divLogin").hide();
            }

        }

        function registerEvents(chatHub) {

            $("#btnStartChat").click(function () {

                var name = $("#txtNickName").val();
                if (name.length > 0) {
                    chatHub.server.connect(name);
                }
                else {
                    alert("Please enter name");
                }

            });

            $('#btnSendMsg').click(function () {

                var msg = $("#txtMessage").val();
                if (msg.length > 0) {

                    var userName = $('#hdUserName').val();
                    chatHub.server.sendMessageToAll(userName, msg);
                    $("#txtMessage").val('');
                }
            });

            $("#txtNickName").keypress(function (e) {
                if (e.which == 13) {
                    $("#btnStartChat").click();
                }
            });

            $("#txtMessage").keypress(function (e) {
                if (e.which == 13) {
                    $('#btnSendMsg').click();
                }
            });

        }

        function registerClientMethods(chatHub) {

            // Calls when user successfully logged in
            chatHub.client.onConnected = function (id, userName, allUsers, messages) {

                setScreen(true);

                $('#hdId').val(id);
                $('#hdUserName').val(userName);
                $('#spanUser').html(userName);

                // Add All Users
                for (i = 0; i < allUsers.length; i++) {

                    AddUser(chatHub, allUsers[i].ConnectionId, allUsers[i].UserName);
                }

                // Add Existing Messages
                for (i = 0; i < messages.length; i++) {

                    AddMessage(messages[i].UserName, messages[i].Message);
                }

            }

            // On New User Connected
            chatHub.client.onNewUserConnected = function (id, name) {

                AddUser(chatHub, id, name);
            }

            // On User Disconnected
            chatHub.client.onUserDisconnected = function (id, userName) {

                $('#' + id).remove();

                var ctrId = 'private_' + id;
                $('#' + ctrId).remove();

                var disc = $('<div class="disconnect">"' + userName + '" logged off.</div>');

                $(disc).hide();
                $('#divusers').prepend(disc);
                $(disc).fadeIn(200).delay(2000).fadeOut(200);

            }

            chatHub.client.messageReceived = function (userName, message) {
                <%--var decryptedMessage = <%=getDecryptedMessage()%>;
                <%--var decryptedMessage = <%=this.getDecryptedMessage()%>;--%>

                //var privateChat = <%=InstaKG.ChatHub.inPrivate%>;
                //if (decryptedMessage = "public"){--%>
                AddMessage(userName, message + "Dedug line 149"); // Adding message to public chat area
                //} else{
                //    AddMessage(userName, InstaKG.ChatHub.decryptedOTR);
                //}

                <%--if (privateChat == "false"){
                    decryptedMessage = <%=getDecryptedMessage()%>;
                    AddMessage(userName, decryptedMessage);
                }else{
                    AddMessage(userName, message);
                }--%>
            }

            chatHub.client.sendPrivateMessage = function (windowId, fromUserName, message) {

                var ctrId = 'private_' + windowId;

                if ($('#' + ctrId).length == 0) {

                    createPrivateChatWindow(chatHub, windowId, ctrId, fromUserName);

                }

                // Decryption of the OTR message
                <%--var decryptedMessage = <%=InstaKG.ChatHub.decryptedOTR%>;--%>

                // THIS WHERE THE PRIVATE MESSAGE IN, AND CAN BE PROCCESSED BEFORE HAND
                //var delay=10000; //10 seconds
                //var decryptedMessage;
                //setTimeout(function(){
                //    //your code to be executed after 10 seconds
                //    decryptedMessage = "SLDHKSNFA";

                //}, delay);

                //refreshingDecryption();

                <%--if (<%=this.privateCounter%> != 0){
                    decryptedMessage = <%=getDecryptedMessage()%>;}--%>

                <%--decryptedMessage = <%=getDecryptedMessage()%>;--%>

                //var delay = 10000; //10 seconds
                //setTimeout(function () {
                    //your code to be executed after 10 seconds
                    //decryptedMessage = "SLDHKSNFA";
                    refreshingDecryption();
                    $('#' + ctrId).find('#divMessage').append('<div class="message"><span class="userName">' + fromUserName + '</span>: ' + decryptedMessage+ " Debug line 196" + '</div>');
                //}, delay);

                // Adding private message

                //$('#' + ctrId).find('#divMessage').append('<div class="message"><span class="userName">' + fromUserName + '</span>: ' + message + '</div>');

                // set scrollbar
                var height = $('#' + ctrId).find('#divMessage')[0].scrollHeight;
                $('#' + ctrId).find('#divMessage').scrollTop(height);

            }

        }

        // getting decrpted value
        function refreshingDecryption() {
            $.ajax({
                type: "POST",
                url: 'Chat.aspx/refreshingDecryption',
                data: "",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (retValue) {
                    //$("#divResult").html("success");
                    //alert(retValue.d)
                    decryptedMessage = retValue.d;
                },
                error: function (e) {
                    //alert("fail to refresh message")
                }
            });
        }

        function AddUser(chatHub, id, name) {

            var userId = $('#hdId').val();

            var code = "";

            if (userId == id) {

                code = $('<div class="loginUser">' + name + "</div>");

            }
            else {

                code = $('<a id="' + id + '" class="user" >' + name + '<a>');

                $(code).dblclick(function () {

                    var id = $(this).attr('id');

                    if (userId != id)

                        OpenPrivateChatWindow(chatHub, id, name);

                });
            }

            $("#divusers").append(code);

        }

        // Public chat
        function AddMessage(userName, message) {
            <%--var privateChat = <%=InstaKG.ChatHub.inPrivate%>;
            if (false){
            // Decryption of the OTR message
                var decryptedMessage = <%=InstaKG.ChatHub.decryptedOTR%>;

                $('#divChatWindow').append('<div class="message"><span class="userName">' + userName + '</span>: ' + decryptedMessage + '</div>');

                var height = $('#divChatWindow')[0].scrollHeight;
                $('#divChatWindow').scrollTop(height);

            } else {
            $('#divChatWindow').append('<div class="message"><span class="userName">' + userName + '</span>: ' + message + '</div>');

            var height = $('#divChatWindow')[0].scrollHeight;
            $('#divChatWindow').scrollTop(height);
            }--%>

            // this is the public chat adding message function
            $('#divChatWindow').append('<div class="message"><span class="userName">' + userName + '</span>: ' + message + '</div>');

            var height = $('#divChatWindow')[0].scrollHeight;
            $('#divChatWindow').scrollTop(height);

        }

        function OpenPrivateChatWindow(chatHub, id, userName) {
            var ctrId = 'private_' + id;

            if ($('#' + ctrId).length > 0) return;

            createPrivateChatWindow(chatHub, id, ctrId, userName);

        }

        function createPrivateChatWindow(chatHub, userId, ctrId, userName) {

            //refreshingDecryption();
            //var delay = 10000; //10 seconds
            //setTimeout(function () {
            //    //your code to be executed after 10 seconds
            //    //decryptedMessage = "SLDHKSNFA";
            //    refreshingDecryption();

            //}, delay);

            var div = '<div id="' + ctrId + '" class="ui-widget-content draggable" rel="0">' +
                       '<div class="header">' +
                          '<div  style="float:right;">' +
                              '<img id="imgDelete"  style="cursor:pointer;" src="Styles/img/delete.png" />' +
                           '</div>' +

                           '<span class="selText" rel="0">' + userName + " Debug line 313" + '</span>' +
                       '</div>' +
                       '<div id="divMessage" class="messageArea">' +

                       '</div>' +
                       '<div class="buttonBar">' +
                          '<input id="txtPrivateMessage" class="msgText" type="text"   />' +
                          '<input id="btnSendMessage" class="submitButton button" type="button" value="Send"   />' +
                       '</div>' +
                    '</div>';

            var $div = $(div);

            // DELETE BUTTON IMAGE
            $div.find('#imgDelete').click(function () {
                $('#' + ctrId).remove();
            });

            // Send Button event
            $div.find("#btnSendMessage").click(function () {

                $textBox = $div.find("#txtPrivateMessage");
                var msg = $textBox.val();
                if (msg.length > 0) {

                    // Process private message
                    chatHub.server.sendPrivateMessage(userId, msg);
                    $textBox.val('');
                    refreshingDecryption();
                    var delay = 10000; //10 seconds
                    setTimeout(function () {
                        //your code to be executed after 1 seconds
                        refreshingDecryption();
                        <%--var pageId = '<%=  Page.ClientID %>';
                        __doPostBack(pageId, "myargs");--%>
                    }, delay);

                    <%--var pageId = '<%=  Page.ClientID %>';
                    __doPostBack(pageId, "myargs");--%>

                }
            });

            // Text Box event
            $div.find("#txtPrivateMessage").keypress(function (e) {
                if (e.which == 13) {
                    $div.find("#btnSendMessage").click();
                }
            });

            AddDivToContainer($div);

        }

        function AddDivToContainer($div) {
            $('#divContainer').prepend($div);

            $div.draggable({

                handle: ".header",
                stop: function () {

                }
            });

            ////$div.resizable({
            ////    stop: function () {

            ////    }
            ////});

        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="header">
        Insta Chat Room
    </div>
    <br />
    <br />
    <br />

    <div id="divContainer">
        <div id="divLogin" class="login">
            <div>
                Your Name:<br />
                <input id="txtNickName" type="text" class="textBox" />
            </div>
            <div id="divButton">
                <input id="btnStartChat" type="button" class="submitButton" value="Start Chat" />
            </div>
        </div>

        <div id="divChat" class="chatRoom">
            <div class="title">
                Welcome to Chat Room [<span id='spanUser'></span>]
            </div>
            <div class="content">
                <div id="divChatWindow" class="chatWindow">
                </div>
                <div id="divusers" class="users">
                </div>
            </div>
            <div class="messageBar">
                <input class="textbox" type="text" id="txtMessage" />
                <input id="btnSendMsg" type="button" value="Send" class="submitButton" />
            </div>
        </div>

        <input id="hdId" type="hidden" />
        <input id="hdUserName" type="hidden" />
    </div>
</asp:Content>