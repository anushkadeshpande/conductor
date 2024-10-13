-- Drop the 'combo_queue_message' index if it exists
DECLARE
    sql_query  VARCHAR2 (150);
BEGIN
    SELECT CASE WHEN
                    (SELECT COUNT(INDEX_NAME) FROM all_indexes WHERE OWNER = USER AND TABLE_NAME = 'QUEUE_MESSAGE' AND INDEX_NAME = 'COMBO_QUEUE_MESSAGE') > 0
                    THEN
                    'DROP INDEX COMBO_QUEUE_MESSAGE'
                ELSE
                    'SELECT 1 FROM DUAL'
               END
    INTO sql_query from DUAL;
    EXECUTE IMMEDIATE sql_query;
END;
/

-- Re-create the 'combo_queue_message' index to add priority column because queries that order by priority are slow in large databases.
CREATE INDEX combo_queue_message ON queue_message (queue_name,priority,popped,deliver_on,created_on);
