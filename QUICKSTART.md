# Quick Start Guide - NPD Status Dashboard

## 🚀 Get Started in 5 Minutes

This guide will help you quickly set up and run the NPD Status Dashboard application.

---

## Prerequisites Checklist

- [ ] Visual Studio 2017 or later installed
- [ ] Oracle Database 11g+ running and accessible
- [ ] .NET Framework 4.7.2 or later

---

## Step 1: Setup Database (2 minutes)

### Open SQL*Plus or SQL Developer and run:

```sql
sqlplus username/password@database @DatabaseSchema.sql
```

**What this does:**
- Creates NPD_PROJECTS table
- Adds 10 sample projects
- Sets up indexes and triggers

### Verify:
```sql
SELECT COUNT(*) FROM NPD_PROJECTS;
-- Should return: 10
```

---

## Step 2: Configure Connection (1 minute)

### Edit `Web.config` and update this section:

```xml
<connectionStrings>
    <add name="OracleConnection" 
         connectionString="Data Source=localhost:1521/XE;User Id=SYSTEM;Password=oracle;" 
         providerName="Oracle.ManagedDataAccess.Client" />
</connectionStrings>
```

**Replace with your values:**
- `localhost` → Your Oracle server
- `1521` → Your Oracle port
- `XE` → Your service name
- `SYSTEM` → Your username
- `oracle` → Your password

---

## Step 3: Open and Run (2 minutes)

### In Visual Studio:

1. **Open** `NPDStatusX.sln`
2. **Wait** for NuGet packages to restore (automatic)
3. **Press** F5 to run

### Or via Command Line:

```powershell
cd /path/to/NPDStatusX
msbuild NPDStatusX.sln
```

---

## 🎉 Done! 

Your browser should open automatically showing the NPD Status Dashboard.

### What You'll See:

✅ **Filter Section** - Date range, Coordinator, Brand, Collection filters  
✅ **Dashboard Cards** - Total, Active, Completed, Pending project counts  
✅ **Main Report** - GridView with all project details (pagination, sorting)  
✅ **Brand Summary** - Aggregated statistics by brand  

---

## 🔍 Try These Features:

1. **Filter by Date**: Select a date range and click Search
2. **Filter by Coordinator**: Choose a coordinator from dropdown
3. **Sort Data**: Click any column header to sort
4. **Navigate Pages**: Use pagination controls at bottom
5. **Reset Filters**: Click Reset to clear all filters

---

## 🆘 Troubleshooting

### Problem: Can't connect to Oracle
**Solution**: Verify Oracle is running:
```bash
lsnrctl status
```

### Problem: NuGet packages not found
**Solution**: Restore packages:
```powershell
nuget restore NPDStatusX.sln
```

### Problem: No data displayed
**Solution**: Check if database has data:
```sql
SELECT COUNT(*) FROM NPD_PROJECTS;
```

---

## 📚 More Information

- **Full Documentation**: See `README.md`
- **Installation Details**: See `INSTALLATION.md`
- **APEX Mapping**: See `APEX_to_WebForms_Mapping.md`
- **Database Schema**: See `DatabaseSchema.sql`

---

## 📋 Project Structure

```
NPDStatusX/
├── NPDStatusDashboard.aspx        # Main page (UI)
├── NPDStatusDashboard.aspx.cs     # Code-behind (logic)
├── NPDDataAccess.cs               # Data layer (Oracle queries)
├── NPDStatusDashboard.css         # Styles
├── Web.config                      # Configuration
├── DatabaseSchema.sql             # Database setup
└── README.md                       # Full documentation
```

---

## 🎯 Key Features Implemented

✅ Date range filtering with validation  
✅ Multi-select dropdown filters  
✅ Dashboard summary cards  
✅ GridView with pagination (25 per page)  
✅ Column sorting (ASC/DESC)  
✅ Brand summary report  
✅ Parameterized SQL (SQL injection protection)  
✅ ODP.NET for Oracle connectivity  
✅ Responsive CSS design  
✅ Search and Reset functionality  

---

## 💡 Tips

- **Default date range**: Current month (auto-set on load)
- **Page size**: 25 records per page (configurable in Web.config)
- **Sorting**: Click column header to toggle ASC/DESC
- **Empty filters**: Use "-- All --" to show all records

---

## 🔒 Security

✅ All SQL queries use parameterized statements  
✅ No SQL injection vulnerabilities  
✅ Connection pooling enabled  
✅ ViewState protected  

---

## 🚀 Next Steps

1. **Customize branding**: Edit header in `NPDStatusDashboard.aspx`
2. **Add more data**: Insert projects via SQL or add create form
3. **Deploy to IIS**: See `INSTALLATION.md` for production setup
4. **Add authentication**: Implement ASP.NET membership
5. **Export features**: Add Excel/PDF export capability

---

**Happy Coding! 🎊**

For questions or issues, check the full documentation in `README.md` or `INSTALLATION.md`.
