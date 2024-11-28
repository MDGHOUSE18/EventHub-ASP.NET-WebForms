<%@ Page Title="Manage Events" Language="C#" MasterPageFile="~/MasterPages/Admin.Master" AutoEventWireup="true" CodeBehind="ManageEvents.aspx.cs" Inherits="EventHub.Pages.Admin.ManageEvents" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2 class="text-center">Manage Events</h2>
    <asp:GridView ID="ManageEventsGrid" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered table-striped" OnRowCommand="ManageEventsGrid_RowCommand" OnRowDataBound="ManageEventsGrid_RowDataBound">
        <Columns>
            <%-- Event ID --%>
            <asp:BoundField DataField="EventID" HeaderText="Event ID" ReadOnly="True" />

            <%-- Event Name --%>
            <asp:BoundField DataField="EventName" HeaderText="Event Name" />

            <%-- Event Date --%>
            <asp:BoundField DataField="EventDate" HeaderText="Event Date" DataFormatString="{0:yyyy-MM-dd}" />

            <%-- Description --%>
            <%--<asp:BoundField DataField="Description" HeaderText="Description" />--%>
            <asp:TemplateField HeaderText="Description">
                <ItemTemplate>
                    <div style="max-width: 200px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
                        <%# Eval("Description") %>
                    </div>
                </ItemTemplate>
            </asp:TemplateField>

            <%-- Images with Default Image if NULL --%>
            <%--<asp:TemplateField HeaderText="Event Image">
                <ItemTemplate>
                    <img src='<%# String.IsNullOrEmpty(Eval("Images").ToString()) ? "~/images/default-image.jpg" : Eval("Images") %>' alt="Event Image" width="100" />
                </ItemTemplate>
            </asp:TemplateField>--%>
            <%-- Image Field --%>
            <asp:TemplateField HeaderText="Event Image">
                <ItemTemplate>
                    <asp:Image ID="imgEventImage" runat="server" Width="100" />
                </ItemTemplate>
            </asp:TemplateField>

            <%-- Location --%>
            <asp:BoundField DataField="Location" HeaderText="Location" />

            <%-- Edit Button --%>
            <asp:ButtonField CommandName="EditEvent" Text="Edit" ButtonType="Button" />

            <%-- Delete Button --%>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:Button ID="DeleteButton" runat="server" Text="Delete" CommandName="DeleteEvent" CommandArgument='<%# Container.DataItemIndex %>' 
                        OnClientClick="return confirm('Are you sure you want to delete this event?');" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <%-- Bootstrap Modal --%>
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
