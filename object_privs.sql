-- rlockard, initial version.
-- this will create a pivot table of object privileges. 
-- to fine tune this, add a where clause to dba_tab_privs

SELECT GRANTEE, 
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
(select grantee, 
    GRANTABLE, 
    owner,
    table_name, 
    type, 
    privilege
FROM DBA_TAB_PRIVS
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
ORDER BY OWNER, TABLE_NAME, GRANTEE;
