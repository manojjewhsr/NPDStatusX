change connection <add name="ConStringOracle" connectionString="Data Source=(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=zuhurac-scan.titan.co.in)(PORT=1530)))(CONNECT_DATA=(SERVER=DEDICATED)(SERVICE_NAME=PROD)));User Id=appsread;Password=appsread;Max Pool Size=200;Connect Timeout=15;" providerName="Oracle.ManagedDataAccess.Client" />


dashboad count query & select card show list table
DECLARE
    v_flex_count     NUMBER := 0;
    v_item_count     NUMBER := 0;
    v_outright_count NUMBER := 0;
    v_outwork_count  NUMBER := 0;
    v_total_theme    NUMBER := 0;
    v_stock          NUMBER := 0;
    v_demerit         NUMBER := 0;
    v_git         NUMBER := 0;

    v_flex_final     NUMBER := 0;
    v_item_final     NUMBER := 0;
BEGIN
    /* FLEX COUNT */
 WITH themes AS (
  SELECT DISTINCT ffv.flex_value
  FROM apps.tjd_pon_fnd_flex_values_v ffv
  JOIN apps.tjd_pon_fnd_flex_values_tl_v ffvt
    ON ffv.flex_value_id = ffvt.flex_value_id
  JOIN tjd_pon.tjd_pon_fnd_flex_value_sets_v ffvs
    ON ffv.flex_value_set_id = ffvs.flex_value_set_id
   AND ffvs.flex_value_set_name = 'THEME_DESIGN'
  JOIN tjd_pon.tjd_pon_pdis_coll_tb p
    ON p.theme = ffv.flex_value
  WHERE ffv.flex_value IS NOT NULL
    AND p.pdis_date >= TO_DATE(:P1000_FROM_DATE, 'DD/MM/YYYY')
    AND p.pdis_date <  TO_DATE(:P1000_TO_DATE,   'DD/MM/YYYY') + 1
     AND ( :P1000_COORDINATOR_NAME IS NULL OR p.coordinator_name = :P1000_COORDINATOR_NAME )
    AND ( :P1000_BRAND            IS NULL OR p.brand            = :P1000_BRAND )
    AND ( :P1000_COLLECTION_NAME  IS NULL OR p.collection_name  = :P1000_COLLECTION_NAME )
    -- Exclude Item Master (org 122)
    AND NOT EXISTS (
          SELECT 1
          FROM apps.mtl_system_items_b m
          WHERE SUBSTR(m.segment1, 3, 7) = ffv.flex_value
            AND m.organization_id = 122
        )

    -- Exclude Demerit by item_no -> theme
    AND NOT EXISTS (
          SELECT 1
          FROM tnq_demerit_details d
          WHERE SUBSTR(d.item_no, 3, 7) = ffv.flex_value
        )

    -- Exclude OWK/JWK by product -> theme
    AND NOT EXISTS (
          SELECT 1
          FROM tjd_pon.tjd_pon_owk_jwk_tbl e
          WHERE SUBSTR(e.product, 3, 7) = ffv.flex_value
        )

    -- Exclude Outright by item_code -> theme
    AND NOT EXISTS (
          SELECT 1
          FROM tjd_pon.tjd_po_outright_vp_apex_tbl t
          WHERE SUBSTR(t.item_code, 3, 7) = ffv.flex_value
        )
)
SELECT COUNT(*)
INTO v_flex_count
FROM themes;  

    /* ITEM COUNT */
   SELECT COUNT(DISTINCT m.segment1)
    INTO v_item_count
    FROM mtl_system_items_b m
     JOIN TJD_PON.TJD_PON_PDIS_COLL_TB p
     ON p.theme = SUBSTR(m.segment1, 3, 7)
     AND p.PDIS_DATE >= TO_DATE(:P1000_FROM_DATE, 'DD/MM/YYYY')
     AND p.PDIS_DATE <  TO_DATE(:P1000_TO_DATE, 'DD/MM/YYYY') + 1
     AND ( :P1000_COORDINATOR_NAME IS NULL
      OR p.coordinator_name = :P1000_COORDINATOR_NAME )
     AND ( :P1000_BRAND IS NULL
      OR p.brand = :P1000_BRAND )
     AND ( :P1000_COLLECTION_NAME IS NULL
      OR p.collection_name = :P1000_COLLECTION_NAME )
