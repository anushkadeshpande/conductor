-- Drop the 'workflow_corr_id_index' index if it exists
DECLARE
    sql_query  VARCHAR2 (150);
BEGIN
    SELECT CASE WHEN
                    (SELECT COUNT(INDEX_NAME) FROM all_indexes WHERE OWNER = USER AND TABLE_NAME = 'WORKFLOW' AND INDEX_NAME = 'WORKFLOW_CORR_ID_INDEX') > 0
                    THEN
                    'ALTER TABLE WORKFLOW DROP CONSTRAINT WORKFLOW_CORR_ID_INDEX DROP INDEX'
                ELSE
                    'SELECT 1 FROM DUAL'
               END
    INTO sql_query from DUAL;
    EXECUTE IMMEDIATE sql_query;
END;
/

-- Create the 'workflow_corr_id_index' index with correlation_id column because correlation_id queries are slow in large databases.
CREATE INDEX workflow_corr_id_index ON workflow (correlation_id);
