# NPD Status Dashboard - ASP.NET Web Forms

## Overview
NPD (New Product Development) Status Dashboard is a comprehensive web application for tracking and managing new product development projects. This application has been converted from Oracle APEX to ASP.NET Web Forms with C#.

## Features

### 1. **Advanced Filtering**
- Date range filter (From/To dates with validation)
- Coordinator dropdown filter
- Brand dropdown filter
- Collection dropdown filter
- Search and Reset functionality

### 2. **Dashboard Summary Cards**
- Total Projects count
- Active Projects count
- Completed Projects count
- Pending Projects count
- Real-time updates based on applied filters

### 3. **Main Report Grid**
- Displays all NPD projects with detailed information
- Pagination support (25 records per page)
- Sortable columns (ascending/descending)
- Responsive data display

### 4. **Brand Summary Report**
- Aggregated statistics by brand
- Shows project counts by status
- Average progress calculation

## Technology Stack

- **Framework**: ASP.NET Web Forms 4.7.2
- **Language**: C# 
- **Database**: Oracle Database
- **Data Access**: Oracle Data Provider for .NET (ODP.NET Managed Driver)
- **Frontend**: HTML5, CSS3
- **Architecture**: Three-tier (Presentation, Business Logic, Data Access)

## Project Structure

```
NPDStatusX/
├── NPDStatusDashboard.aspx           # Main page markup
├── NPDStatusDashboard.aspx.cs        # Code-behind file
├── NPDDataAccess.cs                  # Data Access Layer
├── NPDStatusDashboard.css            # Stylesheet
├── Web.config                        # Configuration file
├── DatabaseSchema.sql                # Database schema and sample data
├── APEX_to_WebForms_Mapping.md       # Detailed mapping documentation
├── REBUILD.md                        # Rebuild and build instructions
├── rebuild.ps1                       # PowerShell rebuild script
├── rebuild.sh                        # Bash rebuild script
├── rebuild.bat                       # Batch rebuild script
├── Makefile                          # Make-based build automation
└── README.md                         # This file
```

## Prerequisites

1. **Development Environment**
   - Visual Studio 2017 or later
   - .NET Framework 4.7.2 or later
   - IIS Express or IIS Server

2. **Database**
   - Oracle Database 11g or later
   - Oracle Data Provider for .NET (ODP.NET)

3. **NuGet Packages**
   - Oracle.ManagedDataAccess (v19.x or later)

## Installation

### 1. Database Setup

Run the database schema script to create the required table and sample data:

```sql
sqlplus username/password@database @DatabaseSchema.sql
```

The script will:
- Create the NPD_PROJECTS table
- Create necessary indexes
- Insert sample data (10 projects)
- Create triggers for automatic timestamp updates

### 2. Configure Connection String

Update the `Web.config` file with your Oracle database connection details:

```xml
<connectionStrings>
    <add name="OracleConnection" 
         connectionString="Data Source=(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=your-host)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=your-service)));User Id=your-username;Password=your-password;" 
         providerName="Oracle.ManagedDataAccess.Client" />
</connectionStrings>
```

### 3. Build and Deploy

**Using Rebuild Scripts (Recommended):**

For detailed build instructions, see [REBUILD.md](REBUILD.md).

Quick start:
- Windows: `.\rebuild.ps1` or `rebuild.bat`
- Linux/macOS: `./rebuild.sh`
- Any platform: `make rebuild`

**Using Visual Studio:**
1. Open the project in Visual Studio
2. Restore NuGet packages
3. Build the solution (Ctrl+Shift+B)
4. Run the application (F5)

**Manual Deployment to IIS:**
1. Build the project in Release mode
2. Copy all files to IIS website directory
3. Create an application pool (.NET Framework v4.0)
4. Assign the application pool to your website
5. Ensure the application pool identity has database access

## Configuration

### Web.config Settings

**Connection String:**
```xml
<connectionStrings>
    <add name="OracleConnection" 
         connectionString="..." 
         providerName="Oracle.ManagedDataAccess.Client" />
</connectionStrings>
```

**Application Settings:**
```xml
<appSettings>
    <add key="ApplicationName" value="NPD Status Dashboard" />
    <add key="DefaultPageSize" value="25" />
</appSettings>
```

## Usage

### Filtering Data

1. **Date Range**: Select from and to dates to filter projects by start date
2. **Coordinator**: Choose a specific coordinator or "All" to see all
3. **Brand**: Filter by product brand
4. **Collection**: Filter by product collection
5. Click **Search** to apply filters
6. Click **Reset** to clear all filters and reload with defaults

### Viewing Reports

**Main Report Grid:**
- View detailed project information
- Click column headers to sort
- Use pagination controls to navigate pages
- Default shows 25 records per page

**Brand Summary:**
- See aggregated statistics by brand
- View total, active, completed, and pending counts
- Check average progress percentage

### Dashboard Cards

The summary cards at the top provide quick metrics:
- **Total Projects**: All projects matching filters
- **Active Projects**: Projects currently in progress
- **Completed Projects**: Successfully completed projects
- **Pending Projects**: Projects not yet started

## Database Schema

### NPD_PROJECTS Table