JOIN apps.tjd_pon_mtl_cross_references_vw c
     ON c.inventory_item_id = m.inventory_item_id
     AND c.CROSS_REFERENCE_TYPE = 'Pricing Information'  
LEFT JOIN ( SELECT DISTINCT item_code
             FROM tjd_pon.tjd_po_outright_vp_apex_tbl) o
              ON o.item_code = m.segment1
LEFT JOIN (SELECT DISTINCT product
             FROM TJD_PON.TJD_PON_OWK_JWK_TBL
            WHERE order_type = 'PROTO ORDER') w
               ON w.product = m.segment1
LEFT JOIN(SELECT DISTINCT product_code
            FROM tnq_opm_transfer_dtl_tb) s
              ON s.product_code = m.segment1
LEFT JOIN(SELECT DISTINCT item_no
            FROM tnq_demerit_details) g
    ON g.item_no = m.segment1
     WHERE m.organization_id = 122
      AND m.attribute22 <> 'D'
      AND o.item_code IS NULL
      AND w.product IS NULL
      AND s.product_code IS NULL
      AND g.item_no IS NULL;
  

    /* OUTRIGHT */
    SELECT COUNT(DISTINCT t.item_code)
    INTO v_outright_count
     FROM tjd_pon.tjd_po_outright_vp_apex_tbl t

JOIN (
      SELECT DISTINCT theme
      FROM TJD_PON.TJD_PON_PDIS_COLL_TB
         WHERE PDIS_DATE  >= TO_DATE(:P1000_FROM_DATE, 'DD/MM/YYYY')
           AND PDIS_DATE  <  TO_DATE(:P1000_TO_DATE,   'DD/MM/YYYY') + 1
            AND ( :P1000_COORDINATOR_NAME IS NULL OR coordinator_name = :P1000_COORDINATOR_NAME )
            AND ( :P1000_BRAND            IS NULL OR brand            = :P1000_BRAND )
            AND ( :P1000_COLLECTION_NAME  IS NULL OR collection_name  = :P1000_COLLECTION_NAME )
     ) p2
  ON SUBSTR(t.item_code, 3, 7) = p2.theme

LEFT JOIN tnq_demerit_details A
  ON A.item_no = t.item_code
 AND A.defect_type IN ('ACCEPT', 'REJECT')

WHERE UPPER(t.order_type) = 'PROTO ORDER'
AND A.item_no IS NULL;
     

    /* OUTWORK */
WITH owk AS (
  SELECT /*+ MATERIALIZE */ o.product
  FROM TJD_PON.TJD_PON_OWK_JWK_TBL o
  JOIN TJD_PON.TJD_PON_PDIS_COLL_TB t
    ON t.THEME = SUBSTR(o.PRODUCT, 3, 7)
  WHERE t.PDIS_DATE >= TO_DATE(:P1000_FROM_DATE, 'DD/MM/YYYY')
    AND t.PDIS_DATE <  TO_DATE(:P1000_TO_DATE,   'DD/MM/YYYY') + 1
    AND ( :P1000_COORDINATOR_NAME IS NULL OR t.coordinator_name = :P1000_COORDINATOR_NAME )
    AND ( :P1000_BRAND            IS NULL OR t.brand            = :P1000_BRAND )
    AND ( :P1000_COLLECTION_NAME  IS NULL OR t.collection_name  = :P1000_COLLECTION_NAME )
)
SELECT /*+ LEADING(o) USE_NL(o) */
       /* If product duplicates exist in OWK, re-enable DISTINCT here, not in CTE: DISTINCT */
      count( DISTINCT o.product)
          INTO v_outwork_count
