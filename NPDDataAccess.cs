using System;
using System.Data;
using Oracle.ManagedDataAccess.Client;
using System.Configuration;

namespace NPDStatusX
{
    /// <summary>
    /// Data Access Layer for NPD Status Dashboard
    /// Uses Oracle Data Provider for .NET (ODP.NET) with parameterized queries
    /// </summary>
    public class NPDDataAccess
    {
        private string connectionString;

        public NPDDataAccess()
        {
            // Get connection string from Web.config
            connectionString = ConfigurationManager.ConnectionStrings["OracleConnection"]?.ConnectionString;
            
            if (string.IsNullOrEmpty(connectionString))
            {
                throw new Exception("Oracle connection string not found in configuration.");
            }
        }

        /// <summary>
        /// Get list of coordinators
        /// </summary>
        public DataTable GetCoordinators()
        {
            string query = @"
                SELECT DISTINCT COORDINATOR 
                FROM NPD_PROJECTS 
                WHERE COORDINATOR IS NOT NULL 
                ORDER BY COORDINATOR";

            return ExecuteQuery(query);
        }

        /// <summary>
        /// Get list of brands
        /// </summary>
        public DataTable GetBrands()
        {
            string query = @"
                SELECT DISTINCT BRAND 
                FROM NPD_PROJECTS 
                WHERE BRAND IS NOT NULL 
                ORDER BY BRAND";

            return ExecuteQuery(query);
        }

        /// <summary>
        /// Get list of collections
        /// </summary>
        public DataTable GetCollections()
        {
            string query = @"
                SELECT DISTINCT COLLECTION 
                FROM NPD_PROJECTS 
                WHERE COLLECTION IS NOT NULL 
                ORDER BY COLLECTION";

            return ExecuteQuery(query);
        }

        /// <summary>
        /// Get project summary for dashboard cards
        /// </summary>
        public DataTable GetProjectSummary(DateTime? fromDate, DateTime? toDate, string coordinator, string brand, string collection)
        {
            string query = @"
                SELECT 
                    COUNT(*) AS TOTAL_PROJECTS,
                    SUM(CASE WHEN STATUS = 'Active' THEN 1 ELSE 0 END) AS ACTIVE_PROJECTS,
                    SUM(CASE WHEN STATUS = 'Completed' THEN 1 ELSE 0 END) AS COMPLETED_PROJECTS,
                    SUM(CASE WHEN STATUS = 'Pending' THEN 1 ELSE 0 END) AS PENDING_PROJECTS
                FROM NPD_PROJECTS
                WHERE 1=1";

            OracleParameter[] parameters = BuildFilterParameters(ref query, fromDate, toDate, coordinator, brand, collection);

            return ExecuteQuery(query, parameters);
        }

        /// <summary>
        /// Get NPD projects with filters, sorting, and pagination support
        /// </summary>
        public DataTable GetNPDProjects(DateTime? fromDate, DateTime? toDate, string coordinator, string brand, 
                                       string collection, string sortExpression, string sortDirection)
        {
            string query = @"
                SELECT 
                    PROJECT_ID,
                    PROJECT_NAME,
                    BRAND,
                    COLLECTION,
                    COORDINATOR,
                    STATUS,
                    START_DATE,
                    TARGET_DATE,
                    COMPLETION_DATE,
                    PROGRESS_PCT,
                    PRIORITY,
                    LAST_UPDATE,
                    CREATED_BY,
                    CREATED_DATE,
                    MODIFIED_BY,
                    MODIFIED_DATE
                FROM NPD_PROJECTS
                WHERE 1=1";

            OracleParameter[] parameters = BuildFilterParameters(ref query, fromDate, toDate, coordinator, brand, collection);

            // Add sorting
            if (!string.IsNullOrEmpty(sortExpression))
            {
                query += $" ORDER BY {sortExpression} {sortDirection}";
            }
            else
            {
                query += " ORDER BY PROJECT_ID DESC";
            }

            return ExecuteQuery(query, parameters);
        }

