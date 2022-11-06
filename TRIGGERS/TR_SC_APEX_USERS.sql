--------------------------------------------------------
--  DDL for Trigger TR_SC_APEX_USERS
--------------------------------------------------------

create or replace TRIGGER "TR_SC_APEX_USERS" 
   BEFORE INSERT OR UPDATE
   ON SC_APEX_USERS
   FOR EACH ROW
   
BEGIN
   :NEW.ID := COALESCE (:NEW.ID, SEQ_ID.NEXTVAL);
   :NEW.USERNAME := TRIM (UPPER (:NEW.USERNAME));

   IF INSERTING
   THEN
		
        DECLARE
            l_workspace_id      number;
        BEGIN
            l_workspace_id := apex_util.find_security_group_id (p_workspace => 'MACDENIZ');
            apex_util.set_security_group_id (p_security_group_id => l_workspace_id);    
            APEX_UTIL.CREATE_USER(
                p_user_name    =>   :NEW.USERNAME ,
                p_web_password =>   :NEW.PW );
        END;
   END IF;
   
   IF UPDATING
   THEN
        IF :NEW.PW != :OLD.PW
        THEN
            DECLARE
                l_workspace_id      number;
            BEGIN
                l_workspace_id := apex_util.find_security_group_id (p_workspace => 'MACDENIZ');
                apex_util.set_security_group_id (p_security_group_id => l_workspace_id);    
                APEX_UTIL.RESET_PASSWORD (
                    p_user_name     => :NEW.USERNAME ,
                    p_old_password  => :OLD.PW,
                    p_new_password  => :NEW.PW ,
                    p_change_password_on_first_use => FALSE);
            END;
        END IF;
   END IF;


	:NEW.PW := NULL;


   IF :NEW.FL_LOCKED = 'Y'
   THEN
      BEGIN
         apex_mail.send (p_to     => 'dnz@live.at',
                         p_from   => 'dnz@live.at',
                         p_body   => '',
                         p_subj   => '[SmartCash] User ' || :NEW.USERNAME || ' wurde gerade gelocked!');
         apex_mail.push_queue;
      EXCEPTION
         WHEN OTHERS
         THEN
            logger.log_error('error occured on sending locked user','TR_SC_APEX_USERS');
      END;
   END IF;
   
END;

/
ALTER TRIGGER "TR_SC_APEX_USERS" ENABLE;
