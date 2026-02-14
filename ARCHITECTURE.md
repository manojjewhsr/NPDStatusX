# NPD Status Dashboard - Architecture Diagram

```
┌─────────────────────────────────────────────────────────────────┐
│                    NPD STATUS DASHBOARD                         │
│              ASP.NET Web Forms Application                      │
└─────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────┐
│                   PRESENTATION LAYER                            │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  NPDStatusDashboard.aspx (172 lines)                           │
│  ┌────────────────────────────────────────────────────────┐   │
│  │  ┌─────────────────────────────────────────────────┐   │   │
│  │  │         HEADER & TITLE                          │   │   │
│  │  │  "NPD Status Dashboard"                         │   │   │
│  │  └─────────────────────────────────────────────────┘   │   │
│  │                                                         │   │
│  │  ┌─────────────────────────────────────────────────┐   │   │
│  │  │         FILTER SECTION                          │   │   │
│  │  │  • Date Range (From/To)                         │   │   │
│  │  │  • Coordinator DropDown                         │   │   │
│  │  │  • Brand DropDown                               │   │   │
│  │  │  • Collection DropDown                          │   │   │
│  │  │  • [Search] [Reset] Buttons                     │   │   │
│  │  └─────────────────────────────────────────────────┘   │   │
│  │                                                         │   │
│  │  ┌──────┐  ┌──────┐  ┌──────┐  ┌──────┐             │   │
│  │  │Total │  │Active│  │Complt│  │Pndng│             │   │
│  │  │ 125  │  │  45  │  │  60  │  │  20  │             │   │
│  │  └──────┘  └──────┘  └──────┘  └──────┘             │   │
│  │  DASHBOARD SUMMARY CARDS                               │   │
│  │                                                         │   │
│  │  ┌─────────────────────────────────────────────────┐   │   │
│  │  │      MAIN REPORT - GridView                     │   │   │
│  │  │  ┌────┬─────┬──────┬───────┬──────┬───────┐     │   │   │
│  │  │  │ID  │Name │Brand │Colctn │Coord │Status │...  │   │   │
│  │  │  ├────┼─────┼──────┼───────┼──────┼───────┤     │   │   │
│  │  │  │001 │Proj1│BrandA│ Spring│ John │Active │     │   │   │
│  │  │  │002 │Proj2│BrandB│ Summer│Sarah │Active │     │   │   │
│  │  │  │... │ ... │ ...  │  ...  │ ...  │  ...  │     │   │   │
│  │  │  └────┴─────┴──────┴───────┴──────┴───────┘     │   │   │
│  │  │  [< 1 2 3 4 5 >] Pagination                      │   │   │
│  │  └─────────────────────────────────────────────────┘   │   │
│  │                                                         │   │
│  │  ┌─────────────────────────────────────────────────┐   │   │
│  │  │     BRAND SUMMARY - Repeater                    │   │   │
│  │  │  ┌──────┬──────┬──────┬──────┬──────┬─────┐     │   │   │
│  │  │  │Brand │Total │Active│Complt│Pndng │Avg% │     │   │   │
│  │  │  ├──────┼──────┼──────┼──────┼──────┼─────┤     │   │   │
│  │  │  │BrandA│  25  │  10  │  12  │  3   │65.5%│     │   │   │
│  │  │  │BrandB│  30  │  15  │  10  │  5   │55.2%│     │   │   │
│  │  │  │...   │ ... │ ...  │ ...  │ ...  │ ... │     │   │   │
│  │  │  └──────┴──────┴──────┴──────┴──────┴─────┘     │   │   │
│  │  └─────────────────────────────────────────────────┘   │   │
│  └────────────────────────────────────────────────────────┘   │
│                                                                 │
│  NPDStatusDashboard.css (376 lines)                            │
│  • Responsive Design (Desktop/Tablet/Mobile)                   │
│  • Modern Card-based Layout                                    │
│  • Gradient Backgrounds & Hover Effects                        │
└─────────────────────────────────────────────────────────────────┘
                              ▲
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                    BUSINESS LOGIC LAYER                         │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  NPDStatusDashboard.aspx.cs (327 lines)                        │
│  ┌────────────────────────────────────────────────────────┐   │
│  │  Page Events:                                           │   │
│  │  • Page_Load() → InitializePage() → LoadData()        │   │
│  │  • btnSearch_Click() → Validate → LoadData()          │   │
│  │  • btnReset_Click() → Reset Filters → LoadData()      │   │
│  │  • gvNPDStatus_PageIndexChanging() → LoadData()       │   │
│  │  • gvNPDStatus_Sorting() → Toggle Sort → LoadData()   │   │
│  │                                                         │   │
│  │  Data Loading:                                          │   │
│  │  • LoadCoordinators() → Populate Dropdown              │   │
│  │  • LoadBrands() → Populate Dropdown                    │   │
│  │  • LoadCollections() → Populate Dropdown               │   │
│  │  • LoadSummaryCards() → Update 4 Dashboard Cards       │   │
│  │  • LoadProjectGrid() → Bind GridView with Sorting      │   │
│  │  • LoadBrandSummary() → Bind Repeater                  │   │
│  │                                                         │   │
│  │  State Management:                                      │   │
│  │  • ViewState["SortExpression"] → Current sort column   │   │
│  │  • ViewState["SortDirection"] → ASC or DESC            │   │
│  │                                                         │   │
│  │  Validation:                                            │   │
│  │  • Date Range: From Date <= To Date                    │   │
│  │  • Error Handling: Try-Catch with ShowMessage()        │   │
│  └────────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────────┘
                              ▲
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                    DATA ACCESS LAYER                            │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  NPDDataAccess.cs (284 lines)                                  │
│  ┌────────────────────────────────────────────────────────┐   │
│  │  Data Retrieval Methods:                                │   │
│  │  ┌────────────────────────────────────────────────┐    │   │
│  │  │ GetCoordinators()                              │    │   │
│  │  │ → SELECT DISTINCT COORDINATOR                  │    │   │
│  │  │ → Returns: DataTable                           │    │   │
│  │  └────────────────────────────────────────────────┘    │   │
│  │  ┌────────────────────────────────────────────────┐    │   │
│  │  │ GetBrands()                                    │    │   │
│  │  │ → SELECT DISTINCT BRAND                        │    │   │
│  │  │ → Returns: DataTable                           │    │   │
│  │  └────────────────────────────────────────────────┘    │   │
│  │  ┌────────────────────────────────────────────────┐    │   │
│  │  │ GetCollections()                               │    │   │
│  │  │ → SELECT DISTINCT COLLECTION                   │    │   │
│  │  │ → Returns: DataTable                           │    │   │
│  │  └────────────────────────────────────────────────┘    │   │
│  │  ┌────────────────────────────────────────────────┐    │   │
│  │  │ GetProjectSummary(filters...)                  │    │   │
│  │  │ → SELECT COUNT(*) GROUP BY STATUS              │    │   │
│  │  │ → Returns: Total, Active, Completed, Pending   │    │   │
│  │  └────────────────────────────────────────────────┘    │   │
│  │  ┌────────────────────────────────────────────────┐    │   │
│  │  │ GetNPDProjects(filters, sort, direction)       │    │   │
│  │  │ → SELECT * FROM NPD_PROJECTS                   │    │   │
│  │  │ → WHERE date/coord/brand/collection filters    │    │   │
│  │  │ → ORDER BY {sortExpression} {sortDirection}    │    │   │
│  │  │ → Returns: DataTable with all project details  │    │   │
│  │  └────────────────────────────────────────────────┘    │   │
│  │  ┌────────────────────────────────────────────────┐    │   │
│  │  │ GetBrandSummary(filters...)                    │    │   │
│  │  │ → SELECT brand, counts, AVG(progress)          │    │   │
│  │  │ → GROUP BY BRAND                               │    │   │
│  │  │ → Returns: DataTable with brand statistics     │    │   │
│  │  └────────────────────────────────────────────────┘    │   │
│  │                                                         │   │
│  │  Security Features:                                     │   │
│  │  • BuildFilterParameters() → OracleParameter[]         │   │
│  │  • ExecuteQuery() → using statements                   │   │
│  │  • No string concatenation in SQL                      │   │
│  │  • Connection from Web.config                          │   │
│  └────────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────────┘
                              ▲
                              │
                   ODP.NET (Oracle.ManagedDataAccess)
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                      DATABASE LAYER                             │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  Oracle Database 11g+                                           │
│  ┌────────────────────────────────────────────────────────┐   │
│  │  NPD_PROJECTS Table                                     │   │
│  │  ┌──────────────────────────────────────────────────┐  │   │
│  │  │ PROJECT_ID (PK) - VARCHAR2(50)                   │  │   │
│  │  │ PROJECT_NAME - VARCHAR2(200)                     │  │   │
│  │  │ BRAND - VARCHAR2(100) [Indexed]                  │  │   │
│  │  │ COLLECTION - VARCHAR2(100) [Indexed]             │  │   │
│  │  │ COORDINATOR - VARCHAR2(100) [Indexed]            │  │   │
│  │  │ STATUS - VARCHAR2(50) [Indexed]                  │  │   │
│  │  │ START_DATE - DATE [Indexed]                      │  │   │
│  │  │ TARGET_DATE - DATE                               │  │   │
│  │  │ COMPLETION_DATE - DATE                           │  │   │
│  │  │ PROGRESS_PCT - NUMBER(5,2)                       │  │   │
│  │  │ PRIORITY - VARCHAR2(20)                          │  │   │
│  │  │ DESCRIPTION - CLOB                               │  │   │
│  │  │ CREATED_BY - VARCHAR2(100)                       │  │   │
│  │  │ CREATED_DATE - DATE                              │  │   │
│  │  │ MODIFIED_BY - VARCHAR2(100)                      │  │   │
│  │  │ MODIFIED_DATE - DATE                             │  │   │
│  │  │ LAST_UPDATE - DATE [Auto-updated by trigger]     │  │   │
│  │  └──────────────────────────────────────────────────┘  │   │
│  │                                                         │   │
│  │  Indexes:                                               │   │
│  │  • IDX_NPD_STATUS                                       │   │
│  │  • IDX_NPD_BRAND                                        │   │
│  │  • IDX_NPD_COORDINATOR                                  │   │
│  │  • IDX_NPD_START_DATE                                   │   │
│  │  • IDX_NPD_COLLECTION                                   │   │
│  │                                                         │   │
│  │  Triggers:                                              │   │
│  │  • TRG_NPD_PROJECTS_UPDATE                              │   │
│  │    → Auto-updates LAST_UPDATE and MODIFIED_DATE         │   │
│  │                                                         │   │
│  │  Sample Data: 10 projects                               │   │
│  │  • 3 Active, 2 Completed, 5 Pending                     │   │
│  │  • 4 Brands, 3 Coordinators, Various collections        │   │
│  └────────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────┐
│                    CONFIGURATION                                │
├─────────────────────────────────────────────────────────────────┤
│  Web.config                                                     │
│  • Connection String: OracleConnection                          │
│  • App Settings: ApplicationName, DefaultPageSize              │
│  • Compilation: .NET Framework 4.7.2                           │
│                                                                 │
│  packages.config                                                │
│  • Oracle.ManagedDataAccess 23.5.1                             │
└─────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────┐
│                    DATA FLOW                                    │
├─────────────────────────────────────────────────────────────────┤
│  User Action → Event Handler → DAL Method → Oracle Query       │
│                                                                 │
│  Example: Search Button Click                                   │
│  ┌─────────────────────────────────────────────────────────┐  │
│  │ 1. User clicks [Search]                                 │  │
│  │ 2. btnSearch_Click() validates date range               │  │
│  │ 3. LoadData() calls multiple DAL methods:               │  │
│  │    • LoadSummaryCards()                                 │  │
│  │      → dal.GetProjectSummary(filters)                   │  │
│  │      → SELECT COUNT(*) with filters                     │  │
│  │      → Updates 4 dashboard cards                        │  │
│  │    • LoadProjectGrid()                                  │  │
│  │      → dal.GetNPDProjects(filters, sort, direction)     │  │
│  │      → SELECT * with filters + ORDER BY                 │  │
│  │      → Binds GridView with results                      │  │
│  │    • LoadBrandSummary()                                 │  │
│  │      → dal.GetBrandSummary(filters)                     │  │
│  │      → SELECT with GROUP BY BRAND                       │  │
│  │      → Binds Repeater with results                      │  │
│  │ 4. ShowMessage() displays "Search completed"            │  │
│  └─────────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────┐
│                    SECURITY                                     │
├─────────────────────────────────────────────────────────────────┤
│  SQL Injection Prevention:                                      │
│  • All queries use OracleParameter                             │
│  • No string concatenation in SQL                              │
│  • Example: new OracleParameter("Brand", value)                │
│                                                                 │
│  Connection Security:                                           │
│  • Connection string in Web.config (can be encrypted)          │
│  • Connection pooling enabled                                  │
│  • Proper disposal with using statements                       │
│                                                                 │
│  ViewState:                                                     │
│  • Protected by default                                        │
│  • Can enable encryption in Web.config                         │
│                                                                 │
│  Input Validation:                                             │
│  • Server-side date range validation                           │
│  • Try-catch error handling                                    │
└─────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────┐
│                    DEPLOYMENT                                   │
├─────────────────────────────────────────────────────────────────┤
│  Development:                                                   │
│  • Visual Studio → F5                                          │
│  • IIS Express (automatic)                                     │
│                                                                 │
│  Production:                                                    │
│  • IIS Server                                                  │
│  • Application Pool: .NET Framework v4.0                       │
│  • HTTPS recommended                                           │
│  • Connection string encryption recommended                    │
└─────────────────────────────────────────────────────────────────┘
```

## Architecture Highlights

### Three-Tier Architecture
1. **Presentation Layer** (ASPX/CSS) - User interface
2. **Business Logic Layer** (ASPX.CS) - Event handlers and logic
3. **Data Access Layer** (NPDDataAccess.cs) - Database operations

### Key Design Patterns
- **Repository Pattern**: NPDDataAccess class encapsulates data access
- **Parameterized Queries**: All SQL uses OracleParameter
- **Connection Management**: Using statements for proper disposal
- **ViewState**: Maintains sort state across postbacks
- **Event-Driven**: ASP.NET Web Forms event model

### Performance Optimizations
- Database indexes on filtered columns
- Connection pooling (automatic with ODP.NET)
- Pagination (25 records per page)
- Minimal ViewState usage

### Security Features
- SQL injection prevention (parameterized queries)
- Connection string in configuration
- Server-side validation
- Error handling with try-catch
- ViewState protection

---

**Total Solution**: 3,251+ lines of code + 1,946 lines of documentation = 5,197+ lines
