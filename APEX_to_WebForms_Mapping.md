# APEX to ASP.NET Web Forms Mapping Documentation

## Overview
This document provides a comprehensive mapping between Oracle APEX page components and their equivalent ASP.NET Web Forms controls implemented in the NPD Status Dashboard.

## Page Information
- **APEX Application**: NPD Status Dashboard
- **ASP.NET Page**: NPDStatusDashboard.aspx / NPDStatusDashboard.aspx.cs
- **Framework**: ASP.NET Web Forms with C#
- **Data Access**: Oracle Data Provider for .NET (ODP.NET)

---

## Control Mappings

### 1. Filter Section Components

#### Date Range Filters

| APEX Item | APEX Item Type | Web Forms Control | Control Type | Properties |
|-----------|----------------|-------------------|--------------|------------|
| P1_FROM_DATE | Date Picker | txtFromDate | TextBox | TextMode="Date" |
| P1_TO_DATE | Date Picker | txtToDate | TextBox | TextMode="Date" |

**Date Logic Preservation:**
- Default From Date: First day of current month
- Default To Date: Current date
- Validation: From Date <= To Date
- Date format: yyyy-MM-dd (HTML5 date input)
- Server-side parsing: DateTime.Parse()

#### Dropdown Filters

| APEX Item | APEX Item Type | Web Forms Control | Control Type | Data Source |
|-----------|----------------|-------------------|--------------|-------------|
| P1_COORDINATOR | Select List | ddlCoordinator | DropDownList | NPDDataAccess.GetCoordinators() |
| P1_BRAND | Select List | ddlBrand | DropDownList | NPDDataAccess.GetBrands() |
| P1_COLLECTION | Select List | ddlCollection | DropDownList | NPDDataAccess.GetCollections() |

**Dropdown Properties:**
- All dropdowns include "-- All --" option with empty value
- AutoPostBack set to false (manual search trigger)
- Data bound on Page_Load (IsPostBack check)
- Sorted alphabetically

---

### 2. Action Buttons

| APEX Button | Web Forms Control | Event Handler | Description |
|-------------|-------------------|---------------|-------------|
| SEARCH | btnSearch | btnSearch_Click | Executes search with current filter values |
| RESET | btnReset | btnReset_Click | Resets all filters to default values |

**Event Handler Details:**

**btnSearch_Click:**
- Validates date range
- Resets grid to page 1
- Resets sort to PROJECT_ID ASC
- Calls LoadData() with filter parameters
- Displays success/error message

**btnReset_Click:**
- Resets date range to current month
- Clears all dropdown selections
- Resets grid pagination and sorting
- Reloads data with default filters
- Displays confirmation message

---

### 3. Dashboard Summary Cards

| APEX Region | Display Item | Web Forms Control | Control Type | Data Source |
|-------------|--------------|-------------------|--------------|-------------|
| Total Projects | Total_Projects_Display | lblTotalProjects | Label | GetProjectSummary().TOTAL_PROJECTS |
| Active Projects | Active_Projects_Display | lblActiveProjects | Label | GetProjectSummary().ACTIVE_PROJECTS |
| Completed Projects | Completed_Projects_Display | lblCompletedProjects | Label | GetProjectSummary().COMPLETED_PROJECTS |
| Pending Projects | Pending_Projects_Display | lblPendingProjects | Label | GetProjectSummary().PENDING_PROJECTS |

**SQL Query Mapping:**
```sql
-- APEX Query
SELECT 
    COUNT(*) AS TOTAL_PROJECTS,
    SUM(CASE WHEN STATUS = 'Active' THEN 1 ELSE 0 END) AS ACTIVE_PROJECTS,
    SUM(CASE WHEN STATUS = 'Completed' THEN 1 ELSE 0 END) AS COMPLETED_PROJECTS,
    SUM(CASE WHEN STATUS = 'Pending' THEN 1 ELSE 0 END) AS PENDING_PROJECTS
FROM NPD_PROJECTS
WHERE ... [filter conditions]
```

**Web Forms Implementation:**
- Method: NPDDataAccess.GetProjectSummary()
- Parameterized with filter values
- Returns DataTable with aggregated counts
- Labels updated in LoadSummaryCards()

