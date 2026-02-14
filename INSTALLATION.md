# NPD Status Dashboard - Installation Guide

## Quick Start Guide

This guide will help you set up and run the NPD Status Dashboard application converted from Oracle APEX to ASP.NET Web Forms.

---

## Prerequisites

### Required Software

1. **Visual Studio 2017 or later** (Community, Professional, or Enterprise)
   - Download from: https://visualstudio.microsoft.com/
   - Required workload: "ASP.NET and web development"

2. **Oracle Database 11g or later**
   - Express Edition (free): https://www.oracle.com/database/technologies/xe-downloads.html
   - Or access to an existing Oracle database instance

3. **.NET Framework 4.7.2 or later**
   - Included with Visual Studio 2017+
   - Standalone download: https://dotnet.microsoft.com/download/dotnet-framework

4. **IIS or IIS Express**
   - IIS Express comes with Visual Studio
   - Full IIS: Enable through Windows Features

---

## Step 1: Database Setup

### A. Connect to Oracle Database

```bash
sqlplus username/password@database
```

Or use SQL Developer, Toad, or any Oracle client tool.

### B. Run the Database Schema Script

```sql
@DatabaseSchema.sql
```

This script will:
- Create the `NPD_PROJECTS` table
- Add indexes for performance
- Insert 10 sample projects
- Create triggers for auto-updating timestamps

### C. Verify Installation

```sql
-- Check table creation
SELECT COUNT(*) FROM NPD_PROJECTS;

-- Should return: 10

-- View sample data
SELECT PROJECT_ID, PROJECT_NAME, STATUS 
FROM NPD_PROJECTS 
ORDER BY PROJECT_ID;
```

### D. Grant Permissions (if needed)

If running as a different user:

```sql
GRANT SELECT, INSERT, UPDATE, DELETE ON NPD_PROJECTS TO your_app_user;
```

---

## Step 2: Project Setup

### A. Open Project in Visual Studio

1. Launch Visual Studio
2. Click "Open a project or solution"
3. Navigate to the project folder
4. Open `NPDStatusX.csproj`

### B. Restore NuGet Packages

Visual Studio should automatically restore packages. If not:

1. Right-click on the solution in Solution Explorer
2. Select "Restore NuGet Packages"

Or use Package Manager Console:
```powershell
Update-Package -reinstall
```

### C. Configure Connection String

Open `Web.config` and update the connection string:

> **Security Warning:** Never commit actual credentials to source control! See the Security Considerations section below for best practices on securing database credentials in production.

**Option 1: EZConnect Format (Recommended - Simpler)**
```xml
<connectionStrings>
    <add name="OracleConnection" 
         connectionString="Data Source=localhost:1521/XE;User Id=your-username;Password=your-password;" 
         providerName="Oracle.ManagedDataAccess.Client" />
</connectionStrings>
```

**Connection String Parameters:**
- `hostname:port/service_name`: Oracle server connection (e.g., localhost:1521/XE)
- `User Id`: Database username
- `Password`: Database password

**Example for Oracle XE on localhost:**
```xml
connectionString="Data Source=localhost:1521/XE;User Id=SYSTEM;Password=oracle;"
```

**Option 2: TNS Format (Advanced - For complex network configurations)**

To use this format, comment out the EZConnect connection string and uncomment this one:

```xml
<connectionStrings>
    <add name="OracleConnection" 
         connectionString="Data Source=(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=your-oracle-host)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=your-service-name)));User Id=your-username;Password=your-password;" 
         providerName="Oracle.ManagedDataAccess.Client" />
</connectionStrings>
```

**TNS Connection String Parameters:**
- `HOST`: Your Oracle server hostname or IP (e.g., localhost, 192.168.1.100)
- `PORT`: Oracle listener port (default: 1521)
- `SERVICE_NAME`: Your Oracle service name (e.g., ORCL, XE)
- `User Id`: Database username
- `Password`: Database password

---

## Step 3: Build and Run

### Option A: Run in Visual Studio (Development)

1. Press **F5** or click the "Start" button
2. Visual Studio will:
   - Build the project
   - Launch IIS Express
   - Open the application in your default browser

### Option B: Build for Deployment

1. In Visual Studio, select **Build > Build Solution**
2. Right-click the project > **Publish**
3. Choose a publish target:
   - File System (for manual IIS deployment)
   - IIS Server (direct deployment)
   - Azure App Service (cloud deployment)

---

## Step 4: Deploy to IIS (Production)

### A. Prepare IIS

