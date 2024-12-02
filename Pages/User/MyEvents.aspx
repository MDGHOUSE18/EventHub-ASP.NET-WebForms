<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/User.Master" AutoEventWireup="true" CodeBehind="MyEvents.aspx.cs" Inherits="EventHub.Pages.User.MyEvents" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
<div class="row justify-content-center">
    <%--<h1>REGISTERED EVENTS</h1>--%>
    <asp:Repeater ID="UserRepeater" runat="server" OnItemCommand="UserRepeater_ItemCommand"
        OnItemDataBound="UserRepeater_ItemDataBound">
        <ItemTemplate>
            <div class="col-lg-3 col-md-4 col-sm-6 mb-4 px-1">
                <div class="card card-hover m-auto" style="width: 100%; height: 23rem;">
                    <asp:Image ID="EventImage" runat="server" ImageUrl='<%# Eval("Images") %>' 
                        CssClass="card-img-top" alt='~/EventImages/default-image.jpg'
                        Width="100%" Height="200" />
                    <div class="card-body">
                        <h5 class="card-title"><%# Eval("EventName") %></h5>
                        <p class="card-text"><strong>Event Date:</strong> <%# Eval("EventDate", "{0:yyyy-MM-dd}") %></p>
                        <!-- Label for Already Registered -->
                        <asp:Label ID="AlreadyRegisteredLabel" runat="server" Text="Already Registered" 
                                   CssClass="text-danger" Visible="false"></asp:Label>
                        <div class="d-flex justify-content-between align-items-center">
                            <!-- Event Details Button -->
                            <asp:Button ID="EventDetailsButton" runat="server" Text="Event Details" 
                                        CommandName="EventDetails" CommandArgument='<%# Eval("EventID") %>' 
                                        CssClass="btn btn-info btn-sm" />

                            

                            <!-- Register Button -->
                            <asp:Button ID="Register" runat="server" Text="Register Now" 
                                        CommandName="EventRegister" CommandArgument='<%# Eval("EventID") %>' 
                                        CssClass="btn btn-info btn-sm mt-2" Visible="false" />
                            <!-- UnRegister Button -->
                            <asp:Button ID="CancelEventRegister" runat="server" Text="Cancel Registration" 
                                        CommandName="CancelEventRegister" CommandArgument='<%# Eval("EventID") %>' 
                                        CssClass="btn btn-info btn-sm mt-2" Visible="false" />
                            
                        </div>
                    </div>
                </div>
            </div>
        </ItemTemplate>
    </asp:Repeater>
</div>
<div class="d-flex justify-content-between align-items-center">
    <asp:Button ID="Home" runat="server" Text="Back To Home" CssClass="btn btn-outline-primary"/>
    <div class="pagination ">
        <asp:Button ID="btnPrevious" runat="server" Text="Previous" OnClick="btnPrevious_Click" CssClass="btn btn-secondary" />
        <asp:Button ID="btnNext" runat="server" Text="Next" OnClick="btnNext_Click" CssClass="btn btn-secondary" />
        <asp:Label ID="lblPageInfo" runat="server" CssClass="ml-3" />
    </div>
</div>
<%-- Event Details Modal --%>
<div class="modal fade" id="eventDetailsModal" tabindex="-1" aria-labelledby="eventDetailsModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="eventDetailsModalLabel">Event Details</h5>
                <button type="button" class="btn-close" data-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <asp:Panel ID="Panel2" runat="server" CssClass="form-group">
                    <asp:HiddenField ID="HiddenField1" runat="server" />

                    <%-- Event Name --%>
                    <asp:Label ID="eNameLabel" runat="server" Text="Event Name:" CssClass="font-weight-bold"></asp:Label>
                    <asp:Literal ID="LiteralEventName" runat="server" ></asp:Literal>
                    <br />

                    <%-- Event Date --%>
                    <asp:Label ID="eDateLabel" runat="server" Text="Event Date (yyyy-MM-dd):" CssClass="font-weight-bold"></asp:Label>
                    <asp:Literal ID="LiteralEventDate" runat="server" ></asp:Literal>
                    <br />

                    <%-- Description --%>
                    <asp:Label ID="eDescriptionLabel" runat="server" Text="Description:" CssClass="font-weight-bold"></asp:Label>
                    <asp:Literal ID="LiteralDescription" runat="server" ></asp:Literal>
                    <br />

                    <%-- Location --%>
                    <asp:Label ID="Label9" runat="server" Text="Location:" CssClass="font-weight-bold"></asp:Label>
                    <asp:Literal ID="LiteralLocation" runat="server"></asp:Literal>
                    <br />

                    <%-- Event Image --%>
                    <asp:Label ID="Label10" runat="server" Text="Event Image:" CssClass="font-weight-bold"></asp:Label>
                    <br />
                    <%--<asp:Image ID="ImageEvent" runat="server"  CssClass="img-thumbnail" Width="200px" Height="150px" />--%>
                    <asp:Image ID="ImageEvent" runat="server" ImageUrl="~/Images/default-image.jpg" Width="200px" Height="150px" CssClass="img-thumbnail" />
                </asp:Panel>
            </div>
        </div>
    </div>
</div>
</asp:Content>