---

### 4. Main Report (Interactive Report → GridView)

| APEX Component | Web Forms Control | Properties |
|----------------|-------------------|------------|
| Interactive Report | gvNPDStatus | GridView with custom columns |

**Column Mappings:**

| APEX Column | GridView Column | Data Type | Format | Sort Enabled |
|-------------|-----------------|-----------|--------|--------------|
| PROJECT_ID | PROJECT_ID | BoundField | N/A | Yes |
| PROJECT_NAME | PROJECT_NAME | BoundField | N/A | Yes |
| BRAND | BRAND | BoundField | N/A | Yes |
| COLLECTION | COLLECTION | BoundField | N/A | Yes |
| COORDINATOR | COORDINATOR | BoundField | N/A | Yes |
| STATUS | STATUS | BoundField | N/A | Yes |
| START_DATE | START_DATE | BoundField | {0:MM/dd/yyyy} | Yes |
| TARGET_DATE | TARGET_DATE | BoundField | {0:MM/dd/yyyy} | Yes |
| COMPLETION_DATE | COMPLETION_DATE | BoundField | {0:MM/dd/yyyy} | Yes |
| PROGRESS_PCT | PROGRESS_PCT | BoundField | {0:F0}% | Yes |
| PRIORITY | PRIORITY | BoundField | N/A | Yes |
| LAST_UPDATE | LAST_UPDATE | BoundField | {0:MM/dd/yyyy HH:mm} | Yes |

**Pagination Settings:**
- APEX Rows Per Page: 25 → GridView PageSize: 25
- APEX Pagination Type: Row Range → PagerSettings Mode: NumericFirstLast
- Event: OnPageIndexChanging → gvNPDStatus_PageIndexChanging

**Sorting:**
- APEX Interactive Report Sorting → GridView AllowSorting: True
- Event: OnSorting → gvNPDStatus_Sorting
- Sort state stored in ViewState["SortExpression"] and ViewState["SortDirection"]
- Toggle between ASC/DESC on same column click

**SQL Query:**
```sql
-- Base query with filters and dynamic sorting
SELECT 
    PROJECT_ID, PROJECT_NAME, BRAND, COLLECTION, COORDINATOR,
    STATUS, START_DATE, TARGET_DATE, COMPLETION_DATE, 
    PROGRESS_PCT, PRIORITY, LAST_UPDATE
FROM NPD_PROJECTS
WHERE 1=1
    [AND START_DATE >= :FromDate]
    [AND START_DATE <= :ToDate]
    [AND COORDINATOR = :Coordinator]
    [AND BRAND = :Brand]
    [AND COLLECTION = :Collection]
ORDER BY {SortExpression} {SortDirection}
```

---

### 5. Brand Summary Report (Classic Report → Repeater)

| APEX Component | Web Forms Control | Properties |
|----------------|-------------------|------------|
| Classic Report | rptBrandSummary | Repeater with custom template |

**Column Mappings:**

| APEX Column | Repeater Output | Format |
|-------------|-----------------|--------|
| BRAND | <%# Eval("BRAND") %> | String |
| TOTAL_PROJECTS | <%# Eval("TOTAL_PROJECTS") %> | Integer |
| ACTIVE_COUNT | <%# Eval("ACTIVE_COUNT") %> | Integer |
| COMPLETED_COUNT | <%# Eval("COMPLETED_COUNT") %> | Integer |
| PENDING_COUNT | <%# Eval("PENDING_COUNT") %> | Integer |
| AVG_PROGRESS | <%# String.Format("{0:F1}%", Eval("AVG_PROGRESS")) %> | Decimal (1 place) |

**SQL Query:**
```sql
SELECT 
    BRAND,
    COUNT(*) AS TOTAL_PROJECTS,
    SUM(CASE WHEN STATUS = 'Active' THEN 1 ELSE 0 END) AS ACTIVE_COUNT,
    SUM(CASE WHEN STATUS = 'Completed' THEN 1 ELSE 0 END) AS COMPLETED_COUNT,
    SUM(CASE WHEN STATUS = 'Pending' THEN 1 ELSE 0 END) AS PENDING_COUNT,
    ROUND(AVG(PROGRESS_PCT), 1) AS AVG_PROGRESS
FROM NPD_PROJECTS
WHERE ... [filter conditions]
GROUP BY BRAND
ORDER BY BRAND
```