FROM owk o
WHERE NOT EXISTS (
        SELECT 1
        FROM tnq_opm_transfer_dtl_tb a
        WHERE a.product_code = o.product
      )
  AND NOT EXISTS (
        SELECT 1
        FROM tnq_demerit_details c
        WHERE c.item_no = o.product
          AND c.defect_type = 'ACCEPT'
      );
      
    /* TOTAL THEME */
    SELECT COUNT(DISTINCT theme)
    INTO v_total_theme
    FROM TJD_PON.TJD_PON_PDIS_COLL_TB
    WHERE created_date >= TO_DATE(:P1000_FROM_DATE,'DD/MM/YYYY')
      AND created_date <  TO_DATE(:P1000_TO_DATE,'DD/MM/YYYY') + 1
      AND ( :P1000_COORDINATOR_NAME IS NULL
            OR UPPER(coordinator_name) = :P1000_COORDINATOR_NAME )
       AND ( :P1000_BRAND IS NULL
            OR UPPER(brand) = :P1000_BRAND )
      AND  ( :P1000_COLLECTION_NAME IS NULL
      OR (collection_name) = :P1000_COLLECTION_NAME ) ;

    /* STOCK */
    SELECT COUNT(DISTINCT a.product_code)
    INTO v_stock
    FROM apps.tnq_opm_transfer_dtl_tb a
    JOIN apps.tnq_opm_transfer_hdr_tb b
        ON a.header_id = b.transfer_no
    JOIN TJD_PON.TJD_PON_PDIS_COLL_TB c
        ON SUBSTR(a.product_code,3,7) = c.theme
    WHERE b.waybill_date IS NOT NULL
      AND b.waybill_date >= TO_DATE(:P1000_FROM_DATE,'DD/MM/YYYY')
      AND b.waybill_date <  TO_DATE(:P1000_TO_DATE,'DD/MM/YYYY') + 1
      AND ( :P1000_COORDINATOR_NAME IS NULL
            OR UPPER(c.coordinator_name) = :P1000_COORDINATOR_NAME )
       AND ( :P1000_BRAND IS NULL
            OR UPPER(c.brand) = :P1000_BRAND )
  AND  ( :P1000_COLLECTION_NAME IS NULL
      OR (c.collection_name) = :P1000_COLLECTION_NAME )             ;
                    
  /* DEMERIT */          
         
  SELECT COUNT(DISTINCT(SUBSTR(A.item_no, 3, 7) ))
INTO v_demerit
FROM tnq_demerit_details A,
     tjd_pon.tjd_pon_pdis_coll_tb B
WHERE substr(A.item_no, 3, 7) = B.theme
AND A.CREATION_DATE >= TO_DATE(:P1000_FROM_DATE,'DD/MM/YYYY')
AND A.CREATION_DATE < TO_DATE(:P1000_TO_DATE,'DD/MM/YYYY')
AND A.DEFECT_TYPE = 'REJECT'
 AND ( :P1000_COORDINATOR_NAME IS NULL
            OR B.coordinator_name = :P1000_COORDINATOR_NAME )
       AND ( :P1000_BRAND IS NULL
            OR B.brand = :P1000_BRAND )
 AND  ( :P1000_COLLECTION_NAME IS NULL
      OR (B.collection_name) = :P1000_COLLECTION_NAME ) ;    
      
    /* GIT */
WITH demerit AS (
  SELECT
     a.item_no
  FROM tnq_demerit_details a
  JOIN tjd_pon.tjd_pon_pdis_coll_tb b
    ON SUBSTR(a.item_no, 3, 7) = b.theme
  WHERE b.PDIS_DATE  >= TO_DATE(:P1000_FROM_DATE, 'DD/MM/YYYY')
    AND b.PDIS_DATE  <  TO_DATE(:P1000_TO_DATE,   'DD/MM/YYYY') + 1 -- make end date inclusive
    AND ( :P1000_COORDINATOR_NAME IS NULL OR b.coordinator_name = :P1000_COORDINATOR_NAME )
    AND ( :P1000_BRAND            IS NULL OR b.brand            = :P1000_BRAND )
    AND ( :P1000_COLLECTION_NAME  IS NULL OR b.collection_name  = :P1000_COLLECTION_NAME )
    AND a.defect_type = 'ACCEPT'
),
xfer AS (
  -- All product_codes that qualify by transfer rules within date window
  SELECT  a.product_code
  FROM apps.tnq_opm_transfer_dtl_tb a
  JOIN tjd_pon.tjd_pon_pdis_coll_tb c
    ON SUBSTR(a.product_code, 3, 7) = c.theme
  WHERE c.PDIS_DATE  >= TO_DATE(:P1000_FROM_DATE, 'DD/MM/YYYY')
    AND c.PDIS_DATE  <  TO_DATE(:P1000_TO_DATE,   'DD/MM/YYYY') + 1
)
SELECT  count(distinct a.item_no)
INTO v_git
FROM demerit a
LEFT JOIN xfer x
  ON x.product_code = a.item_no