        /// <summary>
        /// Get brand summary statistics
        /// </summary>
        public DataTable GetBrandSummary(DateTime? fromDate, DateTime? toDate, string coordinator, string brand, string collection)
        {
            string query = @"
                SELECT 
                    BRAND,
                    COUNT(*) AS TOTAL_PROJECTS,
                    SUM(CASE WHEN STATUS = 'Active' THEN 1 ELSE 0 END) AS ACTIVE_COUNT,
                    SUM(CASE WHEN STATUS = 'Completed' THEN 1 ELSE 0 END) AS COMPLETED_COUNT,
                    SUM(CASE WHEN STATUS = 'Pending' THEN 1 ELSE 0 END) AS PENDING_COUNT,
                    ROUND(AVG(PROGRESS_PCT), 1) AS AVG_PROGRESS
                FROM NPD_PROJECTS
                WHERE 1=1";

            OracleParameter[] parameters = BuildFilterParameters(ref query, fromDate, toDate, coordinator, brand, collection);

            query += " GROUP BY BRAND ORDER BY BRAND";

            return ExecuteQuery(query, parameters);
        }

        /// <summary>
        /// Build filter parameters for queries
        /// </summary>
        private OracleParameter[] BuildFilterParameters(ref string query, DateTime? fromDate, DateTime? toDate, 
                                                        string coordinator, string brand, string collection)
        {
            var paramList = new System.Collections.Generic.List<OracleParameter>();

            // Date range filter
            if (fromDate.HasValue)
            {
                query += " AND START_DATE >= :FromDate";
                paramList.Add(new OracleParameter("FromDate", OracleDbType.Date) { Value = fromDate.Value });
            }

            if (toDate.HasValue)
            {
                query += " AND START_DATE <= :ToDate";
                paramList.Add(new OracleParameter("ToDate", OracleDbType.Date) { Value = toDate.Value });
            }

            // Coordinator filter
            if (!string.IsNullOrEmpty(coordinator))
            {
                query += " AND COORDINATOR = :Coordinator";
                paramList.Add(new OracleParameter("Coordinator", OracleDbType.Varchar2) { Value = coordinator });
            }

            // Brand filter
            if (!string.IsNullOrEmpty(brand))
            {
                query += " AND BRAND = :Brand";
                paramList.Add(new OracleParameter("Brand", OracleDbType.Varchar2) { Value = brand });
            }

            // Collection filter
            if (!string.IsNullOrEmpty(collection))
            {
                query += " AND COLLECTION = :Collection";
                paramList.Add(new OracleParameter("Collection", OracleDbType.Varchar2) { Value = collection });
            }

            return paramList.ToArray();
        }

        /// <summary>
        /// Execute query and return DataTable
        /// </summary>
        private DataTable ExecuteQuery(string query, OracleParameter[] parameters = null)
        {
            DataTable dt = new DataTable();

            using (OracleConnection conn = new OracleConnection(connectionString))
            {
                using (OracleCommand cmd = new OracleCommand(query, conn))
                {
                    // Add parameters if provided
                    if (parameters != null && parameters.Length > 0)
                    {
                        cmd.Parameters.AddRange(parameters);
                    }

                    using (OracleDataAdapter adapter = new OracleDataAdapter(cmd))
                    {
                        try
                        {
                            conn.Open();
                            adapter.Fill(dt);
                        }
                        catch (Exception ex)
                        {
                            throw new Exception($"Database error: {ex.Message}", ex);
                        }
                    }
                }
            }

            return dt;
        }

        /// <summary>
        /// Execute non-query command (INSERT, UPDATE, DELETE)
        /// </summary>
        public int ExecuteNonQuery(string query, OracleParameter[] parameters = null)
        {
            int rowsAffected = 0;

            using (OracleConnection conn = new OracleConnection(connectionString))
            {
                using (OracleCommand cmd = new OracleCommand(query, conn))
                {
                    // Add parameters if provided
                    if (parameters != null && parameters.Length > 0)
                    {
                        cmd.Parameters.AddRange(parameters);
                    }

                    try
                    {
                        conn.Open();
                        rowsAffected = cmd.ExecuteNonQuery();
                    }
                    catch (Exception ex)
                    {
                        throw new Exception($"Database error: {ex.Message}", ex);
                    }
                }
            }

            return rowsAffected;
        }

        /// <summary>
        /// Test database connection
        /// </summary>
        public bool TestConnection()
        {
            try
            {
                using (OracleConnection conn = new OracleConnection(connectionString))
                {
                    conn.Open();
                    return true;
                }
            }
            catch
            {
                return false;
            }
        }
    }
}
