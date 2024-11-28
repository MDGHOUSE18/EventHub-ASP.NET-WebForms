<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Admin.Master" AutoEventWireup="true" CodeBehind="EditEvent.aspx.cs" Inherits="EventHub.Pages.Admin.EditEvent" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   <div class="container mt-4">
        <h2 class="text-center">Edit Event</h2>
        <div class="card shadow-sm">
            <div class="card-body">
                <asp:Panel ID="EditEventPanel" runat="server">
                    <div class="mb-3">
                        <asp:Label ID="lblEventName" runat="server" AssociatedControlID="txtEventName" Text="Event Name:" CssClass="form-label"></asp:Label>
                        <asp:TextBox ID="txtEventName" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <asp:Label ID="lblEventDate" runat="server" AssociatedControlID="txtEventDate" Text="Event Date (yyyy-MM-dd):" CssClass="form-label"></asp:Label>
                        <asp:TextBox ID="txtEventDate" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <asp:Label ID="lblDescription" runat="server" AssociatedControlID="txtDescription" Text="Description:" CssClass="form-label"></asp:Label>
                        <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" Rows="4" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <asp:Label ID="lblLocation" runat="server" AssociatedControlID="txtLocation" Text="Location:" CssClass="form-label"></asp:Label>
                        <asp:TextBox ID="txtLocation" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="d-flex justify-content-between">
                        <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="btn btn-primary" OnClick="btnUpdate_Click" />
                        <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-secondary" PostBackUrl="~/Pages/Admin/ManageEvents.aspx" />
                    </div>
                </asp:Panel>
            </div>
        </div>
    </div>
    
</asp:Content>
