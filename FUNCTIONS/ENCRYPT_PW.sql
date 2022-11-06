 CREATE OR REPLACE FUNCTION ENCRYPT_PASSWORD
    (
    p_password  in varchar2)
return varchar2
    is
    l_password varchar2(2000);
    l_key  varchar2(300) := 'THEBEST_SOLUTION_HAS_TO_BE_EASY_KUROKERO';
    l_mod NUMBER        :=   DBMS_CRYPTO.ENCRYPT_AES128
                            + DBMS_CRYPTO.CHAIN_CBC
                            + DBMS_CRYPTO.PAD_PKCS5;
    l_enc        RAW (2000);
BEGIN
   l_password := DBMS_CRYPTO.encrypt (UTL_I18N.string_to_raw (p_password, 'AL32UTF8'),
                                       l_mod,
                                       UTL_I18N.string_to_raw (l_key, 'AL32UTF8'));

    return l_password;
end ENCRYPT_PASSWORD;
/