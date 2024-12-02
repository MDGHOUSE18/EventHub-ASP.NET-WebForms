<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/User.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="EventHub.Pages.User.Profile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-5">
        <h2>User Profile</h2>
        <hr />
        
        <asp:GridView ID="ProfileGridView" runat="server" 
            CssClass="table table-bordered table-striped table-hover text-center">
            <Columns>
                <%--<asp:BoundField DataField="FullName" HeaderText="Full Name" SortExpression="FullName" />
                <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
                <asp:BoundField DataField="Role" HeaderText="Role" SortExpression="Role" />
                <asp:BoundField DataField="CreatedAt" HeaderText="Created At" SortExpression="CreatedAt" 
                                DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
                <asp:BoundField DataField="LastLogin" HeaderText="Last Login" SortExpression="LastLogin" 
                                DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
                <asp:CheckBoxField DataField="IsActive" HeaderText="Is Active" SortExpression="IsActive" />--%>
            </Columns>
        </asp:GridView>
        <asp:Repeater ID="ProfileRepeater" runat="server">
            <ItemTemplate>
                <div class="profile-item">
                    <h3><%# Eval("FullName") %></h3>
                    <p>Email: <%# Eval("Email") %></p>
                    <p>Passport : <%# Eval("PasswordHash") %></p>
                    <p>Role: <%# Eval("Role") %></p>
                    <p>Created At: <%# Eval("CreatedAt", "{0:yyyy-MM-dd}") %></p>
                    <p>Last Login: <%# Eval("LastLogin", "{0:yyyy-MM-dd}") %></p>
                    <p>Status: <%# Eval("IsActive") %></p>
                </div>
            </ItemTemplate>
        </asp:Repeater>

    </div>
</asp:Content>
