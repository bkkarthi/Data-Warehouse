/*========================================================
  GOLD LAYER – CUSTOMER DIMENSION
  PURPOSE : Create analytics-ready customer dimension
  SOURCE  : Silver Layer (CRM + ERP)
========================================================*/

SELECT  
    ROW_NUMBER() OVER (ORDER BY ci.cst_id) AS customer_key,      -- Surrogate Key
    ci.cst_id        AS customer_id,                             -- Business Key
    ci.cst_key       AS customer_number,
    ci.cst_firstname AS first_name,
    ci.cst_lastname  AS last_name,
    la.cntry         AS country,
    ci.cst_material_status AS marital_status,
    CASE 
        WHEN ci.cst_gndr <> 'n/a' 
            THEN ci.cst_gndr 
        ELSE COALESCE(ca.gen, 'n/a') 
    END AS gender,
    ca.bdate         AS birthdate,
    ci.cst_create_date AS create_date
FROM silver.crm_cust_info       AS ci
LEFT JOIN silver.erp_cust_az12  AS ca
       ON ci.cst_key = ca.cid
LEFT JOIN silver.erp_loc_a101  AS la
       ON ci.cst_key = la.cid;
