USE [DataWarehouse]
GO

/* ============================================================
   Stored Procedure: bronze_table_creation
   Purpose        : Create Bronze Layer tables for CRM & ERP data
   Layer          : Bronze (Raw / Landing Layer)
   Description    : Drops and recreates source-aligned tables
                    used for initial data ingestion.
   ============================================================ */

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[bronze_table_creation]
AS
BEGIN

    /* ========================================================
       CRM CUSTOMER INFORMATION – BRONZE TABLE
       Stores raw customer master data from CRM system
       ======================================================== */
    IF OBJECT_ID('bronze.crm_cust_info','U') IS NOT NULL
        DROP TABLE bronze.crm_cust_info;

    CREATE TABLE bronze.crm_cust_info (
        cst_id              INT,
        cst_key             NVARCHAR(50),
        cst_firstname       NVARCHAR(50),
        cst_lastname        NVARCHAR(50),
        cst_material_status NVARCHAR(50),
        cst_gndr            NVARCHAR(50),
        cst_create_date     DATE
    );

    /* ========================================================
       CRM PRODUCT INFORMATION – BRONZE TABLE
       Stores raw product master data from CRM system
       ======================================================== */
    IF OBJECT_ID('bronze.crm_prd_info','U') IS NOT NULL
        DROP TABLE bronze.crm_prd_info;

    CREATE TABLE bronze.crm_prd_info (
        prd_id        INT,
        prd_key       NVARCHAR(50),
        prd_nm        NVARCHAR(50),
        prd_cost      INT,
        prd_line      NVARCHAR(50),
        prd_start_dt  DATETIME,
        prd_end_dt    DATETIME
    );

    /* ========================================================
       CRM SALES TRANSACTION DATA – BRONZE TABLE
       Stores raw transactional sales records
       ======================================================== */
    IF OBJECT_ID('bronze.crm_sales_details','U') IS NOT NULL
        DROP TABLE bronze.crm_sales_details;

    CREATE TABLE bronze.crm_sales_details (
        sls_ord_num   NVARCHAR(50),
        sls_prd_key   NVARCHAR(50),
        sls_cust_id   INT,
        sls_order_dt  INT,
        sls_ship_dt   INT,
        sls_due_dt    INT,
        sls_sales     INT,
        sls_quantity  INT,
        sls_price     INT
    );

    /* ========================================================
       ERP CUSTOMER DEMOGRAPHICS – BRONZE TABLE
       Stores customer birthdate and gender from ERP
       ======================================================== */
    IF OBJECT_ID('bronze.erp_cust_az12','U') IS NOT NULL
        DROP TABLE bronze.erp_cust_az12;

    CREATE TABLE bronze.erp_cust_az12 (
        cid   NVARCHAR(50),
        bdate DATE,
        gen   NVARCHAR(50)
    );

    /* ========================================================
       ERP CUSTOMER LOCATION – BRONZE TABLE
       Stores country/location details from ERP
       ======================================================== */
    IF OBJECT_ID('bronze.erp_loc_a101','U') IS NOT NULL
        DROP TABLE bronze.erp_loc_a101;

    CREATE TABLE bronze.erp_loc_a101 (
        cid   NVARCHAR(50),
        cntry NVARCHAR(50)
    );

    /* ========================================================
       ERP PRODUCT CATEGORY – BRONZE TABLE
       Stores product category and maintenance information
       ======================================================== */
    IF OBJECT_ID('bronze.erp_px_cat_g1v2','U') IS NOT NULL
        DROP TABLE bronze.erp_px_cat_g1v2;

    CREATE TABLE bronze.erp_px_cat_g1v2 (
        id          NVARCHAR(50),
        cat         NVARCHAR(50),
        subcat      NVARCHAR(50),
        maintenance NVARCHAR(50)
    );

END;
GO
