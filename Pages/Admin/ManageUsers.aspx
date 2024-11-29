<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Admin.Master" AutoEventWireup="true" CodeBehind="ManageUsers.aspx.cs" Inherits="EventHub.Pages.Admin.ManageUsers" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <asp:GridView ID="UsersGrid" runat="server" AutoGenerateColumns="false"
        CssClass="table table-bordered table-striped table-hover text-center" >
        <Columns>
            <%-- Hidden EventID Column --%>
            <asp:BoundField DataField="UserID" HeaderText="User ID" SortExpression="EventID" Visible="False" />
        
            <%-- Serial Number Column --%>
            <asp:TemplateField HeaderText="SNo">
                <ItemTemplate>
                    <%# Container.DataItemIndex + 1 %> <!-- Serial number based on the row index -->
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="FullName" HeaderText="User Name" />
            <asp:BoundField DataField="Email" HeaderText="Email" />
            <asp:BoundField DataField="Role" HeaderText="Role" />
            <asp:BoundField DataField="CreatedAt" HeaderText="Event Date" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
            <asp:BoundField DataField="LastLogin" HeaderText="Event Date" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
            <asp:BoundField DataField="IsActive" HeaderText="IsActive" />
            <asp:TemplateField HeaderText="Actions">
                <ItemTemplate>
        
                    <%-- Delete Button --%>
                    <asp:Button ID="DeleteButton" runat="server" Text="Delete" 
                        CommandName="DeleteEvent" CssClass="btn btn-danger btn-sm" CommandArgument='<%# Eval("UserID") %>' 
                        OnClientClick="return confirm('Are you sure you want to delete this event?');" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>

</asp:Content>