WHERE x.product_code IS NULL;
BEGIN
    -- Set session state
    apex_util.set_session_state('P1000_TOTAL_THEME',    v_total_theme);
    apex_util.set_session_state('P1000_VALUE_COUNT',    v_flex_count);
    apex_util.set_session_state('P1000_ITEM_COUNT',     v_item_count);
    apex_util.set_session_state('P1000_OUTRIGHT_COUNT', v_outright_count);
    apex_util.set_session_state('P1000_OUTWORK_COUNT',  v_outwork_count);
    apex_util.set_session_state('P1000_DEMERIT_COUNT',  v_demerit);
    apex_util.set_session_state('P1000_GIT_COUNT',      v_git);
    apex_util.set_session_state('P1000_STOCK_COUNT',    v_stock);

    -- Return JSON
   /* apex_json.open_object;
    apex_json.write('TOTAL_THEME',  TO_CHAR(ABS(v_total_theme),    '999G99G999G999'));
    apex_json.write('FLEX',    TO_CHAR(ABS(v_flex_count),     '999G99G999G999'));
    apex_json.write('ITEM',   TO_CHAR(ABS(v_item_count),     '999G99G999G999'));
    apex_json.write('OUTRIGHT',  TO_CHAR(ABS(v_outright_count), '999G99G999G999'));
    apex_json.write('OUTWORK',        v_outwork_count);
    apex_json.write('DEMERIT',        v_demerit);
    apex_json.write('GIT',            v_git);
    apex_json.write('STOCK',          v_stock);
    apex_json.close_object;*/
END;

DECLARE
    PROCEDURE add_count (
        p_name  IN VARCHAR2,
        p_value IN NUMBER
    ) IS
    BEGIN
        apex_collection.add_member(
            p_collection_name => 'P1000_DASH_COUNTS',
            p_c001            => p_name,
            p_n001            => p_value
        );
    END;
BEGIN

    IF NOT apex_collection.collection_exists('P1000_DASH_COUNTS') THEN
        apex_collection.create_collection('P1000_DASH_COUNTS');
    ELSE
        apex_collection.truncate_collection('P1000_DASH_COUNTS');
    END IF;

    add_count('TOTAL_THEME', v_total_theme);
    add_count('FLEX',        v_flex_count);
    add_count('ITEM',        v_item_count);
    add_count('OUTRIGHT',    v_outright_count);
    add_count('OUTWORK',     v_outwork_count);
    add_count('DEMERIT',     v_demerit);
    add_count('GIT',         v_git);
    add_count('STOCK',       v_stock);


END;


    /* JSON OUTPUT (FORMATTED STRINGS) */
    
    apex_json.open_object;
    apex_json.write('TOTAL_THEME', TO_CHAR(ABS(v_total_theme),    '999G99G999G999'));
apex_json.write('FLEX',        TO_CHAR(ABS(v_flex_count),     '999G99G999G999'));
apex_json.write('ITEM',        TO_CHAR(ABS(v_item_count),     '999G99G999G999'));
apex_json.write('OUTRIGHT',    TO_CHAR(ABS(v_outright_count), '999G99G999G999'));
apex_json.write('OUTWORK',     TO_CHAR(ABS(v_outwork_count),  '999G99G999G999'));
apex_json.write('STOCK',       TO_CHAR(ABS(v_stock),          '999G99G999G999'));
apex_json.write('DEMERIT',     TO_CHAR(ABS(v_demerit),        '999G99G999G999'));
apex_json.write('GIT',         TO_CHAR(ABS(v_git),            '999G99G999G999'));

    apex_json.close_object;
    
END;
