using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NPDStatusX
{
    public partial class NPDStatusDashboard : System.Web.UI.Page
    {
        private NPDDataAccess dal = new NPDDataAccess();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                InitializePage();
                LoadData();
            }
        }

        /// <summary>
        /// Initialize page controls with default values
        /// </summary>
        private void InitializePage()
        {
            // Set default date range (current month)
            DateTime now = DateTime.Now;
            txtFromDate.Text = new DateTime(now.Year, now.Month, 1).ToString("yyyy-MM-dd");
            txtToDate.Text = now.ToString("yyyy-MM-dd");

            // Load filter dropdowns
            LoadCoordinators();
            LoadBrands();
            LoadCollections();
        }

        /// <summary>
        /// Load coordinators into dropdown
        /// </summary>
        private void LoadCoordinators()
        {
            try
            {
                DataTable dt = dal.GetCoordinators();
                ddlCoordinator.Items.Clear();
                ddlCoordinator.Items.Add(new ListItem("-- All --", ""));
                
                foreach (DataRow row in dt.Rows)
                {
                    ddlCoordinator.Items.Add(new ListItem(row["COORDINATOR"].ToString(), row["COORDINATOR"].ToString()));
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error loading coordinators: " + ex.Message, "error");
            }
        }

        /// <summary>
        /// Load brands into dropdown
        /// </summary>
        private void LoadBrands()
        {
            try
            {
                DataTable dt = dal.GetBrands();
                ddlBrand.Items.Clear();
                ddlBrand.Items.Add(new ListItem("-- All --", ""));
                
                foreach (DataRow row in dt.Rows)
                {
                    ddlBrand.Items.Add(new ListItem(row["BRAND"].ToString(), row["BRAND"].ToString()));
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error loading brands: " + ex.Message, "error");
            }
        }

        /// <summary>
        /// Load collections into dropdown
        /// </summary>
        private void LoadCollections()
        {
            try
            {
                DataTable dt = dal.GetCollections();
                ddlCollection.Items.Clear();
                ddlCollection.Items.Add(new ListItem("-- All --", ""));
                
                foreach (DataRow row in dt.Rows)
                {
                    ddlCollection.Items.Add(new ListItem(row["COLLECTION"].ToString(), row["COLLECTION"].ToString()));
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error loading collections: " + ex.Message, "error");
            }
        }

        /// <summary>
        /// Load all data including summary cards and reports
        /// </summary>
        private void LoadData()
        {
            try
            {
                // Get filter values
                DateTime? fromDate = string.IsNullOrEmpty(txtFromDate.Text) ? (DateTime?)null : DateTime.Parse(txtFromDate.Text);
                DateTime? toDate = string.IsNullOrEmpty(txtToDate.Text) ? (DateTime?)null : DateTime.Parse(txtToDate.Text);
                string coordinator = ddlCoordinator.SelectedValue;
                string brand = ddlBrand.SelectedValue;
                string collection = ddlCollection.SelectedValue;

                // Load summary cards
                LoadSummaryCards(fromDate, toDate, coordinator, brand, collection);

                // Load main grid
                LoadProjectGrid(fromDate, toDate, coordinator, brand, collection);

                // Load brand summary repeater
                LoadBrandSummary(fromDate, toDate, coordinator, brand, collection);
            }
            catch (Exception ex)
            {
                ShowMessage("Error loading data: " + ex.Message, "error");
            }
        }

        /// <summary>
        /// Load summary card values
        /// </summary>
        private void LoadSummaryCards(DateTime? fromDate, DateTime? toDate, string coordinator, string brand, string collection)
        {
            try
            {
                DataTable dt = dal.GetProjectSummary(fromDate, toDate, coordinator, brand, collection);
                
                if (dt.Rows.Count > 0)
                {
                    DataRow row = dt.Rows[0];
                    lblTotalProjects.Text = row["TOTAL_PROJECTS"].ToString();
                    lblActiveProjects.Text = row["ACTIVE_PROJECTS"].ToString();
                    lblCompletedProjects.Text = row["COMPLETED_PROJECTS"].ToString();
                    lblPendingProjects.Text = row["PENDING_PROJECTS"].ToString();
                }
                else
                {
                    lblTotalProjects.Text = "0";
                    lblActiveProjects.Text = "0";
                    lblCompletedProjects.Text = "0";
                    lblPendingProjects.Text = "0";
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error loading summary: " + ex.Message, "error");
            }
        }

        /// <summary>
        /// Load project grid with pagination and sorting
        /// </summary>
        private void LoadProjectGrid(DateTime? fromDate, DateTime? toDate, string coordinator, string brand, string collection)
        {
            try
            {
                string sortExpression = ViewState["SortExpression"] as string ?? "PROJECT_ID";
                string sortDirection = ViewState["SortDirection"] as string ?? "ASC";

                DataTable dt = dal.GetNPDProjects(fromDate, toDate, coordinator, brand, collection, sortExpression, sortDirection);
                
                gvNPDStatus.DataSource = dt;
                gvNPDStatus.DataBind();

                if (dt.Rows.Count == 0)
                {
                    ShowMessage("No records found matching the search criteria.", "info");
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error loading project data: " + ex.Message, "error");
            }
        }

        /// <summary>
        /// Load brand summary repeater
        /// </summary>
        private void LoadBrandSummary(DateTime? fromDate, DateTime? toDate, string coordinator, string brand, string collection)
        {
            try
            {
                DataTable dt = dal.GetBrandSummary(fromDate, toDate, coordinator, brand, collection);
                rptBrandSummary.DataSource = dt;
                rptBrandSummary.DataBind();
            }
            catch (Exception ex)
            {
                ShowMessage("Error loading brand summary: " + ex.Message, "error");
            }
        }

        /// <summary>
        /// Handle Search button click
        /// </summary>
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            try
            {
                // Validate date range
                if (!string.IsNullOrEmpty(txtFromDate.Text) && !string.IsNullOrEmpty(txtToDate.Text))
                {
                    DateTime fromDate = DateTime.Parse(txtFromDate.Text);
                    DateTime toDate = DateTime.Parse(txtToDate.Text);

                    if (fromDate > toDate)
                    {
                        ShowMessage("From Date cannot be greater than To Date.", "error");
                        return;
                    }
                }

                // Reset to first page when searching
                gvNPDStatus.PageIndex = 0;
                ViewState["SortExpression"] = "PROJECT_ID";
                ViewState["SortDirection"] = "ASC";

                LoadData();
                ShowMessage("Search completed successfully.", "success");
            }
            catch (Exception ex)
            {
                ShowMessage("Error during search: " + ex.Message, "error");
            }
        }

        /// <summary>
        /// Handle Reset button click
        /// </summary>
        protected void btnReset_Click(object sender, EventArgs e)
        {
            try
            {
                // Reset all filters to default
                DateTime now = DateTime.Now;
                txtFromDate.Text = new DateTime(now.Year, now.Month, 1).ToString("yyyy-MM-dd");
                txtToDate.Text = now.ToString("yyyy-MM-dd");
                ddlCoordinator.SelectedIndex = 0;
                ddlBrand.SelectedIndex = 0;
                ddlCollection.SelectedIndex = 0;

                // Reset grid state
                gvNPDStatus.PageIndex = 0;
                ViewState["SortExpression"] = "PROJECT_ID";
                ViewState["SortDirection"] = "ASC";

                LoadData();
                ShowMessage("Filters reset successfully.", "success");
            }
            catch (Exception ex)
            {
                ShowMessage("Error during reset: " + ex.Message, "error");
            }
        }

        /// <summary>
        /// Handle GridView page index changing
        /// </summary>
        protected void gvNPDStatus_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            try
            {
                gvNPDStatus.PageIndex = e.NewPageIndex;
                LoadData();
            }
            catch (Exception ex)
            {
                ShowMessage("Error changing page: " + ex.Message, "error");
            }
        }

        /// <summary>
        /// Handle GridView sorting
        /// </summary>
        protected void gvNPDStatus_Sorting(object sender, GridViewSortEventArgs e)
        {
            try
            {
                string sortExpression = e.SortExpression;
                string currentSort = ViewState["SortExpression"] as string;
                string currentDirection = ViewState["SortDirection"] as string ?? "ASC";

                // Toggle sort direction if same column
                if (sortExpression == currentSort)
                {
                    currentDirection = currentDirection == "ASC" ? "DESC" : "ASC";
                }
                else
                {
                    currentDirection = "ASC";
                }

                ViewState["SortExpression"] = sortExpression;
                ViewState["SortDirection"] = currentDirection;

                LoadData();
            }
            catch (Exception ex)
            {
                ShowMessage("Error during sorting: " + ex.Message, "error");
            }
        }

        /// <summary>
        /// Display message to user
        /// </summary>
        private void ShowMessage(string message, string type)
        {
            lblMessage.Text = message;
            pnlMessage.Visible = true;
            pnlMessage.CssClass = "message-panel message-" + type;
        }
    }
}
