﻿<%@ Page Title="" Language="C#" MasterPageFile="~/InstaKG.Master" AutoEventWireup="true" CodeBehind="CommentViewer_Test.aspx.cs" Inherits="InstaKG.CommentViewer_Test" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <div class="container">
        <!-- Alert placeholder, alter attributes in CodeBehind -->
        <div id="alert_placeholder" runat="server" visible="false">
            <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
            <asp:Literal runat="server" ID="alertText" />
        </div>

        <fieldset class="form-horizontal">
            <div class="row">
                <legend class="col-lg-offset-2 col-lg-5">Viewing comments from images:</legend>
            </div>

            <div class="form-group">
                <asp:Label ID="lbl_imageTitle" CssClass="col-lg-3 control-label" runat="server">Image:</asp:Label>
                <div class="col-lg-3">
                    <asp:DropDownList ID="ddl_imageTitle" runat="server" CssClass="form-control" AutoPostBack="True" DataSourceID="sds_Images" DataTextField="imageTitle" DataValueField="imageID"></asp:DropDownList>
                </div>
            </div>
        </fieldset>

        <div class="panel panel-default">
            <div class="panel-heading">Comments Section</div>
            <div class="panel-body">
                <fieldset class="form-horizontal">
                    <div class="form-group">
                        <div class="col-lg-offset-1">
                            <asp:GridView ID="gv_comments" runat="server" CssClass="table table-responsive" AutoGenerateColumns="False" DataSourceID="sds_Comments" DataKeyNames="accountID">
                                <Columns>
                                    <asp:BoundField DataField="commentDateTime" HeaderText="Timestamp" SortExpression="commentDateTime">
                                        <HeaderStyle CssClass="text-center" />
                                        <ItemStyle CssClass="col-lg-2 col-md-2 col-sm-2 text-center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="commentContent" HtmlEncode="false" HeaderText="Content" SortExpression="commentContent">
                                        <ItemStyle CssClass="col-lg-8 col-md-8 col-sm-8" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="fName" HeaderText="Author" SortExpression="fName">
                                        <HeaderStyle CssClass="text-center" />
                                        <ItemStyle CssClass="col-lg-2 col-md-2 col-sm-2 text-center" />
                                    </asp:BoundField>
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>
                </fieldset>
            </div>
        </div>
    </div>

    <asp:SqlDataSource ID="sds_Images" runat="server" ConnectionString="<%$ ConnectionStrings:InstaKG %>" SelectCommand="SELECT DISTINCT [imageID], [imageTitle] FROM [Image] ORDER BY [imageID]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sds_Comments" runat="server" ConnectionString="<%$ ConnectionStrings:InstaKG %>" SelectCommand="SELECT Comment.commentDateTime, Comment.commentContent, Comment.commentAuthor, Account.accountID, Account.fName FROM Comment INNER JOIN Account ON Comment.commentAuthor = Account.accountID WHERE (Comment.imageID = @imageID) ORDER BY Comment.commentDateTime DESC">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddl_imageTitle" DefaultValue="1" Name="imageID" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>