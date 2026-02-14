<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NPDStatusDashboard.aspx.cs" Inherits="NPDStatusX.NPDStatusDashboard" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>NPD Status Dashboard</title>
    <link href="NPDStatusDashboard.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <header>
                <h1>NPD Status Dashboard</h1>
                <p class="subtitle">New Product Development Tracking System</p>
            </header>

            <!-- Filter Section -->
            <div class="filter-section">
                <h2>Filters</h2>
                <div class="filter-row">
                    <div class="filter-group">
                        <label for="txtFromDate">From Date:</label>
                        <asp:TextBox ID="txtFromDate" runat="server" TextMode="Date" CssClass="filter-control"></asp:TextBox>
                    </div>
                    <div class="filter-group">
                        <label for="txtToDate">To Date:</label>
                        <asp:TextBox ID="txtToDate" runat="server" TextMode="Date" CssClass="filter-control"></asp:TextBox>
                    </div>
                    <div class="filter-group">
                        <label for="ddlCoordinator">Coordinator:</label>
                        <asp:DropDownList ID="ddlCoordinator" runat="server" CssClass="filter-control" AutoPostBack="false">
                            <asp:ListItem Text="-- All --" Value=""></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="filter-group">
                        <label for="ddlBrand">Brand:</label>
                        <asp:DropDownList ID="ddlBrand" runat="server" CssClass="filter-control" AutoPostBack="false">
                            <asp:ListItem Text="-- All --" Value=""></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="filter-group">
                        <label for="ddlCollection">Collection:</label>
                        <asp:DropDownList ID="ddlCollection" runat="server" CssClass="filter-control" AutoPostBack="false">
                            <asp:ListItem Text="-- All --" Value=""></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="button-row">
                    <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-primary" OnClick="btnSearch_Click" />
                    <asp:Button ID="btnReset" runat="server" Text="Reset" CssClass="btn btn-secondary" OnClick="btnReset_Click" />
                </div>
            </div>

            <!-- Dashboard Summary Cards -->
            <div class="dashboard-cards">
                <div class="card">
                    <div class="card-header">Total Projects</div>
                    <div class="card-body">
                        <asp:Label ID="lblTotalProjects" runat="server" CssClass="card-value" Text="0"></asp:Label>
                    </div>
                </div>
                <div class="card card-success">
                    <div class="card-header">Active Projects</div>
                    <div class="card-body">
                        <asp:Label ID="lblActiveProjects" runat="server" CssClass="card-value" Text="0"></asp:Label>
                    </div>
                </div>
                <div class="card card-info">
                    <div class="card-header">Completed Projects</div>
                    <div class="card-body">
                        <asp:Label ID="lblCompletedProjects" runat="server" CssClass="card-value" Text="0"></asp:Label>
                    </div>
                </div>
                <div class="card card-warning">
                    <div class="card-header">Pending Projects</div>
                    <div class="card-body">
                        <asp:Label ID="lblPendingProjects" runat="server" CssClass="card-value" Text="0"></asp:Label>
                    </div>
                </div>
            </div>

            <!-- Status Message -->
            <asp:Panel ID="pnlMessage" runat="server" Visible="false" CssClass="message-panel">
                <asp:Label ID="lblMessage" runat="server"></asp:Label>
            </asp:Panel>

            <!-- Report Section -->
            <div class="report-section">
                <h2>NPD Project Status Report</h2>
                <asp:GridView ID="gvNPDStatus" runat="server" 
                    CssClass="grid-view" 
                    AutoGenerateColumns="False"
                    AllowPaging="True" 
                    PageSize="25"
                    AllowSorting="True"
                    OnPageIndexChanging="gvNPDStatus_PageIndexChanging"
                    OnSorting="gvNPDStatus_Sorting"
                    EmptyDataText="No records found matching the search criteria.">
                    <Columns>
                        <asp:BoundField DataField="PROJECT_ID" HeaderText="Project ID" SortExpression="PROJECT_ID" />
                        <asp:BoundField DataField="PROJECT_NAME" HeaderText="Project Name" SortExpression="PROJECT_NAME" />
                        <asp:BoundField DataField="BRAND" HeaderText="Brand" SortExpression="BRAND" />
                        <asp:BoundField DataField="COLLECTION" HeaderText="Collection" SortExpression="COLLECTION" />
                        <asp:BoundField DataField="COORDINATOR" HeaderText="Coordinator" SortExpression="COORDINATOR" />
                        <asp:BoundField DataField="STATUS" HeaderText="Status" SortExpression="STATUS" />
                        <asp:BoundField DataField="START_DATE" HeaderText="Start Date" SortExpression="START_DATE" DataFormatString="{0:MM/dd/yyyy}" />
                        <asp:BoundField DataField="TARGET_DATE" HeaderText="Target Date" SortExpression="TARGET_DATE" DataFormatString="{0:MM/dd/yyyy}" />
                        <asp:BoundField DataField="COMPLETION_DATE" HeaderText="Completion Date" SortExpression="COMPLETION_DATE" DataFormatString="{0:MM/dd/yyyy}" />
                        <asp:BoundField DataField="PROGRESS_PCT" HeaderText="Progress %" SortExpression="PROGRESS_PCT" DataFormatString="{0:F0}%" />
                        <asp:BoundField DataField="PRIORITY" HeaderText="Priority" SortExpression="PRIORITY" />
                        <asp:BoundField DataField="LAST_UPDATE" HeaderText="Last Updated" SortExpression="LAST_UPDATE" DataFormatString="{0:MM/dd/yyyy HH:mm}" />
                    </Columns>
                    <HeaderStyle CssClass="grid-header" />
                    <RowStyle CssClass="grid-row" />
                    <AlternatingRowStyle CssClass="grid-row-alt" />
                    <PagerStyle CssClass="grid-pager" />
                    <PagerSettings Mode="NumericFirstLast" FirstPageText="First" LastPageText="Last" PageButtonCount="10" />
                </asp:GridView>
            </div>

            <!-- Additional Report - Repeater for Summary by Brand -->
            <div class="report-section">
                <h2>Summary by Brand</h2>
                <asp:Repeater ID="rptBrandSummary" runat="server">
                    <HeaderTemplate>
                        <table class="grid-view">
                            <thead>
                                <tr class="grid-header">
                                    <th>Brand</th>
                                    <th>Total Projects</th>
                                    <th>Active</th>
                                    <th>Completed</th>
                                    <th>Pending</th>
                                    <th>Average Progress</th>
                                </tr>
                            </thead>
                            <tbody>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr class="grid-row">
                            <td><%# Eval("BRAND") %></td>
                            <td><%# Eval("TOTAL_PROJECTS") %></td>
                            <td><%# Eval("ACTIVE_COUNT") %></td>
                            <td><%# Eval("COMPLETED_COUNT") %></td>
                            <td><%# Eval("PENDING_COUNT") %></td>
                            <td><%# String.Format("{0:F1}%", Eval("AVG_PROGRESS")) %></td>
                        </tr>
                    </ItemTemplate>
                    <AlternatingItemTemplate>
                        <tr class="grid-row-alt">
                            <td><%# Eval("BRAND") %></td>
                            <td><%# Eval("TOTAL_PROJECTS") %></td>
                            <td><%# Eval("ACTIVE_COUNT") %></td>
                            <td><%# Eval("COMPLETED_COUNT") %></td>
                            <td><%# Eval("PENDING_COUNT") %></td>
                            <td><%# String.Format("{0:F1}%", Eval("AVG_PROGRESS")) %></td>
                        </tr>
                    </AlternatingItemTemplate>
                    <FooterTemplate>
                            </tbody>
                        </table>
                    </FooterTemplate>
                </asp:Repeater>
            </div>

            <footer>
                <p>&copy; 2026 NPD Status Dashboard. All rights reserved.</p>
            </footer>
        </div>
    </form>
</body>
</html>
