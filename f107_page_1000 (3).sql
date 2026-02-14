prompt --application/set_environment
set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- ORACLE Application Express (APEX) export file
--
-- You should run the script connected to SQL*Plus as the Oracle user
-- APEX_190200 or as the owner (parsing schema) of the application.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_api.import_begin (
 p_version_yyyy_mm_dd=>'2019.10.04'
,p_release=>'19.2.0.00.18'
,p_default_workspace_id=>445968571092639789
,p_default_application_id=>107
,p_default_id_offset=>885531316010693451
,p_default_owner=>'TJD_PON'
);
end;
/
 
prompt APPLICATION 107 - UNNATI(NPID)
--
-- Application Export:
--   Application:     107
--   Name:            UNNATI(NPID)
--   Date and Time:   09:14 Saturday February 14, 2026
--   Exported By:     KARTHIK_DOYENSYS
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 1000
--   Manifest End
--   Version:         19.2.0.00.18
--   Instance ID:     199008746504100
--

begin
null;
end;
/
prompt --application/pages/delete_01000
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>1000);
end;
/
prompt --application/pages/page_01000
begin
wwv_flow_api.create_page(
 p_id=>1000
,p_user_interface_id=>wwv_flow_api.id(5105374943875253083)
,p_name=>'NPI StatusX'
,p_step_title=>'NPI StatusX'
,p_autocomplete_on_off=>'OFF'
,p_html_page_header=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" integrity="sha512-..." crossorigin="anonymous" referrerpolicy="no-referrer" />',
''))
,p_javascript_file_urls=>wwv_flow_string.join(wwv_flow_t_varchar2(
'https://cdn.jsdelivr.net/momentjs/latest/moment.min.js',
'https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js',
''))
,p_javascript_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'document.addEventListener("DOMContentLoaded", function () {',
'    document.querySelectorAll(".dash-card").forEach(function(card) {',
'        card.addEventListener("click", function() {',
'            document.querySelectorAll(".dash-card").forEach(c => c.classList.remove("clicked"));',
'            this.classList.add("clicked");',
'        });',
'    });',
'});',
''))
,p_javascript_code_onload=>wwv_flow_string.join(wwv_flow_t_varchar2(
'$(document).ready(function () {',
'',
'    $(".dash-card").click(function () {',
'',
'        var reportType = $(this).data("report");',
'',
'        if (reportType) {',
'',
'            // Reset first (important)',
'            apex.item("P1000_SELECTED_REPORT").setValue("");',
'',
'            // Set selected report',
'        apex.item("P1000_SELECTED_REPORT").setValue(reportType);',
'',
'            // Hide all IR regions',
'            $("#IR_MAIN, #IR_MAIN2, #IR_MAIN3, #IR_MAIN4,#IR_MAIN5,#IR_MAIN6,#IR_MAIN7,#IR_MAIN8").hide();',
'',
'            // Show & refresh only selected region',
'            if (reportType === "INFLEX") {',
'                apex.region("IR_MAIN").refresh();',
'                $("#IR_MAIN").show();',
'            }',
'            else if (reportType === "THEME") {',
'                 apex.region("IR_MAIN8").refresh();',
'                $("#IR_MAIN8").show();',
'            }',
'            else if (reportType === "ITEMMASTER") {',
'                 apex.region("IR_MAIN2").refresh();',
'                $("#IR_MAIN2").show();',
'               ',
'            }',
'            else if (reportType === "OUTRIGHT") {',
'                apex.region("IR_MAIN3").refresh();',
'                $("#IR_MAIN3").show();',
'               ',
'            }',
'            else if (reportType === "OUTWORK") {',
'                 apex.region("IR_MAIN4").refresh();',
'                $("#IR_MAIN4").show();',
'               ',
'            }',
'                 else if (reportType === "STOCK") {',
'                 apex.region("IR_MAIN5").refresh();',
'                     $("#IR_MAIN5").show();',
'               ',
'            }',
'                   else if (reportType === "DEMERIT") {',
'                 apex.region("IR_MAIN6").refresh();',
'                       $("#IR_MAIN6").show();',
'               ',
'            }',
'               else if (reportType === "GIT") {',
'                 apex.region("IR_MAIN7").refresh();',
'                   $("#IR_MAIN7").show();',
'               ',
'            }',
'            ',
'        }',
'    });',
'',
'});',
'',
'',
'',
'',
'',
'document.querySelectorAll(''.dash-card-value[data-format="number"]'').forEach(function(el){',
'    let val = el.textContent.trim().replace(/,/g, '''');',
'    if(!isNaN(val) && val !== "") {',
'        el.textContent = Number(val).toLocaleString(''en-IN'');',
'    }',
'});',
'',
'',
'$(function () {',
'',
'  // 1?? Initialize Date Range Picker',
'  $(''#P1000_DATE_RANGE'').daterangepicker({',
'      autoUpdateInput: false,',
'      opens: ''left'',',
'      locale: {',
'          format: ''DD/MM/YYYY'',',
'          cancelLabel: ''Clear''',
'      }',
'  });',
'',
'  // 2?? When user clicks Apply',
'  $(''#P1000_DATE_RANGE'').on(''apply.daterangepicker'', function (ev, picker) {',
'',
'      $(this).val(',
'          picker.startDate.format(''DD/MM/YYYY'') +',
'          '' - '' +',
'          picker.endDate.format(''DD/MM/YYYY'')',
'      );',
'',
'      apex.item(''P1000_FROM_DATE'').setValue(',
'          picker.startDate.format(''DD/MM/YYYY'')',
'      );',
'',
'      apex.item(''P1000_TO_DATE'').setValue(',
'          picker.endDate.format(''DD/MM/YYYY'')',
'      );',
'  });',
'',
'',
'    ',
'    // When user clicks Clear',
'$(''#P1000_DATE_RANGE'').on(''cancel.daterangepicker'', function () {',
'',
'    // Clear visible field',
'    $(this).val('''');',
'',
'    // Clear hidden date items',
'    apex.item(''P1000_FROM_DATE'').setValue('''');',
'    apex.item(''P1000_TO_DATE'').setValue('''');',
'',
'});',
'',
'',
'});',
''))
,p_css_file_urls=>wwv_flow_string.join(wwv_flow_t_varchar2(
'https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css',
''))
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#MAIN_REGION {',
'    background: linear-gradient(160deg,',
'        #eef2f7 0%,',
'        #d3def0 35%,',
'        #c2d2ee 100%',
'    );',
'    border-radius: 10px;',
'}',
'',
'',
'',
'.hide-item-complete {',
'  display: none !important;',
'}',
'',
'button.t-Button.dash-filter-btn {',
'  padding: 8px 18px !important;',
'  font-size: 13px !important;',
'  font-weight: 600 !important;',
'  border-radius: 14px !important;',
'',
'  /* SPECIAL AURORA GRADIENT */',
'  background: linear-gradient(135deg,',
'      #fdfefe 0%,',
'      #eef3ff 35%,',
'      #e6dcff 65%,',
'      #dbeafe 100%',
'  ) !important;',
'',
'  color: #1e1b4b !important;   /* deep indigo text */',
'  border: none !important;',
'',
'  box-shadow:',
'    0 10px 28px rgba(79,70,229,0.25),',
'    inset 0 1px 0 rgba(255,255,255,0.8);',
'',
'  transition: all .3s ease;',
'  margin-top: 20px;',
'}',
'',
'button.t-Button.dash-filter-btn:hover {',
'  background: linear-gradient(135deg,',
'      #f8faff 0%,',
'      #e9e4ff 40%,',
'      #dbeafe 100%',
'  ) !important;',
'',
'  box-shadow:',
'    0 14px 34px rgba(79,70,229,0.35);',
'',
'  transform: translateY(-2px);',
'}',
'',
'button.t-Button.dash-filter-btn:active {',
'  transform: translateY(0);',
'  box-shadow:',
'    inset 0 3px 8px rgba(0,0,0,0.18);',
'}',
'',
'button.t-Button.dash-filter-btn:focus {',
'  outline: none;',
'  box-shadow:',
'    0 0 0 4px rgba(139,92,246,0.35),',
'    0 12px 30px rgba(79,70,229,0.35);',
'}',
'',
'/* =======================================================',
'   PREMIUM DASHBOARD WRAPPER',
'======================================================= */',
'.dashboard-grid {',
'    position: relative;',
'    display: flex;',
'    flex-direction: column;',
'    gap: 8px;',
'    padding: 18px;',
'    width: 100%;',
'    font-family: ''Inter'',''Segoe UI'',sans-serif;',
'',
'    background: linear-gradient(150deg,',
'        #fbfcfe 0%,',
'        #eef1f7 30%,',
'        #d9e0f0 60%,',
'        #c1cbe2 100%',
'    );',
'    border-radius: 14px;',
'    box-shadow: 0 12px 30px rgba(50, 60, 120, 0.18);',
'',
'',
'}',
'',
'.dashboard-grid::before {',
'    content: "";',
'    position: absolute;',
'    inset: 0;',
'    border-radius: 14px;',
'    background: linear-gradient(180deg,',
'        rgba(255,255,255,0.55),',
'        rgba(255,255,255,0)',
'    );',
'    pointer-events: none;',
'}',
'',
'',
'',
'',
'',
'/* =======================================================',
'   TITLES',
'======================================================= */',
'.dash-title {',
'    font-size: 22px;',
'    font-weight: 700;',
'    margin: 0 0 8px 0;',
'    color: #0f172a;',
'    letter-spacing: -0.4px;',
'}',
'',
'/* =======================================================',
'   CARD GRID (WIDTH + SPACING CONTROL)',
'======================================================= */',
'.dash-row {',
'    display: grid;',
'    gap: 10px;',
'    grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));',
'}',
'',
'/* =======================================================',
'   CARD BASE (COMPACT + PREMIUM)',
'======================================================= */',
'.dash-card {',
'    position: relative;',
'    padding: 8px 10px;',
'    min-height: 50px;',
'    border-radius: 12px;',
'    text-align: center;',
'    overflow: hidden;',
'    cursor: pointer;',
'',
'    background: linear-gradient(145deg, #ffffff, #f3f4f6);',
'',
'    box-shadow:',
'        0 4px 12px rgba(0,0,0,0.10),',
'        0 8px 20px rgba(0,0,0,0.08);',
'',
'    border-left: 5px solid transparent;',
'    transition: 0.3s ease;',
'}',
'',
'/* =======================================================',
'   PREMIUM LIGHT COLOR THEMES',
'======================================================= */',
'.dash-card.theme-blue {',
'    border-left-color: #1e40af;',
'    background: linear-gradient(135deg, #f4f7ff, #e8eeff);',
'}',
'',
'.dash-card.theme-purple {',
'    border-left-color: #6d28d9;',
'    background: linear-gradient(135deg, #f8f1ff, #efe6ff);',
'}',
'',
'.dash-card.theme-green {',
'    border-left-color: #047857;',
'    background: linear-gradient(135deg, #f2fff8, #e3fdf2);',
'}',
'',
'.dash-card.theme-orange {',
'    border-left-color: #c2410c;',
'    background: linear-gradient(135deg, #fff4eb, #ffe7d5);',
'}',
'',
'.dash-card.theme-pink {',
'    border-left-color: #be185d;',
'    background: linear-gradient(135deg, #fff0f7, #ffe1f0);',
'}',
'',
'.dash-card.theme-cyan {',
'    border-left-color: #0e7490;',
'    background: linear-gradient(135deg, #f0fdff, #e1f8ff);',
'}',
'',
'.dash-card.theme-yellow {',
'    border-left-color: #ca8a04;',
'    background: linear-gradient(135deg, #fffbea, #fff3cf);',
'}',
'',
'/* =======================================================',
'   CARD CONTENT',
'======================================================= */',
'.dash-card-title {',
'    font-size: 14px;',
'    font-weight: 620;',
'    color: #475569;',
'    margin-bottom: 3px;',
'}',
'',
'.dash-card-value {',
'    font-size: 14px;',
'    font-weight: 700;',
'    color: #0f766e;',
'    letter-spacing: -0.1px;',
'}',
'',
'/* =======================================================',
'   HOVER EFFECT',
'======================================================= */',
'.dash-card:hover {',
'    transform: translateY(-3px) scale(1.02);',
'    box-shadow:',
'        0 10px 22px rgba(0,0,0,0.18),',
'        0 14px 32px rgba(0,0,0,0.14);',
'}',
'',
'/* =======================================================',
'   CLICKED / ACTIVE STATE',
'======================================================= */',
'.dash-card.clicked {',
'    transform: translateY(-4px) scale(1.04);',
'    filter: brightness(1.12);',
'    box-shadow:',
'        0 10px 24px rgba(0,0,0,0.16),',
'        0 6px 14px rgba(0,0,0,0.10);',
'    outline-offset: 2px;',
'}',
'',
'/* Theme-based outline on click */',
'.dash-card.theme-blue.clicked {',
'    outline: 1px solid rgba(37, 99, 235, 0.6);',
'}',
'.dash-card.theme-green.clicked {',
'    outline: 1px solid rgba(4, 120, 87, 0.6);',
'}',
'.dash-card.theme-purple.clicked {',
'    outline: 1px solid rgba(109, 40, 217, 0.6);',
'}',
'.dash-card.theme-orange.clicked {',
'    outline: 1px solid rgba(194, 65, 12, 0.6);',
'}',
'.dash-card.theme-pink.clicked {',
'    outline: 1px solid rgba(190, 24, 93, 0.6);',
'}',
'.dash-card.theme-cyan.clicked {',
'    outline: 1px solid rgba(14, 116, 144, 0.6);',
'}',
'.dash-card.theme-yellow.clicked {',
'    outline: 1px solid rgba(202, 138, 4, 0.6);',
'}',
'',
'',
'/* =======================================================',
'   FILTER BUTTON BAR',
'======================================================= */',
'.dash-filter-bar {',
'    display: flex;',
'    gap: 20px;',
'    margin-bottom: 5px;',
'    flex-wrap: wrap;',
'}',
'',
'.dash-filter-btn {',
'    padding: 6px 12px;',
'    font-size: 12px;',
'    font-weight: 600;',
'    border-radius: 8px;',
'    border: 1px solid #cbd5e1;',
'    background: #ffffff;',
'    color: #0f172a;',
'    cursor: pointer;',
'    transition: all 0.2s ease;',
'    box-shadow: 0 2px 6px rgba(0,0,0,0.08);',
'}',
'',
'.dash-filter-btn:hover {',
'    background: #f1f5f9;',
'    transform: translateY(-1px);',
'}',
'',
'.dash-filter-btn:active {',
'    background: #e2e8f0;',
'    transform: translateY(0);',
'}',
'',
'/* =======================================================',
'   RESPONSIVE COMPACT MODE',
'======================================================= */',
'@media (max-width: 1700px) {',
'    .dash-row {',
'        grid-template-columns: repeat(auto-fill, minmax(125px, 1fr));',
'    }',
'}',
'',
'',
'',
'',
'',
'',
'',
'',
'',
'/* ================================',
'   HIDE ALL IRs INITIALLY',
'================================ */',
'#IR_MAIN, ',
'#IR_MAIN2,',
'#IR_MAIN3,',
'#IR_MAIN4,',
'#IR_MAIN5,',
'#IR_MAIN6,',
'#IR_MAIN7,',
'#IR_MAIN8{',
'    display: none;',
'}',
'',
'/* ================================',
'   BODY CELLS (TD) ? LIGHT PREMIUM',
'================================ */',
'#IR_MAIN .a-IRR-table td,',
'#IR_MAIN2 .a-IRR-table td,',
'#IR_MAIN3 .a-IRR-table td,',
'#IR_MAIN4 .a-IRR-table td,',
'#IR_MAIN5 .a-IRR-table td,',
'#IR_MAIN6 .a-IRR-table td,',
'#IR_MAIN7 .a-IRR-table td,',
'#IR_MAIN8 .a-IRR-table td{',
'    background: linear-gradient(90deg, #fbfdff 0%, #f1f5fb 100%) !important;',
'    padding: 6px 8px !important;',
'    font-size: 9px !important;',
'    color: #1f2937 !important;',
'    border-color: #dbe3f3 !important;',
'    transition: 0.25s ease;',
'}',
'',
'/* ================================',
'   ROW HOVER ? SOFT PREMIUM GLOW',
'================================ */',
'#IR_MAIN .a-IRR-table tbody tr:hover td,',
'#IR_MAIN2 .a-IRR-table tbody tr:hover td,',
'#IR_MAIN3 .a-IRR-table tbody tr:hover td,',
'#IR_MAIN4 .a-IRR-table tbody tr:hover td,',
'#IR_MAIN5 .a-IRR-table tbody tr:hover td,',
'#IR_MAIN6 .a-IRR-table tbody tr:hover td,',
'#IR_MAIN7 .a-IRR-table tbody tr:hover td,',
'#IR_MAIN8 .a-IRR-table tbody tr:hover td{',
'    background: linear-gradient(90deg, #edf4ff 0%, #e3edff 100%) !important;',
'    cursor: pointer;',
'    box-shadow: inset 0 0 6px rgba(60, 100, 180, 0.18);',
'}',
'',
'/* ================================',
'   HEADER (TH) ? NPI STATUSX STYLE',
'================================ */',
'#IR_MAIN .a-IRR-table th,',
'#IR_MAIN2 .a-IRR-table th,',
'#IR_MAIN3 .a-IRR-table th,',
'#IR_MAIN4 .a-IRR-table th,',
'#IR_MAIN5 .a-IRR-table th,',
'#IR_MAIN6 .a-IRR-table th,',
'#IR_MAIN7 .a-IRR-table th,',
'#IR_MAIN8 .a-IRR-table th{',
' /*  background: linear-gradient(90deg, #1f2933 0%, #1e3a8a 100%) !important;*/',
'   /* background: linear-gradient(90deg, #334155 0%, #1e40af 100%) !important;*/',
'background: linear-gradient(90deg, #3b4a5f 0%, #2a55c5 100%) !important;',
'',
'    color: #ffffff !important;',
'    padding: 2px 4px !important;',
'    height: 7px !important;',
'    line-height: 1.2 !important;',
'}',
'',
'/* ================================',
'   HEADER TEXT ? CLEAN & EXECUTIVE',
'================================ */',
'#IR_MAIN .a-IRR-table th,',
'#IR_MAIN .a-IRR-table th span,',
'#IR_MAIN .a-IRR-table th a,',
'#IR_MAIN .a-IRR-table th .u-sort,',
'',
'#IR_MAIN2 .a-IRR-table th,',
'#IR_MAIN2 .a-IRR-table th span,',
'#IR_MAIN2 .a-IRR-table th a,',
'#IR_MAIN2 .a-IRR-table th .u-sort,',
'',
'#IR_MAIN3 .a-IRR-table th,',
'#IR_MAIN3 .a-IRR-table th span,',
'#IR_MAIN3 .a-IRR-table th a,',
'#IR_MAIN3 .a-IRR-table th .u-sort,',
'',
'#IR_MAIN6 .a-IRR-table th,',
'#IR_MAIN6 .a-IRR-table th span,',
'#IR_MAIN6 .a-IRR-table th a,',
'#IR_MAIN6 .a-IRR-table th .u-sort,',
'',
'#IR_MAIN7 .a-IRR-table th,',
'#IR_MAIN7 .a-IRR-table th span,',
'#IR_MAIN7 .a-IRR-table th a,',
'#IR_MAIN7 .a-IRR-table th .u-sort,',
'',
'#IR_MAIN8 .a-IRR-table th,',
'#IR_MAIN8 .a-IRR-table th span,',
'#IR_MAIN8 .a-IRR-table th a,',
'#IR_MAIN8 .a-IRR-table th .u-sort,',
'',
'#IR_MAIN4 .a-IRR-table th,',
'#IR_MAIN4 .a-IRR-table th span,',
'#IR_MAIN4 .a-IRR-table th a,',
'#IR_MAIN4 .a-IRR-table th .u-sort {',
'    color: #f8faff !important;',
'    font-size: 10px !important;',
'    font-weight: 650 !important;',
'    letter-spacing: 0.3px;',
'    text-transform: none !important;',
'    text-decoration: none !important;',
'}',
'#IR_MAIN5 .a-IRR-table th,',
'#IR_MAIN5 .a-IRR-table th span,',
'#IR_MAIN5 .a-IRR-table th a,',
'#IR_MAIN5 .a-IRR-table th .u-sort {',
'    color: #f8faff !important;',
'    font-size: 10px !important;',
'    font-weight: 650 !important;',
'    letter-spacing: 0.3px;',
'    text-transform: none !important;',
'    text-decoration: none !important;',
'}',
'',
'/* Prevent underline on hover */',
'#IR_MAIN .a-IRR-table th a:hover,',
'#IR_MAIN2 .a-IRR-table th a:hover,',
'#IR_MAIN3 .a-IRR-table th a:hover,',
'#IR_MAIN4 .a-IRR-table th a:hover,',
'#IR_MAIN5 .a-IRR-table th a:hover,',
'#IR_MAIN6 .a-IRR-table th a:hover,',
'#IR_MAIN7 .a-IRR-table th a:hover,',
'#IR_MAIN8 .a-IRR-table th a:hover',
'{',
'    color: #ffffff !important;',
'}',
'',
'/* ================================',
'   TABLE CONTAINER ? LIGHT CARD',
'================================ */',
'#IR_MAIN .a-IRR-table,',
'#IR_MAIN2 .a-IRR-table,',
'#IR_MAIN3 .a-IRR-table,',
'#IR_MAIN4 .a-IRR-table,',
'#IR_MAIN5 .a-IRR-table,',
'#IR_MAIN6 .a-IRR-table,',
'#IR_MAIN7 .a-IRR-table,',
'#IR_MAIN8 .a-IRR-table',
'{',
'    border-radius: 12px !important;',
'    overflow: hidden;',
'    border: 1px solid #dbe3f3 !important;',
'    box-shadow: 0 4px 14px rgba(0,0,0,0.06);',
'}',
'',
'/* ================================',
'   CELL BORDERS ? SOFT',
'================================ */',
'#IR_MAIN .a-IRR-table td,',
'#IR_MAIN .a-IRR-table th,',
'',
'#IR_MAIN2 .a-IRR-table td,',
'#IR_MAIN2 .a-IRR-table th,',
'',
'#IR_MAIN3 .a-IRR-table td,',
'#IR_MAIN3 .a-IRR-table th,',
'',
'#IR_MAIN4 .a-IRR-table td,',
'#IR_MAIN4 .a-IRR-table th {',
'    border-color: #dbe3f3 !important;',
'}',
'',
'#IR_MAIN5 .a-IRR-table td,',
'#IR_MAIN5 .a-IRR-table th {',
'    border-color: #dbe3f3 !important;',
'}',
'',
'',
'#IR_MAIN6 .a-IRR-table td,',
'#IR_MAIN6 .a-IRR-table th {',
'    border-color: #dbe3f3 !important;',
'}',
'',
'#IR_MAIN7 .a-IRR-table td,',
'#IR_MAIN7 .a-IRR-table th {',
'    border-color: #dbe3f3 !important;',
'}',
'',
'#IR_MAIN8 .a-IRR-table td,',
'#IR_MAIN8 .a-IRR-table th {',
'    border-color: #dbe3f3 !important;',
'}',
'',
'',
'',
'',
'body,',
'.t-PageBody {',
'   background-color: #f8fafc !important;',
'}',
'',
'',
'#IR_MAIN2 .a-IRR-tableContainer {',
'    overflow-x: auto !important;',
'    overflow-y: hidden;',
'}',
'',
'#IR_MAIN2 .a-IRR-table {',
'    min-width: 1800px !important;   /* increase if many columns */',
'    table-layout: auto !important;',
'}',
'',
'',
'',
''))
,p_page_template_options=>'#DEFAULT#'
,p_page_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(
'$(document).ready(function () {',
'    $(".dash-card").click(function () {',
'',
'        var reportType = $(this).data("report");',
'',
'        if (reportType) {',
'            apex.item("P1_SELECTED_REPORT").setValue(reportType);',
'',
'            // Hide all IR regions',
'            $("#IR_MAIN, #IR_MAIN2, #IR_MAIN3, #IR_MAIN4").hide();',
'',
'            // Show the correct report based on clicked card',
'            if (reportType === "INFLEX") {',
'                $("#IR_MAIN").show();',
'                apex.region("IR_MAIN").refresh();',
'            }',
'            else if (reportType === "ITEMMASTER") {',
'                $("#IR_MAIN2").show();',
'                apex.region("IR_MAIN2").refresh();',
'            }',
'            else if (reportType === "OUTRIGHT") {',
'                $("#IR_MAIN3").show();',
'                apex.region("IR_MAIN3").refresh();',
'            }',
'            else if (reportType === "OUTWORK") {',
'                $("#IR_MAIN4").show();',
'                apex.region("IR_MAIN4").refresh();',
'            }',
'        }',
'    });',
'});',
'',
'document.querySelectorAll(''.dash-card-value[data-format="number"]'').forEach(function(el){',
'    let val = el.textContent.trim().replace(/,/g, '''');',
'    if(!isNaN(val) && val !== "") {',
'        el.textContent = Number(val).toLocaleString(''en-IN'');',
'    }',
'});',
''))
,p_last_updated_by=>'KARTHIK_DOYENSYS'
,p_last_upd_yyyymmddhh24miss=>'20260214091114'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(6333989575327785812)
,p_plug_name=>'New'
,p_region_name=>'IR_MAIN8'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(5105460051616253014)
,p_plug_display_sequence=>50
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT',
'    PDIS_DATE,',
'    BRAND,',
'    THEME,',
'    COLLECTION_NAME, ',
'    COORDINATOR_NAME',
'FROM TJD_PON.TJD_PON_PDIS_COLL_TB',
'WHERE CREATED_DATE >= TO_DATE(:P1000_FROM_DATE, ''DD/MM/YYYY'')',
' AND CREATED_DATE <  TO_DATE(:P1000_TO_DATE, ''DD/MM/YYYY'') + 1',
' --AND  NVL(:P1000_SELECTED_REPORT, ''THEME'' ) = ''THEME'' ',
'  AND  :P1000_SELECTED_REPORT = ''THEME'' ',
'AND ( :P1000_COORDINATOR_NAME IS NULL',
'      OR (coordinator_name) = :P1000_COORDINATOR_NAME )',
'AND ( :P1000_BRAND IS NULL',
'      OR (brand) = :P1000_BRAND )',
'AND ( :P1000_COLLECTION_NAME IS NULL',
'      OR (collection_name) = :P1000_COLLECTION_NAME )      ',
'AND  :P1000_TOTAL_THEME <> ''0'' ;',
'',
''))
,p_plug_source_type=>'NATIVE_IG'
,p_ajax_items_to_submit=>'P1000_SELECTED_REPORT,P1000_TOTAL_THEME,P1000_BRAND,P1000_COLLECTION_NAME,P1000_COORDINATOR_NAME,P1000_FROM_DATE,P1000_TO_DATE'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'NEVER'
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(6333989735512785814)
,p_name=>'PDIS_DATE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PDIS_DATE'
,p_data_type=>'DATE'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DATE_PICKER'
,p_heading=>'Pdis Date'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>10
,p_value_alignment=>'CENTER'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
,p_is_required=>false
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_date_ranges=>'ALL'
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(6333989873073785815)
,p_name=>'BRAND'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'BRAND'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>'Brand'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>20
,p_value_alignment=>'LEFT'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
,p_is_required=>false
,p_max_length=>100
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(6333989964474785816)
,p_name=>'THEME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'THEME'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>'Theme'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>30
,p_value_alignment=>'LEFT'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
,p_is_required=>false
,p_max_length=>100
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(6333990005148785817)
,p_name=>'COLLECTION_NAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COLLECTION_NAME'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>'Collection Name'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>40
,p_value_alignment=>'LEFT'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
,p_is_required=>false
,p_max_length=>150
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(6333990195094785818)
,p_name=>'COORDINATOR_NAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COORDINATOR_NAME'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>'Coordinator Name'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>50
,p_value_alignment=>'LEFT'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
,p_is_required=>false
,p_max_length=>150
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_interactive_grid(
 p_id=>wwv_flow_api.id(6333989617814785813)
,p_internal_uid=>6333989617814785813
,p_is_editable=>false
,p_lazy_loading=>false
,p_requires_filter=>false
,p_show_nulls_as=>'-'
,p_select_first_row=>true
,p_pagination_type=>'SCROLL'
,p_show_total_row_count=>true
,p_show_toolbar=>true
,p_enable_save_public_report=>false
,p_enable_subscriptions=>true
,p_enable_flashback=>true
,p_define_chart_view=>true
,p_enable_download=>true
,p_enable_mail_download=>true
,p_fixed_header=>'PAGE'
,p_show_icon_view=>false
,p_show_detail_view=>false
);
wwv_flow_api.create_ig_report(
 p_id=>wwv_flow_api.id(6335844625879143107)
,p_interactive_grid_id=>wwv_flow_api.id(6333989617814785813)
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_api.create_ig_report_view(
 p_id=>wwv_flow_api.id(6335844768673143109)
,p_report_id=>wwv_flow_api.id(6335844625879143107)
,p_view_type=>'GRID'
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(6335845226412143120)
,p_view_id=>wwv_flow_api.id(6335844768673143109)
,p_display_seq=>1
,p_column_id=>wwv_flow_api.id(6333989735512785814)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(6335845788449143128)
,p_view_id=>wwv_flow_api.id(6335844768673143109)
,p_display_seq=>2
,p_column_id=>wwv_flow_api.id(6333989873073785815)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(6335846244479143132)
,p_view_id=>wwv_flow_api.id(6335844768673143109)
,p_display_seq=>3
,p_column_id=>wwv_flow_api.id(6333989964474785816)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(6335846780190143135)
,p_view_id=>wwv_flow_api.id(6335844768673143109)
,p_display_seq=>4
,p_column_id=>wwv_flow_api.id(6333990005148785817)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(6335847231879143138)
,p_view_id=>wwv_flow_api.id(6335844768673143109)
,p_display_seq=>5
,p_column_id=>wwv_flow_api.id(6333990195094785818)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(16884646340881382175)
,p_plug_name=>'In_Git'
,p_region_name=>'IR_MAIN7'
,p_region_template_options=>'#DEFAULT#:t-IRR-region--noBorders'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(5105460051616253014)
,p_plug_display_sequence=>120
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'WITH demerit AS (',
'  SELECT',
'     a.item_no,',
'         a.creation_date,',
'         a.defect_type,',
'         a.remarks,',
'         a.lot_number,',
'         a.reason_code',
'  FROM tnq_demerit_details a',
'  JOIN tjd_pon.tjd_pon_pdis_coll_tb b',
'    ON SUBSTR(a.item_no, 3, 7) = b.theme',
'  WHERE b.PDIS_DATE  >= TO_DATE(:P1000_FROM_DATE, ''DD/MM/YYYY'')',
'    AND b.PDIS_DATE  <  TO_DATE(:P1000_TO_DATE,   ''DD/MM/YYYY'') + 1 -- make end date inclusive',
'    AND ( :P1000_COORDINATOR_NAME IS NULL OR b.coordinator_name = :P1000_COORDINATOR_NAME )',
'    AND ( :P1000_BRAND            IS NULL OR b.brand            = :P1000_BRAND )',
'    AND ( :P1000_COLLECTION_NAME  IS NULL OR b.collection_name  = :P1000_COLLECTION_NAME )',
'      AND :P1000_SELECTED_REPORT = ''GIT''',
'    AND a.defect_type = ''ACCEPT''',
'),',
'xfer AS (',
'  -- All product_codes that qualify by transfer rules within date window',
'  SELECT  a.product_code',
'  FROM apps.tnq_opm_transfer_dtl_tb a',
'  JOIN tjd_pon.tjd_pon_pdis_coll_tb c',
'    ON SUBSTR(a.product_code, 3, 7) = c.theme',
'  WHERE c.PDIS_DATE  >= TO_DATE(:P1000_FROM_DATE, ''DD/MM/YYYY'')',
'    AND c.PDIS_DATE  <  TO_DATE(:P1000_TO_DATE,   ''DD/MM/YYYY'') + 1',
')',
'SELECT   a.item_no,',
'         a.creation_date,',
'         a.defect_type,',
'         a.remarks,',
'         a.lot_number,',
'         a.reason_code',
'FROM demerit a',
'LEFT JOIN xfer x',
'  ON x.product_code = a.item_no',
'WHERE x.product_code IS NULL',
'AND NVL(:P1000_GIT_COUNT, ''0'') <> ''0'';',
'',
''))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P1000_SELECTED_REPORT,P1000_FROM_DATE,P1000_TO_DATE,P1000_COORDINATOR_NAME,P1000_BRAND,P1000_COLLECTION_NAME,P1000_GIT_COUNT'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'LETTER'
,p_prn_width=>8.5
,p_prn_height=>11
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header_font_color=>'#000000'
,p_prn_page_header_font_family=>'Helvetica'
,p_prn_page_header_font_weight=>'normal'
,p_prn_page_header_font_size=>'12'
,p_prn_page_footer_font_color=>'#000000'
,p_prn_page_footer_font_family=>'Helvetica'
,p_prn_page_footer_font_weight=>'normal'
,p_prn_page_footer_font_size=>'12'
,p_prn_header_bg_color=>'#9bafde'
,p_prn_header_font_color=>'#000000'
,p_prn_header_font_family=>'Helvetica'
,p_prn_header_font_weight=>'normal'
,p_prn_header_font_size=>'10'
,p_prn_body_bg_color=>'#efefef'
,p_prn_body_font_color=>'#000000'
,p_prn_body_font_family=>'Helvetica'
,p_prn_body_font_weight=>'normal'
,p_prn_body_font_size=>'10'
,p_prn_border_width=>.5
,p_prn_page_header_alignment=>'CENTER'
,p_prn_page_footer_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(16884646401746382176)
,p_max_row_count=>'1000'
,p_max_rows_per_page=>'50'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:XLS'
,p_download_filename=>'GIT'
,p_csv_output_separator=>','
,p_owner=>'SRIDHAR'
,p_internal_uid=>16884646401746382176
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(6125919749137270010)
,p_db_column_name=>'DEFECT_TYPE'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Defect Type'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(6125920102319270010)
,p_db_column_name=>'ITEM_NO'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Item No'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(6125920555950270011)
,p_db_column_name=>'REMARKS'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Remarks'
,p_column_type=>'STRING'
);
end;
/
begin
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(6125920926740270011)
,p_db_column_name=>'LOT_NUMBER'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'Lot Number'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(6125921322250270011)
,p_db_column_name=>'REASON_CODE'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>'Reason Code'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(6243381252966676414)
,p_db_column_name=>'CREATION_DATE'
,p_display_order=>60
,p_column_identifier=>'G'
,p_column_label=>'Creation Date'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(16886967883140100193)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'61259217'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'DEFECT_TYPE:ITEM_NO:REMARKS:LOT_NUMBER:REASON_CODE:CREATION_DATE'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(16884647102137382183)
,p_plug_name=>'In_themes'
,p_region_name=>'IR_MAIN8'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(5105460051616253014)
,p_plug_display_sequence=>40
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT',
'    PDIS_DATE,',
'    BRAND,',
'    THEME,',
'    COLLECTION_NAME, ',
'    COORDINATOR_NAME',
'FROM TJD_PON.TJD_PON_PDIS_COLL_TB',
'WHERE CREATED_DATE >= TO_DATE(:P1000_FROM_DATE, ''DD/MM/YYYY'')',
' AND CREATED_DATE <  TO_DATE(:P1000_TO_DATE, ''DD/MM/YYYY'') + 1',
' AND  NVL(:P1000_SELECTED_REPORT, ''DEFAULT'' ) = ''THEME'' ',
'  --AND  ( :P1000_SELECTED_REPORT IS NOT NULL  AND :P1000_SELECTED_REPORT = ''THEME'' )',
'AND ( :P1000_COORDINATOR_NAME IS NULL',
'      OR (coordinator_name) = :P1000_COORDINATOR_NAME )',
'AND ( :P1000_BRAND IS NULL',
'      OR (brand) = :P1000_BRAND )',
'AND ( :P1000_COLLECTION_NAME IS NULL',
'      OR (collection_name) = :P1000_COLLECTION_NAME )      ',
'AND  :P1000_TOTAL_THEME <> ''0'' ;',
'',
''))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P1000_SELECTED_REPORT,P1000_TO_DATE,P1000_FROM_DATE,P1000_BRAND,P1000_COORDINATOR_NAME,P1000_COLLECTION_NAME,P1000_TOTAL_THEME'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'LETTER'
,p_prn_width=>8.5
,p_prn_height=>11
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header_font_color=>'#000000'
,p_prn_page_header_font_family=>'Helvetica'
,p_prn_page_header_font_weight=>'normal'
,p_prn_page_header_font_size=>'12'
,p_prn_page_footer_font_color=>'#000000'
,p_prn_page_footer_font_family=>'Helvetica'
,p_prn_page_footer_font_weight=>'normal'
,p_prn_page_footer_font_size=>'12'
,p_prn_header_bg_color=>'#9bafde'
,p_prn_header_font_color=>'#000000'
,p_prn_header_font_family=>'Helvetica'
,p_prn_header_font_weight=>'normal'
,p_prn_header_font_size=>'10'
,p_prn_body_bg_color=>'#efefef'
,p_prn_body_font_color=>'#000000'
,p_prn_body_font_family=>'Helvetica'
,p_prn_body_font_weight=>'normal'
,p_prn_body_font_size=>'10'
,p_prn_border_width=>.5
,p_prn_page_header_alignment=>'CENTER'
,p_prn_page_footer_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(16884647186117382184)
,p_max_row_count=>'10000'
,p_max_rows_per_page=>'50'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:XLS'
,p_download_filename=>'Theme Count'
,p_csv_output_separator=>','
,p_owner=>'SRIDHAR'
,p_internal_uid=>16884647186117382184
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(6125922474799270013)
,p_db_column_name=>'PDIS_DATE'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'PDIS Date'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(6125922889154270013)
,p_db_column_name=>'BRAND'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Brand'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(6125923282541270013)
,p_db_column_name=>'THEME'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Theme'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(6125923695732270014)
,p_db_column_name=>'COLLECTION_NAME'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'Collection Name'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(6125924040942270014)
,p_db_column_name=>'COORDINATOR_NAME'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>'Coordinator Name'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(16887010962016323998)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'61259244'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'PDIS_DATE:BRAND:THEME:COLLECTION_NAME:COORDINATOR_NAME'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(18762662126361566643)
,p_plug_name=>'In_flex_report'
,p_region_name=>'IR_MAIN'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(5105460051616253014)
,p_plug_display_sequence=>60
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT',
'    ffv.flex_value,',
'    ffv.attribute1,',
'    ffv.attribute11,',
'    ffv.attribute13,',
'    ffv.attribute24,',
'    ffv.attribute25,',
'    ffv.attribute29,',
'    TO_DATE(ffv.attribute16, ''DD/MM/YYYY'') attribute16',
'FROM apps.tjd_pon_fnd_flex_values_v ffv',
'JOIN apps.tjd_pon_fnd_flex_values_tl_v ffvt',
'    ON ffv.flex_value_id = ffvt.flex_value_id',
'JOIN tjd_pon.tjd_pon_fnd_flex_value_sets_v ffvs',
'    ON ffv.flex_value_set_id = ffvs.flex_value_set_id',
'   AND ffvs.flex_value_set_name = ''THEME_DESIGN''',
'JOIN tjd_pon.tjd_pon_pdis_coll_tb p',
'    ON p.theme = ffv.flex_value',
'WHERE ffv.flex_value IS NOT NULL',
'AND p.coordinator_name = NVL(:P1000_COORDINATOR_NAME, p.coordinator_name)',
'AND p.brand            = NVL(:P1000_BRAND, p.brand)',
'AND p.collection_name  = NVL(:P1000_COLLECTION_NAME, p.collection_name)',
'AND P.PDIS_DATE >= TO_DATE(:P1000_FROM_DATE, ''DD/MM/YYYY'')',
'AND P.PDIS_DATE <  TO_DATE(:P1000_TO_DATE,   ''DD/MM/YYYY'') + 1',
'AND :P1000_SELECTED_REPORT = ''INFLEX''',
'AND  :P1000_VALUE_COUNT <> ''0''',
'  AND NOT EXISTS (',
'        SELECT 1',
'        FROM apps.mtl_system_items_b m',
'        WHERE substr(m.segment1,3,7) = ffv.flex_value',
'          AND  m.organization_id = 122)',
'AND NOT EXISTS (',
'  SELECT 1',
'  FROM tnq_demerit_details d',
'  WHERE SUBSTR(d.item_no, 3, 7) = ffv.flex_value)',
'AND NOT EXISTS (',
'    SELECT 1',
'      FROM TJD_PON.TJD_PON_OWK_JWK_TBL e',
'      WHERE  SUBSTR(e.PRODUCT, 3, 7)     = ffv.flex_value)',
'AND NOT EXISTS (',
'     SELECT 1',
'       FROM tjd_pon.tjd_po_outright_vp_apex_tbl t ',
'      WHERE SUBSTR(t.ITEM_CODE, 3, 7) = ffv.flex_value);      ',
''))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P1000_BRAND,P1000_COORDINATOR_NAME,P1000_COLLECTION_NAME,P1000_TO_DATE,P1000_FROM_DATE,P1000_SELECTED_REPORT,P1000_VALUE_COUNT'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'LETTER'
,p_prn_width=>8.5
,p_prn_height=>11
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header_font_color=>'#000000'
,p_prn_page_header_font_family=>'Helvetica'
,p_prn_page_header_font_weight=>'normal'
,p_prn_page_header_font_size=>'12'
,p_prn_page_footer_font_color=>'#000000'
,p_prn_page_footer_font_family=>'Helvetica'
,p_prn_page_footer_font_weight=>'normal'
,p_prn_page_footer_font_size=>'12'
,p_prn_header_bg_color=>'#9bafde'
,p_prn_header_font_color=>'#000000'
,p_prn_header_font_family=>'Helvetica'
,p_prn_header_font_weight=>'normal'
,p_prn_header_font_size=>'10'
,p_prn_body_bg_color=>'#efefef'
,p_prn_body_font_color=>'#000000'
,p_prn_body_font_family=>'Helvetica'
,p_prn_body_font_weight=>'normal'
,p_prn_body_font_size=>'10'
,p_prn_border_width=>.5
,p_prn_page_header_alignment=>'CENTER'
,p_prn_page_footer_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(18762661966522566642)
,p_max_row_count=>'10000'
,p_max_rows_per_page=>'50'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:XLS'
,p_download_filename=>'In Flex'
,p_csv_output_separator=>','
,p_owner=>'KARTHIK_DOYENSYS'
,p_internal_uid=>18762661966522566642
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(6125927999649270018)
,p_db_column_name=>'FLEX_VALUE'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Flex Value'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(6125927537112270018)
,p_db_column_name=>'ATTRIBUTE1'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Collection Name'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(6125927123395270017)
,p_db_column_name=>'ATTRIBUTE11'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Complexity'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(6125926714936270017)
,p_db_column_name=>'ATTRIBUTE13'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'karatage'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(6125926310466270017)
,p_db_column_name=>'ATTRIBUTE24'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>'CADpb'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(6125925901380270016)
,p_db_column_name=>'ATTRIBUTE25'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>'CFA'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(6125925583273270016)
,p_db_column_name=>'ATTRIBUTE29'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>'Design Source'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(6125925108808270015)
,p_db_column_name=>'ATTRIBUTE16'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>'Theme code created Date'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(18757310483493837345)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'61259283'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'ATTRIBUTE16:FLEX_VALUE:ATTRIBUTE1:ATTRIBUTE11:ATTRIBUTE13:ATTRIBUTE24:ATTRIBUTE25:ATTRIBUTE29:'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(18828295524044853021)
,p_plug_name=>'In_Demerit'
,p_region_name=>'IR_MAIN6'
,p_region_template_options=>'#DEFAULT#:t-IRR-region--noBorders'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(5105460051616253014)
,p_plug_display_sequence=>110
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT defect_type,',
'       item_no,',
'       remarks,',
'       lot_number,',
'       reason_code ',
'FROM tnq_demerit_details A,',
'     tjd_pon.tjd_pon_pdis_coll_tb B',
'WHERE substr(A.item_no, 3, 7) = B.theme',
'AND A.CREATION_DATE >= TO_DATE(:P1000_FROM_DATE,''DD/MM/YYYY'')',
'AND A.CREATION_DATE < TO_DATE(:P1000_TO_DATE,''DD/MM/YYYY'')',
'AND :P1000_DEMERIT_COUNT <> ''0''',
'AND :P1000_SELECTED_REPORT =''DEMERIT''',
'--AND NVL(:P1000_SELECTED_REPORT,''DEMERIT'') = ''DEMERIT''',
'AND DEFECT_TYPE = ''REJECT''',
'AND ( :P1000_COORDINATOR_NAME IS NULL',
'            OR B.coordinator_name = :P1000_COORDINATOR_NAME )',
'      AND ( :P1000_BRAND IS NULL',
'            OR B.brand = :P1000_BRAND )',
'AND  ( :P1000_COLLECTION_NAME IS NULL',
'      OR (collection_name) = :P1000_COLLECTION_NAME );',
''))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P1000_SELECTED_REPORT,P1000_FROM_DATE,P1000_TO_DATE,P1000_DEMERIT_COUNT,P1000_COORDINATOR_NAME,P1000_BRAND,P1000_COLLECTION_NAME'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'LETTER'
,p_prn_width=>8.5
,p_prn_height=>11
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header_font_color=>'#000000'
,p_prn_page_header_font_family=>'Helvetica'
,p_prn_page_header_font_weight=>'normal'
,p_prn_page_header_font_size=>'12'
,p_prn_page_footer_font_color=>'#000000'
,p_prn_page_footer_font_family=>'Helvetica'
,p_prn_page_footer_font_weight=>'normal'
,p_prn_page_footer_font_size=>'12'
,p_prn_header_bg_color=>'#9bafde'
,p_prn_header_font_color=>'#000000'
,p_prn_header_font_family=>'Helvetica'
,p_prn_header_font_weight=>'normal'
,p_prn_header_font_size=>'10'
,p_prn_body_bg_color=>'#efefef'
,p_prn_body_font_color=>'#000000'
,p_prn_body_font_family=>'Helvetica'
,p_prn_body_font_weight=>'normal'
,p_prn_body_font_size=>'10'
,p_prn_border_width=>.5
,p_prn_page_header_alignment=>'CENTER'
,p_prn_page_footer_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(18828295360673853020)
,p_max_row_count=>'1000'
,p_max_rows_per_page=>'50'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:XLS'
,p_download_filename=>'Demerit'
,p_csv_output_separator=>','
,p_owner=>'KARTHIK_DOYENSYS'
,p_internal_uid=>18828295360673853020
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(6125930618172270023)
,p_db_column_name=>'DEFECT_TYPE'
,p_display_order=>10
,p_column_identifier=>'B'
,p_column_label=>'Defect Type'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(6125930228241270022)
,p_db_column_name=>'ITEM_NO'
,p_display_order=>20
,p_column_identifier=>'C'
,p_column_label=>'Item No'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(6125929826513270022)
,p_db_column_name=>'REMARKS'
,p_display_order=>30
,p_column_identifier=>'D'
,p_column_label=>'Remarks'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(6125929481318270022)
,p_db_column_name=>'LOT_NUMBER'
,p_display_order=>40
,p_column_identifier=>'E'
,p_column_label=>'Lot Number'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(6125929055925270021)
,p_db_column_name=>'REASON_CODE'
,p_display_order=>50
,p_column_identifier=>'F'
,p_column_label=>'Reason Code'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(18762632636408508255)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'61259310'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'DEFECT_TYPE:ITEM_NO:REMARKS:LOT_NUMBER:REASON_CODE'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(18828298603912853052)
,p_plug_name=>'In_Stock'
,p_region_name=>'IR_MAIN5'
,p_region_template_options=>'#DEFAULT#:t-IRR-region--noBorders'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(5105460051616253014)
,p_plug_display_sequence=>100
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT',
'   a.INWARD_SL_NO ,',
'    b.warehouse        AS whs_code,',
'   -- NULL               AS inv_code,',
'   -- NULL               AS location,',
'    a.product_code   Product_code,',
'    a.ORDER_NUMBER          AS order_number,',
'    a.BATCH_ID         AS BATCH_ID,',
'    --NULL               AS lotnumber,',
'    a.qty2,',
'    --NULL               AS vendor_name,',
'     (  select vendor_name_alt ',
'       from apps.tjd_ap_suppliers_vp_apex_v v',
'      where v.segment1 =b.vendor_code) vendor_code ,',
'   -- NULL               AS approx_ucp_value,',
'    b.status',
'FROM tnq_opm_transfer_dtl_tb a',
'JOIN tnq_opm_transfer_hdr_tb b',
'    ON a.header_id = b.transfer_no',
'JOIN TJD_PON.TJD_PON_PDIS_COLL_TB t',
'    ON SUBSTR(a.product_code, 3, 7) = t.theme',
'WHERE b.waybill_date IS NOT NULL',
'  AND b.waybill_date >= NVL(',
'        TO_DATE(:P1000_FROM_DATE, ''DD/MM/YYYY''),',
'        ADD_MONTHS(TRUNC(SYSDATE), -6)',
'      )',
'  AND b.waybill_date < NVL(',
'        TO_DATE(:P1000_TO_DATE, ''DD/MM/YYYY'') + 1,',
'        TRUNC(SYSDATE) + 1',
'      )',
'  AND :P1000_STOCK_COUNT <> ''0''  ',
'  --AND NVL(:P1000_SELECTED_REPORT,''STOCK'') = ''STOCK''',
' AND :P1000_SELECTED_REPORT = ''STOCK''',
'AND ( :P1000_COORDINATOR_NAME IS NULL',
'            OR t.coordinator_name= :P1000_COORDINATOR_NAME )',
'      AND ( :P1000_BRAND IS NULL',
'            OR t.brand = :P1000_BRAND )',
'AND  ( :P1000_COLLECTION_NAME IS NULL',
'      OR (collection_name) = :P1000_COLLECTION_NAME )             ;',
''))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P1000_SELECTED_REPORT,P1000_FROM_DATE,P1000_TO_DATE,P1000_COORDINATOR_NAME,P1000_BRAND,P1000_COLLECTION_NAME,P1000_STOCK_COUNT'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'LETTER'
,p_prn_width=>8.5
,p_prn_height=>11
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header_font_color=>'#000000'
,p_prn_page_header_font_family=>'Helvetica'
,p_prn_page_header_font_weight=>'normal'
,p_prn_page_header_font_size=>'12'
,p_prn_page_footer_font_color=>'#000000'
,p_prn_page_footer_font_family=>'Helvetica'
,p_prn_page_footer_font_weight=>'normal'
,p_prn_page_footer_font_size=>'12'
,p_prn_header_bg_color=>'#9bafde'
,p_prn_header_font_color=>'#000000'
,p_prn_header_font_family=>'Helvetica'
,p_prn_header_font_weight=>'normal'
,p_prn_header_font_size=>'10'
,p_prn_body_bg_color=>'#efefef'
,p_prn_body_font_color=>'#000000'
,p_prn_body_font_family=>'Helvetica'
,p_prn_body_font_weight=>'normal'
,p_prn_body_font_size=>'10'
,p_prn_border_width=>.5
,p_prn_page_header_alignment=>'CENTER'
,p_prn_page_footer_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(18828298471888853051)
,p_max_row_count=>'1000'
,p_max_rows_per_page=>'50'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:XLS'
,p_download_filename=>'Stock'
,p_csv_output_separator=>','
,p_owner=>'KARTHIK_DOYENSYS'
,p_internal_uid=>18828298471888853051
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(6125916605111270006)
,p_db_column_name=>'INWARD_SL_NO'
,p_display_order=>10
,p_column_identifier=>'L'
,p_column_label=>'Inward SL No'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(6125915874326270005)
,p_db_column_name=>'BATCH_ID'
,p_display_order=>20
,p_column_identifier=>'N'
,p_column_label=>'Batch ID'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(6125918657092270008)
,p_db_column_name=>'WHS_CODE'
,p_display_order=>30
,p_column_identifier=>'B'
,p_column_label=>'Warehouse Code'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(6125918235942270008)
,p_db_column_name=>'PRODUCT_CODE'
,p_display_order=>40
,p_column_identifier=>'E'
,p_column_label=>'Product Code'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(6125917818718270007)
,p_db_column_name=>'QTY2'
,p_display_order=>50
,p_column_identifier=>'G'
,p_column_label=>'Qty2'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(6125917414614270007)
,p_db_column_name=>'VENDOR_CODE'
,p_display_order=>60
,p_column_identifier=>'I'
,p_column_label=>'Vendor Code'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(6125917097374270006)
,p_db_column_name=>'STATUS'
,p_display_order=>70
,p_column_identifier=>'K'
,p_column_label=>'Status'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(6125916215812270006)
,p_db_column_name=>'ORDER_NUMBER'
,p_display_order=>80
,p_column_identifier=>'M'
,p_column_label=>'Order Number'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(18810103629241525859)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'61259190'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'INWARD_SL_NO:BATCH_ID:WHS_CODE:PRODUCT_CODE:ORDER_NUMBER:QTY2:VENDOR_CODE:STATUS:'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(25575306541737096357)
,p_plug_name=>'Dashboard'
,p_region_name=>'dash'
,p_region_template_options=>'#DEFAULT#:t-Form--noPadding:margin-top-none:margin-bottom-none'
,p_plug_template=>wwv_flow_api.id(5105485381557252983)
,p_plug_display_sequence=>30
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="dashboard-grid">',
'',
'  <!-- Row 2 - Dynamic Summary Values -->',
'  <div class="dash-row">',
'',
'    <div class="dash-card theme-blue" data-report= "THEME">',
'      <div class="dash-card-title">Total Count</div>',
'      <div class="dash-card-value" id="val_total"> &P1000_TOTAL_THEME.</div>',
'    </div>',
'',
'    <div class="dash-card theme-green" data-report= "INFLEX">',
'      <div class="dash-card-title">In Flex Value</div>',
'       <div class="dash-card-value" id="val_total1">',
'  &P1000_VALUE_COUNT.',
'</div>',
'    </div>',
'',
'    <div class="dash-card theme-purple" data-report="ITEMMASTER">',
'      <div class="dash-card-title">In Item Master</div>',
'      <div class="dash-card-value" id="val_item">&P1000_ITEM_COUNT.</div>',
'    </div>',
'',
'    <div class="dash-card theme-orange" data-report="OUTWORK">',
'      <div class="dash-card-title">In Outwork WIP</div>',
'      <div class="dash-card-value" id="val_outwork">&P1000_OUTWORK_COUNT.</div>',
'    </div>',
'',
'    <div class="dash-card theme-pink" data-report="OUTRIGHT">',
'      <div class="dash-card-title">In Outright WIP</div>',
'      <div class="dash-card-value" id="val_outright">&P1000_OUTRIGHT_COUNT.</div>',
'    </div>',
'',
'    <div class="dash-card theme-cyan" data-report="DEMERIT">',
'      <div class="dash-card-title">In Demerit</div>',
'      <div class="dash-card-value" id="val_demerit">&P1000_DEMERIT_COUNT.</div>',
'    </div>',
'    ',
'     <div class="dash-card theme-cyan" data-report="GIT">',
'      <div class="dash-card-title">GIT</div>',
'      <div class="dash-card-value" id="val_git">&P1000_GIT_COUNT.</div>',
'    </div>',
'    ',
'     <div class="dash-card theme-yellow"  data-report="STOCK">',
'      <div class="dash-card-title">Stock</div>',
'      <div class="dash-card-value" id="val_stock">&P1000_STOCK_COUNT.</div>',
'    </div>',
'',
'  </div>',
'',
'</div>',
''))
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
,p_plug_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(
' <!-- Row 1 - Filter Cards -->',
'  <div class="dash-row">',
'',
'    <div class="dash-card" data-filter="INCHARGE">',
'      <div class="dash-card-title">Collection Incharge Filter</div>',
'    </div>',
'',
'    <div class="dash-card" data-filter="COLLECTION">',
'      <div class="dash-card-title">Collection Filter</div>',
'    </div>',
'',
'    <div class="dash-card" data-filter="BRAND">',
'      <div class="dash-card-title">Brand Filter Name</div>',
'    </div>',
'',
'  </div>'))
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(25579416363322931803)
,p_plug_name=>'NPI Proto Tracker'
,p_icon_css_classes=>'app-icon'
,p_region_template_options=>'#DEFAULT#:t-HeroRegion--iconsCircle:t-Form--slimPadding'
,p_plug_template=>wwv_flow_api.id(5105467720972253003)
,p_plug_display_sequence=>20
,p_plug_display_point=>'REGION_POSITION_01'
,p_plug_query_num_rows=>15
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'NEVER'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(25579563889064379423)
,p_plug_name=>'In_Item_Master'
,p_region_name=>'IR_MAIN2'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(5105460051616253014)
,p_plug_display_sequence=>70
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT',
'    DISTINCT m.segment1   AS item_code ,',
'    m.primary_uom_code,',
'    m.attribute1          AS brand,',
'    m.attribute4          AS karatage,',
'    m.attribute6          AS theme,',
'    m.attribute7          AS prod_catgry,',
'    m.attribute21         AS plating,',
'    m.attribute28         AS finising,',
'    m.attribute30         AS "Mfg source",',
'    c.attribute1          AS std_weight,',
'    c.attribute4          AS f1_price,',
'    c.attribute5          AS f2_price,',
'    c.attribute6          AS total_price,',
'    m.attribute22         AS status,',
'    m.ATTRIBUTE24         AS IsForIndent,',
'    m.attribute30         AS source',
'    FROM mtl_system_items_b m',
'',
'JOIN TJD_PON.TJD_PON_PDIS_COLL_TB p',
'     ON p.theme = SUBSTR(m.segment1, 3, 7)',
'    AND p.PDIS_DATE >= TO_DATE(:P1000_FROM_DATE, ''DD/MM/YYYY'')',
'    AND p.PDIS_DATE <  TO_DATE(:P1000_TO_DATE, ''DD/MM/YYYY'') + 1',
'    AND ( :P1000_COORDINATOR_NAME IS NULL',
'      OR p.coordinator_name = :P1000_COORDINATOR_NAME )',
'    AND ( :P1000_BRAND IS NULL',
'      OR p.brand = :P1000_BRAND )',
'    AND ( :P1000_COLLECTION_NAME IS NULL',
'      OR p.collection_name = :P1000_COLLECTION_NAME )',
'',
'',
'JOIN apps.tjd_pon_mtl_cross_references_vw c',
'     ON c.inventory_item_id = m.inventory_item_id',
'    AND c.CROSS_REFERENCE_TYPE = ''Pricing Information''',
'',
'  ',
'LEFT JOIN (',
'        SELECT DISTINCT item_code',
'        FROM tjd_pon.tjd_po_outright_vp_apex_tbl',
') o',
'     ON o.item_code = m.segment1',
'  ',
'LEFT JOIN (',
'        SELECT DISTINCT product',
'        FROM TJD_PON.TJD_PON_OWK_JWK_TBL',
'        WHERE order_type = ''PROTO ORDER''',
') w',
'     ON w.product = m.segment1',
'',
'LEFT JOIN(',
'     SELECT DISTINCT product_code',
'     FROM tnq_opm_transfer_dtl_tb',
') s',
'    ON s.product_code = m.segment1',
'LEFT JOIN(',
'     SELECT DISTINCT item_no',
'     FROM tnq_demerit_details',
') g',
'    ON g.item_no = m.segment1',
'     WHERE m.organization_id = 122',
'      AND :P1000_SELECTED_REPORT = ''ITEMMASTER''',
'      AND m.attribute22 <> ''D''',
'      AND :P1000_ITEM_COUNT <> ''0''',
'      AND o.item_code IS NULL',
'      AND w.product IS NULL',
'      AND s.product_code IS NULL',
'      AND g.item_no IS NULL',
'     ',
'      ',
'',
'    ',
'      ',
' '))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P1000_SELECTED_REPORT,P1000_TO_DATE,P1000_FROM_DATE,P1000_ITEM_COUNT,P1000_BRAND,P1000_COORDINATOR_NAME,P1000_COLLECTION_NAME'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'LETTER'
,p_prn_width=>8.5
,p_prn_height=>11
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header_font_color=>'#000000'
,p_prn_page_header_font_family=>'Helvetica'
,p_prn_page_header_font_weight=>'normal'
,p_prn_page_header_font_size=>'12'
,p_prn_page_footer_font_color=>'#000000'
,p_prn_page_footer_font_family=>'Helvetica'
,p_prn_page_footer_font_weight=>'normal'
,p_prn_page_footer_font_size=>'12'
,p_prn_header_bg_color=>'#9bafde'
,p_prn_header_font_color=>'#000000'
,p_prn_header_font_family=>'Helvetica'
,p_prn_header_font_weight=>'normal'
,p_prn_header_font_size=>'10'
,p_prn_body_bg_color=>'#efefef'
,p_prn_body_font_color=>'#000000'
,p_prn_body_font_family=>'Helvetica'
,p_prn_body_font_weight=>'normal'
,p_prn_body_font_size=>'10'
,p_prn_border_width=>.5
,p_prn_page_header_alignment=>'CENTER'
,p_prn_page_footer_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(25579563966072379424)
,p_max_row_count=>'10000'
,p_max_rows_per_page=>'50'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:XLS'
,p_download_filename=>'Item Master'
,p_csv_output_separator=>','
,p_owner=>'SRIDHAR'
,p_internal_uid=>25579563966072379424
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(6125796626966269980)
,p_db_column_name=>'PRIMARY_UOM_CODE'
,p_display_order=>20
,p_column_identifier=>'J'
,p_column_label=>'Primary Uom Code'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(6125796233926269980)
,p_db_column_name=>'BRAND'
,p_display_order=>30
,p_column_identifier=>'K'
,p_column_label=>'Brand'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(6125791843237269975)
,p_db_column_name=>'KARATAGE'
,p_display_order=>40
,p_column_identifier=>'W'
,p_column_label=>'Karatage'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(6125795810087269979)
,p_db_column_name=>'THEME'
,p_display_order=>50
,p_column_identifier=>'L'
,p_column_label=>'Theme'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(6125791454831269975)
,p_db_column_name=>'PROD_CATGRY'
,p_display_order=>60
,p_column_identifier=>'X'
,p_column_label=>'Prod Catgry'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(6125795494617269979)
,p_db_column_name=>'PLATING'
,p_display_order=>70
,p_column_identifier=>'N'
,p_column_label=>'Plating'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(6125795043396269979)
,p_db_column_name=>'FINISING'
,p_display_order=>80
,p_column_identifier=>'O'
,p_column_label=>'Finising'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(6125794684491269978)
,p_db_column_name=>'Mfg source'
,p_display_order=>90
,p_column_identifier=>'P'
,p_column_label=>'Mfg Source'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(6125794260065269978)
,p_db_column_name=>'STD_WEIGHT'
,p_display_order=>100
,p_column_identifier=>'Q'
,p_column_label=>'Std Weight'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(6125793886727269977)
,p_db_column_name=>'F1_PRICE'
,p_display_order=>110
,p_column_identifier=>'R'
,p_column_label=>'F1 Price'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(6125793471278269977)
,p_db_column_name=>'F2_PRICE'
,p_display_order=>120
,p_column_identifier=>'S'
,p_column_label=>'F2 Price'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(6125793041711269977)
,p_db_column_name=>'TOTAL_PRICE'
,p_display_order=>130
,p_column_identifier=>'T'
,p_column_label=>'Total Price'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(6125792601957269976)
,p_db_column_name=>'ISFORINDENT'
,p_display_order=>140
,p_column_identifier=>'U'
,p_column_label=>'Isforindent'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(6125792287015269976)
,p_db_column_name=>'SOURCE'
,p_display_order=>150
,p_column_identifier=>'V'
,p_column_label=>'Source'
,p_column_type=>'STRING'
);
end;
/
begin
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(6125791066674269974)
,p_db_column_name=>'STATUS'
,p_display_order=>160
,p_column_identifier=>'Y'
,p_column_label=>'Status'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(6125790671046269973)
,p_db_column_name=>'ITEM_CODE'
,p_display_order=>170
,p_column_identifier=>'Z'
,p_column_label=>'Item Code'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(25580474987461519424)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'61257970'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'ITEM_CODE:PRIMARY_UOM_CODE:BRAND:KARATAGE:THEME:PLATING:FINISING:Mfg source:STD_WEIGHT:F1_PRICE:F2_PRICE:TOTAL_PRICE:ISFORINDENT:SOURCE:PROD_CATGRY:STATUS:'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(25579566692644379451)
,p_plug_name=>'In_Outright_Values'
,p_region_name=>'IR_MAIN3'
,p_region_template_options=>'#DEFAULT#:t-IRR-region--noBorders'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(5105460051616253014)
,p_plug_display_sequence=>80
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT DISTINCT',
'    t.order_type,',
'    t.batch_no,',
'    t.item_code AS Product,',
'    t.vendor_name_1,',
'    t.site,',
'    t.po_no,',
'    t.inv_no,',
'    t.inv_date,',
'    NULL AS inv_status,',
'    t.ORD_NO AS Transfer_No,',
'    NULL AS HM_Number,',
'    NULL AS HM_Status,',
'    NULL AS Waybill_No,',
'    NULL AS Inwarding_Warehouse',
'FROM tjd_pon.tjd_po_outright_vp_apex_tbl t',
'',
'JOIN (',
'      SELECT DISTINCT theme',
'      FROM TJD_PON.TJD_PON_PDIS_COLL_TB',
'         WHERE PDIS_DATE  >= TO_DATE(:P1000_FROM_DATE, ''DD/MM/YYYY'')',
'            AND PDIS_DATE  <  TO_DATE(:P1000_TO_DATE,   ''DD/MM/YYYY'') + 1',
'            AND COORDINATOR_NAME = NVL(:P1000_COORDINATOR_NAME, COORDINATOR_NAME)',
'            AND BRAND           = NVL(:P1000_BRAND, BRAND)',
'            AND COLLECTION_NAME  = NVL(:P1000_COLLECTION_NAME, COLLECTION_NAME)',
'     ) p2',
'  ON SUBSTR(t.item_code, 3, 7) = p2.theme',
'',
'LEFT JOIN tnq_demerit_details A',
'  ON A.item_no = t.item_code',
'  AND A.defect_type IN (''ACCEPT'', ''REJECT'')',
'   WHERE UPPER(t.order_type) = ''PROTO ORDER''',
'    AND :P1000_SELECTED_REPORT = ''OUTRIGHT''',
'    AND :P1000_OUTRIGHT_COUNT <> ''0''',
'    AND A.item_no IS NULL;'))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P1000_SELECTED_REPORT,P1000_TO_DATE,P1000_FROM_DATE,P1000_COORDINATOR_NAME,P1000_BRAND,P1000_COLLECTION_NAME,P1000_OUTRIGHT_COUNT'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'LETTER'
,p_prn_width=>8.5
,p_prn_height=>11
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header_font_color=>'#000000'
,p_prn_page_header_font_family=>'Helvetica'
,p_prn_page_header_font_weight=>'normal'
,p_prn_page_header_font_size=>'12'
,p_prn_page_footer_font_color=>'#000000'
,p_prn_page_footer_font_family=>'Helvetica'
,p_prn_page_footer_font_weight=>'normal'
,p_prn_page_footer_font_size=>'12'
,p_prn_header_bg_color=>'#9bafde'
,p_prn_header_font_color=>'#000000'
,p_prn_header_font_family=>'Helvetica'
,p_prn_header_font_weight=>'normal'
,p_prn_header_font_size=>'10'
,p_prn_body_bg_color=>'#efefef'
,p_prn_body_font_color=>'#000000'
,p_prn_body_font_family=>'Helvetica'
,p_prn_body_font_weight=>'normal'
,p_prn_body_font_size=>'10'
,p_prn_border_width=>.5
,p_prn_page_header_alignment=>'CENTER'
,p_prn_page_footer_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(25579566800687379452)
,p_max_row_count=>'1000'
,p_max_rows_per_page=>'50'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:XLS'
,p_download_filename=>'Outright Values'
,p_csv_output_separator=>','
,p_owner=>'SRIDHAR'
,p_internal_uid=>25579566800687379452
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(6125802924849269992)
,p_db_column_name=>'ORDER_TYPE'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Order Type'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(6125802549879269991)
,p_db_column_name=>'BATCH_NO'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Batch No'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(6125802134755269991)
,p_db_column_name=>'PRODUCT'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Product'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(6125801757136269991)
,p_db_column_name=>'VENDOR_NAME_1'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'Vendor Name 1'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(6125801329360269990)
,p_db_column_name=>'SITE'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>'Site'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(6125800958428269990)
,p_db_column_name=>'PO_NO'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>'Po No'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(6125800515838269990)
,p_db_column_name=>'INV_NO'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>'Inv No'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(6125800180654269989)
,p_db_column_name=>'INV_DATE'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>'Inv Date'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(6125799759787269988)
,p_db_column_name=>'INV_STATUS'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>'Inv Status'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(6125799388216269988)
,p_db_column_name=>'TRANSFER_NO'
,p_display_order=>100
,p_column_identifier=>'J'
,p_column_label=>'Transfer No'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(6125798955721269987)
,p_db_column_name=>'HM_NUMBER'
,p_display_order=>110
,p_column_identifier=>'K'
,p_column_label=>'Hm Number'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(6125798579058269987)
,p_db_column_name=>'HM_STATUS'
,p_display_order=>120
,p_column_identifier=>'L'
,p_column_label=>'Hm Status'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(6125798151606269986)
,p_db_column_name=>'WAYBILL_NO'
,p_display_order=>130
,p_column_identifier=>'M'
,p_column_label=>'Waybill No'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(6125797730529269985)
,p_db_column_name=>'INWARDING_WAREHOUSE'
,p_display_order=>140
,p_column_identifier=>'N'
,p_column_label=>'Inwarding Warehouse'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(25582009757691731785)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'61258033'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'ORDER_TYPE:BATCH_NO:PRODUCT:VENDOR_NAME_1:SITE:PO_NO:INV_NO:INV_DATE:INV_STATUS:TRANSFER_NO:HM_NUMBER:HM_STATUS:WAYBILL_NO:INWARDING_WAREHOUSE'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(25582000251524707827)
,p_plug_name=>'In_Outwork_Values'
,p_region_name=>'IR_MAIN4'
,p_region_template_options=>'#DEFAULT#:t-IRR-region--noBorders'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(5105460051616253014)
,p_plug_display_sequence=>90
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'WITH owk AS (',
'  SELECT  DISTINCT o.ORDER_TYPE Btq_Order_Type,',
'             o.BATCH_ID,',
'             o.JO_NO,',
'             o.JO_DATE,',
'             o.VENDOR_SITE,',
'             o.INW_NO,',
'             o.INW_DATE,',
'             o.iNW_STATUS,',
'             o.WAYBIL_NO,',
'          --Order_Line_id,',
'          -- Wip Line id,',
'           o.Product,',
'          -- o.TOC_ORD_TYPE,',
'           o.VENDOR_SHORT_NAME',
'           --Inwd Name,',
'          -- PO_NO',
'          -- UCP,',
'           --Vend Inv Num,',
'        --   Lot Num,',
'          -- Inwd Weight,',
'         --  Docket/ABW No',
'  FROM TJD_PON.TJD_PON_OWK_JWK_TBL o',
'  JOIN TJD_PON.TJD_PON_PDIS_COLL_TB t',
'    ON t.THEME = SUBSTR(o.PRODUCT, 3, 7)',
'  WHERE t.PDIS_DATE >= TO_DATE(:P1000_FROM_DATE, ''DD/MM/YYYY'')',
'    AND t.PDIS_DATE <  TO_DATE(:P1000_TO_DATE,   ''DD/MM/YYYY'') + 1',
'    AND ( :P1000_COORDINATOR_NAME IS NULL OR t.coordinator_name = :P1000_COORDINATOR_NAME )',
'    AND ( :P1000_BRAND            IS NULL OR t.brand            = :P1000_BRAND )',
'    AND ( :P1000_COLLECTION_NAME  IS NULL OR t.collection_name  = :P1000_COLLECTION_NAME )',
')',
'SELECT /*+ LEADING(o) USE_NL(o) */',
'       /* If product duplicates exist in OWK, re-enable DISTINCT here, not in CTE: DISTINCT */',
'      DISTINCT Btq_Order_Type,',
'             o.BATCH_ID,',
'             o.JO_NO,',
'             o.JO_DATE,',
'             o.VENDOR_SITE,',
'             o.INW_NO,',
'             o.INW_DATE,',
'             o.iNW_STATUS,',
'             o.WAYBIL_NO,',
'          --Order_Line_id,',
'          -- Wip Line id,',
'           o.Product,',
'          -- o.TOC_ORD_TYPE,',
'           o.VENDOR_SHORT_NAME',
'           --Inwd Name,',
'          -- PO_NO',
'          -- UCP,',
'           --Vend Inv Num,',
'        --   Lot Num,',
'          -- Inwd Weight,',
'         --  Docket/ABW No',
'         -- INTO v_outwork_count',
'FROM owk o',
'WHERE :P1000_OUTWORK_COUNT <>''0''',
' AND  :P1000_SELECTED_REPORT = ''OUTWORK'' ',
' AND  NOT EXISTS (',
'        SELECT 1',
'        FROM tnq_opm_transfer_dtl_tb a',
'        WHERE a.product_code = o.product',
'      )',
'  AND NOT EXISTS (',
'        SELECT 1',
'        FROM tnq_demerit_details c',
'        WHERE c.item_no = o.product',
'          AND c.defect_type = ''ACCEPT''',
'      );',
'      ',
''))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P1000_SELECTED_REPORT,P1000_FROM_DATE,P1000_TO_DATE,P1000_BRAND,P1000_COORDINATOR_NAME,P1000_COLLECTION_NAME,P1000_OUTWORK_COUNT,P1000_DATE_RANGE'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'LETTER'
,p_prn_width=>8.5
,p_prn_height=>11
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header_font_color=>'#000000'
,p_prn_page_header_font_family=>'Helvetica'
,p_prn_page_header_font_weight=>'normal'
,p_prn_page_header_font_size=>'12'
,p_prn_page_footer_font_color=>'#000000'
,p_prn_page_footer_font_family=>'Helvetica'
,p_prn_page_footer_font_weight=>'normal'
,p_prn_page_footer_font_size=>'12'
,p_prn_header_bg_color=>'#9bafde'
,p_prn_header_font_color=>'#000000'
,p_prn_header_font_family=>'Helvetica'
,p_prn_header_font_weight=>'normal'
,p_prn_header_font_size=>'10'
,p_prn_body_bg_color=>'#efefef'
,p_prn_body_font_color=>'#000000'
,p_prn_body_font_family=>'Helvetica'
,p_prn_body_font_weight=>'normal'
,p_prn_body_font_size=>'10'
,p_prn_border_width=>.5
,p_prn_page_header_alignment=>'CENTER'
,p_prn_page_footer_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(25582000401013707828)
,p_max_row_count=>'1000'
,p_max_rows_per_page=>'50'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:XLS'
,p_download_filename=>'Outwork Values'
,p_csv_output_separator=>','
,p_owner=>'SRIDHAR'
,p_internal_uid=>25582000401013707828
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(6125908071943269998)
,p_db_column_name=>'PRODUCT'
,p_display_order=>30
,p_column_identifier=>'A'
,p_column_label=>'Product'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(6125907654267269997)
,p_db_column_name=>'BTQ_ORDER_TYPE'
,p_display_order=>40
,p_column_identifier=>'B'
,p_column_label=>'Btq Order Type'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(6125907293020269997)
,p_db_column_name=>'VENDOR_SHORT_NAME'
,p_display_order=>60
,p_column_identifier=>'D'
,p_column_label=>'Vendor Short Name'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(6125906828582269996)
,p_db_column_name=>'BATCH_ID'
,p_display_order=>70
,p_column_identifier=>'E'
,p_column_label=>'Batch Id'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(6125906406095269996)
,p_db_column_name=>'JO_NO'
,p_display_order=>80
,p_column_identifier=>'F'
,p_column_label=>'Jo No'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(6125906044299269996)
,p_db_column_name=>'JO_DATE'
,p_display_order=>90
,p_column_identifier=>'G'
,p_column_label=>'Jo Date'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(6125905634309269995)
,p_db_column_name=>'VENDOR_SITE'
,p_display_order=>100
,p_column_identifier=>'H'
,p_column_label=>'Vendor Site'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(6125805270259269994)
,p_db_column_name=>'INW_NO'
,p_display_order=>110
,p_column_identifier=>'I'
,p_column_label=>'Inw No'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(6125804848035269994)
,p_db_column_name=>'INW_DATE'
,p_display_order=>120
,p_column_identifier=>'J'
,p_column_label=>'Inw Date'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(6125804430879269994)
,p_db_column_name=>'INW_STATUS'
,p_display_order=>130
,p_column_identifier=>'K'
,p_column_label=>'Inw Status'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(6125804080717269993)
,p_db_column_name=>'WAYBIL_NO'
,p_display_order=>140
,p_column_identifier=>'L'
,p_column_label=>'Waybil No'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(25582099078396911101)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'61259084'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'PRODUCT:BTQ_ORDER_TYPE:VENDOR_SHORT_NAME:BATCH_ID:JO_NO:JO_DATE:VENDOR_SITE:INW_NO:INW_DATE:INW_STATUS:WAYBIL_NO'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(25584048070362793822)
,p_plug_name=>'Filter'
,p_region_name=>'MAIN_REGION'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader:t-Region--noBorder:t-Region--hiddenOverflow:t-Form--noPadding'
,p_plug_template=>wwv_flow_api.id(5105458139045253017)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_header=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<h3 class="dash-title"',
'    style="',
'      color: #1e3a8a;',
'      font-weight: 700;',
'      letter-spacing: 0.4px;',
'      margin: 0;',
'    ">',
'  NPI StatusX',
'</h3>',
''))
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(6125909101348269999)
,p_button_sequence=>120
,p_button_plug_id=>wwv_flow_api.id(25584048070362793822)
,p_button_name=>'BTN_SEARCH'
,p_button_static_id=>'btn_search'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--padLeft:t-Button--padBottom'
,p_button_template_id=>wwv_flow_api.id(5105397500968253063)
,p_button_image_alt=>'Search'
,p_button_position=>'BODY'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
,p_button_css_classes=>'dash-filter-btn'
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(6333988880039785805)
,p_button_sequence=>130
,p_button_plug_id=>wwv_flow_api.id(25584048070362793822)
,p_button_name=>'Reset'
,p_button_static_id=>'reset_btn'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--padBottom'
,p_button_template_id=>wwv_flow_api.id(5105397500968253063)
,p_button_image_alt=>'Reset'
,p_button_position=>'BODY'
,p_warn_on_unsaved_changes=>null
,p_button_css_classes=>'dash-filter-btn'
,p_grid_new_row=>'N'
,p_grid_new_column=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(6125909568167270000)
,p_name=>'P1000_DATE_RANGE'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(25584048070362793822)
,p_prompt=>'<strong>Date Range</strong>'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>50
,p_cMaxlength=>100
,p_colspan=>2
,p_field_template=>wwv_flow_api.id(5105398615065253059)
,p_item_template_options=>'#DEFAULT#:margin-top-none:margin-bottom-none:margin-left-sm'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(6125909901128270001)
,p_name=>'P1000_BRAND'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(25584048070362793822)
,p_use_cache_before_default=>'NO'
,p_prompt=>'<strong>Brand</strong>'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct BRAND from TJD_PON.TJD_PON_PDIS_COLL_TB',
'WHERE  COORDINATOR_NAME = :P1000_COORDINATOR_NAME;'))
,p_lov_display_null=>'YES'
,p_lov_cascade_parent_items=>'P1000_COORDINATOR_NAME'
,p_ajax_items_to_submit=>'P1000_COORDINATOR_NAME,P1000_BRAND'
,p_ajax_optimize_refresh=>'Y'
,p_cSize=>50
,p_cMaxlength=>100
,p_begin_on_new_line=>'N'
,p_colspan=>2
,p_field_template=>wwv_flow_api.id(5105398615065253059)
,p_item_template_options=>'#DEFAULT#:margin-top-none:margin-bottom-none:margin-left-sm'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(6125910353031270002)
,p_name=>'P1000_COORDINATOR_NAME'
,p_is_required=>true
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(25584048070362793822)
,p_use_cache_before_default=>'NO'
,p_prompt=>'<strong>Coordinator Name</strong>'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct COORDINATOR_NAME as d, COORDINATOR_NAME as r',
'from TJD_PON.TJD_PON_PDIS_COLL_TB',
'ORDER BY 1;',
''))
,p_lov_display_null=>'YES'
,p_cSize=>50
,p_cMaxlength=>100
,p_begin_on_new_line=>'N'
,p_colspan=>2
,p_field_template=>wwv_flow_api.id(5105398372885253060)
,p_item_template_options=>'#DEFAULT#:margin-top-none:margin-bottom-none:margin-left-sm'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(6125910756264270002)
,p_name=>'P1000_COLLECTION_NAME'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(25584048070362793822)
,p_use_cache_before_default=>'NO'
,p_prompt=>'<strong>Collection  Name</strong>'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct COLLECTION_NAME as d, COLLECTION_NAME as r',
'from TJD_PON.TJD_PON_PDIS_COLL_TB',
'where COORDINATOR_NAME = :P1000_COORDINATOR_NAME',
'  and (:P1000_BRAND is null or BRAND = :P1000_BRAND)',
'order by 1'))
,p_lov_cascade_parent_items=>'P1000_COORDINATOR_NAME'
,p_ajax_items_to_submit=>'P1000_COORDINATOR_NAME,P1000_COLLECTION_NAME'
,p_ajax_optimize_refresh=>'Y'
,p_cSize=>50
,p_cMaxlength=>100
,p_begin_on_new_line=>'N'
,p_colspan=>2
,p_field_template=>wwv_flow_api.id(5105398615065253059)
,p_item_template_options=>'#DEFAULT#:margin-top-none:margin-bottom-none:margin-left-sm'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(6125911199693270002)
,p_name=>'P1000_TO_DATE'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(25584048070362793822)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(6125911502479270002)
,p_name=>'P1000_FROM_DATE'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(25584048070362793822)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(6125911902872270002)
,p_name=>'P1000_SELECTED_REPORT'
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_api.id(25584048070362793822)
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_tag_css_classes=>'hide-item-complete'
,p_field_template=>wwv_flow_api.id(5105398601102253060)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(6125912379230270003)
,p_name=>'P1000_VALUE_COUNT'
,p_item_sequence=>170
,p_item_plug_id=>wwv_flow_api.id(25584048070362793822)
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_tag_css_classes=>'hide-item-complete'
,p_field_template=>wwv_flow_api.id(5105398601102253060)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(6125912748401270003)
,p_name=>'P1000_ITEM_COUNT'
,p_item_sequence=>180
,p_item_plug_id=>wwv_flow_api.id(25584048070362793822)
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_tag_css_classes=>'hide-item-complete'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(5105398601102253060)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(6125913171886270003)
,p_name=>'P1000_OUTRIGHT_COUNT'
,p_item_sequence=>190
,p_item_plug_id=>wwv_flow_api.id(25584048070362793822)
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_tag_css_classes=>'hide-item-complete'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(5105398601102253060)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(6125913556616270003)
,p_name=>'P1000_OUTWORK_COUNT'
,p_item_sequence=>200
,p_item_plug_id=>wwv_flow_api.id(25584048070362793822)
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT  TO_CHAR(COUNT(*), ''999G99G999G999'')',
'   FROM TJD_PON.TJD_PON_OWK_JWK_TBL',
'   where CREATED_DT > TRUNC(SYSDATE,''YYYY'')',
'   and   ORDER_TYPE = ''PROTO ORDER'''))
,p_source_type=>'QUERY'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_tag_css_classes=>'hide-item-complete'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(5105398601102253060)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(6125913994960270004)
,p_name=>'P1000_TOTAL_THEME'
,p_item_sequence=>210
,p_item_plug_id=>wwv_flow_api.id(25584048070362793822)
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT  TO_CHAR(COUNT(*), ''999G99G999G999'')',
'   FROM TJD_PON.TJD_PON_OWK_JWK_TBL',
'   where CREATED_DT > TRUNC(SYSDATE,''YYYY'')',
'   and   ORDER_TYPE = ''PROTO ORDER'''))
,p_source_type=>'QUERY'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_tag_css_classes=>'hide-item-complete'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(5105398601102253060)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(6125914362521270004)
,p_name=>'P1000_STOCK_COUNT'
,p_item_sequence=>220
,p_item_plug_id=>wwv_flow_api.id(25584048070362793822)
,p_prompt=>'Stock Count'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT  TO_CHAR(COUNT(*), ''999G99G999G999'')',
'   FROM TJD_PON.TJD_PON_OWK_JWK_TBL',
'   where CREATED_DT > TRUNC(SYSDATE,''YYYY'')',
'   and   ORDER_TYPE = ''PROTO ORDER'''))
,p_source_type=>'QUERY'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_tag_css_classes=>'hide-item-complete'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(5105398601102253060)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(6125914727304270004)
,p_name=>'P1000_DEMERIT_COUNT'
,p_item_sequence=>230
,p_item_plug_id=>wwv_flow_api.id(25584048070362793822)
,p_prompt=>'Stock Count'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_tag_css_classes=>'hide-item-complete'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(5105398601102253060)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(6125915151556270004)
,p_name=>'P1000_GIT_COUNT'
,p_item_sequence=>240
,p_item_plug_id=>wwv_flow_api.id(25584048070362793822)
,p_prompt=>'Stock Count'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_tag_css_classes=>'hide-item-complete'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(5105398601102253060)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(6125933082306270028)
,p_name=>'Search'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(6125909101348269999)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(6125933551803270029)
,p_event_id=>wwv_flow_api.id(6125933082306270028)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'var btn = $(''#btn_search'');',
'',
'if (btn.prop(''disabled'')) {',
'    return;',
'}',
'',
'btn.prop(''disabled'', true)',
'.html(''<span class="u-processing"></span> Searching...'');',
'',
'var spinner = apex.util.showSpinner();',
'',
'var pageOverlay = $(''<div id="pageLock"></div>'').css({',
'    position: ''fixed'',',
'    top: 0,',
'    left: 0,',
'    width: ''100%'',',
'    height: ''100%'',',
'    background: ''rgba(255,255,255,0.6)'',',
'    zIndex: 9999,',
'    cursor: ''wait''',
'});',
'$(''body'').append(pageOverlay);',
'apex.message.clearErrors();',
'',
'apex.server.process(',
'    "GET_DASH_COUNTS",',
'    {',
'        pageItems: "#P1000_FROM_DATE,#P1000_TO_DATE,#P1000_COORDINATOR_NAME,#P1000_BRAND,#P1000_COLLECTION_NAME"',
'    },',
'    {',
'        success: function (pData) {',
'',
'            if (!pData) {',
'                apex.message.showErrors([{',
'                    type: "error",',
'                    location: "inline",',
'                    pageItem: "P1000_FROM_DATE",',
'                    message: "No response from server.",',
'                    unsafe: false',
'                }]);',
'                return;',
'            }',
'            ',
'            ',
'            $s("P1000_TOTAL_THEME",    pData.TOTAL_THEME);',
'            $s("P1000_VALUE_COUNT",    pData.FLEX);',
'            $s("P1000_ITEM_COUNT",     pData.ITEM);',
'            $s("P1000_OUTRIGHT_COUNT", pData.OUTRIGHT);',
'            $s("P1000_OUTWORK_COUNT",  pData.OUTWORK);',
'            $s("P1000_DEMERIT_COUNT",  pData.DEMERIT);',
'            $s("P1000_GIT_COUNT",      pData.GIT);',
'            $s("P1000_STOCK_COUNT",    pData.STOCK);',
'            ',
'            $(''#val_total'').text(pData.TOTAL_THEME);',
'            $(''#val_total1'').text(pData.FLEX);',
'            $(''#val_item'').text(pData.ITEM);',
'            $(''#val_outright'').text(pData.OUTRIGHT);',
'            $(''#val_outwork'').text(pData.OUTWORK);',
'            $(''#val_stock'').text(pData.STOCK);',
'            $(''#val_demerit'').text(pData.DEMERIT);',
'            $(''#val_git'').text(pData.GIT);',
'',
'            apex.message.showPageSuccess("Dashboard data loaded successfully.");',
'',
'            setTimeout(function () {',
'                $(".t-Alert--success").fadeOut("slow");',
'            }, 2000);',
'        },',
'',
'        error: function () {',
'            apex.message.showErrors([{',
'                type: "error",',
'                location: "page",',
'                message: "Error while fetching dashboard data.",',
'                unsafe: false',
'            }]);',
'        },',
'',
'        complete: function () {',
'',
'            if (spinner) {',
'                spinner.remove();',
'            }',
'',
'            btn.prop(''disabled'', false)',
'               .html(''Search'');',
'            ',
'            $(''#pageLock'').remove();',
'            $(''#dash'').show();',
'            apex.region("IR_MAIN8").refresh(); apex.region("IR_MAIN").refresh(); apex.region("IR_MAIN2").refresh(); apex.region("IR_MAIN3").refresh(); apex.region("IR_MAIN4").refresh();',
'            apex.region("IR_MAIN5").refresh(); apex.region("IR_MAIN6").refresh(); apex.region("IR_MAIN7").refresh();',
'        }',
'    }',
');',
''))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(6333988682016785803)
,p_name=>'Enable/Disable Button'
,p_event_sequence=>20
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P1000_BRAND,P1000_COORDINATOR_NAME,P1000_COLLECTION_NAME'
,p_triggering_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_expression=>wwv_flow_string.join(wwv_flow_t_varchar2(
'$v(''P1000_BRAND'') !== '''' ||',
'$v(''P1000_COORDINATOR_NAME'') !== '''' ||',
'$v(''P1000_COLLECTION_NAME'') !== ''''',
''))
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(6333988416272785801)
,p_event_id=>wwv_flow_api.id(6333988682016785803)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(6125909101348269999)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(6333988574919785802)
,p_event_id=>wwv_flow_api.id(6333988682016785803)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(6125909101348269999)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(6333988926551785806)
,p_name=>'Reset values'
,p_event_sequence=>30
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(6333988880039785805)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(6333989073137785807)
,p_event_id=>wwv_flow_api.id(6333988926551785806)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
' :P1000_DATE_RANGE :=  TO_CHAR(ADD_MONTHS(TRUNC(SYSDATE), -6),''DD/MM/YYYY'') || '' - ''|| TO_CHAR(TRUNC(SYSDATE),''DD/MM/YYYY'');',
' :P1000_FROM_DATE := TO_CHAR(ADD_MONTHS(TRUNC(SYSDATE), -6),''DD/MM/YYYY'');',
' :P1000_TO_DATE   := TO_CHAR(TRUNC(SYSDATE),''DD/MM/YYYY'');',
' :P1000_COORDINATOR_NAME := NULL;',
':P1000_BRAND            := NULL;',
':P1000_COLLECTION_NAME  := NULL;',
''))
,p_attribute_02=>'P1000_DATE_RANGE,P1000_BRAND,P1000_COORDINATOR_NAME,P1000_COLLECTION_NAME,P1000_TO_DATE,P1000_FROM_DATE'
,p_attribute_03=>'P1000_COORDINATOR_NAME,P1000_COLLECTION_NAME,P1000_BRAND'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
end;
/
begin
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(6333989399985785810)
,p_event_id=>wwv_flow_api.id(6333988926551785806)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(25575306541737096357)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(6333989147426785808)
,p_name=>'Hide region'
,p_event_sequence=>40
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(6333989289372785809)
,p_event_id=>wwv_flow_api.id(6333989147426785808)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(25575306541737096357)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(6125932670829270027)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Initial Process for Assign Values'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'',
'',
' :P1000_DATE_RANGE :=  TO_CHAR(ADD_MONTHS(TRUNC(SYSDATE), -6),''DD/MM/YYYY'') || '' - ''|| TO_CHAR(TRUNC(SYSDATE),''DD/MM/YYYY'');',
' :P1000_FROM_DATE := TO_CHAR(ADD_MONTHS(TRUNC(SYSDATE), -6),''DD/MM/YYYY'');',
' :P1000_TO_DATE   := TO_CHAR(TRUNC(SYSDATE),''DD/MM/YYYY'');',
'',
'   ',
'  SELECT',
'    to_char(',
'        count(*),',
'        ''999G99G999G999''',
'    )',
'    INTO :P1000_VALUE_COUNT',
'FROM',
'     apps.tjd_pon_fnd_flex_values_tl_v ffvt,',
'     apps.tjd_pon_fnd_flex_values_v ffv ,',
'     TJD_PON.TJD_PON_FND_FLEX_VALUE_SETS_V ffvs ',
'    WHERE ffv.flex_value_id=ffvt.flex_value_id ',
'   -- AND ffv.flex_value= tos.attribute21',
'    AND ffv.flex_value_set_id=ffvs.flex_value_set_id ',
'    AND ffvs.flex_value_set_name=''THEME_DESIGN''',
'--AND ffv.creation_date >= TO_Date(:P1000_FROM_DATE, ''DD/MM/YYYY'')',
'--AND ffv.creation_date <  TO_DATE(:P1000_TO_DATE, ''DD/MM/YYYY'') + 1',
'AND EXISTS  (SELECT 1 ',
'                                FROM TJD_PON.TJD_PON_PDIS_COLL_TB t',
'                               WHERE ffv.FLEX_VALUE = t.THEME)',
' /*AND NOT EXISTS (SELECT 1',
'                        FROM mtl_system_items_b',
'                       WHERE organization_id = ''122''',
'                         AND attribute6 = ffv.FLEX_VALUE',
'                          AND EXISTS  (SELECT 1 ',
'                                         FROM TJD_PON.TJD_PON_PDIS_COLL_TB t',
'                                         WHERE  t.THEME = SUBSTR(SEGMENT1, 3, 7) ))*/;',
'',
'',
'--item ',
'  SELECT TO_CHAR(COUNT(*), ''999G99G999G999'') AS ITEM_COUNT',
'     INTO :P1000_ITEM_COUNT',
'     FROM tjd_pon.mtl_system_items_b',
'    WHERE organization_id = ''122''',
'       AND EXISTS  (SELECT 1 ',
'                       FROM TJD_PON.TJD_PON_PDIS_COLL_TB t',
'                    WHERE  t.THEME = SUBSTR(SEGMENT1, 3, 7) )',
'     -- AND LAST_UPDATE_DATE >= TO_DATE(:P1000_FROM_DATE, ''DD/MM/YYYY'')',
'     -- AND LAST_UPDATE_DATE <  TO_DATE(:P1000_TO_DATE,   ''DD/MM/YYYY'') + 1',
'      AND ATTRIBUTE22 NOT IN (''D'');',
'      /*AND  NOT EXISTS (SELECT 1',
'                        FROM TJD_PON.TJD_PON_OWK_JWK_TBL t',
'                       WHERE t.PRODUCT = SEGMENT1',
'                          AND SUBSTR(t.PRODUCT, 3, 7)   IN (SELECT THEME FROM TJD_PON.TJD_PON_PDIS_COLL_TB)',
'                            --CREATED_DT >=  TO_Date(:P1000_FROM_DATE, ''DD/MM/YYYY'')',
'                       --  AND CREATED_DT < TO_DATE(:P1000_TO_DATE, ''DD/MM/YYYY'') + 1',
'                          AND  ORDER_TYPE = ''PROTO ORDER'')',
'                AND NOT EXISTS  (SELECT 1',
'                            FROM tjd_pon.tjd_po_outright_vp_apex_tbl a',
'                           WHERE  SEGMENT1 = a.ITEM_CODE',
'                               AND SUBSTR(ITEM_CODE, 3, 7)   IN (SELECT THEME FROM TJD_PON.TJD_PON_PDIS_COLL_TB));',
'                                     --CREATED_DATE >= TO_Date(:P1000_FROM_DATE, ''DD/MM/YYYY'')',
'                             --AND CREATED_DATE < TO_DATE(:P1000_TO_DATE, ''DD/MM/YYYY'') + 1)  ;*/',
'    ',
'--outright',
'    SELECT TO_CHAR(COUNT(*), ''999G99G999G999'')',
'      INTO :P1000_OUTRIGHT_COUNT',
'      FROM tjd_pon.tjd_po_outright_vp_apex_tbl',
'     WHERE  SUBSTR(ITEM_CODE, 3, 7)   IN (SELECT THEME FROM TJD_PON.TJD_PON_PDIS_COLL_TB) ; ',
'       --CREATED_DATE >= TO_DATE(:P1000_FROM_DATE, ''DD/MM/YYYY'')',
'     --  AND CREATED_DATE <  TO_DATE(:P1000_TO_DATE,   ''DD/MM/YYYY'') + 1;',
'     ',
'',
'',
'--outwork',
'  SELECT  TO_CHAR(COUNT(*), ''999G99G999G999'')',
'    INTO :P1000_OUTWORK_COUNT',
'    FROM TJD_PON.TJD_PON_OWK_JWK_TBL',
'   WHERE SUBSTR(PRODUCT, 3, 7)   IN (SELECT THEME FROM TJD_PON.TJD_PON_PDIS_COLL_TB)',
'     AND ORDER_TYPE = ''PROTO ORDER'';',
'    -- AND CREATED_DT >= TO_DATE(:P1000_FROM_DATE, ''DD/MM/YYYY'')',
'   --  AND CREATED_DT <  TO_DATE(:P1000_TO_DATE,   ''DD/MM/YYYY'') + 1;',
'',
'',
'END;',
'',
'',
''))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_type=>'NEVER'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(6125932240963270026)
,p_process_sequence=>20
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Initial Process step1'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'',
'',
' :P1000_DATE_RANGE :=  TO_CHAR(ADD_MONTHS(TRUNC(SYSDATE), -6),''DD/MM/YYYY'') || '' - ''|| TO_CHAR(TRUNC(SYSDATE),''DD/MM/YYYY'');',
' :P1000_FROM_DATE := TO_CHAR(ADD_MONTHS(TRUNC(SYSDATE), -6),''DD/MM/YYYY'');',
' :P1000_TO_DATE   := TO_CHAR(TRUNC(SYSDATE),''DD/MM/YYYY'');',
'',
'BEGIN',
'    IF apex_collection.collection_exists(''P1000_DASH_COUNTS'') THEN',
'        apex_collection.truncate_collection(''P1000_DASH_COUNTS'');',
'    ELSE',
'        apex_collection.create_collection(''P1000_DASH_COUNTS'');',
'    END IF;',
'END;',
'',
'',
'DECLARE',
'    v_flex_count     NUMBER;',
'    v_item_count     NUMBER;',
'    v_outright_count NUMBER;',
'    v_outwork_count  NUMBER;',
'    v_total_theme NUMBER;',
'    v_stock NUMBER;',
'    v_demerit NUMBER;',
'    v_git  NUMBER;',
'BEGIN',
'    /* ================================',
'       FLEX COUNT',
'    ================================ */',
' -- Count distinct themes quickly by first generating a distinct set, then count',
'-- Count distinct themes quickly by first generating a distinct set, then count',
'WITH themes AS (',
'  SELECT /*+ MATERIALIZE */',
'         DISTINCT ffv.flex_value AS theme',
'  FROM apps.tjd_pon_fnd_flex_values_v ffv',
'  /* Only validate the value-set membership via EXISTS to avoid row explosion */',
'  WHERE EXISTS (',
'          SELECT 1',
'          FROM tjd_pon.tjd_pon_fnd_flex_value_sets_v ffvs',
'          WHERE ffvs.flex_value_set_id   = ffv.flex_value_set_id',
'            AND ffvs.flex_value_set_name = ''THEME_DESIGN''',
'        )',
'    /* Keep only themes that appear in PDIS within the date window via EXISTS */',
'    AND EXISTS (',
'          SELECT 1',
'          FROM tjd_pon.tjd_pon_pdis_coll_tb p',
'          WHERE p.theme = ffv.flex_value',
'            AND p.pdis_date >= TO_DATE(:P1000_FROM_DATE, ''DD/MM/YYYY'')',
'            AND p.pdis_date <  TO_DATE(:P1000_TO_DATE,   ''DD/MM/YYYY'') + 1',
'        )',
'    /* Exclude any Item Master entry (org 122) mapped by theme */',
'    AND NOT EXISTS (',
'          SELECT 1',
'          FROM apps.mtl_system_items_b m',
'          WHERE m.organization_id = 122',
'            AND SUBSTR(m.segment1, 3, 7) = ffv.flex_value',
'        )',
'    /* Exclude any demerit mapped by item_no -> theme',
'       (leave as global exclusion since your original had no date filter) */',
'    AND NOT EXISTS (',
'          SELECT 1',
'          FROM tnq_demerit_details d',
'          WHERE SUBSTR(d.item_no, 3, 7) = ffv.flex_value',
'        )',
'    /* Exclude OWK/JWK entries (assumes column PRODUCT carries item code pattern) */',
'    AND NOT EXISTS (',
'          SELECT 1',
'          FROM tjd_pon.tjd_pon_owk_jwk_tbl e',
'          WHERE SUBSTR(e.product, 3, 7) = ffv.flex_value',
'        )',
'    /* Exclude outright table entries */',
'    AND NOT EXISTS (',
'          SELECT 1',
'          FROM tjd_pon.tjd_po_outright_vp_apex_tbl t',
'          WHERE SUBSTR(t.item_code, 3, 7) = ffv.flex_value',
'        )',
')',
'SELECT COUNT(*) INTO v_flex_count',
'FROM themes;   ',
'',
'  apex_collection.add_member(',
'        p_collection_name => ''P1000_DASH_COUNTS'',',
'        p_c001 => ''FLEX'',',
'        p_n001 => v_flex_count',
'    );',
'',
'    /* ================================',
'       ITEM COUNT',
'    ================================ */',
'  SELECT COUNT(DISTINCT m.segment1)',
'    INTO v_item_count',
'    FROM mtl_system_items_b m',
'',
'JOIN TJD_PON.TJD_PON_PDIS_COLL_TB p',
'     ON p.theme = SUBSTR(m.segment1, 3, 7)',
'    AND p.PDIS_DATE >= TO_DATE(:P1000_FROM_DATE, ''DD/MM/YYYY'')',
'    AND p.PDIS_DATE <  TO_DATE(:P1000_TO_DATE, ''DD/MM/YYYY'') + 1',
'',
'',
'JOIN apps.tjd_pon_mtl_cross_references_vw c',
'     ON c.inventory_item_id = m.inventory_item_id',
'    AND c.CROSS_REFERENCE_TYPE = ''Pricing Information''',
'',
'  ',
'LEFT JOIN (',
'        SELECT DISTINCT item_code',
'        FROM tjd_pon.tjd_po_outright_vp_apex_tbl',
') o',
'     ON o.item_code = m.segment1',
'  ',
'LEFT JOIN (',
'        SELECT DISTINCT product',
'        FROM TJD_PON.TJD_PON_OWK_JWK_TBL',
'        WHERE order_type = ''PROTO ORDER''',
') w',
'     ON w.product = m.segment1',
'',
'',
'LEFT JOIN(',
'     SELECT DISTINCT product_code',
'     FROM tnq_opm_transfer_dtl_tb',
') s',
'    ON s.product_code = m.segment1',
'LEFT JOIN(',
'     SELECT DISTINCT item_no',
'     FROM tnq_demerit_details',
') g',
'    ON g.item_no = m.segment1',
'  WHERE m.organization_id = 122',
'  AND m.attribute22 <> ''D''',
'  AND o.item_code IS NULL',
'  AND w.product IS NULL',
'  AND s.product_code IS NULL',
'  AND g.item_no IS NULL;',
'',
' ',
'   ',
'   /*FROM tjd_pon.mtl_system_items_b m',
'    JOIN TJD_PON.TJD_PON_PDIS_COLL_TB t',
'         ON t.theme = SUBSTR(m.segment1, 3, 7)',
'    WHERE m.organization_id = 122',
'      AND m.attribute22 <> ''D''',
'      AND m.LAST_UPDATE_DATE >= TO_DATE(:P1000_FROM_DATE, ''DD/MM/YYYY'')',
'      AND m.LAST_UPDATE_DATE <  TO_DATE(:P1000_TO_DATE,   ''DD/MM/YYYY'') + 1;',
'      */',
'',
'    apex_collection.add_member(',
'        p_collection_name => ''P1000_DASH_COUNTS'',',
'        p_c001 => ''ITEM'',',
'        p_n001 => v_item_count',
'    );',
'',
'    /* ================================',
'       OUTRIGHT COUNT',
'    ================================ */',
'    /*SELECT COUNT( DISTINCT a.item_code)-- COUNT(DISTINCT SUBSTR(a.item_code, 3, 7))',
'    INTO v_outright_count',
'    FROM tjd_pon.tjd_po_outright_vp_apex_tbl a',
'    JOIN TJD_PON.TJD_PON_PDIS_COLL_TB t',
'         ON t.theme = SUBSTR(a.item_code, 3, 7)',
'    WHERE a.created_date >= TO_DATE(:P1000_FROM_DATE, ''DD/MM/YYYY'')',
'     AND a.created_date <  TO_DATE(:P1000_TO_DATE,   ''DD/MM/YYYY'') + 1;*/',
'',
'   SELECT COUNT (distinct t.item_code)',
'   INTO v_outright_count',
'   FROM tjd_pon.tjd_po_outright_vp_apex_tbl t',
'',
'JOIN (',
'      SELECT DISTINCT theme',
'      FROM TJD_PON.TJD_PON_PDIS_COLL_TB',
'      WHERE PDIS_DATE  >= TO_DATE(:P1000_FROM_DATE, ''DD/MM/YYYY'')',
'      AND PDIS_DATE  <  TO_DATE(:P1000_TO_DATE,   ''DD/MM/YYYY'') + 1',
'     ) p2',
'  ON SUBSTR(t.item_code, 3, 7) = p2.theme',
'',
'  LEFT JOIN tnq_demerit_details A',
'  ON A.item_no = t.item_code',
'  AND A.defect_type IN (''ACCEPT'', ''REJECT'')',
'  WHERE UPPER(t.order_type) = ''PROTO ORDER''',
'  AND A.item_no IS NULL;',
'  ',
'',
'    apex_collection.add_member(',
'        p_collection_name => ''P1000_DASH_COUNTS'',',
'        p_c001 => ''OUTRIGHT'',',
'        p_n001 => v_outright_count',
'    );',
'',
'    /* ================================',
'       OUTWORK COUNT',
'    ================================ */',
'  ',
'    ',
'    WITH owk AS (',
'  SELECT /*+ MATERIALIZE */ o.product',
'  FROM TJD_PON.TJD_PON_OWK_JWK_TBL o',
'  JOIN TJD_PON.TJD_PON_PDIS_COLL_TB t',
'    ON t.THEME = SUBSTR(o.PRODUCT, 3, 7)',
'  WHERE t.PDIS_DATE >= TO_DATE(:P1000_FROM_DATE, ''DD/MM/YYYY'')',
'    AND t.PDIS_DATE <  TO_DATE(:P1000_TO_DATE,   ''DD/MM/YYYY'') + 1',
')',
'SELECT /*+ LEADING(o) USE_NL(o) */',
'       /* If product duplicates exist in OWK, re-enable DISTINCT here, not in CTE: DISTINCT */',
'      count( DISTINCT o.product)',
'      INTO   v_outwork_count',
'FROM owk o',
'WHERE NOT EXISTS (',
'        SELECT 1',
'        FROM tnq_opm_transfer_dtl_tb a',
'        WHERE a.product_code = o.product',
'      )',
'  AND NOT EXISTS (',
'        SELECT 1',
'        FROM tnq_demerit_details c',
'        WHERE c.item_no = o.product',
'          AND c.defect_type = ''ACCEPT''',
'      );',
'',
'    apex_collection.add_member(',
'        p_collection_name => ''P1000_DASH_COUNTS'',',
'        p_c001 => ''OUTWORK'',',
'        p_n001 => v_outwork_count',
'    );',
'    ',
'    /* ================================',
'       THEME COUNT',
'    ================================ */ ',
' SELECT COUNT(DISTINCT theme)',
'INTO v_total_theme',
'FROM TJD_PON.TJD_PON_PDIS_COLL_TB',
'WHERE PDIS_DATE >= TO_DATE(:P1000_FROM_DATE, ''DD/MM/YYYY'')',
'  AND PDIS_DATE <  TO_DATE(:P1000_TO_DATE,   ''DD/MM/YYYY'') + 1;',
'',
'',
'    apex_collection.add_member(',
'        p_collection_name => ''P1000_DASH_COUNTS'',',
'        p_c001 => ''TOTAL_THEME'',',
'        p_n001 => v_total_theme',
'    );',
'    ',
'/* ================================',
'       DEMERIT COUNT',
'    ================================ */ ',
' ',
'  SELECT COUNT(DISTINCT(SUBSTR(A.item_no, 3, 7) ))',
'INTO v_demerit',
'FROM tnq_demerit_details A,',
'     tjd_pon.tjd_pon_pdis_coll_tb B',
'WHERE substr(A.item_no, 3, 7) = B.theme',
'AND A.CREATION_DATE >= TO_DATE(:P1000_FROM_DATE,''DD/MM/YYYY'')',
'AND A.CREATION_DATE < TO_DATE(:P1000_TO_DATE,''DD/MM/YYYY'')',
'AND A.DEFECT_TYPE = ''REJECT'';',
'',
' apex_collection.add_member(',
'        p_collection_name => ''P1000_DASH_COUNTS'',',
'        p_c001 => ''DEMERIT'',',
'        p_n001 => v_demerit',
'    );',
'',
'',
'    ',
'/* ================================',
'       GIT COUNT',
'    ================================ */ ',
'    ',
'WITH demerit AS (',
'  SELECT',
'     a.item_no',
'  FROM tnq_demerit_details a',
'  JOIN tjd_pon.tjd_pon_pdis_coll_tb b',
'    ON SUBSTR(a.item_no, 3, 7) = b.theme',
'  WHERE b.PDIS_DATE  >= TO_DATE(:P1000_FROM_DATE, ''DD/MM/YYYY'')',
'    AND b.PDIS_DATE  <  TO_DATE(:P1000_TO_DATE,   ''DD/MM/YYYY'') + 1 -- make end date inclusive',
'    AND a.defect_type = ''ACCEPT''',
'),',
'xfer AS (',
'  -- All product_codes that qualify by transfer rules within date window',
'  SELECT  a.product_code',
'  FROM apps.tnq_opm_transfer_dtl_tb a',
'  JOIN tjd_pon.tjd_pon_pdis_coll_tb c',
'    ON SUBSTR(a.product_code, 3, 7) = c.theme',
'  WHERE c.PDIS_DATE  >= TO_DATE(:P1000_FROM_DATE, ''DD/MM/YYYY'')',
'    AND c.PDIS_DATE  <  TO_DATE(:P1000_TO_DATE,   ''DD/MM/YYYY'') + 1',
')',
'SELECT  count(distinct a.item_no)',
'INTO v_git',
'FROM demerit a',
'LEFT JOIN xfer x',
'  ON x.product_code = a.item_no',
'WHERE x.product_code IS NULL;',
'',
' ',
'',
' apex_collection.add_member(',
'        p_collection_name => ''P1000_DASH_COUNTS'',',
'        p_c001 => ''GIT'',',
'        p_n001 => v_git',
'    );',
'    ',
'    ',
'  ',
'   SELECT COUNT(DISTINCT a.product_code)',
' INTO v_stock',
'FROM apps.tnq_opm_transfer_dtl_tb a',
'JOIN apps.tnq_opm_transfer_hdr_tb b',
'     ON a.header_id = b.transfer_no',
'JOIN TJD_PON.TJD_PON_PDIS_COLL_TB c',
'     ON SUBSTR(a.product_code, 3, 7) = c.theme',
'WHERE b.waybill_date IS NOT NULL',
'  AND b.waybill_date >= TO_DATE(:P1000_FROM_DATE, ''DD/MM/YYYY'')',
'  AND b.waybill_date <  TO_DATE(:P1000_TO_DATE,   ''DD/MM/YYYY'') + 1;',
'  ',
' apex_collection.add_member(',
'        p_collection_name => ''P1000_DASH_COUNTS'',',
'        p_c001 => ''STOCK'',',
'        p_n001 => v_stock',
'    );',
'    ',
'END;',
'',
'',
'',
'END;',
'',
'',
''))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_type=>'NEVER'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(6125931825578270026)
,p_process_sequence=>30
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Initial Process step2'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'',
'  SELECT n001',
'    INTO :P1000_TOTAL_THEME',
'    FROM apex_collections',
'    WHERE collection_name = ''P1000_DASH_COUNTS''',
'      AND c001 = ''TOTAL_THEME'';',
'      ',
'    SELECT n001',
'    INTO :P1000_VALUE_COUNT',
'    FROM apex_collections',
'    WHERE collection_name = ''P1000_DASH_COUNTS''',
'      AND c001 = ''FLEX'';',
'',
' SELECT n001',
'    INTO :P1000_ITEM_COUNT',
'    FROM apex_collections',
'    WHERE collection_name = ''P1000_DASH_COUNTS''',
'      AND c001 = ''ITEM'';',
'',
'    SELECT n001',
'    INTO :P1000_OUTRIGHT_COUNT',
'    FROM apex_collections',
'    WHERE collection_name = ''P1000_DASH_COUNTS''',
'      AND c001 = ''OUTRIGHT'';',
'',
'    SELECT n001',
'    INTO :P1000_OUTWORK_COUNT',
'    FROM apex_collections',
'    WHERE collection_name = ''P1000_DASH_COUNTS''',
'      AND c001 = ''OUTWORK'';',
'      ',
'      SELECT n001',
'    INTO :P1000_STOCK_COUNT',
'    FROM apex_collections',
'    WHERE collection_name = ''P1000_DASH_COUNTS''',
'      AND c001 = ''STOCK'';',
'      ',
'  SELECT n001',
'    INTO :P1000_DEMERIT_COUNT',
'    FROM apex_collections',
'    WHERE collection_name = ''P1000_DASH_COUNTS''',
'      AND c001 = ''DEMERIT'';',
'      ',
'            ',
'  SELECT n001',
'    INTO :P1000_GIT_COUNT',
'    FROM apex_collections',
'    WHERE collection_name = ''P1000_DASH_COUNTS''',
'      AND c001 = ''GIT'';',
'      ',
'    :P1000_VALUE_COUNT :=  TO_CHAR(:P1000_VALUE_COUNT, ''999G99G999G999'');',
'    :P1000_ITEM_COUNT := TO_CHAR(:P1000_ITEM_COUNT , ''999G99G999G999'');',
'    :P1000_OUTWORK_COUNT :=TO_CHAR(:P1000_OUTWORK_COUNT, ''999G99G999G999'');',
'    :P1000_OUTRIGHT_COUNT :=TO_CHAR(:P1000_OUTRIGHT_COUNT, ''999G99G999G999'');',
'    :P1000_STOCK_COUNT := TO_CHAR(:P1000_STOCK_COUNT, ''999G99G999G999'');',
'    :P1000_DEMERIT_COUNT := TO_CHAR(:P1000_DEMERIT_COUNT, ''999G99G999G999'');',
'   ',
'    :P1000_GIT_COUNT := TO_CHAR(:P1000_GIT_COUNT, ''999G99G999G999'');',
'      ',
'END;',
''))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_type=>'NEVER'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(6333989477134785811)
,p_process_sequence=>40
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Assign Values'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'',
'',
' :P1000_DATE_RANGE :=  TO_CHAR(ADD_MONTHS(TRUNC(SYSDATE), -6),''DD/MM/YYYY'') || '' - ''|| TO_CHAR(TRUNC(SYSDATE),''DD/MM/YYYY'');',
' :P1000_FROM_DATE := TO_CHAR(ADD_MONTHS(TRUNC(SYSDATE), -6),''DD/MM/YYYY'');',
' :P1000_TO_DATE   := TO_CHAR(TRUNC(SYSDATE),''DD/MM/YYYY'');',
'BEGIN',
'    IF apex_collection.collection_exists(''P1000_DASH_COUNTS'') THEN',
'        apex_collection.truncate_collection(''P1000_DASH_COUNTS'');',
'    ELSE',
'        apex_collection.create_collection(''P1000_DASH_COUNTS'');',
'    END IF;',
'END;',
'',
'END;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(6125931435504270024)
,p_process_sequence=>10
,p_process_point=>'ON_DEMAND'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'GET_DASH_COUNTS'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    v_flex_count     NUMBER := 0;',
'    v_item_count     NUMBER := 0;',
'    v_outright_count NUMBER := 0;',
'    v_outwork_count  NUMBER := 0;',
'    v_total_theme    NUMBER := 0;',
'    v_stock          NUMBER := 0;',
'    v_demerit         NUMBER := 0;',
'    v_git         NUMBER := 0;',
'',
'    v_flex_final     NUMBER := 0;',
'    v_item_final     NUMBER := 0;',
'BEGIN',
'    /* FLEX COUNT */',
' WITH themes AS (',
'  SELECT DISTINCT ffv.flex_value',
'  FROM apps.tjd_pon_fnd_flex_values_v ffv',
'  JOIN apps.tjd_pon_fnd_flex_values_tl_v ffvt',
'    ON ffv.flex_value_id = ffvt.flex_value_id',
'  JOIN tjd_pon.tjd_pon_fnd_flex_value_sets_v ffvs',
'    ON ffv.flex_value_set_id = ffvs.flex_value_set_id',
'   AND ffvs.flex_value_set_name = ''THEME_DESIGN''',
'  JOIN tjd_pon.tjd_pon_pdis_coll_tb p',
'    ON p.theme = ffv.flex_value',
'  WHERE ffv.flex_value IS NOT NULL',
'    AND p.pdis_date >= TO_DATE(:P1000_FROM_DATE, ''DD/MM/YYYY'')',
'    AND p.pdis_date <  TO_DATE(:P1000_TO_DATE,   ''DD/MM/YYYY'') + 1',
'     AND ( :P1000_COORDINATOR_NAME IS NULL OR p.coordinator_name = :P1000_COORDINATOR_NAME )',
'    AND ( :P1000_BRAND            IS NULL OR p.brand            = :P1000_BRAND )',
'    AND ( :P1000_COLLECTION_NAME  IS NULL OR p.collection_name  = :P1000_COLLECTION_NAME )',
'    -- Exclude Item Master (org 122)',
'    AND NOT EXISTS (',
'          SELECT 1',
'          FROM apps.mtl_system_items_b m',
'          WHERE SUBSTR(m.segment1, 3, 7) = ffv.flex_value',
'            AND m.organization_id = 122',
'        )',
'',
'    -- Exclude Demerit by item_no -> theme',
'    AND NOT EXISTS (',
'          SELECT 1',
'          FROM tnq_demerit_details d',
'          WHERE SUBSTR(d.item_no, 3, 7) = ffv.flex_value',
'        )',
'',
'    -- Exclude OWK/JWK by product -> theme',
'    AND NOT EXISTS (',
'          SELECT 1',
'          FROM tjd_pon.tjd_pon_owk_jwk_tbl e',
'          WHERE SUBSTR(e.product, 3, 7) = ffv.flex_value',
'        )',
'',
'    -- Exclude Outright by item_code -> theme',
'    AND NOT EXISTS (',
'          SELECT 1',
'          FROM tjd_pon.tjd_po_outright_vp_apex_tbl t',
'          WHERE SUBSTR(t.item_code, 3, 7) = ffv.flex_value',
'        )',
')',
'SELECT COUNT(*)',
'INTO v_flex_count',
'FROM themes;  ',
'',
'    /* ITEM COUNT */',
'   SELECT COUNT(DISTINCT m.segment1)',
'    INTO v_item_count',
'    FROM mtl_system_items_b m',
'     JOIN TJD_PON.TJD_PON_PDIS_COLL_TB p',
'     ON p.theme = SUBSTR(m.segment1, 3, 7)',
'     AND p.PDIS_DATE >= TO_DATE(:P1000_FROM_DATE, ''DD/MM/YYYY'')',
'     AND p.PDIS_DATE <  TO_DATE(:P1000_TO_DATE, ''DD/MM/YYYY'') + 1',
'     AND ( :P1000_COORDINATOR_NAME IS NULL',
'      OR p.coordinator_name = :P1000_COORDINATOR_NAME )',
'     AND ( :P1000_BRAND IS NULL',
'      OR p.brand = :P1000_BRAND )',
'     AND ( :P1000_COLLECTION_NAME IS NULL',
'      OR p.collection_name = :P1000_COLLECTION_NAME )',
'JOIN apps.tjd_pon_mtl_cross_references_vw c',
'     ON c.inventory_item_id = m.inventory_item_id',
'     AND c.CROSS_REFERENCE_TYPE = ''Pricing Information''  ',
'LEFT JOIN ( SELECT DISTINCT item_code',
'             FROM tjd_pon.tjd_po_outright_vp_apex_tbl) o',
'              ON o.item_code = m.segment1',
'LEFT JOIN (SELECT DISTINCT product',
'             FROM TJD_PON.TJD_PON_OWK_JWK_TBL',
'            WHERE order_type = ''PROTO ORDER'') w',
'               ON w.product = m.segment1',
'LEFT JOIN(SELECT DISTINCT product_code',
'            FROM tnq_opm_transfer_dtl_tb) s',
'              ON s.product_code = m.segment1',
'LEFT JOIN(SELECT DISTINCT item_no',
'            FROM tnq_demerit_details) g',
'    ON g.item_no = m.segment1',
'     WHERE m.organization_id = 122',
'      AND m.attribute22 <> ''D''',
'      AND o.item_code IS NULL',
'      AND w.product IS NULL',
'      AND s.product_code IS NULL',
'      AND g.item_no IS NULL;',
'  ',
'',
'    /* OUTRIGHT */',
'    SELECT COUNT(DISTINCT t.item_code)',
'    INTO v_outright_count',
'     FROM tjd_pon.tjd_po_outright_vp_apex_tbl t',
'',
'JOIN (',
'      SELECT DISTINCT theme',
'      FROM TJD_PON.TJD_PON_PDIS_COLL_TB',
'         WHERE PDIS_DATE  >= TO_DATE(:P1000_FROM_DATE, ''DD/MM/YYYY'')',
'           AND PDIS_DATE  <  TO_DATE(:P1000_TO_DATE,   ''DD/MM/YYYY'') + 1',
'            AND ( :P1000_COORDINATOR_NAME IS NULL OR coordinator_name = :P1000_COORDINATOR_NAME )',
'            AND ( :P1000_BRAND            IS NULL OR brand            = :P1000_BRAND )',
'            AND ( :P1000_COLLECTION_NAME  IS NULL OR collection_name  = :P1000_COLLECTION_NAME )',
'     ) p2',
'  ON SUBSTR(t.item_code, 3, 7) = p2.theme',
'',
'LEFT JOIN tnq_demerit_details A',
'  ON A.item_no = t.item_code',
' AND A.defect_type IN (''ACCEPT'', ''REJECT'')',
'',
'WHERE UPPER(t.order_type) = ''PROTO ORDER''',
'AND A.item_no IS NULL;',
'     ',
'',
'    /* OUTWORK */',
'WITH owk AS (',
'  SELECT /*+ MATERIALIZE */ o.product',
'  FROM TJD_PON.TJD_PON_OWK_JWK_TBL o',
'  JOIN TJD_PON.TJD_PON_PDIS_COLL_TB t',
'    ON t.THEME = SUBSTR(o.PRODUCT, 3, 7)',
'  WHERE t.PDIS_DATE >= TO_DATE(:P1000_FROM_DATE, ''DD/MM/YYYY'')',
'    AND t.PDIS_DATE <  TO_DATE(:P1000_TO_DATE,   ''DD/MM/YYYY'') + 1',
'    AND ( :P1000_COORDINATOR_NAME IS NULL OR t.coordinator_name = :P1000_COORDINATOR_NAME )',
'    AND ( :P1000_BRAND            IS NULL OR t.brand            = :P1000_BRAND )',
'    AND ( :P1000_COLLECTION_NAME  IS NULL OR t.collection_name  = :P1000_COLLECTION_NAME )',
')',
'SELECT /*+ LEADING(o) USE_NL(o) */',
'       /* If product duplicates exist in OWK, re-enable DISTINCT here, not in CTE: DISTINCT */',
'      count( DISTINCT o.product)',
'          INTO v_outwork_count',
'FROM owk o',
'WHERE NOT EXISTS (',
'        SELECT 1',
'        FROM tnq_opm_transfer_dtl_tb a',
'        WHERE a.product_code = o.product',
'      )',
'  AND NOT EXISTS (',
'        SELECT 1',
'        FROM tnq_demerit_details c',
'        WHERE c.item_no = o.product',
'          AND c.defect_type = ''ACCEPT''',
'      );',
'      ',
'    /* TOTAL THEME */',
'    SELECT COUNT(DISTINCT theme)',
'    INTO v_total_theme',
'    FROM TJD_PON.TJD_PON_PDIS_COLL_TB',
'    WHERE created_date >= TO_DATE(:P1000_FROM_DATE,''DD/MM/YYYY'')',
'      AND created_date <  TO_DATE(:P1000_TO_DATE,''DD/MM/YYYY'') + 1',
'      AND ( :P1000_COORDINATOR_NAME IS NULL',
'            OR UPPER(coordinator_name) = :P1000_COORDINATOR_NAME )',
'       AND ( :P1000_BRAND IS NULL',
'            OR UPPER(brand) = :P1000_BRAND )',
'      AND  ( :P1000_COLLECTION_NAME IS NULL',
'      OR (collection_name) = :P1000_COLLECTION_NAME ) ;',
'',
'    /* STOCK */',
'    SELECT COUNT(DISTINCT a.product_code)',
'    INTO v_stock',
'    FROM apps.tnq_opm_transfer_dtl_tb a',
'    JOIN apps.tnq_opm_transfer_hdr_tb b',
'        ON a.header_id = b.transfer_no',
'    JOIN TJD_PON.TJD_PON_PDIS_COLL_TB c',
'        ON SUBSTR(a.product_code,3,7) = c.theme',
'    WHERE b.waybill_date IS NOT NULL',
'      AND b.waybill_date >= TO_DATE(:P1000_FROM_DATE,''DD/MM/YYYY'')',
'      AND b.waybill_date <  TO_DATE(:P1000_TO_DATE,''DD/MM/YYYY'') + 1',
'      AND ( :P1000_COORDINATOR_NAME IS NULL',
'            OR UPPER(c.coordinator_name) = :P1000_COORDINATOR_NAME )',
'       AND ( :P1000_BRAND IS NULL',
'            OR UPPER(c.brand) = :P1000_BRAND )',
'  AND  ( :P1000_COLLECTION_NAME IS NULL',
'      OR (c.collection_name) = :P1000_COLLECTION_NAME )             ;',
'                    ',
'  /* DEMERIT */          ',
'         ',
'  SELECT COUNT(DISTINCT(SUBSTR(A.item_no, 3, 7) ))',
'INTO v_demerit',
'FROM tnq_demerit_details A,',
'     tjd_pon.tjd_pon_pdis_coll_tb B',
'WHERE substr(A.item_no, 3, 7) = B.theme',
'AND A.CREATION_DATE >= TO_DATE(:P1000_FROM_DATE,''DD/MM/YYYY'')',
'AND A.CREATION_DATE < TO_DATE(:P1000_TO_DATE,''DD/MM/YYYY'')',
'AND A.DEFECT_TYPE = ''REJECT''',
' AND ( :P1000_COORDINATOR_NAME IS NULL',
'            OR B.coordinator_name = :P1000_COORDINATOR_NAME )',
'       AND ( :P1000_BRAND IS NULL',
'            OR B.brand = :P1000_BRAND )',
' AND  ( :P1000_COLLECTION_NAME IS NULL',
'      OR (B.collection_name) = :P1000_COLLECTION_NAME ) ;    ',
'      ',
'    /* GIT */',
'WITH demerit AS (',
'  SELECT',
'     a.item_no',
'  FROM tnq_demerit_details a',
'  JOIN tjd_pon.tjd_pon_pdis_coll_tb b',
'    ON SUBSTR(a.item_no, 3, 7) = b.theme',
'  WHERE b.PDIS_DATE  >= TO_DATE(:P1000_FROM_DATE, ''DD/MM/YYYY'')',
'    AND b.PDIS_DATE  <  TO_DATE(:P1000_TO_DATE,   ''DD/MM/YYYY'') + 1 -- make end date inclusive',
'    AND ( :P1000_COORDINATOR_NAME IS NULL OR b.coordinator_name = :P1000_COORDINATOR_NAME )',
'    AND ( :P1000_BRAND            IS NULL OR b.brand            = :P1000_BRAND )',
'    AND ( :P1000_COLLECTION_NAME  IS NULL OR b.collection_name  = :P1000_COLLECTION_NAME )',
'    AND a.defect_type = ''ACCEPT''',
'),',
'xfer AS (',
'  -- All product_codes that qualify by transfer rules within date window',
'  SELECT  a.product_code',
'  FROM apps.tnq_opm_transfer_dtl_tb a',
'  JOIN tjd_pon.tjd_pon_pdis_coll_tb c',
'    ON SUBSTR(a.product_code, 3, 7) = c.theme',
'  WHERE c.PDIS_DATE  >= TO_DATE(:P1000_FROM_DATE, ''DD/MM/YYYY'')',
'    AND c.PDIS_DATE  <  TO_DATE(:P1000_TO_DATE,   ''DD/MM/YYYY'') + 1',
')',
'SELECT  count(distinct a.item_no)',
'INTO v_git',
'FROM demerit a',
'LEFT JOIN xfer x',
'  ON x.product_code = a.item_no',
'WHERE x.product_code IS NULL;',
'BEGIN',
'    -- Set session state',
'    apex_util.set_session_state(''P1000_TOTAL_THEME'',    v_total_theme);',
'    apex_util.set_session_state(''P1000_VALUE_COUNT'',    v_flex_count);',
'    apex_util.set_session_state(''P1000_ITEM_COUNT'',     v_item_count);',
'    apex_util.set_session_state(''P1000_OUTRIGHT_COUNT'', v_outright_count);',
'    apex_util.set_session_state(''P1000_OUTWORK_COUNT'',  v_outwork_count);',
'    apex_util.set_session_state(''P1000_DEMERIT_COUNT'',  v_demerit);',
'    apex_util.set_session_state(''P1000_GIT_COUNT'',      v_git);',
'    apex_util.set_session_state(''P1000_STOCK_COUNT'',    v_stock);',
'',
'    -- Return JSON',
'   /* apex_json.open_object;',
'    apex_json.write(''TOTAL_THEME'',  TO_CHAR(ABS(v_total_theme),    ''999G99G999G999''));',
'    apex_json.write(''FLEX'',    TO_CHAR(ABS(v_flex_count),     ''999G99G999G999''));',
'    apex_json.write(''ITEM'',   TO_CHAR(ABS(v_item_count),     ''999G99G999G999''));',
'    apex_json.write(''OUTRIGHT'',  TO_CHAR(ABS(v_outright_count), ''999G99G999G999''));',
'    apex_json.write(''OUTWORK'',        v_outwork_count);',
'    apex_json.write(''DEMERIT'',        v_demerit);',
'    apex_json.write(''GIT'',            v_git);',
'    apex_json.write(''STOCK'',          v_stock);',
'    apex_json.close_object;*/',
'END;',
'',
'DECLARE',
'    PROCEDURE add_count (',
'        p_name  IN VARCHAR2,',
'        p_value IN NUMBER',
'    ) IS',
'    BEGIN',
'        apex_collection.add_member(',
'            p_collection_name => ''P1000_DASH_COUNTS'',',
'            p_c001            => p_name,',
'            p_n001            => p_value',
'        );',
'    END;',
'BEGIN',
'',
'    IF NOT apex_collection.collection_exists(''P1000_DASH_COUNTS'') THEN',
'        apex_collection.create_collection(''P1000_DASH_COUNTS'');',
'    ELSE',
'        apex_collection.truncate_collection(''P1000_DASH_COUNTS'');',
'    END IF;',
'',
'    add_count(''TOTAL_THEME'', v_total_theme);',
'    add_count(''FLEX'',        v_flex_count);',
'    add_count(''ITEM'',        v_item_count);',
'    add_count(''OUTRIGHT'',    v_outright_count);',
'    add_count(''OUTWORK'',     v_outwork_count);',
'    add_count(''DEMERIT'',     v_demerit);',
'    add_count(''GIT'',         v_git);',
'    add_count(''STOCK'',       v_stock);',
'',
'',
'END;',
'',
'',
'    /* JSON OUTPUT (FORMATTED STRINGS) */',
'    ',
'    apex_json.open_object;',
'    apex_json.write(''TOTAL_THEME'', TO_CHAR(ABS(v_total_theme),    ''999G99G999G999''));',
'apex_json.write(''FLEX'',        TO_CHAR(ABS(v_flex_count),     ''999G99G999G999''));',
'apex_json.write(''ITEM'',        TO_CHAR(ABS(v_item_count),     ''999G99G999G999''));',
'apex_json.write(''OUTRIGHT'',    TO_CHAR(ABS(v_outright_count), ''999G99G999G999''));',
'apex_json.write(''OUTWORK'',     TO_CHAR(ABS(v_outwork_count),  ''999G99G999G999''));',
'apex_json.write(''STOCK'',       TO_CHAR(ABS(v_stock),          ''999G99G999G999''));',
'apex_json.write(''DEMERIT'',     TO_CHAR(ABS(v_demerit),        ''999G99G999G999''));',
'apex_json.write(''GIT'',         TO_CHAR(ABS(v_git),            ''999G99G999G999''));',
'',
'    apex_json.close_object;',
'    ',
'END;',
''))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
end;
/
prompt --application/end_environment
begin
wwv_flow_api.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false));
commit;
end;
/
set verify on feedback on define on
prompt  ...done
