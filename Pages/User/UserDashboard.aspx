<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/User.Master" AutoEventWireup="true" CodeBehind="UserDashboard.aspx.cs" Inherits="EventHub.Pages.User.UserDashboard1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>This is a UserDasboard</h1>
    <asp:GridView ID="UserGrid" runat="server"
        AutoGenerateColumns="False" 
        CssClass="table table-bordered table-striped table-hover text-center" 
        OnRowCommand="ManageEventsGrid_RowCommand" 
        AllowPaging="true" PageSize="5" OnPageIndexChanging="ManageEventsGrid_PageIndexChanging"
    >
        <Columns>
            <%-- Hidden EventID Column --%>
            <asp:BoundField DataField="EventID" HeaderText="Event ID" SortExpression="EventID" Visible="False" />

            <%-- Serial Number Column --%>
            <asp:TemplateField HeaderText="SNo">
                <ItemTemplate>
                    <%# Container.DataItemIndex + 1 %> <!-- Serial number based on the row index -->
                </ItemTemplate>
            </asp:TemplateField>


            <%-- Event Name --%>
            <asp:BoundField DataField="EventName" HeaderText="Event Name" />

            <%-- Event Date --%>
            <asp:BoundField DataField="EventDate" HeaderText="Event Date" DataFormatString="{0:yyyy-MM-dd}" />

            <%-- Location --%>
            <asp:BoundField DataField="Location" HeaderText="Location" />
            <%-- Image Field --%>
            <asp:TemplateField HeaderText="Event Image">
                <ItemTemplate>
                    <asp:Image ID="imgEventImage" runat="server" Width="100" ImageUrl='<%# Eval("Images") %>'/>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Actions">
                <ItemTemplate>
                    <%-- Event Details Button --%>
                    <asp:Button ID="EventDetailsButton" runat="server" Text="Event Details" 
                        CommandName="EventDetails" CommandArgument='<%# Eval("EventID") %>' 
                        CssClass="btn btn-info btn-sm me-2" />

                   <%-- <%-- Edit Button 
                    <asp:Button ID="EditButton" runat="server" Text="Edit" CommandName="EditEvent" 
                        CommandArgument='<%# Eval("EventID") %>' CssClass="btn btn-warning btn-sm me-2" /> --%>

                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>


    
    <h1>Event Repeater</h1>
    <div class="row">
        <asp:Repeater ID="UserRepeater" runat="server">
            <ItemTemplate>
                <div class="col-md-4 mb-4">
                    <div class="card">
                        <div class="card-body">
                            <img src="<%# Eval("Images") %>" class="card-img-top" alt="...">
                            <h5 class="card-title"><%# Eval("EventName") %></h5>
                            <p class="card-text"><strong>Event Date:</strong> <%# Eval("EventDate", "{0:yyyy-MM-dd}") %></p>
                            <p class="card-text"><strong>Location:</strong> <%# Eval("Location") %></p>
                            <asp:Button ID="EventDetailsButton" runat="server" Text="Event Details" 
                                        CommandName="EventDetails" CommandArgument='<%# Eval("EventID") %>' 
                                        CssClass="btn btn-info btn-sm" />
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>


    <%-- Pagination Section --%>
    <div class="d-flex justify-content-center mt-4">
        <asp:GridView ID="GridView1" runat="server" 
                      AutoGenerateColumns="False" 
                      CssClass="table table-bordered table-striped table-hover text-center" 
                      AllowPaging="true" 
                      PageSize="5" 
                      OnPageIndexChanging="ManageEventsGrid_PageIndexChanging" 
                      Visible="false"> <%-- Hide GridView and use the Repeater instead --%>
            <Columns>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:Label runat="server" Text="Page:"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <PagerSettings Mode="Numeric" PageButtonCount="5" />
        </asp:GridView>
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
