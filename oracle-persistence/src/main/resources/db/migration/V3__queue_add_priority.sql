DECLARE
    sql_query  VARCHAR2 (150);
BEGIN
    SELECT CASE WHEN
                    (SELECT COUNT(*) FROM all_tab_columns WHERE OWNER = USER AND TABLE_NAME = 'QUEUE_MESSAGE' AND COLUMN_NAME = 'PRIORITY' ) > 0
                    THEN
                    'SELECT 1 FROM DUAL'
                ELSE
                    'ALTER TABLE QUEUE_MESSAGE ADD PRIORITY NUMBER(3) DEFAULT 0'
               END
    INTO sql_query from DUAL;
    EXECUTE IMMEDIATE sql_query;
END;
/