1. Open "Turn Windows features on or off"
2. Enable:
   - Internet Information Services
   - Web Management Tools > IIS Management Console
   - World Wide Web Services > Application Development Features > ASP.NET 4.8

### B. Create Application Pool

1. Open IIS Manager
2. Right-click "Application Pools" > "Add Application Pool"
3. Settings:
   - Name: NPDStatusX
   - .NET CLR Version: v4.0
   - Managed Pipeline Mode: Integrated
4. Click "OK"

### C. Create Website/Application

**Option 1: New Website**
1. Right-click "Sites" > "Add Website"
2. Settings:
   - Site name: NPDStatusX
   - Application pool: NPDStatusX
   - Physical path: C:\inetpub\wwwroot\NPDStatusX
   - Port: 8080
3. Click "OK"

**Option 2: Application under Default Web Site**
1. Right-click "Default Web Site" > "Add Application"
2. Settings:
   - Alias: NPDStatusX
   - Application pool: NPDStatusX
   - Physical path: C:\inetpub\wwwroot\NPDStatusX
3. Click "OK"

### D. Copy Files

Copy these files to your IIS physical path:
- NPDStatusDashboard.aspx
- NPDStatusDashboard.aspx.cs
- NPDDataAccess.cs
- NPDStatusDashboard.css
- Web.config
- bin/ folder (with compiled DLLs)

### E. Set Permissions

1. Right-click the application folder
2. Properties > Security > Edit
3. Add "IIS_IUSRS" with Read & Execute permissions

### F. Test the Application

Open browser and navigate to:
- New Site: http://localhost:8080/NPDStatusDashboard.aspx
- Application: http://localhost/NPDStatusX/NPDStatusDashboard.aspx

---

## Troubleshooting

### Issue 1: Cannot connect to Oracle database

**Error:** `ORA-12154: TNS:could not resolve the connect identifier`

**Solutions:**
1. Verify Oracle is running:
   ```bash
   lsnrctl status
   ```
2. Check `tnsnames.ora` file (if using TNS)
3. Try EZConnect format instead
4. Verify firewall allows port 1521

### Issue 2: ODP.NET assembly not found

**Error:** `Could not load file or assembly 'Oracle.ManagedDataAccess'`

**Solutions:**
1. Restore NuGet packages:
   ```powershell
   Update-Package -reinstall Oracle.ManagedDataAccess
   ```
2. Verify `packages.config` exists
3. Check `Web.config` has correct binding redirect

### Issue 3: No data displayed

**Error:** "No records found matching the search criteria"

**Solutions:**
1. Verify database has data:
   ```sql
   SELECT COUNT(*) FROM NPD_PROJECTS;
   ```
2. Check date filters - expand date range
3. Reset filters using Reset button
4. Check database permissions

### Issue 4: IIS 500 error

**Solutions:**
1. Enable detailed errors in `Web.config`:
   ```xml
   <system.web>
       <customErrors mode="Off"/>
   </system.web>
   ```
2. Check Event Viewer > Windows Logs > Application
3. Verify .NET Framework 4.7.2 is installed
4. Check application pool is running

### Issue 5: CSS not loading

**Solutions:**
1. Verify `NPDStatusDashboard.css` is in the same folder as .aspx
2. Check file permissions (IIS_IUSRS needs Read access)
3. Clear browser cache (Ctrl+F5)
4. Check path in .aspx file matches file location

---

## Configuration Options

### Adjust Page Size

In `Web.config`:
```xml
<appSettings>
    <add key="DefaultPageSize" value="25" />
</appSettings>
```

Then in code-behind:
```csharp
gvNPDStatus.PageSize = int.Parse(ConfigurationManager.AppSettings["DefaultPageSize"]);
```

### Enable ViewState Encryption

In `Web.config`:
```xml
<system.web>
    <pages enableViewStateMac="true" viewStateEncryptionMode="Always" />
</system.web>
```

### Connection Pooling

ODP.NET enables connection pooling by default. To customize:
```xml
connectionString="...;Min Pool Size=5;Max Pool Size=100;Connection Lifetime=300;"
```

---

## Testing the Application

### 1. Test Database Connection

Create a test page:
```csharp
protected void Page_Load(object sender, EventArgs e)
{
    NPDDataAccess dal = new NPDDataAccess();
    bool connected = dal.TestConnection();
    Response.Write(connected ? "Connected!" : "Connection Failed");
}
```

### 2. Test Filters

1. Select a date range
2. Choose filter values
3. Click Search
4. Verify results are filtered correctly

