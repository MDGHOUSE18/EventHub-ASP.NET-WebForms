﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Admin.Master" AutoEventWireup="true" CodeBehind="Reports.aspx.cs" Inherits="EventHub.Pages.Admin.Reports" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <div class="d-flex justify-content-between align-items-center mr-5 ml-5">
        <h2 class="text-center m-2">Manage Events Attendees</h2>
        <div Class="font-weight-bold">
            <asp:Label ID="eNameLabel" runat="server" Text="Total Attendees:" ></asp:Label>
            <asp:Literal ID="AttendeesCount" runat="server" ></asp:Literal> 
        </div>
    </div>
    <asp:GridView ID="AttendeesCountGrid" runat="server" AutoGenerateColumns="false"
        CssClass="table table-bordered table-striped table-hover text-center"
        AllowPaging="true" PageSize="5" OnPageIndexChanging="AttendeesCountGrid_PageIndexChanging">
        <Columns>
            <%-- Serial Number Column --%>
            <asp:TemplateField HeaderText="SNo">
                <ItemTemplate>
                    <%# Container.DataItemIndex + 1 %> <!-- Serial number based on the row index -->
                </ItemTemplate>
            </asp:TemplateField>
                    
            <asp:BoundField DataField="EventName" HeaderText="Event Name" />
            <asp:BoundField DataField="EventDate" HeaderText="Event Date" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"/>
            <asp:BoundField DataField="AttendeeCount" HeaderText="Attendee Count" />

        </Columns>
    </asp:GridView>
    <div class="d-flex justify-content-between align-items-center mr-5 ml-5">
        <h2 class="text-center m-2">Manage Events Attendees</h2>
    </div>
    <asp:GridView ID="AttendessGrid" runat="server" AutoGenerateColumns="false"
        CssClass="table table-bordered table-striped table-hover text-center"
        AllowPaging="true" PageSize="5" OnPageIndexChanging="AttendessGrid_PageIndexChanging">
        <Columns>
            <%-- Serial Number Column --%>
            <asp:TemplateField HeaderText="SNo">
                <ItemTemplate>
                    <%# Container.DataItemIndex + 1 %> <!-- Serial number based on the row index -->
                </ItemTemplate>
            </asp:TemplateField>
                        
            <asp:BoundField DataField="EventName" HeaderText="Event Name" />
            <asp:BoundField DataField="EventDate" HeaderText="Event Date" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"/>
            <asp:BoundField DataField="FullName" HeaderText="Attendee Name" />
            <asp:BoundField DataField="Email" HeaderText="UserEmail" />
            <asp:BoundField DataField="Role" HeaderText="Event Role" />

        </Columns>
    </asp:GridView>
</asp:Content>
