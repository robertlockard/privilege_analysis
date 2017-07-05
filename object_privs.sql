-- rlockard, initial version.
-- this will create a pivot table of object privileges. 
-- to fine tune this, add a where clause to dba_tab_privs

SELECT grantee_to, 
      GRANTEE_from, 
      GRANTABLE, 
      OWNER, 
      TABLE_NAME, 
      TYPE, 
      "'SELECT'" SEL, 
      "'UPDATE'" UPD,
      "'INSERT'" INS,
      "'DELETE'" DEL,
      "'EXECUTE'" EXE,
      "'FLASHBACK'" FLSH,
      "'ON COMMIT REFRESH'" OCR,
      "'ALTER'" ALTR,
      "'DEQUEUE'" DEQ,
      "'INHERIT PRIVILEGES'" IPRV,
      "'DEBUG'" DBG,
      "'QUERY REWRITE'" QR,
      "'USE'" US,
      "'READ'" RD,
      "'WRITE'" WT,
      "'INDEX'" IDX,
      "'REFERENCES'" REF
FROM
(SELECT R.GRANTEE "GRANTEE_TO",
    T.GRANTEE GRANTEE_FROM, 
    T.GRANTABLE, 
    T.owner,
    T.table_name, 
    T.TYPE, 
    T.PRIVILEGE
FROM DBA_TAB_PRIVS T,
	 DBA_ROLE_PRIVS R
WHERE T.GRANTEE = R.GRANTED_ROLE (+)
  AND T.OWNER = 'IRP'
)
PIVOT (COUNT(PRIVILEGE)
    FOR PRIVILEGE IN ('SELECT',
                      'UPDATE',
                      'INSERT',
                      'DELETE', 
                      'EXECUTE',
                      'FLASHBACK',
                      'ON COMMIT REFRESH',
                      'ALTER',
                      'DEQUEUE',
                      'INHERIT PRIVILEGES',
                      'DEBUG',
                      'QUERY REWRITE',
                      'USE',
                      'READ',
                      'WRITE',
                      'INDEX',
                      'REFERENCES'))
ORDER BY OWNER, TABLE_NAME, GRANTEE_TO, GRANTEE_FROM;