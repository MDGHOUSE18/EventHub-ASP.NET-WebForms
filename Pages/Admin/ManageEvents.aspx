<%@ Page Title="Manage Events" Language="C#" MasterPageFile="~/MasterPages/Admin.Master" AutoEventWireup="true" CodeBehind="ManageEvents.aspx.cs" Inherits="EventHub.Pages.Admin.ManageEvents" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="d-flex justify-content-between align-items-center mr-5 ml-5">
        <h2 class="text-center m-2">Manage Events</h2>
        <asp:Button ID="AddEvent" runat="server" Text="Add Event" CssClass="btn btn-primary btn-sm px-4 py-2" OnClick="AddEvent_Click" />
    </div>
    <asp:GridView
        ID="ManageEventsGrid" runat="server" AutoGenerateColumns="False" 
        CssClass="table table-bordered table-striped table-hover text-center" 
        OnRowCommand="ManageEventsGrid_RowCommand" OnRowDataBound="ManageEventsGrid_RowDataBound" 
        AllowPaging="true" PageSize="5" OnPageIndexChanging="ManageEventsGrid_PageIndexChanging">
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
            <asp:BoundField DataField="EventDate" HeaderText="Event Date" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />


            <%-- Images with Default Image if NULL --%>
            <%--<asp:TemplateField HeaderText="Event Image">
                <ItemTemplate>
                    <img src='<%# String.IsNullOrEmpty(Eval("Images").ToString()) ? "~/images/default-image.jpg" : Eval("Images") %>' alt="Event Image" width="100" />
                </ItemTemplate>
            </asp:TemplateField>--%>
            <%-- Image Field --%>
            <%--<asp:TemplateField HeaderText="Event Image">
                <ItemTemplate>
                    <asp:Image ID="imgEventImage" runat="server" Width="100" />
                </ItemTemplate>
            </asp:TemplateField>--%>

            <%-- Location --%>
            <asp:BoundField DataField="Location" HeaderText="Location" />

            <asp:TemplateField HeaderText="Actions">
                <ItemTemplate>
                    <%-- Event Details Button --%>
                    <asp:Button ID="EventDetailsButton" runat="server" Text="Event Details" 
                        CommandName="EventDetails" CommandArgument='<%# Eval("EventID") %>' 
                        CssClass="btn btn-info btn-sm me-2" />
        
                    <%-- Edit Button --%>
                    <asp:Button ID="EditButton" runat="server" Text="Edit" CommandName="EditEvent" 
                        CommandArgument='<%# Eval("EventID") %>' CssClass="btn btn-warning btn-sm me-2" />
        
                    <%-- Delete Button --%>
                    <asp:Button ID="DeleteButton" runat="server" Text="Delete" 
                        CommandName="DeleteEvent" CssClass="btn btn-danger btn-sm" CommandArgument='<%# Eval("EventID") %>' 
                        OnClientClick="return confirm('Are you sure you want to delete this event?');" />
                </ItemTemplate>
            </asp:TemplateField>

        </Columns>
    </asp:GridView>
    <%-- Add Event Modal --%>
    <div class="modal fade" id="addEventModal" tabindex="-1" aria-labelledby="addEventModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addEventModalLabel">Edit Event</h5>
                <button type="button" class="btn-close" data-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <asp:Panel ID="Panel3" runat="server" CssClass="form-group">

                    <asp:Label ID="Label5" runat="server" AssociatedControlID="TextBox1" Text="Event Name:"></asp:Label>
                    <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control" Placeholder="Enter event name"></asp:TextBox>

                    <asp:Label ID="Label7" runat="server" AssociatedControlID="TextBox2" Text="Event Date (yyyy-MM-dd):"></asp:Label>
                    <asp:TextBox ID="TextBox2" runat="server" CssClass="form-control" Placeholder="Enter event date"></asp:TextBox>

                    <asp:Label ID="Label8" runat="server" AssociatedControlID="TextBox3" Text="Description:"></asp:Label>
                    <asp:TextBox ID="TextBox3" runat="server" TextMode="MultiLine" Rows="4" CssClass="form-control" Placeholder="Enter event description"></asp:TextBox>

                    <asp:Label ID="Label11" runat="server" AssociatedControlID="TextBox4" Text="Location:"></asp:Label>
                    <asp:TextBox ID="TextBox4" runat="server" CssClass="form-control" Placeholder="Enter event location"></asp:TextBox>

                    <asp:Label ID="Label12" runat="server" AssociatedControlID="fileUploadEventImage" Text="Event Image:"></asp:Label>
                    <asp:FileUpload ID="fileUpload1" runat="server" CssClass="form-control" />

                </asp:Panel>
            </div>
            <div class="modal-footer">
                <asp:Button ID="AddEventButton" runat="server" Text="Add Event" CssClass="btn btn-primary" OnClick="btnAdd_Click" />
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
            </div>
        </div>
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
                        <asp:Label ID="Label10" runat="server" Text="Event Image:" CssClass="font-weight-bold " ></asp:Label>
                        <br />
                        <%--<asp:Image ID="ImageEvent" runat="server"  CssClass="img-thumbnail" Width="200px" Height="150px" />--%>
                        <asp:Image ID="ImageEvent" runat="server" ImageUrl="~/Images/default-image.jpg" Width="200px" Height="150px" CssClass="img-thumbnail" />
                    </asp:Panel>
                </div>
            </div>
        </div>
    </div>
    <%-- Event Edit Modal --%>
    <div class="modal fade" id="editEventModal" tabindex="-1" aria-labelledby="editEventModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editEventModalLabel">Edit Event</h5>
                    <button type="button" class="btn-close" data-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <asp:Panel ID="Panel1" runat="server" CssClass="form-group">
                        <asp:HiddenField ID="hfEventID" runat="server" />

                        <asp:Label ID="Label1" runat="server" AssociatedControlID="txtEventName" Text="Event Name:"></asp:Label>
                        <asp:TextBox ID="txtEventName" runat="server" CssClass="form-control"></asp:TextBox>
                    
                        <asp:Label ID="Label2" runat="server" AssociatedControlID="txtEventDate" Text="Event Date (yyyy-MM-dd):"></asp:Label>
                        <asp:TextBox ID="txtEventDate" runat="server" CssClass="form-control"></asp:TextBox>
                    
                        <asp:Label ID="Label3" runat="server" AssociatedControlID="txtDescription" Text="Description:"></asp:Label>
                        <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" Rows="4" CssClass="form-control"></asp:TextBox>
                    
                        <asp:Label ID="Label4" runat="server" AssociatedControlID="txtLocation" Text="Location:"></asp:Label>
                        <asp:TextBox ID="txtLocation" runat="server" CssClass="form-control"></asp:TextBox>
                        <asp:Label ID="Label6" runat="server" AssociatedControlID="fileUploadEventImage" Text="Event Image:"></asp:Label>
                        <asp:FileUpload ID="fileUploadEventImage" runat="server" CssClass="form-control" />     
                    </asp:Panel>
                </div>
                <div class="modal-footer">
                    <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="btn btn-primary" OnClick="btnUpdate_Click" />
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
