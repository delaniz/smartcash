--Package contains only constant variables, has no body!
CREATE OR REPLACE PACKAGE C
IS
  no  CONSTANT VARCHAR2 (1) := 'N';
  yes CONSTANT VARCHAR2 (1) := 'J';
  gc_dml_insert        CONSTANT VARCHAR2 (10 CHAR) := 'INSERT';
  gc_dml_update        CONSTANT VARCHAR2 (10 CHAR) := 'UPDATE';
  gc_dml_delete        CONSTANT VARCHAR2 (10 CHAR) := 'DELETE';
END C;
/
