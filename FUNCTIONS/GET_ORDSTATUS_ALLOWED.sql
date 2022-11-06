--------------------------------------------------------
--  DDL for Function GET_ORDSTATUS_ALLOWED
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "YYORDERDB2"."GET_ORDSTATUS_ALLOWED" (pUSERNAME           IN VARCHAR2,
                                                             pORGANIZATION_ID   IN NUMBER,
                                                             pORD_STATUS         IN VARCHAR2,
                                                             pORD_TYPE           IN VARCHAR2,
                                                             pORD_MARKT          IN VARCHAR2)
   RETURN ordstatus_arr
   PIPELINED
IS
--   PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN   
   -- Fall 3.5.6 "Loschen" wird uber die App geregelt und zusatzlich uber Trigger
   FOR r
      IN (SELECT   *
            FROM   V_APEX_USERRIGHTS
           WHERE   UPPER (USERNAME) LIKE REPLACE (UPPER (pUsername), 'POWER\') AND ORGANIZATION_ID = pORGANIZATION_ID)
   LOOP
      IF pORD_STATUS IS NULL AND r.FL_INIT = 'J'
      -- Fall 3.5.1 bis 3.5.5
      -- Wenn noch kein Status vergeben wurde wird ermittelt, ob der User fur diese Organisation das Init Recht hat
      THEN
         PIPE ROW (ordstatus_type (AOO.Stat_Sleeping));
         PIPE ROW (ordstatus_type (AOO.Stat_New));
      END IF;

      IF pORD_STATUS IS NULL AND r.FL_TRADE = 'J'
      THEN
         PIPE ROW (ordstatus_type (AOO.Stat_In_System));
         PIPE ROW (ordstatus_type (AOO.Stat_Await_Settle));
      END IF;

      IF pORD_STATUS IN (AOO.Stat_Sleeping) AND r.FL_INIT = 'J'
      -- Fall 3.5.1 bis 3.5.5
      -- Wenn der Datensatz angelegt wurde und der User das Init Recht hat, dann darf er ihn wieder auf Sleeping setzen oder updaten solange er noch nicht "IN SYSTEM" ist.
      THEN
         PIPE ROW (ordstatus_type (AOO.Stat_Sleeping));
         PIPE ROW (ordstatus_type (AOO.Stat_New));
      END IF;

      IF pORD_STATUS IN (AOO.Stat_New) AND r.FL_INIT = 'J'
      -- Wenn der Datensatz angelegt wurde und der User das Init Recht hat, dann darf er ihn auf "DELETION REQUEST" setzen.
      THEN
         PIPE ROW (ordstatus_type (AOO.Stat_New));
         PIPE ROW (ordstatus_type (AOO.Stat_Deletion_Request));
      END IF;

      IF pORD_STATUS IN (AOO.Stat_Deletion_Request) AND r.FL_TRADE = 'J'
      -- Wenn der Datensatz angelegt wurde und der User das Init Recht hat, dann darf er ihn auf "DELETION REQUEST" setzen.
      THEN
         PIPE ROW (ordstatus_type (AOO.Stat_Deletion_Confirmed));
      END IF;

      IF pORD_STATUS IN (AOO.Stat_New, AOO.Stat_Update_Request) AND r.FL_TRADE = 'J'
      -- Fall 3.5.2 bis 3.5.4
      -- Wenn der Datensatz angelegt oder verandert wurde und der User handeln darf, dann kann er ihn auf "In System" oder "AWAIT SETTLE" setzen je nach Markt und Ordertyp.
      THEN
         IF pORD_TYPE = 'Match Settle' AND pORD_MARKT IN ('Börse', 'OTC', 'Choice')
         THEN
            PIPE ROW (ordstatus_type (AOO.Stat_Await_Settle));
         ELSE
            PIPE ROW (ordstatus_type (AOO.Stat_In_System));
         END IF;
      END IF;

      IF pORD_STATUS IN (AOO.Stat_In_System, AOO.Stat_Await_Settle, AOO.Stat_Update_Request) AND r.FL_INIT = 'J'
      -- Fall 3.5.4 und 3.5.7 und 3.5.8
      -- Wenn der Datensatz "in System" ist oder gerade upgedated wurde und der User das Init Recht hat, dann darf er ihn updaten oder canceln
      THEN
         PIPE ROW (ordstatus_type (AOO.Stat_Update_Request));
         PIPE ROW (ordstatus_type (AOO.Stat_Cancellation_Request));
      END IF;

      IF     pORD_STATUS IN (AOO.Stat_In_System,
                             AOO.Stat_Await_Settle,
                             AOO.Stat_Update_Request,
                             AOO.Stat_Cancellation_Request)
         AND r.FL_TRADE = 'J'
      -- Fall 3.5.1 bis 3.5.8
      -- Wenn der Datensatz "in System" ist und der User handeln darf, dann darf er ihn als Executed kennzeichnen
      THEN
         PIPE ROW (ordstatus_type (AOO.Stat_Executed));
      END IF;

      IF pORD_STATUS IN (AOO.Stat_Executed) AND r.FL_ADMIN = 'J'
      -- Fall 3.5.1 bis 3.5.3
      -- Wenn der Datensatz "EXECUTED" ist und der User handeln darf, dann darf er ihn als BOOKED kennzeichnen
      THEN
         PIPE ROW (ordstatus_type (AOO.Stat_Booked));
      END IF;

      IF pORD_STATUS IN (AOO.Stat_Cancellation_Request) AND r.FL_TRADE = 'J'
      -- Fall 3.5.7
      -- Wenn der Datensatz "CANCELED" ist und der User handeln darf, dann darf er ihn als CANCELATION CONFIRMED kennzeichnen
      THEN
         PIPE ROW (ordstatus_type (AOO.Stat_Cancellation_Confirmed));
      END IF;

      IF pORD_STATUS IN (AOO.Stat_In_System) AND r.FL_TRADE = 'J'
      -- Fall 3.5.9
      -- Wenn der Datensatz "in System" ist und der User handeln darf, dann darf er ihn als EXPIRED kennzeichnen
      THEN
         PIPE ROW (ordstatus_type (AOO.Stat_Expired));
      END IF;
   END LOOP;

   RETURN;
EXCEPTION
   WHEN no_data_needed
   THEN
      -- Clean up if you need to
      RETURN;
   WHEN OTHERS
   THEN
  logger.log_error('Fehler! pUSERNAME='
      || pUSERNAME
      || ' pORGANIZATION_ID='
      || pORGANIZATION_ID
      || ' pORD_STATUS='
      || pORD_STATUS
      || ' pORD_TYPE='
      || pORD_TYPE
      || ' pORD_MARKT='
      || pORD_MARKT
   );
END;


/
