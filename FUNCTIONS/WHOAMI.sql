CREATE OR REPLACE function YYORDERDB2."WHOAMI"
   return varchar2
--   RESULT_CACHE
is
   vAPP_USER     varchar2(100) := UPPER(REPLACE(v('APP_USER'), 'POWER\'));
   vOS_USER      varchar2(100) := UPPER(SYS_CONTEXT('USERENV', 'OS_USER'));
   vSESSION_USER varchar2(100) := UPPER(SYS_CONTEXT('USERENV', 'SESSION_USER'));
   vWhoami       varchar2(100);
begin
   if vOS_USER = 'ORATST' then
      vOS_USER := 'ORACLE';
   end if;

   vWhoami :=
      case                                                                                   /* OMS_INTERN Apex App */
         when vSESSION_USER = 'APEX_PUBLIC_USER' and vAPP_USER is not null then
            vAPP_USER      /* DB-Link als OMS_EXTERN Apex App User. (App User konnte gefaked sein, DB-Link nicht) */
         when vSESSION_USER = 'APEX_PUBLIC_USER' and vOS_USER in ('ORAPRD', 'ORAGRID', 'ORACLE') then
            'APEX_JOB'                                                            /* DB-Job intern -> Dealbooking */
         when vSESSION_USER = 'YYORDERDB2' and vOS_USER in ('ORAPRD', 'ORAGRID', 'ORACLE') then
            'XDI' /* interner DB-Connect auf dafur eingereichteten User, um direkt in die DB zu schreiben. zb YYORDERDB_VSA, YYORDERDB_STP */
         when (vSESSION_USER in ('PMST', 'TRADEMANAGER', 'TRAP') or vSESSION_USER like 'YYORDERDB\_%' escape '\') then
            vSESSION_USER                            /* interner DB-Connect, verwende OS-User statt Apex APP_USER */
         when vSESSION_USER in (
               'YYORDERDB2',
               'ENDUR',
               'YYLDAPENDUR',
               'YYNDURP1',
               'YYNDURP2',
               'YYNDURP3',
               'YYNDURP4',
               'YYNDURT1',
               'YYNDURT2',
               'YYNDURT3',
               'YYNDURT4',
               'APP_UTIL',
               'MARS_READ',
               'SYS',
               'YYSTP',
               'YYZEP',
               'APT_DWHP_READ',
               'LOOKER_READ',
               'LOOKER',
               'OMS_BO_READ')
            and vAPP_USER is null
         then
            vOS_USER
         when vSESSION_USER = 'YYZEP' and vAPP_USER = 'YYZEP' and vOS_USER = 'ORACLE' then
            'YYZEP'
         when vSESSION_USER = 'YYZEP' and vAPP_USER = 'YYZEP' then
            vOS_USER
         else
            'FRAUD DETECTED!'
      end;

   if vWhoami = 'FRAUD DETECTED!' then
      logger.log_error(
         vWhoami
         || ' <- vAPP_USER='
         || vAPP_USER
         || ', vOS_USER='
         || vOS_USER
         || ', vSESSION_USER='
         || vSESSION_USER,
         'FRAUD DETECTED!'
      );
      raise_application_error(-20000, 'Fraud detected!');
   end if;

   vWhoami := COALESCE(V('P0_WHOAMI'), vWhoami);

   return vWhoami;
end;
/