| Column | Type | Description |
|--------|------|-------------|
| PROJECT_ID | VARCHAR2(50) | Unique project identifier (PK) |
| PROJECT_NAME | VARCHAR2(200) | Project name |
| BRAND | VARCHAR2(100) | Product brand |
| COLLECTION | VARCHAR2(100) | Product collection |
| COORDINATOR | VARCHAR2(100) | Project coordinator |
| STATUS | VARCHAR2(50) | Project status (Pending/Active/Completed) |
| START_DATE | DATE | Project start date |
| TARGET_DATE | DATE | Target completion date |
| COMPLETION_DATE | DATE | Actual completion date |
| PROGRESS_PCT | NUMBER(5,2) | Completion percentage (0-100) |
| PRIORITY | VARCHAR2(20) | Priority (High/Medium/Low) |
| DESCRIPTION | CLOB | Project description |
| CREATED_BY | VARCHAR2(100) | Created by user |
| CREATED_DATE | DATE | Creation timestamp |
| MODIFIED_BY | VARCHAR2(100) | Last modified by user |
| MODIFIED_DATE | DATE | Last modification timestamp |
| LAST_UPDATE | DATE | Last update timestamp |

## Security Features

1. **Parameterized Queries**: All SQL queries use parameterized statements to prevent SQL injection
2. **Connection Pooling**: ODP.NET automatically manages connection pooling
3. **ViewState**: Protected and encrypted (configure in Web.config)
4. **Input Validation**: Server-side validation for all user inputs

## API Reference

### NPDDataAccess Class

**GetCoordinators()**
```csharp
public DataTable GetCoordinators()
```
Returns list of unique coordinators.

**GetBrands()**
```csharp
public DataTable GetBrands()
```
Returns list of unique brands.

**GetCollections()**
```csharp
public DataTable GetCollections()
```
Returns list of unique collections.

**GetProjectSummary()**
```csharp
public DataTable GetProjectSummary(DateTime? fromDate, DateTime? toDate, 
                                   string coordinator, string brand, string collection)
```
Returns aggregated project counts for dashboard cards.

**GetNPDProjects()**
```csharp
public DataTable GetNPDProjects(DateTime? fromDate, DateTime? toDate, string coordinator, 
                                string brand, string collection, string sortExpression, 
                                string sortDirection)
```
Returns filtered and sorted project list.

**GetBrandSummary()**
```csharp
public DataTable GetBrandSummary(DateTime? fromDate, DateTime? toDate, 
                                 string coordinator, string brand, string collection)
```
Returns brand-level statistics.

## Troubleshooting

### Common Issues

**1. Connection String Error**
```
Error: Oracle connection string not found in configuration.
```
**Solution**: Verify Web.config has the correct connection string with name="OracleConnection"

**2. ODP.NET Not Found**
```
Error: Could not load file or assembly 'Oracle.ManagedDataAccess'
```
**Solution**: Install Oracle.ManagedDataAccess NuGet package

**3. Database Connection Failed**
```
Error: ORA-12154: TNS:could not resolve the connect identifier specified
```
**Solution**: Check Oracle connection string parameters (host, port, service name)

**4. No Data Displayed**
```
Message: No records found matching the search criteria.
```
**Solution**: 
- Verify database has data
- Check filter criteria
- Ensure dates are in valid range

## Performance Optimization

1. **Database Indexing**: Indexes created on STATUS, BRAND, COORDINATOR, START_DATE, COLLECTION
2. **Connection Pooling**: Enabled by default in ODP.NET
3. **ViewState Management**: Minimal ViewState usage
4. **Pagination**: Reduces data transfer with 25 records per page

## Browser Compatibility

- Chrome (latest)
- Firefox (latest)
- Edge (latest)
- Safari (latest)
- IE 11+ (with some CSS limitations)

## Responsive Design

The application includes responsive CSS that adapts to:
- Desktop (1400px+)
- Tablet (768px - 1399px)
- Mobile (< 768px)

## Future Enhancements

- [ ] User authentication and authorization
- [ ] Role-based access control
- [ ] Export to Excel/PDF
- [ ] Inline grid editing
- [ ] Real-time notifications
- [ ] Dashboard charts and graphs
- [ ] Advanced search with wildcards
- [ ] Audit logging
- [ ] Email notifications
- [ ] Mobile app integration

## Support

For issues, questions, or contributions:
1. Check the mapping document: `APEX_to_WebForms_Mapping.md`
2. Review database schema: `DatabaseSchema.sql`
3. Verify configuration in `Web.config`

## License

This project is provided as-is for educational and commercial use.

## Changelog

### Version 1.0.0 (2026-02-14)
- Initial release
- Complete APEX to Web Forms conversion
- All features implemented:
  - Date range filtering
  - Multiple dropdown filters
  - Dashboard summary cards
  - Main report with pagination and sorting
  - Brand summary report
  - Parameterized SQL with ODP.NET
  - Comprehensive documentation

## Authors

- Converted from Oracle APEX to ASP.NET Web Forms
- IOT Dashboard Team

---

**Note**: This application was converted from Oracle APEX. See `APEX_to_WebForms_Mapping.md` for detailed component mappings and migration notes.
