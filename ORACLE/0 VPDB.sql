CREATE OR REPLACE PACKAGE MASOUD.VPDP_FILTERS_PACK AS
	FUNCTION FILTER_FUNC01(OBJECT_SCHEMA IN VARCHAR2,OBJECT_NAME VARCHAR2) RETURN VARCHAR2;
	FUNCTION FILTER_FUNC02(OBJECT_SCHEMA IN VARCHAR2,OBJECT_NAME VARCHAR2) RETURN VARCHAR2;
END VPDP_FILTERS_PACK;
----------------------------------------------------------------------------------------
CREATE OR REPLACE PACKAGE BODY MASOUD.VPDP_FILTERS_PACK AS
	FUNCTION FILTER_FUNC01(OBJECT_SCHEMA IN VARCHAR2,OBJECT_NAME VARCHAR2) 
		RETURN VARCHAR2
		IS
		BEGIN
			RETURN 'CUSTOMER_NO NOT IN (SELECT CUSTOMER_NO FROM MASOUD.HIDDEN_CUSTOMERS)';
	END FILTER_FUNC01;
	FUNCTION FILTER_FUNC02(OBJECT_SCHEMA IN VARCHAR2,OBJECT_NAME VARCHAR2) 
		RETURN VARCHAR2
		IS
		BEGIN
			RETURN 'DEPOSIT_NO NOT IN (SELECT DEPOSIT_NO FROM MASOUD.HIDDEN_DEPOSITS)';
	END FILTER_FUNC02;
END VPDP_FILTERS_PACK;
---------------------------------------------------------------------------------------- 
EXEC DBMS_RLS.ADD_POLICY(OBJECT_SCHEMA=>'DATA_SCHEMA',OBJECT_NAME=>'CUSTOMERS',POLICY_NAME=>'VPDP_FILTERS 1',FUNCTION_SCHEMA=>'MASOUD',POLICY_FUNCTION=>'VPDP_FILTERS_PACK.FILTER_FUNC1',STATEMENT_TYPES=>'SELECT',POLICY_TYPE=>DBMS_RLS.STATIC);
EXEC DBMS_RLS.ADD_POLICY(OBJECT_SCHEMA=>'DATA_SCHEMA',OBJECT_NAME=>'DEPOSITS' ,POLICY_NAME=>'VPDP_FILTERS 2',FUNCTION_SCHEMA=>'MASOUD',POLICY_FUNCTION=>'VPDP_FILTERS_PACK.FILTER_FUNC2',STATEMENT_TYPES=>'SELECT',POLICY_TYPE=>DBMS_RLS.STATIC);