### 3. Test Pagination

1. Verify grid shows 25 records per page
2. Click page numbers to navigate
3. Check "First" and "Last" buttons work

### 4. Test Sorting

1. Click column headers
2. Verify data sorts ascending
3. Click again to sort descending
4. Check sort indicator (if implemented)

### 5. Test Reset

1. Apply various filters
2. Click Reset button
3. Verify all filters return to defaults
4. Check data reloads

---

## Performance Tuning

### Database Optimization

```sql
-- Analyze table statistics
ANALYZE TABLE NPD_PROJECTS COMPUTE STATISTICS;

-- Rebuild indexes
ALTER INDEX IDX_NPD_STATUS REBUILD;
ALTER INDEX IDX_NPD_BRAND REBUILD;
ALTER INDEX IDX_NPD_COORDINATOR REBUILD;
```

### Application Optimization

1. **Enable Output Caching** (if data doesn't change frequently):
   ```aspx
   <%@ OutputCache Duration="60" VaryByParam="none" %>
   ```

2. **Disable ViewState** (where not needed):
   ```aspx
   <asp:GridView EnableViewState="false" ... />
   ```

3. **Use Compiled Bindings**:
   ```aspx
   <%# Item.PropertyName %>  <%-- Instead of Eval --%>
   ```

---

## Security Considerations

### 1. Production Connection String

**Never** store passwords in plain text. Use:

**Option A: Encrypted Connection String**
```powershell
aspnet_regiis -pef "connectionStrings" "C:\path\to\app"
```

**Option B: Windows Authentication**
```xml
connectionString="Data Source=...;Integrated Security=True;"
```

### 2. Enable Request Validation

In `Web.config`:
```xml
<system.web>
    <pages validateRequest="true" />
    <httpRuntime requestValidationMode="4.5" />
</system.web>
```

### 3. HTTPS Only (Production)

In `Web.config`:
```xml
<system.webServer>
    <rewrite>
        <rules>
            <rule name="Redirect to HTTPS" stopProcessing="true">
                <match url="(.*)" />
                <conditions>
                    <add input="{HTTPS}" pattern="off" />
                </conditions>
                <action type="Redirect" url="https://{HTTP_HOST}/{R:1}" />
            </rule>
        </rules>
    </rewrite>
</system.webServer>
```

---

## Backup and Maintenance

### Database Backup

```sql
-- Export data
expdp username/password@database TABLES=NPD_PROJECTS DIRECTORY=backup_dir DUMPFILE=npd_backup.dmp

-- Import data
impdp username/password@database TABLES=NPD_PROJECTS DIRECTORY=backup_dir DUMPFILE=npd_backup.dmp
```

### Application Backup

1. Copy entire application folder
2. Include Web.config (but protect credentials)
3. Backup database separately
4. Document custom configuration changes

---

## Next Steps

After successful installation:

1. **Customize the Application**
   - Update branding (header, colors)
   - Add your company logo
   - Modify CSS for corporate style

2. **Add Authentication**
   - Implement ASP.NET Forms Authentication
   - Add login page
   - Create user roles

3. **Enhance Features**
   - Add export to Excel
   - Implement charts/graphs
   - Add email notifications

4. **Monitor Performance**
   - Set up application logging
   - Monitor database queries
   - Track user activities

---

## Support Resources

- **Documentation**: See `APEX_to_WebForms_Mapping.md` for detailed mappings
- **Database Schema**: Refer to `DatabaseSchema.sql`
- **README**: Check `README.md` for feature overview

For technical issues:
1. Check error messages in Event Viewer
2. Enable detailed errors in Web.config
3. Review database logs
4. Verify Oracle connectivity

---

## Appendix: Command Reference

### Visual Studio Commands

```powershell
# Build solution
msbuild NPDStatusX.sln /p:Configuration=Release

# Restore packages
nuget restore NPDStatusX.sln

# Clean solution
msbuild NPDStatusX.sln /t:Clean
```

### Oracle Commands

```sql
-- Start listener
lsnrctl start

-- Stop listener
lsnrctl stop

-- Check listener status
lsnrctl status

-- Connect to database
sqlplus / as sysdba
```

### IIS Commands

```powershell
# Start IIS
iisreset /start

# Stop IIS
iisreset /stop

# Restart IIS
iisreset /restart

# List application pools
%systemroot%\system32\inetsrv\appcmd list apppools
```

---

**Installation Complete!** You should now have a fully functional NPD Status Dashboard application running on ASP.NET Web Forms.
