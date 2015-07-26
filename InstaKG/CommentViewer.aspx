<%@ Page Title="" Language="C#" MasterPageFile="~/InstaKG.Master" AutoEventWireup="true" CodeBehind="CommentViewer.aspx.cs" Inherits="InstaKG.CommentViewer_Test" ValidateRequest="false" %>
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
                <%--<legend class="col-lg-offset-2 col-lg-7">Viewing Comments From <span id="span_title"><%= imageTitle %></span>:</legend>--%>
                <h3 class="col-lg-offset-2 col-lg-6">Comments From: <span><%= imageTitle %></span></h3>
            </div>
            <br />

            <%--<div class="form-group">
                <asp:Label ID="lbl_imageTitle" CssClass="col-lg-3 control-label" runat="server">Image:</asp:Label>
                <div class="col-lg-3">
                    <asp:DropDownList ID="ddl_imageTitle" runat="server" CssClass="form-control" AutoPostBack="True" DataSourceID="sds_Images" DataTextField="imageTitle" DataValueField="imageID"></asp:DropDownList>
                </div>
            </div>--%>

            <div class="form-group">
                <div class="col-lg-8 col-lg-offset-2">
                    <asp:Image ID="img_selectedImage" runat="server" CssClass="img-responsive center-block" Style="max-height: 500px;" />
                    <%--<asp:Image ID="img_selectedImage" runat="server" CssClass="img-responsive" ImageUrl='<%#"~/ImageViewerHandler.ashx?id=" + ddl_imageTitle.SelectedValue%>' />--%>
                </div>
            </div>
        </fieldset>

        <div class="panel panel-default">
            <div class="panel-heading"><b style="padding-right:5px;">Description: </b><% =imageDescription %><span class="pull-right">Uploader: <span><%= fName %></span></span></div>
            <div class="panel-body">
                <fieldset class="form-horizontal">
                    <div class="form-group">
                        <div>
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

        <fieldset class="form-horizontal">
            <div class="form-group">
                <asp:Label ID="lbl_commentContent" CssClass="col-lg-3 control-label" runat="server">Comment:</asp:Label>
                <div class="col-lg-6">
                    <asp:TextBox ID="tb_commentContent" CssClass="form-control" TextMode="MultiLine" Rows="4" runat="server" placeholder="Write a comment here"></asp:TextBox>
                </div>
                <div class="col-lg-1">
                    <asp:RequiredFieldValidator ID="rfv_commentContent" runat="server" ErrorMessage="Comment required" ControlToValidate="tb_commentContent" ForeColor="Red"></asp:RequiredFieldValidator>
                </div>
            </div>

            <div class="form-group">
                <div class="col-lg-4 col-lg-offset-7">
                    <asp:Button ID="btn_cancel" CssClass="btn btn-default" Text="Cancel" runat="server" OnClick="btn_cancel_Click" CausesValidation="false" />
                    <asp:Button ID="btn_submit" CssClass="btn btn-primary" Text="Submit" runat="server" OnClick="btn_submit_Click" />
                </div>
            </div>
        </fieldset>
    </div>

    <%--<asp:SqlDataSource ID="sds_Images" runat="server" ConnectionString="<%$ ConnectionStrings:InstaKG %>" SelectCommand="SELECT DISTINCT [imageID], [imageTitle] FROM [Image] ORDER BY [imageID]"></asp:SqlDataSource>--%>
    <asp:SqlDataSource ID="sds_Comments" runat="server" ConnectionString="<%$ ConnectionStrings:InstaKG %>" SelectCommand="SELECT Comment.commentDateTime, Comment.commentContent, Comment.commentAuthor, Account.accountID, Account.fName FROM Comment INNER JOIN Account ON Comment.commentAuthor = Account.accountID WHERE (Comment.imageID = @imageID) ORDER BY Comment.commentDateTime DESC">
        <SelectParameters>
            <%--<asp:ControlParameter ControlID="ddl_imageTitle" DefaultValue="1" Name="imageID" PropertyName="SelectedValue" Type="Int32" />--%>
            <asp:QueryStringParameter DefaultValue="1" Name="imageID" QueryStringField="imageID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