---

## Data Access Layer (DAL) Architecture

### Class: NPDDataAccess

| Method | Purpose | APEX Equivalent | Parameters | Returns |
|--------|---------|-----------------|------------|---------|
| GetCoordinators() | Load coordinator list | APEX LOV Query | None | DataTable |
| GetBrands() | Load brand list | APEX LOV Query | None | DataTable |
| GetCollections() | Load collection list | APEX LOV Query | None | DataTable |
| GetProjectSummary() | Dashboard cards data | APEX Region Query | Filters | DataTable |
| GetNPDProjects() | Main report data | Interactive Report Query | Filters, Sort | DataTable |
| GetBrandSummary() | Brand summary report | Classic Report Query | Filters | DataTable |

### Parameterized Query Implementation

All queries use ODP.NET parameterized queries to prevent SQL injection:

```csharp
// Example parameter creation
OracleParameter[] parameters = new OracleParameter[]
{
    new OracleParameter("FromDate", OracleDbType.Date) { Value = fromDate },
    new OracleParameter("ToDate", OracleDbType.Date) { Value = toDate },
    new OracleParameter("Coordinator", OracleDbType.Varchar2) { Value = coordinator },
    new OracleParameter("Brand", OracleDbType.Varchar2) { Value = brand },
    new OracleParameter("Collection", OracleDbType.Varchar2) { Value = collection }
};
```

**Parameter Types:**
- Date fields: OracleDbType.Date
- String fields: OracleDbType.Varchar2
- Numeric fields: OracleDbType.Int32 / OracleDbType.Decimal

---

## Page Lifecycle Comparison

### APEX Page Lifecycle
1. Before Header
2. After Header
3. Before Regions
4. Region Rendering
5. After Regions
6. Page Processing

### ASP.NET Web Forms Page Lifecycle
1. PreInit
2. Init
3. LoadViewState
4. Load (Page_Load) → InitializePage() / LoadData()
5. Control Events (btnSearch_Click, btnReset_Click)
6. PreRender
7. Render
8. Unload

**Key Differences:**
- APEX uses regions; Web Forms uses server controls
- APEX auto-generates SQL; Web Forms requires explicit DAL calls
- APEX manages state in session; Web Forms uses ViewState
- APEX processes on submit; Web Forms uses event-driven model

---

## Session State Management

| APEX Item | Scope | Web Forms Equivalent | Storage |
|-----------|-------|---------------------|----------|
| Page Items (P1_*) | Page | Control.Text / SelectedValue | ViewState |
| Application Items | Application | Application["key"] | Application State |
| Session State | Session | Session["key"] | Session State |
| Sort State | Session | ViewState["SortExpression"] | ViewState |

---

## Validation Rules

### Date Range Validation

**APEX Validation:**
```
P1_FROM_DATE <= P1_TO_DATE
Error Message: "From Date cannot be greater than To Date"
```

**Web Forms Implementation:**
```csharp
if (fromDate > toDate)
{
    ShowMessage("From Date cannot be greater than To Date.", "error");
    return;
}
```

### Required Field Validation
- APEX: Handled by item settings (Required: Yes/No)
- Web Forms: Implemented with server-side validation in event handlers

---

## CSS Class Mappings

| APEX Theme Class | Web Forms CSS Class | Purpose |
|------------------|---------------------|---------|
| t-Region | .filter-section, .report-section | Container styling |
| t-Region-title | h2 | Section headers |
| t-Button--hot | .btn-primary | Primary action button |
| t-Button | .btn-secondary | Secondary button |
| t-Report-report | .grid-view | Report table |
| t-Report-cell | td | Table cells |
| t-Alert | .message-panel | Message display |

---

## Security Considerations

### APEX Built-in Security
- Session management
- Page access control
- Authorization schemes

### Web Forms Implementation
- Parameterized queries (SQL injection prevention)
- ViewState encryption (set in Web.config)
- Request validation enabled
- Authentication/Authorization via ASP.NET membership (not implemented in base version)

**Recommended Additions:**
```xml
<system.web>
    <pages enableViewStateMac="true" viewStateEncryptionMode="Always" />
    <authentication mode="Forms">
        <forms loginUrl="~/Login.aspx" timeout="30" />
    </authentication>
</system.web>
```

---

## Configuration Files

### APEX
- Application Definition Export (.sql file)
- Supporting Objects

### Web Forms
- **Web.config**: Connection strings, app settings, system configuration
- **Global.asax**: Application-level events (optional)

**Connection String:**
```xml
<connectionStrings>
    <add name="OracleConnection" 
         connectionString="Data Source=...;User Id=...;Password=..." 
         providerName="Oracle.ManagedDataAccess.Client" />
</connectionStrings>
```

---

## Deployment Differences

### APEX Deployment
1. Import application SQL file
2. Run supporting objects script
3. Configure application settings
4. Assign schemas

### Web Forms Deployment
1. Compile project to DLL
2. Deploy files to IIS:
   - .aspx pages
   - Compiled assemblies (bin/)
   - Web.config
   - CSS files
3. Configure IIS application pool
4. Set connection string
5. Test connectivity

---

## Performance Optimizations

### APEX
- Caching regions
- Lazy loading
- APEX session state

### Web Forms
- ViewState management (disabled where not needed)
- Output caching (page level)
- Data caching (Application state)
- Connection pooling (automatic with ODP.NET)

```csharp
// Example caching implementation
[OutputCache(Duration=60, VaryByParam="none")]
```

---

## Testing Checklist

- [ ] All filters work independently
- [ ] Date range validation works correctly
- [ ] Search button applies filters
- [ ] Reset button clears all filters
- [ ] Dashboard cards show correct counts
- [ ] GridView displays data correctly
- [ ] Pagination works (Previous/Next/Page numbers)
- [ ] Sorting works (ASC/DESC toggle)
- [ ] Repeater shows brand summary
- [ ] Empty state handled gracefully
- [ ] Error messages display correctly
- [ ] SQL injection prevention verified
- [ ] Date formatting matches requirements
- [ ] Performance acceptable with large datasets

---

## Known Limitations & Differences

1. **Interactive Report Features**: APEX Interactive Reports have built-in features (filtering, highlighting, computations) not replicated in basic GridView. Consider using third-party grid controls for advanced features.

2. **Dynamic Actions**: APEX Dynamic Actions require manual JavaScript implementation in Web Forms.

3. **Built-in Search**: APEX has built-in search bar; Web Forms requires custom implementation.

4. **Export Features**: APEX provides built-in CSV/PDF export; Web Forms requires manual implementation or third-party libraries.

5. **Chart Integration**: APEX has built-in charting; Web Forms requires chart controls (e.g., Chart.js, Microsoft Chart Controls).

---

## Future Enhancements

1. Add authentication and authorization
2. Implement role-based access control
3. Add export to Excel/PDF functionality
4. Add inline editing capabilities
5. Implement real-time notifications
6. Add dashboard charts/graphs
7. Mobile responsive improvements
8. Add audit logging
9. Implement advanced search with wildcards
10. Add batch operations

---

## Support and Maintenance

### Code Comments
All methods include XML documentation comments for IntelliSense support.

### Error Handling
- Try-catch blocks in all data access methods
- User-friendly error messages
- Detailed exception logging (implement logging framework)

### Code Organization
```
NPDStatusX/
├── NPDStatusDashboard.aspx       # Presentation layer
├── NPDStatusDashboard.aspx.cs    # Code-behind (business logic)
├── NPDDataAccess.cs              # Data access layer
├── NPDStatusDashboard.css        # Styling
├── Web.config                     # Configuration
└── DatabaseSchema.sql            # Database setup
```

---

## Conclusion

This mapping document provides a complete reference for understanding the conversion from Oracle APEX to ASP.NET Web Forms. All queries, date logic, pagination, and filtering functionality have been preserved and properly implemented using ODP.NET with parameterized SQL to ensure security and maintainability.
