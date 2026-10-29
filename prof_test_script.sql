SET LONG 1000000
SET LONGCHUNKSIZE 1000000
SET PAGESIZE 50000
SET LINESIZE 32767
SET SERVEROUTPUT ON

VARIABLE oCode     NUMBER
VARIABLE oMessage  VARCHAR2(4000)
VARIABLE oJsonResp CLOB

PROMPT
PROMPT ======================================================================
PROMPT TEST 1: PROF.S.CHECK_LOGIN_CREDENTIALS (hardcoded)   (2 input params)
PROMPT ======================================================================

DECLARE
    l_reqObj CLOB;
BEGIN
    XYZ_REQUEST_HANDLER.isSendHardCodedResponse := 1;
    l_reqObj := '{
        "JHeader": {
            "ActionCode": "PROF.S.CHECK_LOGIN_CREDENTIALS",
            "APILogin": "xyzapp@xyz.com",
            "APIPassword": "12345",
            "RequestedURL": "http://domain.com/XYZAPI/ProcessRequest"
        },
        "JMetaData": {},
        "JData": {
            "p_LOGIN_ID": "j.lee@xyzcar.com",
            "p_PASSWORD": "<<J.LEE_PASSWORD>>"
        }
    }';
    XYZ_REQUEST_HANDLER.Actions(
        'PROF.S.CHECK_LOGIN_CREDENTIALS', 101, 'PROFILE', '127.0.0.0',
        l_reqObj, '',
        :oCode, :oMessage, :oJsonResp
    );
END;
/

COMMIT;

PRINT oCode
PRINT oMessage
PRINT oJsonResp

PROMPT
PROMPT ======================================================================
PROMPT TEST 1: PROF.S.CHECK_LOGIN_CREDENTIALS (dynamic)   (2 input params)
PROMPT ======================================================================

DECLARE
    l_reqObj CLOB;
BEGIN
    XYZ_REQUEST_HANDLER.isSendHardCodedResponse := 0;
    l_reqObj := '{
        "JHeader": {
            "ActionCode": "PROF.S.CHECK_LOGIN_CREDENTIALS",
            "APILogin": "xyzapp@xyz.com",
            "APIPassword": "12345",
            "RequestedURL": "http://domain.com/XYZAPI/ProcessRequest"
        },
        "JMetaData": {},
        "JData": {
            "p_LOGIN_ID": "j.lee@xyzcar.com",
            "p_PASSWORD": "<<J.LEE_PASSWORD>>"
        }
    }';
    XYZ_REQUEST_HANDLER.Actions(
        'PROF.S.CHECK_LOGIN_CREDENTIALS', 101, 'PROFILE', '127.0.0.0',
        l_reqObj, '',
        :oCode, :oMessage, :oJsonResp
    );
END;
/

COMMIT;

PRINT oCode
PRINT oMessage
PRINT oJsonResp

PROMPT
PROMPT ======================================================================
PROMPT TEST 2: PROF.S.IS_UNIQUE_EMAIL (hardcoded)   (1 input param)
PROMPT ======================================================================

DECLARE
    l_reqObj CLOB;
BEGIN
    XYZ_REQUEST_HANDLER.isSendHardCodedResponse := 1;
    l_reqObj := '{
        "JHeader": {
            "ActionCode": "PROF.S.IS_UNIQUE_EMAIL",
            "APILogin": "xyzapp@xyz.com",
            "APIPassword": "12345",
            "RequestedURL": "http://domain.com/XYZAPI/ProcessRequest"
        },
        "JMetaData": {},
        "JData": {
            "p_LOGIN_ID": "j.lee@xyzcar.com"
        }
    }';
    XYZ_REQUEST_HANDLER.Actions(
        'PROF.S.IS_UNIQUE_EMAIL', 101, 'PROFILE', '127.0.0.0',
        l_reqObj, '',
        :oCode, :oMessage, :oJsonResp
    );
END;
/

COMMIT;

PRINT oCode
PRINT oMessage
PRINT oJsonResp

PROMPT
PROMPT ======================================================================
PROMPT TEST 2: PROF.S.IS_UNIQUE_EMAIL (dynamic)   (1 input param)
PROMPT ======================================================================

-- Existing login, so expect o_code 1 'Duplicate'. Use an unused email to get 0.
DECLARE
    l_reqObj CLOB;
BEGIN
    XYZ_REQUEST_HANDLER.isSendHardCodedResponse := 0;
    l_reqObj := '{
        "JHeader": {
            "ActionCode": "PROF.S.IS_UNIQUE_EMAIL",
            "APILogin": "xyzapp@xyz.com",
            "APIPassword": "12345",
            "RequestedURL": "http://domain.com/XYZAPI/ProcessRequest"
        },
        "JMetaData": {},
        "JData": {
            "p_LOGIN_ID": "j.lee@xyzcar.com"
        }
    }';
    XYZ_REQUEST_HANDLER.Actions(
        'PROF.S.IS_UNIQUE_EMAIL', 101, 'PROFILE', '127.0.0.0',
        l_reqObj, '',
        :oCode, :oMessage, :oJsonResp
    );
END;
/

COMMIT;

PRINT oCode
PRINT oMessage
PRINT oJsonResp

PROMPT
PROMPT ======================================================================
PROMPT TEST 3: PROF.S.IS_VALID_COMPANY_NAME (hardcoded)   (2 input params)
PROMPT ======================================================================

DECLARE
    l_reqObj CLOB;
BEGIN
    XYZ_REQUEST_HANDLER.isSendHardCodedResponse := 1;
    l_reqObj := '{
        "JHeader": {
            "ActionCode": "PROF.S.IS_VALID_COMPANY_NAME",
            "APILogin": "xyzapp@xyz.com",
            "APIPassword": "12345",
            "RequestedURL": "http://domain.com/XYZAPI/ProcessRequest"
        },
        "JMetaData": {},
        "JData": {
            "p_ACCOUNT_NUM": "99005",
            "p_COMPANY_NAME": "XYZ99005"
        }
    }';
    XYZ_REQUEST_HANDLER.Actions(
        'PROF.S.IS_VALID_COMPANY_NAME', 101, 'PROFILE', '127.0.0.0',
        l_reqObj, '',
        :oCode, :oMessage, :oJsonResp
    );
END;
/

COMMIT;

PRINT oCode
PRINT oMessage
PRINT oJsonResp

PROMPT
PROMPT ======================================================================
PROMPT TEST 3: PROF.S.IS_VALID_COMPANY_NAME (dynamic)   (2 input params)
PROMPT ======================================================================

-- XYZ99005 is the magic key in IsValidCompanyName, so this passes for any real account.
DECLARE
    l_reqObj CLOB;
BEGIN
    XYZ_REQUEST_HANDLER.isSendHardCodedResponse := 0;
    l_reqObj := '{
        "JHeader": {
            "ActionCode": "PROF.S.IS_VALID_COMPANY_NAME",
            "APILogin": "xyzapp@xyz.com",
            "APIPassword": "12345",
            "RequestedURL": "http://domain.com/XYZAPI/ProcessRequest"
        },
        "JMetaData": {},
        "JData": {
            "p_ACCOUNT_NUM": "99005",
            "p_COMPANY_NAME": "XYZ99005"
        }
    }';
    XYZ_REQUEST_HANDLER.Actions(
        'PROF.S.IS_VALID_COMPANY_NAME', 101, 'PROFILE', '127.0.0.0',
        l_reqObj, '',
        :oCode, :oMessage, :oJsonResp
    );
END;
/

COMMIT;

PRINT oCode
PRINT oMessage
PRINT oJsonResp

PROMPT
PROMPT ======================================================================
PROMPT TEST 4: PROF.S.PASSWORD (hardcoded)   (1 input param)
PROMPT ======================================================================

DECLARE
    l_reqObj CLOB;
BEGIN
    XYZ_REQUEST_HANDLER.isSendHardCodedResponse := 1;
    l_reqObj := '{
        "JHeader": {
            "ActionCode": "PROF.S.PASSWORD",
            "APILogin": "xyzapp@xyz.com",
            "APIPassword": "12345",
            "RequestedURL": "http://domain.com/XYZAPI/ProcessRequest"
        },
        "JMetaData": {},
        "JData": {
            "p_LOGIN_ID": "j.lee@xyzcar.com"
        }
    }';
    XYZ_REQUEST_HANDLER.Actions(
        'PROF.S.PASSWORD', 101, 'PROFILE', '127.0.0.0',
        l_reqObj, '',
        :oCode, :oMessage, :oJsonResp
    );
END;
/

COMMIT;

PRINT oCode
PRINT oMessage
PRINT oJsonResp

PROMPT
PROMPT ======================================================================
PROMPT TEST 4: PROF.S.PASSWORD (dynamic)   (1 input param)
PROMPT ======================================================================

-- Inserts a password email into optima.emailer, so the dynamic run is rolled back.
DECLARE
    l_reqObj CLOB;
BEGIN
    XYZ_REQUEST_HANDLER.isSendHardCodedResponse := 0;
    l_reqObj := '{
        "JHeader": {
            "ActionCode": "PROF.S.PASSWORD",
            "APILogin": "xyzapp@xyz.com",
            "APIPassword": "12345",
            "RequestedURL": "http://domain.com/XYZAPI/ProcessRequest"
        },
        "JMetaData": {},
        "JData": {
            "p_LOGIN_ID": "j.lee@xyzcar.com"
        }
    }';
    XYZ_REQUEST_HANDLER.Actions(
        'PROF.S.PASSWORD', 101, 'PROFILE', '127.0.0.0',
        l_reqObj, '',
        :oCode, :oMessage, :oJsonResp
    );
END;
/

-- Rolled back so the test leaves the data as it was
ROLLBACK;

PRINT oCode
PRINT oMessage
PRINT oJsonResp

PROMPT
PROMPT ======================================================================
PROMPT TEST 5: PROF.U.PASSWORD (hardcoded)   (3 input params)
PROMPT ======================================================================

DECLARE
    l_reqObj CLOB;
BEGIN
    XYZ_REQUEST_HANDLER.isSendHardCodedResponse := 1;
    l_reqObj := '{
        "JHeader": {
            "ActionCode": "PROF.U.PASSWORD",
            "APILogin": "xyzapp@xyz.com",
            "APIPassword": "12345",
            "RequestedURL": "http://domain.com/XYZAPI/ProcessRequest"
        },
        "JMetaData": {},
        "JData": {
            "p_LOGIN_ID": "j.lee@xyzcar.com",
            "p_OLD_PASSWORD": "<<J.LEE_PASSWORD>>",
            "p_NEW_PASSWORD": "<<J.LEE_PASSWORD>>"
        }
    }';
    XYZ_REQUEST_HANDLER.Actions(
        'PROF.U.PASSWORD', 101, 'PROFILE', '127.0.0.0',
        l_reqObj, '',
        :oCode, :oMessage, :oJsonResp
    );
END;
/

COMMIT;

PRINT oCode
PRINT oMessage
PRINT oJsonResp

PROMPT
PROMPT ======================================================================
PROMPT TEST 5: PROF.U.PASSWORD (dynamic)   (3 input params)
PROMPT ======================================================================

-- New password = old password and rolled back, so j.lee's login is not changed.
DECLARE
    l_reqObj CLOB;
BEGIN
    XYZ_REQUEST_HANDLER.isSendHardCodedResponse := 0;
    l_reqObj := '{
        "JHeader": {
            "ActionCode": "PROF.U.PASSWORD",
            "APILogin": "xyzapp@xyz.com",
            "APIPassword": "12345",
            "RequestedURL": "http://domain.com/XYZAPI/ProcessRequest"
        },
        "JMetaData": {},
        "JData": {
            "p_LOGIN_ID": "j.lee@xyzcar.com",
            "p_OLD_PASSWORD": "12456",
            "p_NEW_PASSWORD": "112233"
        }
    }';
    XYZ_REQUEST_HANDLER.Actions(
        'PROF.U.PASSWORD', 101, 'PROFILE', '127.0.0.0',
        l_reqObj, '',
        :oCode, :oMessage, :oJsonResp
    );
END;
/

-- Rolled back so the test leaves the data as it was
ROLLBACK;

PRINT oCode
PRINT oMessage
PRINT oJsonResp

PROMPT
PROMPT ======================================================================
PROMPT TEST 6: PROF.I.PROFILE (hardcoded)   (41 input params)
PROMPT ======================================================================

DECLARE
    l_reqObj CLOB;
BEGIN
    XYZ_REQUEST_HANDLER.isSendHardCodedResponse := 1;
    l_reqObj := '{
        "JHeader": {
            "ActionCode": "PROF.I.PROFILE",
            "APILogin": "xyzapp@xyz.com",
            "APIPassword": "12345",
            "RequestedURL": "http://domain.com/XYZAPI/ProcessRequest"
        },
        "JMetaData": {},
        "JData": {
            "p_LOGIN_ID": "r.patel.qa1029@xyzcar.com",
            "p_PASSWORD": "Ride2026!",
            "p_CONFIRM_PASSWORD": "Ride2026!",
            "p_FIRST_NAME": "Ravi",
            "p_LAST_NAME": "Patel",
            "p_PHONE_NUMBER": "",
            "p_PHONE_EXT": "",
            "p_PHONE_NUMBER_US": "2125550147",
            "p_PHONE_EXT_US": "12",
            "p_FAX": "",
            "p_COUNTRY": "01",
            "p_STATE": "NY",
            "p_CITY": "New York",
            "p_ZIP": "10019",
            "p_BUILDING_NUM": "245",
            "p_STREET_NAME": "W 52ND ST",
            "p_CROSS_STREET1": "BROADWAY",
            "p_CROSS_STREET2": "8TH AVE",
            "p_ADDRESS_PHONE": "",
            "p_ADDRESS_PHONE_US": "2125550147",
            "p_ADDRESS_TYPE": "HOME",
            "p_PAYMENT_TYPE": "1",
            "p_ACCOUNT_NUM": "99005",
            "p_VIP_NUM": "",
            "p_CC_TYPE": "",
            "p_CARD_HOLDER_NAME": "",
            "p_CARD_NUMBER": "",
            "p_VERIFY_CODE": "",
            "p_CC_MONTH": "",
            "p_CC_YEAR": "",
            "p_ACCOUNT_REQ1": "",
            "p_ACCOUNT_REQ2": "",
            "p_ACCOUNT_REQ3": "",
            "p_ACCOUNT_REQ4": "",
            "p_CONFIRMATION_METHOD": "ML",
            "p_PREFERRED_FLEET": "",
            "p_CAR_YEAR": "90",
            "p_CAR_PHONE": "N",
            "p_SPECIAL_OFFER": "N",
            "p_SMOKING_CAR": "N",
            "p_IVR_PIN": ""
        }
    }';
    XYZ_REQUEST_HANDLER.Actions(
        'PROF.I.PROFILE', 101, 'PROFILE', '127.0.0.0',
        l_reqObj, '',
        :oCode, :oMessage, :oJsonResp
    );
END;
/

COMMIT;

PRINT oCode
PRINT oMessage
PRINT oJsonResp

PROMPT
PROMPT ======================================================================
PROMPT TEST 6: PROF.I.PROFILE (dynamic)   (41 input params)
PROMPT ======================================================================

-- Creates a new VIP profile on account 99005; rolled back. p_LOGIN_ID must not exist yet.
DECLARE
    l_reqObj CLOB;
BEGIN
    XYZ_REQUEST_HANDLER.isSendHardCodedResponse := 0;
    l_reqObj := '{
        "JHeader": {
            "ActionCode": "PROF.I.PROFILE",
            "APILogin": "xyzapp@xyz.com",
            "APIPassword": "12345",
            "RequestedURL": "http://domain.com/XYZAPI/ProcessRequest"
        },
        "JMetaData": {},
        "JData": {
            "p_LOGIN_ID": "r.patel.qa1029@xyzcar.com",
            "p_PASSWORD": "Ride2026!",
            "p_CONFIRM_PASSWORD": "Ride2026!",
            "p_FIRST_NAME": "Ravi",
            "p_LAST_NAME": "Patel",
            "p_PHONE_NUMBER": "",
            "p_PHONE_EXT": "",
            "p_PHONE_NUMBER_US": "2125550147",
            "p_PHONE_EXT_US": "12",
            "p_FAX": "",
            "p_COUNTRY": "01",
            "p_STATE": "NY",
            "p_CITY": "New York",
            "p_ZIP": "10019",
            "p_BUILDING_NUM": "245",
            "p_STREET_NAME": "W 52ND ST",
            "p_CROSS_STREET1": "BROADWAY",
            "p_CROSS_STREET2": "8TH AVE",
            "p_ADDRESS_PHONE": "",
            "p_ADDRESS_PHONE_US": "2125550147",
            "p_ADDRESS_TYPE": "HOME",
            "p_PAYMENT_TYPE": "1",
            "p_ACCOUNT_NUM": "99005",
            "p_VIP_NUM": "",
            "p_CC_TYPE": "",
            "p_CARD_HOLDER_NAME": "",
            "p_CARD_NUMBER": "",
            "p_VERIFY_CODE": "",
            "p_CC_MONTH": "",
            "p_CC_YEAR": "",
            "p_ACCOUNT_REQ1": "",
            "p_ACCOUNT_REQ2": "",
            "p_ACCOUNT_REQ3": "",
            "p_ACCOUNT_REQ4": "",
            "p_CONFIRMATION_METHOD": "ML",
            "p_PREFERRED_FLEET": "",
            "p_CAR_YEAR": "90",
            "p_CAR_PHONE": "N",
            "p_SPECIAL_OFFER": "N",
            "p_SMOKING_CAR": "N",
            "p_IVR_PIN": ""
        }
    }';
    XYZ_REQUEST_HANDLER.Actions(
        'PROF.I.PROFILE', 101, 'PROFILE', '127.0.0.0',
        l_reqObj, '',
        :oCode, :oMessage, :oJsonResp
    );
END;
/

-- Rolled back so the test leaves the data as it was
ROLLBACK;

PRINT oCode
PRINT oMessage
PRINT oJsonResp

PROMPT
PROMPT ======================================================================
PROMPT TEST 7: PROF.U.PROFILE (hardcoded)   (38 input params)
PROMPT ======================================================================

DECLARE
    l_reqObj CLOB;
BEGIN
    XYZ_REQUEST_HANDLER.isSendHardCodedResponse := 1;
    l_reqObj := '{
        "JHeader": {
            "ActionCode": "PROF.U.PROFILE",
            "APILogin": "xyzapp@xyz.com",
            "APIPassword": "12345",
            "RequestedURL": "http://domain.com/XYZAPI/ProcessRequest"
        },
        "JMetaData": {},
        "JData": {
            "p_LOGIN_ID": "j.lee@xyzcar.com",
            "p_PASSWORD": "<<J.LEE_PASSWORD>>",
            "p_FIRST_NAME": "Jordan",
            "p_LAST_NAME": "Lee",
            "p_PHONE_NUMBER": "",
            "p_PHONE_EXT": "",
            "p_PHONE_NUMBER_US": "2125550134",
            "p_PHONE_EXT_US": "12",
            "p_FAX": "",
            "p_COUNTRY": "01",
            "p_STATE": "NY",
            "p_CITY": "New York",
            "p_ZIP": "10019",
            "p_BUILDING_NUM": "245",
            "p_STREET_NAME": "W 52ND ST",
            "p_CROSS_STREET1": "BROADWAY",
            "p_CROSS_STREET2": "8TH AVE",
            "p_ADDRESS_PHONE": "",
            "p_ADDRESS_PHONE_US": "2125550134",
            "p_ADDRESS_TYPE": "HOME",
            "p_PAYMENT_TYPE": "1",
            "p_CC_TYPE": "",
            "p_CARD_HOLDER_NAME": "",
            "p_CARD_NUMBER": "",
            "p_VERIFY_CODE": "",
            "p_CC_MONTH": "12",
            "p_CC_YEAR": "28",
            "p_ACCOUNT_REQ1": "",
            "p_ACCOUNT_REQ2": "",
            "p_ACCOUNT_REQ3": "",
            "p_ACCOUNT_REQ4": "",
            "p_CONFIRMATION_METHOD": "ML",
            "p_PREFERRED_FLEET": "",
            "p_CAR_YEAR": "90",
            "p_CAR_PHONE": "N",
            "p_SPECIAL_OFFER": "N",
            "p_SMOKING_CAR": "N",
            "p_IVR_PIN": ""
        }
    }';
    XYZ_REQUEST_HANDLER.Actions(
        'PROF.U.PROFILE', 101, 'PROFILE', '127.0.0.0',
        l_reqObj, '',
        :oCode, :oMessage, :oJsonResp
    );
END;
/

COMMIT;

PRINT oCode
PRINT oMessage
PRINT oJsonResp

PROMPT
PROMPT ======================================================================
PROMPT TEST 7: PROF.U.PROFILE (dynamic)   (38 input params)
PROMPT ======================================================================

-- Overwrites j.lee's profile (password included), so it is rolled back. p_PASSWORD must be j.lee's real password.
DECLARE
    l_reqObj CLOB;
BEGIN
    XYZ_REQUEST_HANDLER.isSendHardCodedResponse := 0;
    l_reqObj := '{
        "JHeader": {
            "ActionCode": "PROF.U.PROFILE",
            "APILogin": "xyzapp@xyz.com",
            "APIPassword": "12345",
            "RequestedURL": "http://domain.com/XYZAPI/ProcessRequest"
        },
        "JMetaData": {},
        "JData": {
            "p_LOGIN_ID": "j.lee@xyzcar.com",
            "p_PASSWORD": "99005",
            "p_FIRST_NAME": "Jordan",
            "p_LAST_NAME": "Lee",
            "p_PHONE_NUMBER": "",
            "p_PHONE_EXT": "",
            "p_PHONE_NUMBER_US": "2125550134",
            "p_PHONE_EXT_US": "12",
            "p_FAX": "",
            "p_COUNTRY": "01",
            "p_STATE": "NY",
            "p_CITY": "New York",
            "p_ZIP": "10019",
            "p_BUILDING_NUM": "245",
            "p_STREET_NAME": "W 52ND ST",
            "p_CROSS_STREET1": "BROADWAY",
            "p_CROSS_STREET2": "8TH AVE",
            "p_ADDRESS_PHONE": "",
            "p_ADDRESS_PHONE_US": "2125550134",
            "p_ADDRESS_TYPE": "HOME",
            "p_PAYMENT_TYPE": "1",
            "p_CC_TYPE": "",
            "p_CARD_HOLDER_NAME": "",
            "p_CARD_NUMBER": "",
            "p_VERIFY_CODE": "",
            "p_CC_MONTH": "12",
            "p_CC_YEAR": "28",
            "p_ACCOUNT_REQ1": "",
            "p_ACCOUNT_REQ2": "",
            "p_ACCOUNT_REQ3": "",
            "p_ACCOUNT_REQ4": "",
            "p_CONFIRMATION_METHOD": "",
            "p_PREFERRED_FLEET": "",
            "p_CAR_YEAR": "90",
            "p_CAR_PHONE": "N",
            "p_SPECIAL_OFFER": "N",
            "p_SMOKING_CAR": "N",
            "p_IVR_PIN": ""
        }
    }';
    XYZ_REQUEST_HANDLER.Actions(
        'PROF.U.PROFILE', 101, 'PROFILE', '127.0.0.0',
        l_reqObj, '',
        :oCode, :oMessage, :oJsonResp
    );
END;
/

-- Rolled back so the test leaves the data as it was
ROLLBACK;

PRINT oCode
PRINT oMessage
PRINT oJsonResp

PROMPT
PROMPT ======================================================================
PROMPT TEST 8: PROF.S.LOAD_PROFILE (hardcoded)   (1 input param)
PROMPT ======================================================================

DECLARE
    l_reqObj CLOB;
BEGIN
    XYZ_REQUEST_HANDLER.isSendHardCodedResponse := 1;
    l_reqObj := '{
        "JHeader": {
            "ActionCode": "PROF.S.LOAD_PROFILE",
            "APILogin": "xyzapp@xyz.com",
            "APIPassword": "12345",
            "RequestedURL": "http://domain.com/XYZAPI/ProcessRequest"
        },
        "JMetaData": {},
        "JData": {
            "p_LOGIN_ID": "j.lee@xyzcar.com"
        }
    }';
    XYZ_REQUEST_HANDLER.Actions(
        'PROF.S.LOAD_PROFILE', 101, 'PROFILE', '127.0.0.0',
        l_reqObj, '',
        :oCode, :oMessage, :oJsonResp
    );
END;
/

COMMIT;

PRINT oCode
PRINT oMessage
PRINT oJsonResp

PROMPT
PROMPT ======================================================================
PROMPT TEST 8: PROF.S.LOAD_PROFILE (dynamic)   (1 input param)
PROMPT ======================================================================

DECLARE
    l_reqObj CLOB;
BEGIN
    XYZ_REQUEST_HANDLER.isSendHardCodedResponse := 0;
    l_reqObj := '{
        "JHeader": {
            "ActionCode": "PROF.S.LOAD_PROFILE",
            "APILogin": "xyzapp@xyz.com",
            "APIPassword": "12345",
            "RequestedURL": "http://domain.com/XYZAPI/ProcessRequest"
        },
        "JMetaData": {},
        "JData": {
            "p_LOGIN_ID": "j.lee@xyzcar.com"
        }
    }';
    XYZ_REQUEST_HANDLER.Actions(
        'PROF.S.LOAD_PROFILE', 101, 'PROFILE', '127.0.0.0',
        l_reqObj, '',
        :oCode, :oMessage, :oJsonResp
    );
END;
/

COMMIT;

PRINT oCode
PRINT oMessage
PRINT oJsonResp

PROMPT
PROMPT ======================================================================
PROMPT TEST 9: PROF.S.ACCOUNT_REQUIREMENTS (hardcoded)   (1 input param)
PROMPT ======================================================================

DECLARE
    l_reqObj CLOB;
BEGIN
    XYZ_REQUEST_HANDLER.isSendHardCodedResponse := 1;
    l_reqObj := '{
        "JHeader": {
            "ActionCode": "PROF.S.ACCOUNT_REQUIREMENTS",
            "APILogin": "xyzapp@xyz.com",
            "APIPassword": "12345",
            "RequestedURL": "http://domain.com/XYZAPI/ProcessRequest"
        },
        "JMetaData": {},
        "JData": {
            "p_ACCOUNT_NUM": "99005"
        }
    }';
    XYZ_REQUEST_HANDLER.Actions(
        'PROF.S.ACCOUNT_REQUIREMENTS', 101, 'PROFILE', '127.0.0.0',
        l_reqObj, '',
        :oCode, :oMessage, :oJsonResp
    );
END;
/

COMMIT;

PRINT oCode
PRINT oMessage
PRINT oJsonResp

PROMPT
PROMPT ======================================================================
PROMPT TEST 9: PROF.S.ACCOUNT_REQUIREMENTS (dynamic)   (1 input param)
PROMPT ======================================================================

DECLARE
    l_reqObj CLOB;
BEGIN
    XYZ_REQUEST_HANDLER.isSendHardCodedResponse := 0;
    l_reqObj := '{
        "JHeader": {
            "ActionCode": "PROF.S.ACCOUNT_REQUIREMENTS",
            "APILogin": "xyzapp@xyz.com",
            "APIPassword": "12345",
            "RequestedURL": "http://domain.com/XYZAPI/ProcessRequest"
        },
        "JMetaData": {},
        "JData": {
            "p_ACCOUNT_NUM": "99005"
        }
    }';
    XYZ_REQUEST_HANDLER.Actions(
        'PROF.S.ACCOUNT_REQUIREMENTS', 101, 'PROFILE', '127.0.0.0',
        l_reqObj, '',
        :oCode, :oMessage, :oJsonResp
    );
END;
/

COMMIT;

PRINT oCode
PRINT oMessage
PRINT oJsonResp

PROMPT
PROMPT ======================================================================
PROMPT TEST 10: PROF.S.ACCOUNT_REQUIREMENTS_RS (hardcoded)   (1 input param)
PROMPT ======================================================================

DECLARE
    l_reqObj CLOB;
BEGIN
    XYZ_REQUEST_HANDLER.isSendHardCodedResponse := 1;
    l_reqObj := '{
        "JHeader": {
            "ActionCode": "PROF.S.ACCOUNT_REQUIREMENTS_RS",
            "APILogin": "xyzapp@xyz.com",
            "APIPassword": "12345",
            "RequestedURL": "http://domain.com/XYZAPI/ProcessRequest"
        },
        "JMetaData": {},
        "JData": {
            "p_ACCOUNT_NUM": "99005"
        }
    }';
    XYZ_REQUEST_HANDLER.Actions(
        'PROF.S.ACCOUNT_REQUIREMENTS_RS', 101, 'PROFILE', '127.0.0.0',
        l_reqObj, '',
        :oCode, :oMessage, :oJsonResp
    );
END;
/

COMMIT;

PRINT oCode
PRINT oMessage
PRINT oJsonResp

PROMPT
PROMPT ======================================================================
PROMPT TEST 10: PROF.S.ACCOUNT_REQUIREMENTS_RS (dynamic)   (1 input param)
PROMPT ======================================================================

DECLARE
    l_reqObj CLOB;
BEGIN
    XYZ_REQUEST_HANDLER.isSendHardCodedResponse := 0;
    l_reqObj := '{
        "JHeader": {
            "ActionCode": "PROF.S.ACCOUNT_REQUIREMENTS_RS",
            "APILogin": "xyzapp@xyz.com",
            "APIPassword": "12345",
            "RequestedURL": "http://domain.com/XYZAPI/ProcessRequest"
        },
        "JMetaData": {},
        "JData": {
            "p_ACCOUNT_NUM": "99005"
        }
    }';
    XYZ_REQUEST_HANDLER.Actions(
        'PROF.S.ACCOUNT_REQUIREMENTS_RS', 101, 'PROFILE', '127.0.0.0',
        l_reqObj, '',
        :oCode, :oMessage, :oJsonResp
    );
END;
/

COMMIT;

PRINT oCode
PRINT oMessage
PRINT oJsonResp

PROMPT
PROMPT ======================================================================
PROMPT TEST 11: PROF.S.USER_ADDRESSES (hardcoded)   (1 input param)
PROMPT ======================================================================

DECLARE
    l_reqObj CLOB;
BEGIN
    XYZ_REQUEST_HANDLER.isSendHardCodedResponse := 1;
    l_reqObj := '{
        "JHeader": {
            "ActionCode": "PROF.S.USER_ADDRESSES",
            "APILogin": "xyzapp@xyz.com",
            "APIPassword": "12345",
            "RequestedURL": "http://domain.com/XYZAPI/ProcessRequest"
        },
        "JMetaData": {},
        "JData": {
            "p_LOGIN_ID": "j.lee@xyzcar.com"
        }
    }';
    XYZ_REQUEST_HANDLER.Actions(
        'PROF.S.USER_ADDRESSES', 101, 'PROFILE', '127.0.0.0',
        l_reqObj, '',
        :oCode, :oMessage, :oJsonResp
    );
END;
/

COMMIT;

PRINT oCode
PRINT oMessage
PRINT oJsonResp

PROMPT
PROMPT ======================================================================
PROMPT TEST 11: PROF.S.USER_ADDRESSES (dynamic)   (1 input param)
PROMPT ======================================================================

DECLARE
    l_reqObj CLOB;
BEGIN
    XYZ_REQUEST_HANDLER.isSendHardCodedResponse := 0;
    l_reqObj := '{
        "JHeader": {
            "ActionCode": "PROF.S.USER_ADDRESSES",
            "APILogin": "xyzapp@xyz.com",
            "APIPassword": "12345",
            "RequestedURL": "http://domain.com/XYZAPI/ProcessRequest"
        },
        "JMetaData": {},
        "JData": {
            "p_LOGIN_ID": "j.lee@xyzcar.com"
        }
    }';
    XYZ_REQUEST_HANDLER.Actions(
        'PROF.S.USER_ADDRESSES', 101, 'PROFILE', '127.0.0.0',
        l_reqObj, '',
        :oCode, :oMessage, :oJsonResp
    );
END;
/

COMMIT;

PRINT oCode
PRINT oMessage
PRINT oJsonResp

PROMPT
PROMPT ======================================================================
PROMPT TEST 12: PROF.I.USER_ADDRESS (hardcoded)   (14 input params)
PROMPT ======================================================================

DECLARE
    l_reqObj CLOB;
BEGIN
    XYZ_REQUEST_HANDLER.isSendHardCodedResponse := 1;
    l_reqObj := '{
        "JHeader": {
            "ActionCode": "PROF.I.USER_ADDRESS",
            "APILogin": "xyzapp@xyz.com",
            "APIPassword": "12345",
            "RequestedURL": "http://domain.com/XYZAPI/ProcessRequest"
        },
        "JMetaData": {},
        "JData": {
            "p_LOGIN_ID": "j.lee@xyzcar.com",
            "p_COUNTRY": "01",
            "p_STATE": "NY",
            "p_CITY": "New York",
            "p_STREET_NUM": "245",
            "p_STREET_NAME": "W 52ND ST",
            "p_CROSS_STREET": "BROADWAY",
            "p_PICKUP_POINT": "MAIN ENTRANCE",
            "p_ZIP": "10019",
            "p_DIRECTIONS": "LOBBY",
            "p_PHONE_NUM": "",
            "p_EXT": "",
            "p_PHONE_NUM_US": "2125550147",
            "p_EXT_US": "12"
        }
    }';
    XYZ_REQUEST_HANDLER.Actions(
        'PROF.I.USER_ADDRESS', 101, 'PROFILE', '127.0.0.0',
        l_reqObj, '',
        :oCode, :oMessage, :oJsonResp
    );
END;
/

COMMIT;

PRINT oCode
PRINT oMessage
PRINT oJsonResp

PROMPT
PROMPT ======================================================================
PROMPT TEST 12: PROF.I.USER_ADDRESS (dynamic)   (14 input params)
PROMPT ======================================================================

-- Adds 245 W 52ND ST to j.lee's saved addresses. Tests 13 and 14 update and then delete it.
DECLARE
    l_reqObj CLOB;
BEGIN
    XYZ_REQUEST_HANDLER.isSendHardCodedResponse := 0;
    l_reqObj := '{
        "JHeader": {
            "ActionCode": "PROF.I.USER_ADDRESS",
            "APILogin": "xyzapp@xyz.com",
            "APIPassword": "12345",
            "RequestedURL": "http://domain.com/XYZAPI/ProcessRequest"
        },
        "JMetaData": {},
        "JData": {
            "p_LOGIN_ID": "j.lee@xyzcar.com",
            "p_COUNTRY": "01",
            "p_STATE": "NY",
            "p_CITY": "New York",
            "p_STREET_NUM": "245",
            "p_STREET_NAME": "W 52ND ST",
            "p_CROSS_STREET": "BROADWAY",
            "p_PICKUP_POINT": "MAIN ENTRANCE",
            "p_ZIP": "10019",
            "p_DIRECTIONS": "LOBBY",
            "p_PHONE_NUM": "",
            "p_EXT": "",
            "p_PHONE_NUM_US": "2125550147",
            "p_EXT_US": "12"
        }
    }';
    XYZ_REQUEST_HANDLER.Actions(
        'PROF.I.USER_ADDRESS', 101, 'PROFILE', '127.0.0.0',
        l_reqObj, '',
        :oCode, :oMessage, :oJsonResp
    );
END;
/

COMMIT;

PRINT oCode
PRINT oMessage
PRINT oJsonResp

PROMPT
PROMPT ======================================================================
PROMPT TEST 13: PROF.U.USER_ADDRESS (hardcoded)   (15 input params)
PROMPT ======================================================================

DECLARE
    l_reqObj CLOB;
BEGIN
    XYZ_REQUEST_HANDLER.isSendHardCodedResponse := 1;
    l_reqObj := '{
        "JHeader": {
            "ActionCode": "PROF.U.USER_ADDRESS",
            "APILogin": "xyzapp@xyz.com",
            "APIPassword": "12345",
            "RequestedURL": "http://domain.com/XYZAPI/ProcessRequest"
        },
        "JMetaData": {},
        "JData": {
            "p_LOGIN_ID": "j.lee@xyzcar.com",
            "p_PICKUP_COUNT": "1",
            "p_COUNTRY": "01",
            "p_STATE": "NY",
            "p_CITY": "New York",
            "p_STREET_NUM": "245",
            "p_STREET_NAME": "W 52ND ST",
            "p_CROSS_STREET": "8TH AVE",
            "p_PICKUP_POINT": "MAIN ENTRANCE",
            "p_ZIP": "10019",
            "p_DIRECTIONS": "SIDE DOOR",
            "p_PHONE_NUM": "",
            "p_EXT": "",
            "p_PHONE_NUM_US": "2125550147",
            "p_EXT_US": "12"
        }
    }';
    XYZ_REQUEST_HANDLER.Actions(
        'PROF.U.USER_ADDRESS', 101, 'PROFILE', '127.0.0.0',
        l_reqObj, '',
        :oCode, :oMessage, :oJsonResp
    );
END;
/

COMMIT;

PRINT oCode
PRINT oMessage
PRINT oJsonResp

PROMPT
PROMPT ======================================================================
PROMPT TEST 13: PROF.U.USER_ADDRESS (dynamic)   (15 input params)
PROMPT ======================================================================

-- Dynamic run looks up the pickup count of the address added in test 12.
DECLARE
    l_reqObj CLOB;
    l_pickupCount VARCHAR2(10);
BEGIN
    -- Pickup count of the address added by the PROF.I.USER_ADDRESS test
    SELECT  TO_CHAR(MAX(vp.pickup_count))
    INTO    l_pickupCount
    FROM    optima.vip_pickup  vp,
            optima.vip_profile p
    WHERE   p.login_id     = UPPER('j.lee@xyzcar.com')
    AND     (p.end_date IS NULL OR p.end_date > SYSDATE)
    AND     vp.account_num = p.account_num
    AND     vp.vip_num     = p.vip_num
    AND     vp.street_num  = '245'
    AND     vp.street_name = 'W 52ND ST';

    XYZ_REQUEST_HANDLER.isSendHardCodedResponse := 0;
    l_reqObj := '{
        "JHeader": {
            "ActionCode": "PROF.U.USER_ADDRESS",
            "APILogin": "xyzapp@xyz.com",
            "APIPassword": "12345",
            "RequestedURL": "http://domain.com/XYZAPI/ProcessRequest"
        },
        "JMetaData": {},
        "JData": {
            "p_LOGIN_ID": "j.lee@xyzcar.com",
            "p_PICKUP_COUNT": "' || l_pickupCount || '",
            "p_COUNTRY": "01",
            "p_STATE": "NY",
            "p_CITY": "New York",
            "p_STREET_NUM": "245",
            "p_STREET_NAME": "W 52ND ST",
            "p_CROSS_STREET": "8TH AVE",
            "p_PICKUP_POINT": "MAIN ENTRANCE",
            "p_ZIP": "10019",
            "p_DIRECTIONS": "SIDE DOOR",
            "p_PHONE_NUM": "",
            "p_EXT": "",
            "p_PHONE_NUM_US": "2125550147",
            "p_EXT_US": "12"
        }
    }';
    XYZ_REQUEST_HANDLER.Actions(
        'PROF.U.USER_ADDRESS', 101, 'PROFILE', '127.0.0.0',
        l_reqObj, '',
        :oCode, :oMessage, :oJsonResp
    );
END;
/

COMMIT;

PRINT oCode
PRINT oMessage
PRINT oJsonResp

PROMPT
PROMPT ======================================================================
PROMPT TEST 14: PROF.D.USER_ADDRESS (hardcoded)   (2 input params)
PROMPT ======================================================================

DECLARE
    l_reqObj CLOB;
BEGIN
    XYZ_REQUEST_HANDLER.isSendHardCodedResponse := 1;
    l_reqObj := '{
        "JHeader": {
            "ActionCode": "PROF.D.USER_ADDRESS",
            "APILogin": "xyzapp@xyz.com",
            "APIPassword": "12345",
            "RequestedURL": "http://domain.com/XYZAPI/ProcessRequest"
        },
        "JMetaData": {},
        "JData": {
            "p_LOGIN_ID": "j.lee@xyzcar.com",
            "p_PICKUP_COUNT": "1"
        }
    }';
    XYZ_REQUEST_HANDLER.Actions(
        'PROF.D.USER_ADDRESS', 101, 'PROFILE', '127.0.0.0',
        l_reqObj, '',
        :oCode, :oMessage, :oJsonResp
    );
END;
/

COMMIT;

PRINT oCode
PRINT oMessage
PRINT oJsonResp

PROMPT
PROMPT ======================================================================
PROMPT TEST 14: PROF.D.USER_ADDRESS (dynamic)   (2 input params)
PROMPT ======================================================================

-- Dynamic run deletes the address added in test 12.
DECLARE
    l_reqObj CLOB;
    l_pickupCount VARCHAR2(10);
BEGIN
    -- Pickup count of the address added by the PROF.I.USER_ADDRESS test
    SELECT  TO_CHAR(MAX(vp.pickup_count))
    INTO    l_pickupCount
    FROM    optima.vip_pickup  vp,
            optima.vip_profile p
    WHERE   p.login_id     = UPPER('j.lee@xyzcar.com')
    AND     (p.end_date IS NULL OR p.end_date > SYSDATE)
    AND     vp.account_num = p.account_num
    AND     vp.vip_num     = p.vip_num
    AND     vp.street_num  = '245'
    AND     vp.street_name = 'W 52ND ST';

    XYZ_REQUEST_HANDLER.isSendHardCodedResponse := 0;
    l_reqObj := '{
        "JHeader": {
            "ActionCode": "PROF.D.USER_ADDRESS",
            "APILogin": "xyzapp@xyz.com",
            "APIPassword": "12345",
            "RequestedURL": "http://domain.com/XYZAPI/ProcessRequest"
        },
        "JMetaData": {},
        "JData": {
            "p_LOGIN_ID": "j.lee@xyzcar.com",
            "p_PICKUP_COUNT": "' || l_pickupCount || '"
        }
    }';
    XYZ_REQUEST_HANDLER.Actions(
        'PROF.D.USER_ADDRESS', 101, 'PROFILE', '127.0.0.0',
        l_reqObj, '',
        :oCode, :oMessage, :oJsonResp
    );
END;
/

COMMIT;

PRINT oCode
PRINT oMessage
PRINT oJsonResp

PROMPT
PROMPT ======================================================================
PROMPT TEST 15: PROF.S.IS_VALID_VIP (hardcoded)   (2 input params)
PROMPT ======================================================================

DECLARE
    l_reqObj CLOB;
BEGIN
    XYZ_REQUEST_HANDLER.isSendHardCodedResponse := 1;
    l_reqObj := '{
        "JHeader": {
            "ActionCode": "PROF.S.IS_VALID_VIP",
            "APILogin": "xyzapp@xyz.com",
            "APIPassword": "12345",
            "RequestedURL": "http://domain.com/XYZAPI/ProcessRequest"
        },
        "JMetaData": {},
        "JData": {
            "p_ACCOUNT_NUM": "99005",
            "p_VIP_NUM": "<<J.LEE_VIP_NUM>>"
        }
    }';
    XYZ_REQUEST_HANDLER.Actions(
        'PROF.S.IS_VALID_VIP', 101, 'PROFILE', '127.0.0.0',
        l_reqObj, '',
        :oCode, :oMessage, :oJsonResp
    );
END;
/

COMMIT;

PRINT oCode
PRINT oMessage
PRINT oJsonResp

PROMPT
PROMPT ======================================================================
PROMPT TEST 15: PROF.S.IS_VALID_VIP (dynamic)   (2 input params)
PROMPT ======================================================================

-- Needs j.lee's VIP number. Test 16 (PROF.S.ACCOUNT_VIP_NUM) returns it.
DECLARE
    l_reqObj CLOB;
BEGIN
    XYZ_REQUEST_HANDLER.isSendHardCodedResponse := 0;
    l_reqObj := '{
        "JHeader": {
            "ActionCode": "PROF.S.IS_VALID_VIP",
            "APILogin": "xyzapp@xyz.com",
            "APIPassword": "12345",
            "RequestedURL": "http://domain.com/XYZAPI/ProcessRequest"
        },
        "JMetaData": {},
        "JData": {
            "p_ACCOUNT_NUM": "99005",
            "p_VIP_NUM": "9990000001"
        }
    }';
    XYZ_REQUEST_HANDLER.Actions(
        'PROF.S.IS_VALID_VIP', 101, 'PROFILE', '127.0.0.0',
        l_reqObj, '',
        :oCode, :oMessage, :oJsonResp
    );
END;
/

COMMIT;

PRINT oCode
PRINT oMessage
PRINT oJsonResp

PROMPT
PROMPT ======================================================================
PROMPT TEST 16: PROF.S.ACCOUNT_VIP_NUM (hardcoded)   (1 input param)
PROMPT ======================================================================

DECLARE
    l_reqObj CLOB;
BEGIN
    XYZ_REQUEST_HANDLER.isSendHardCodedResponse := 1;
    l_reqObj := '{
        "JHeader": {
            "ActionCode": "PROF.S.ACCOUNT_VIP_NUM",
            "APILogin": "xyzapp@xyz.com",
            "APIPassword": "12345",
            "RequestedURL": "http://domain.com/XYZAPI/ProcessRequest"
        },
        "JMetaData": {},
        "JData": {
            "p_LOGIN_ID": "j.lee@xyzcar.com"
        }
    }';
    XYZ_REQUEST_HANDLER.Actions(
        'PROF.S.ACCOUNT_VIP_NUM', 101, 'PROFILE', '127.0.0.0',
        l_reqObj, '',
        :oCode, :oMessage, :oJsonResp
    );
END;
/

COMMIT;

PRINT oCode
PRINT oMessage
PRINT oJsonResp

PROMPT
PROMPT ======================================================================
PROMPT TEST 16: PROF.S.ACCOUNT_VIP_NUM (dynamic)   (1 input param)
PROMPT ======================================================================

DECLARE
    l_reqObj CLOB;
BEGIN
    XYZ_REQUEST_HANDLER.isSendHardCodedResponse := 0;
    l_reqObj := '{
        "JHeader": {
            "ActionCode": "PROF.S.ACCOUNT_VIP_NUM",
            "APILogin": "xyzapp@xyz.com",
            "APIPassword": "12345",
            "RequestedURL": "http://domain.com/XYZAPI/ProcessRequest"
        },
        "JMetaData": {},
        "JData": {
            "p_LOGIN_ID": "j.lee@xyzcar.com"
        }
    }';
    XYZ_REQUEST_HANDLER.Actions(
        'PROF.S.ACCOUNT_VIP_NUM', 101, 'PROFILE', '127.0.0.0',
        l_reqObj, '',
        :oCode, :oMessage, :oJsonResp
    );
END;
/

COMMIT;

PRINT oCode
PRINT oMessage
PRINT oJsonResp

PROMPT
PROMPT ======================================================================
PROMPT TEST 17: PROF.S.BLOCKED_DRIVERS (hardcoded)   (1 input param)
PROMPT ======================================================================

DECLARE
    l_reqObj CLOB;
BEGIN
    XYZ_REQUEST_HANDLER.isSendHardCodedResponse := 1;
    l_reqObj := '{
        "JHeader": {
            "ActionCode": "PROF.S.BLOCKED_DRIVERS",
            "APILogin": "xyzapp@xyz.com",
            "APIPassword": "12345",
            "RequestedURL": "http://domain.com/XYZAPI/ProcessRequest"
        },
        "JMetaData": {},
        "JData": {
            "p_LOGIN_ID": "j.lee@xyzcar.com"
        }
    }';
    XYZ_REQUEST_HANDLER.Actions(
        'PROF.S.BLOCKED_DRIVERS', 101, 'PROFILE', '127.0.0.0',
        l_reqObj, '',
        :oCode, :oMessage, :oJsonResp
    );
END;
/

COMMIT;

PRINT oCode
PRINT oMessage
PRINT oJsonResp

PROMPT
PROMPT ======================================================================
PROMPT TEST 17: PROF.S.BLOCKED_DRIVERS (dynamic)   (1 input param)
PROMPT ======================================================================

-- Marked NOT implemented in WS_PROFILE.
DECLARE
    l_reqObj CLOB;
BEGIN
    XYZ_REQUEST_HANDLER.isSendHardCodedResponse := 0;
    l_reqObj := '{
        "JHeader": {
            "ActionCode": "PROF.S.BLOCKED_DRIVERS",
            "APILogin": "xyzapp@xyz.com",
            "APIPassword": "12345",
            "RequestedURL": "http://domain.com/XYZAPI/ProcessRequest"
        },
        "JMetaData": {},
        "JData": {
            "p_LOGIN_ID": "j.lee@xyzcar.com"
        }
    }';
    XYZ_REQUEST_HANDLER.Actions(
        'PROF.S.BLOCKED_DRIVERS', 101, 'PROFILE', '127.0.0.0',
        l_reqObj, '',
        :oCode, :oMessage, :oJsonResp
    );
END;
/

COMMIT;

PRINT oCode
PRINT oMessage
PRINT oJsonResp

PROMPT
PROMPT ======================================================================
PROMPT TEST 18: PROF.S.CAR_INFO (hardcoded)   (1 input param)
PROMPT ======================================================================

DECLARE
    l_reqObj CLOB;
BEGIN
    XYZ_REQUEST_HANDLER.isSendHardCodedResponse := 1;
    l_reqObj := '{
        "JHeader": {
            "ActionCode": "PROF.S.CAR_INFO",
            "APILogin": "xyzapp@xyz.com",
            "APIPassword": "12345",
            "RequestedURL": "http://domain.com/XYZAPI/ProcessRequest"
        },
        "JMetaData": {},
        "JData": {
            "p_CAR_NUM": "412"
        }
    }';
    XYZ_REQUEST_HANDLER.Actions(
        'PROF.S.CAR_INFO', 101, 'PROFILE', '127.0.0.0',
        l_reqObj, '',
        :oCode, :oMessage, :oJsonResp
    );
END;
/

COMMIT;

PRINT oCode
PRINT oMessage
PRINT oJsonResp

PROMPT
PROMPT ======================================================================
PROMPT TEST 18: PROF.S.CAR_INFO (dynamic)   (1 input param)
PROMPT ======================================================================

-- Car 412 is the car used in the reservation script.
DECLARE
    l_reqObj CLOB;
BEGIN
    XYZ_REQUEST_HANDLER.isSendHardCodedResponse := 0;
    l_reqObj := '{
        "JHeader": {
            "ActionCode": "PROF.S.CAR_INFO",
            "APILogin": "xyzapp@xyz.com",
            "APIPassword": "12345",
            "RequestedURL": "http://domain.com/XYZAPI/ProcessRequest"
        },
        "JMetaData": {},
        "JData": {
            "p_CAR_NUM": "412"
        }
    }';
    XYZ_REQUEST_HANDLER.Actions(
        'PROF.S.CAR_INFO', 101, 'PROFILE', '127.0.0.0',
        l_reqObj, '',
        :oCode, :oMessage, :oJsonResp
    );
END;
/

COMMIT;

PRINT oCode
PRINT oMessage
PRINT oJsonResp

PROMPT
PROMPT ======================================================================
PROMPT TEST 19: PROF.I.BLOCKED_DRIVER (hardcoded)   (2 input params)
PROMPT ======================================================================

DECLARE
    l_reqObj CLOB;
BEGIN
    XYZ_REQUEST_HANDLER.isSendHardCodedResponse := 1;
    l_reqObj := '{
        "JHeader": {
            "ActionCode": "PROF.I.BLOCKED_DRIVER",
            "APILogin": "xyzapp@xyz.com",
            "APIPassword": "12345",
            "RequestedURL": "http://domain.com/XYZAPI/ProcessRequest"
        },
        "JMetaData": {},
        "JData": {
            "p_LOGIN_ID": "j.lee@xyzcar.com",
            "p_CAR_NUM": "412"
        }
    }';
    XYZ_REQUEST_HANDLER.Actions(
        'PROF.I.BLOCKED_DRIVER', 101, 'PROFILE', '127.0.0.0',
        l_reqObj, '',
        :oCode, :oMessage, :oJsonResp
    );
END;
/

COMMIT;

PRINT oCode
PRINT oMessage
PRINT oJsonResp

PROMPT
PROMPT ======================================================================
PROMPT TEST 19: PROF.I.BLOCKED_DRIVER (dynamic)   (2 input params)
PROMPT ======================================================================

-- Insert is commented out in WS_PROFILE (ToDo), so no row is written.
DECLARE
    l_reqObj CLOB;
BEGIN
    XYZ_REQUEST_HANDLER.isSendHardCodedResponse := 0;
    l_reqObj := '{
        "JHeader": {
            "ActionCode": "PROF.I.BLOCKED_DRIVER",
            "APILogin": "xyzapp@xyz.com",
            "APIPassword": "12345",
            "RequestedURL": "http://domain.com/XYZAPI/ProcessRequest"
        },
        "JMetaData": {},
        "JData": {
            "p_LOGIN_ID": "j.lee@xyzcar.com",
            "p_CAR_NUM": "412"
        }
    }';
    XYZ_REQUEST_HANDLER.Actions(
        'PROF.I.BLOCKED_DRIVER', 101, 'PROFILE', '127.0.0.0',
        l_reqObj, '',
        :oCode, :oMessage, :oJsonResp
    );
END;
/

COMMIT;

PRINT oCode
PRINT oMessage
PRINT oJsonResp

PROMPT
PROMPT ======================================================================
PROMPT TEST 20: PROF.D.BLOCKED_DRIVER (hardcoded)   (2 input params)
PROMPT ======================================================================

DECLARE
    l_reqObj CLOB;
BEGIN
    XYZ_REQUEST_HANDLER.isSendHardCodedResponse := 1;
    l_reqObj := '{
        "JHeader": {
            "ActionCode": "PROF.D.BLOCKED_DRIVER",
            "APILogin": "xyzapp@xyz.com",
            "APIPassword": "12345",
            "RequestedURL": "http://domain.com/XYZAPI/ProcessRequest"
        },
        "JMetaData": {},
        "JData": {
            "p_LOGIN_ID": "j.lee@xyzcar.com",
            "p_CAR_NUM": "412"
        }
    }';
    XYZ_REQUEST_HANDLER.Actions(
        'PROF.D.BLOCKED_DRIVER', 101, 'PROFILE', '127.0.0.0',
        l_reqObj, '',
        :oCode, :oMessage, :oJsonResp
    );
END;
/

COMMIT;

PRINT oCode
PRINT oMessage
PRINT oJsonResp

PROMPT
PROMPT ======================================================================
PROMPT TEST 20: PROF.D.BLOCKED_DRIVER (dynamic)   (2 input params)
PROMPT ======================================================================

-- Delete is commented out in WS_PROFILE (ToDo), so no row is removed.
DECLARE
    l_reqObj CLOB;
BEGIN
    XYZ_REQUEST_HANDLER.isSendHardCodedResponse := 0;
    l_reqObj := '{
        "JHeader": {
            "ActionCode": "PROF.D.BLOCKED_DRIVER",
            "APILogin": "xyzapp@xyz.com",
            "APIPassword": "12345",
            "RequestedURL": "http://domain.com/XYZAPI/ProcessRequest"
        },
        "JMetaData": {},
        "JData": {
            "p_LOGIN_ID": "j.lee@xyzcar.com",
            "p_CAR_NUM": "412"
        }
    }';
    XYZ_REQUEST_HANDLER.Actions(
        'PROF.D.BLOCKED_DRIVER', 101, 'PROFILE', '127.0.0.0',
        l_reqObj, '',
        :oCode, :oMessage, :oJsonResp
    );
END;
/

COMMIT;

PRINT oCode
PRINT oMessage
PRINT oJsonResp

PROMPT
PROMPT ======================================================================
PROMPT TEST 21: PROF.I.ACCESS_RIGHTS (hardcoded)   (4 input params)
PROMPT ======================================================================

DECLARE
    l_reqObj CLOB;
BEGIN
    XYZ_REQUEST_HANDLER.isSendHardCodedResponse := 1;
    l_reqObj := '{
        "JHeader": {
            "ActionCode": "PROF.I.ACCESS_RIGHTS",
            "APILogin": "xyzapp@xyz.com",
            "APIPassword": "12345",
            "RequestedURL": "http://domain.com/XYZAPI/ProcessRequest"
        },
        "JMetaData": {},
        "JData": {
            "p_LOGIN_ID_FROM": "j.lee@xyzcar.com",
            "p_LOGIN_ID_TO": "m.chen@xyzcar.com",
            "p_PHONE": "2125550147",
            "p_EXTENSION": "12"
        }
    }';
    XYZ_REQUEST_HANDLER.Actions(
        'PROF.I.ACCESS_RIGHTS', 101, 'PROFILE', '127.0.0.0',
        l_reqObj, '',
        :oCode, :oMessage, :oJsonResp
    );
END;
/

COMMIT;

PRINT oCode
PRINT oMessage
PRINT oJsonResp

PROMPT
PROMPT ======================================================================
PROMPT TEST 21: PROF.I.ACCESS_RIGHTS (dynamic)   (4 input params)
PROMPT ======================================================================

-- Dynamic run picks another active login on j.lee's account. Test 22 revokes the grant again.
DECLARE
    l_reqObj CLOB;
    l_loginTo     VARCHAR2(100);
BEGIN
    -- Another active login on the same account as j.lee (access rights only work inside one account)
    SELECT  MIN(p2.login_id)
    INTO    l_loginTo
    FROM    optima.vip_profile p1,
            optima.vip_profile p2
    WHERE   p1.login_id    = UPPER('j.lee@xyzcar.com')
    AND     (p1.end_date IS NULL OR p1.end_date > SYSDATE)
    AND     p2.account_num = p1.account_num
    AND     p2.vip_num    <> p1.vip_num
    AND     p2.login_id IS NOT NULL
    AND     (p2.end_date IS NULL OR p2.end_date > SYSDATE);

    XYZ_REQUEST_HANDLER.isSendHardCodedResponse := 0;
    l_reqObj := '{
        "JHeader": {
            "ActionCode": "PROF.I.ACCESS_RIGHTS",
            "APILogin": "xyzapp@xyz.com",
            "APIPassword": "12345",
            "RequestedURL": "http://domain.com/XYZAPI/ProcessRequest"
        },
        "JMetaData": {},
        "JData": {
            "p_LOGIN_ID_FROM": "j.lee@xyzcar.com",
            "p_LOGIN_ID_TO": "' || l_loginTo || '",
            "p_PHONE": "2125550147",
            "p_EXTENSION": "12"
        }
    }';
    XYZ_REQUEST_HANDLER.Actions(
        'PROF.I.ACCESS_RIGHTS', 101, 'PROFILE', '127.0.0.0',
        l_reqObj, '',
        :oCode, :oMessage, :oJsonResp
    );
END;
/

COMMIT;

PRINT oCode
PRINT oMessage
PRINT oJsonResp

PROMPT
PROMPT ======================================================================
PROMPT TEST 22: PROF.D.ACCESS_RIGHTS (hardcoded)   (4 input params)
PROMPT ======================================================================

DECLARE
    l_reqObj CLOB;
BEGIN
    XYZ_REQUEST_HANDLER.isSendHardCodedResponse := 1;
    l_reqObj := '{
        "JHeader": {
            "ActionCode": "PROF.D.ACCESS_RIGHTS",
            "APILogin": "xyzapp@xyz.com",
            "APIPassword": "12345",
            "RequestedURL": "http://domain.com/XYZAPI/ProcessRequest"
        },
        "JMetaData": {},
        "JData": {
            "p_LOGIN_ID_FROM": "j.lee@xyzcar.com",
            "p_LOGIN_ID_TO": "m.chen@xyzcar.com",
            "p_PHONE": "2125550147",
            "p_EXTENSION": "12"
        }
    }';
    XYZ_REQUEST_HANDLER.Actions(
        'PROF.D.ACCESS_RIGHTS', 101, 'PROFILE', '127.0.0.0',
        l_reqObj, '',
        :oCode, :oMessage, :oJsonResp
    );
END;
/

COMMIT;

PRINT oCode
PRINT oMessage
PRINT oJsonResp

PROMPT
PROMPT ======================================================================
PROMPT TEST 22: PROF.D.ACCESS_RIGHTS (dynamic)   (4 input params)
PROMPT ======================================================================

-- Revokes the grant made in test 21.
DECLARE
    l_reqObj CLOB;
    l_loginTo     VARCHAR2(100);
BEGIN
    -- Another active login on the same account as j.lee (access rights only work inside one account)
    SELECT  MIN(p2.login_id)
    INTO    l_loginTo
    FROM    optima.vip_profile p1,
            optima.vip_profile p2
    WHERE   p1.login_id    = UPPER('j.lee@xyzcar.com')
    AND     (p1.end_date IS NULL OR p1.end_date > SYSDATE)
    AND     p2.account_num = p1.account_num
    AND     p2.vip_num    <> p1.vip_num
    AND     p2.login_id IS NOT NULL
    AND     (p2.end_date IS NULL OR p2.end_date > SYSDATE);

    XYZ_REQUEST_HANDLER.isSendHardCodedResponse := 0;
    l_reqObj := '{
        "JHeader": {
            "ActionCode": "PROF.D.ACCESS_RIGHTS",
            "APILogin": "xyzapp@xyz.com",
            "APIPassword": "12345",
            "RequestedURL": "http://domain.com/XYZAPI/ProcessRequest"
        },
        "JMetaData": {},
        "JData": {
            "p_LOGIN_ID_FROM": "j.lee@xyzcar.com",
            "p_LOGIN_ID_TO": "' || l_loginTo || '",
            "p_PHONE": "2125550147",
            "p_EXTENSION": "12"
        }
    }';
    XYZ_REQUEST_HANDLER.Actions(
        'PROF.D.ACCESS_RIGHTS', 101, 'PROFILE', '127.0.0.0',
        l_reqObj, '',
        :oCode, :oMessage, :oJsonResp
    );
END;
/

COMMIT;

PRINT oCode
PRINT oMessage
PRINT oJsonResp

PROMPT
PROMPT ======================================================================
PROMPT TEST 23: PROF.S.MATCHING_PROFILE_LIST (hardcoded)   (5 input params)
PROMPT ======================================================================

DECLARE
    l_reqObj CLOB;
BEGIN
    XYZ_REQUEST_HANDLER.isSendHardCodedResponse := 1;
    l_reqObj := '{
        "JHeader": {
            "ActionCode": "PROF.S.MATCHING_PROFILE_LIST",
            "APILogin": "xyzapp@xyz.com",
            "APIPassword": "12345",
            "RequestedURL": "http://domain.com/XYZAPI/ProcessRequest"
        },
        "JMetaData": {},
        "JData": {
            "p_LOGIN_ID": "j.lee@xyzcar.com",
            "p_FIRST_NAME": "",
            "p_LAST_NAME": "Lee",
            "p_PHONE": "",
            "p_PHONE_EXTENSION": ""
        }
    }';
    XYZ_REQUEST_HANDLER.Actions(
        'PROF.S.MATCHING_PROFILE_LIST', 101, 'PROFILE', '127.0.0.0',
        l_reqObj, '',
        :oCode, :oMessage, :oJsonResp
    );
END;
/

COMMIT;

PRINT oCode
PRINT oMessage
PRINT oJsonResp

PROMPT
PROMPT ======================================================================
PROMPT TEST 23: PROF.S.MATCHING_PROFILE_LIST (dynamic)   (5 input params)
PROMPT ======================================================================

DECLARE
    l_reqObj CLOB;
BEGIN
    XYZ_REQUEST_HANDLER.isSendHardCodedResponse := 0;
    l_reqObj := '{
        "JHeader": {
            "ActionCode": "PROF.S.MATCHING_PROFILE_LIST",
            "APILogin": "xyzapp@xyz.com",
            "APIPassword": "12345",
            "RequestedURL": "http://domain.com/XYZAPI/ProcessRequest"
        },
        "JMetaData": {},
        "JData": {
            "p_LOGIN_ID": "j.lee@xyzcar.com",
            "p_FIRST_NAME": "Jennifer",
            "p_LAST_NAME": "Lee",
            "p_PHONE": "",
            "p_PHONE_EXTENSION": ""
        }
    }';
    XYZ_REQUEST_HANDLER.Actions(
        'PROF.S.MATCHING_PROFILE_LIST', 101, 'PROFILE', '127.0.0.0',
        l_reqObj, '',
        :oCode, :oMessage, :oJsonResp
    );
END;
/

COMMIT;

PRINT oCode
PRINT oMessage
PRINT oJsonResp

PROMPT
PROMPT ======================================================================
PROMPT TEST 24: PROF.S.GRANT_ACCESS_RIGHTS_TO_ALL (hardcoded)   (1 input param)
PROMPT ======================================================================

DECLARE
    l_reqObj CLOB;
BEGIN
    XYZ_REQUEST_HANDLER.isSendHardCodedResponse := 1;
    l_reqObj := '{
        "JHeader": {
            "ActionCode": "PROF.S.GRANT_ACCESS_RIGHTS_TO_ALL",
            "APILogin": "xyzapp@xyz.com",
            "APIPassword": "12345",
            "RequestedURL": "http://domain.com/XYZAPI/ProcessRequest"
        },
        "JMetaData": {},
        "JData": {
            "p_LOGIN_ID_FROM": "j.lee@xyzcar.com"
        }
    }';
    XYZ_REQUEST_HANDLER.Actions(
        'PROF.S.GRANT_ACCESS_RIGHTS_TO_ALL', 101, 'PROFILE', '127.0.0.0',
        l_reqObj, '',
        :oCode, :oMessage, :oJsonResp
    );
END;
/

COMMIT;

PRINT oCode
PRINT oMessage
PRINT oJsonResp

PROMPT
PROMPT ======================================================================
PROMPT TEST 24: PROF.S.GRANT_ACCESS_RIGHTS_TO_ALL (dynamic)   (1 input param)
PROMPT ======================================================================

DECLARE
    l_reqObj CLOB;
BEGIN
    XYZ_REQUEST_HANDLER.isSendHardCodedResponse := 0;
    l_reqObj := '{
        "JHeader": {
            "ActionCode": "PROF.S.GRANT_ACCESS_RIGHTS_TO_ALL",
            "APILogin": "xyzapp@xyz.com",
            "APIPassword": "12345",
            "RequestedURL": "http://domain.com/XYZAPI/ProcessRequest"
        },
        "JMetaData": {},
        "JData": {
            "p_LOGIN_ID_FROM": "j.lee@xyzcar.com"
        }
    }';
    XYZ_REQUEST_HANDLER.Actions(
        'PROF.S.GRANT_ACCESS_RIGHTS_TO_ALL', 101, 'PROFILE', '127.0.0.0',
        l_reqObj, '',
        :oCode, :oMessage, :oJsonResp
    );
END;
/

COMMIT;

PRINT oCode
PRINT oMessage
PRINT oJsonResp

PROMPT
PROMPT ======================================================================
PROMPT TEST 25: PROF.U.GRANT_ACCESS_RIGHTS_TO_ALL (hardcoded)   (1 input param)
PROMPT ======================================================================

DECLARE
    l_reqObj CLOB;
BEGIN
    XYZ_REQUEST_HANDLER.isSendHardCodedResponse := 1;
    l_reqObj := '{
        "JHeader": {
            "ActionCode": "PROF.U.GRANT_ACCESS_RIGHTS_TO_ALL",
            "APILogin": "xyzapp@xyz.com",
            "APIPassword": "12345",
            "RequestedURL": "http://domain.com/XYZAPI/ProcessRequest"
        },
        "JMetaData": {},
        "JData": {
            "p_LOGIN_ID_FROM": "j.lee@xyzcar.com"
        }
    }';
    XYZ_REQUEST_HANDLER.Actions(
        'PROF.U.GRANT_ACCESS_RIGHTS_TO_ALL', 101, 'PROFILE', '127.0.0.0',
        l_reqObj, '',
        :oCode, :oMessage, :oJsonResp
    );
END;
/

COMMIT;

PRINT oCode
PRINT oMessage
PRINT oJsonResp

PROMPT
PROMPT ======================================================================
PROMPT TEST 25: PROF.U.GRANT_ACCESS_RIGHTS_TO_ALL (dynamic)   (1 input param)
PROMPT ======================================================================

-- Deletes j.lee's individual grants and sets grant-to-all = 1, so it is rolled back.
DECLARE
    l_reqObj CLOB;
BEGIN
    XYZ_REQUEST_HANDLER.isSendHardCodedResponse := 0;
    l_reqObj := '{
        "JHeader": {
            "ActionCode": "PROF.U.GRANT_ACCESS_RIGHTS_TO_ALL",
            "APILogin": "xyzapp@xyz.com",
            "APIPassword": "12345",
            "RequestedURL": "http://domain.com/XYZAPI/ProcessRequest"
        },
        "JMetaData": {},
        "JData": {
            "p_LOGIN_ID_FROM": "j.lee@xyzcar.com"
        }
    }';
    XYZ_REQUEST_HANDLER.Actions(
        'PROF.U.GRANT_ACCESS_RIGHTS_TO_ALL', 101, 'PROFILE', '127.0.0.0',
        l_reqObj, '',
        :oCode, :oMessage, :oJsonResp
    );
END;
/

-- Rolled back so the test leaves the data as it was
ROLLBACK;

PRINT oCode
PRINT oMessage
PRINT oJsonResp

PROMPT
PROMPT ======================================================================
PROMPT TEST 26: PROF.U.REVOKE_ACCESS_RIGHTS_TO_ALL (hardcoded)   (1 input param)
PROMPT ======================================================================

DECLARE
    l_reqObj CLOB;
BEGIN
    XYZ_REQUEST_HANDLER.isSendHardCodedResponse := 1;
    l_reqObj := '{
        "JHeader": {
            "ActionCode": "PROF.U.REVOKE_ACCESS_RIGHTS_TO_ALL",
            "APILogin": "xyzapp@xyz.com",
            "APIPassword": "12345",
            "RequestedURL": "http://domain.com/XYZAPI/ProcessRequest"
        },
        "JMetaData": {},
        "JData": {
            "p_LOGIN_ID_FROM": "j.lee@xyzcar.com"
        }
    }';
    XYZ_REQUEST_HANDLER.Actions(
        'PROF.U.REVOKE_ACCESS_RIGHTS_TO_ALL', 101, 'PROFILE', '127.0.0.0',
        l_reqObj, '',
        :oCode, :oMessage, :oJsonResp
    );
END;
/

COMMIT;

PRINT oCode
PRINT oMessage
PRINT oJsonResp

PROMPT
PROMPT ======================================================================
PROMPT TEST 26: PROF.U.REVOKE_ACCESS_RIGHTS_TO_ALL (dynamic)   (1 input param)
PROMPT ======================================================================

-- Deletes j.lee's individual grants and sets grant-to-all = 0, so it is rolled back.
DECLARE
    l_reqObj CLOB;
BEGIN
    XYZ_REQUEST_HANDLER.isSendHardCodedResponse := 0;
    l_reqObj := '{
        "JHeader": {
            "ActionCode": "PROF.U.REVOKE_ACCESS_RIGHTS_TO_ALL",
            "APILogin": "xyzapp@xyz.com",
            "APIPassword": "12345",
            "RequestedURL": "http://domain.com/XYZAPI/ProcessRequest"
        },
        "JMetaData": {},
        "JData": {
            "p_LOGIN_ID_FROM": "j.lee@xyzcar.com"
        }
    }';
    XYZ_REQUEST_HANDLER.Actions(
        'PROF.U.REVOKE_ACCESS_RIGHTS_TO_ALL', 101, 'PROFILE', '127.0.0.0',
        l_reqObj, '',
        :oCode, :oMessage, :oJsonResp
    );
END;
/

-- Rolled back so the test leaves the data as it was
ROLLBACK;

PRINT oCode
PRINT oMessage
PRINT oJsonResp

PROMPT
PROMPT ======================================================================
PROMPT TEST 27: PROF.S.ACCESS_RIGHTS_GRANTED_PROFILE (hardcoded)   (1 input param)
PROMPT ======================================================================

DECLARE
    l_reqObj CLOB;
BEGIN
    XYZ_REQUEST_HANDLER.isSendHardCodedResponse := 1;
    l_reqObj := '{
        "JHeader": {
            "ActionCode": "PROF.S.ACCESS_RIGHTS_GRANTED_PROFILE",
            "APILogin": "xyzapp@xyz.com",
            "APIPassword": "12345",
            "RequestedURL": "http://domain.com/XYZAPI/ProcessRequest"
        },
        "JMetaData": {},
        "JData": {
            "p_LOGIN_ID_FROM": "j.lee@xyzcar.com"
        }
    }';
    XYZ_REQUEST_HANDLER.Actions(
        'PROF.S.ACCESS_RIGHTS_GRANTED_PROFILE', 101, 'PROFILE', '127.0.0.0',
        l_reqObj, '',
        :oCode, :oMessage, :oJsonResp
    );
END;
/

COMMIT;

PRINT oCode
PRINT oMessage
PRINT oJsonResp

PROMPT
PROMPT ======================================================================
PROMPT TEST 27: PROF.S.ACCESS_RIGHTS_GRANTED_PROFILE (dynamic)   (1 input param)
PROMPT ======================================================================

DECLARE
    l_reqObj CLOB;
BEGIN
    XYZ_REQUEST_HANDLER.isSendHardCodedResponse := 0;
    l_reqObj := '{
        "JHeader": {
            "ActionCode": "PROF.S.ACCESS_RIGHTS_GRANTED_PROFILE",
            "APILogin": "xyzapp@xyz.com",
            "APIPassword": "12345",
            "RequestedURL": "http://domain.com/XYZAPI/ProcessRequest"
        },
        "JMetaData": {},
        "JData": {
            "p_LOGIN_ID_FROM": "j.lee@xyzcar.com"
        }
    }';
    XYZ_REQUEST_HANDLER.Actions(
        'PROF.S.ACCESS_RIGHTS_GRANTED_PROFILE', 101, 'PROFILE', '127.0.0.0',
        l_reqObj, '',
        :oCode, :oMessage, :oJsonResp
    );
END;
/

COMMIT;

PRINT oCode
PRINT oMessage
PRINT oJsonResp

PROMPT
PROMPT ======================================================================
PROMPT TEST 28: PROF.S.PROFILE_WHO_GRANTED_ACCESS (hardcoded)   (1 input param)
PROMPT ======================================================================

DECLARE
    l_reqObj CLOB;
BEGIN
    XYZ_REQUEST_HANDLER.isSendHardCodedResponse := 1;
    l_reqObj := '{
        "JHeader": {
            "ActionCode": "PROF.S.PROFILE_WHO_GRANTED_ACCESS",
            "APILogin": "xyzapp@xyz.com",
            "APIPassword": "12345",
            "RequestedURL": "http://domain.com/XYZAPI/ProcessRequest"
        },
        "JMetaData": {},
        "JData": {
            "p_LOGIN_ID_TO": "j.lee@xyzcar.com"
        }
    }';
    XYZ_REQUEST_HANDLER.Actions(
        'PROF.S.PROFILE_WHO_GRANTED_ACCESS', 101, 'PROFILE', '127.0.0.0',
        l_reqObj, '',
        :oCode, :oMessage, :oJsonResp
    );
END;
/

COMMIT;

PRINT oCode
PRINT oMessage
PRINT oJsonResp

PROMPT
PROMPT ======================================================================
PROMPT TEST 28: PROF.S.PROFILE_WHO_GRANTED_ACCESS (dynamic)   (1 input param)
PROMPT ======================================================================

DECLARE
    l_reqObj CLOB;
BEGIN
    XYZ_REQUEST_HANDLER.isSendHardCodedResponse := 0;
    l_reqObj := '{
        "JHeader": {
            "ActionCode": "PROF.S.PROFILE_WHO_GRANTED_ACCESS",
            "APILogin": "xyzapp@xyz.com",
            "APIPassword": "12345",
            "RequestedURL": "http://domain.com/XYZAPI/ProcessRequest"
        },
        "JMetaData": {},
        "JData": {
            "p_LOGIN_ID_TO": "j.lee@xyzcar.com"
        }
    }';
    XYZ_REQUEST_HANDLER.Actions(
        'PROF.S.PROFILE_WHO_GRANTED_ACCESS', 101, 'PROFILE', '127.0.0.0',
        l_reqObj, '',
        :oCode, :oMessage, :oJsonResp
    );
END;
/

COMMIT;

PRINT oCode
PRINT oMessage
PRINT oJsonResp

PROMPT
PROMPT ======================================================================
PROMPT TEST 29: PROF.S.PROFILE_COLUMN_VALUES (hardcoded)   (1 input param)
PROMPT ======================================================================

DECLARE
    l_reqObj CLOB;
BEGIN
    XYZ_REQUEST_HANDLER.isSendHardCodedResponse := 1;
    l_reqObj := '{
        "JHeader": {
            "ActionCode": "PROF.S.PROFILE_COLUMN_VALUES",
            "APILogin": "xyzapp@xyz.com",
            "APIPassword": "12345",
            "RequestedURL": "http://domain.com/XYZAPI/ProcessRequest"
        },
        "JMetaData": {},
        "JData": {
            "p_LOGIN_ID": "j.lee@xyzcar.com"
        }
    }';
    XYZ_REQUEST_HANDLER.Actions(
        'PROF.S.PROFILE_COLUMN_VALUES', 101, 'PROFILE', '127.0.0.0',
        l_reqObj, '',
        :oCode, :oMessage, :oJsonResp
    );
END;
/

COMMIT;

PRINT oCode
PRINT oMessage
PRINT oJsonResp

PROMPT
PROMPT ======================================================================
PROMPT TEST 29: PROF.S.PROFILE_COLUMN_VALUES (dynamic)   (1 input param)
PROMPT ======================================================================

DECLARE
    l_reqObj CLOB;
BEGIN
    XYZ_REQUEST_HANDLER.isSendHardCodedResponse := 0;
    l_reqObj := '{
        "JHeader": {
            "ActionCode": "PROF.S.PROFILE_COLUMN_VALUES",
            "APILogin": "xyzapp@xyz.com",
            "APIPassword": "12345",
            "RequestedURL": "http://domain.com/XYZAPI/ProcessRequest"
        },
        "JMetaData": {},
        "JData": {
            "p_LOGIN_ID": "j.lee@xyzcar.com"
        }
    }';
    XYZ_REQUEST_HANDLER.Actions(
        'PROF.S.PROFILE_COLUMN_VALUES', 101, 'PROFILE', '127.0.0.0',
        l_reqObj, '',
        :oCode, :oMessage, :oJsonResp
    );
END;
/

COMMIT;

PRINT oCode
PRINT oMessage
PRINT oJsonResp

PROMPT
PROMPT ======================================================================
PROMPT TEST 30: PROF.S.PROFILE_COLUMN_VALUES_BY_TYPE (hardcoded)   (2 input params)
PROMPT ======================================================================

DECLARE
    l_reqObj CLOB;
BEGIN
    XYZ_REQUEST_HANDLER.isSendHardCodedResponse := 1;
    l_reqObj := '{
        "JHeader": {
            "ActionCode": "PROF.S.PROFILE_COLUMN_VALUES_BY_TYPE",
            "APILogin": "xyzapp@xyz.com",
            "APIPassword": "12345",
            "RequestedURL": "http://domain.com/XYZAPI/ProcessRequest"
        },
        "JMetaData": {},
        "JData": {
            "p_LOGIN_ID": "j.lee@xyzcar.com",
            "p_COLUMN_ID": "6"
        }
    }';
    XYZ_REQUEST_HANDLER.Actions(
        'PROF.S.PROFILE_COLUMN_VALUES_BY_TYPE', 101, 'PROFILE', '127.0.0.0',
        l_reqObj, '',
        :oCode, :oMessage, :oJsonResp
    );
END;
/

COMMIT;

PRINT oCode
PRINT oMessage
PRINT oJsonResp

PROMPT
PROMPT ======================================================================
PROMPT TEST 30: PROF.S.PROFILE_COLUMN_VALUES_BY_TYPE (dynamic)   (2 input params)
PROMPT ======================================================================

-- Column 6 = cell phone (3 home, 4 office, 5 fax, 7 pager, 8 email).
DECLARE
    l_reqObj CLOB;
BEGIN
    XYZ_REQUEST_HANDLER.isSendHardCodedResponse := 0;
    l_reqObj := '{
        "JHeader": {
            "ActionCode": "PROF.S.PROFILE_COLUMN_VALUES_BY_TYPE",
            "APILogin": "xyzapp@xyz.com",
            "APIPassword": "12345",
            "RequestedURL": "http://domain.com/XYZAPI/ProcessRequest"
        },
        "JMetaData": {},
        "JData": {
            "p_LOGIN_ID": "j.lee@xyzcar.com",
            "p_COLUMN_ID": "6"
        }
    }';
    XYZ_REQUEST_HANDLER.Actions(
        'PROF.S.PROFILE_COLUMN_VALUES_BY_TYPE', 101, 'PROFILE', '127.0.0.0',
        l_reqObj, '',
        :oCode, :oMessage, :oJsonResp
    );
END;
/

COMMIT;

PRINT oCode
PRINT oMessage
PRINT oJsonResp

PROMPT
PROMPT ======================================================================
PROMPT TEST 31: PROF.I.PROFILE_COLUMN_VALUE (hardcoded)   (3 input params)
PROMPT ======================================================================

DECLARE
    l_reqObj CLOB;
BEGIN
    XYZ_REQUEST_HANDLER.isSendHardCodedResponse := 1;
    l_reqObj := '{
        "JHeader": {
            "ActionCode": "PROF.I.PROFILE_COLUMN_VALUE",
            "APILogin": "xyzapp@xyz.com",
            "APIPassword": "12345",
            "RequestedURL": "http://domain.com/XYZAPI/ProcessRequest"
        },
        "JMetaData": {},
        "JData": {
            "p_LOGIN_ID": "j.lee@xyzcar.com",
            "p_COLUMN_ID": "6",
            "p_COLUMN_VALUE": "2125550147-12"
        }
    }';
    XYZ_REQUEST_HANDLER.Actions(
        'PROF.I.PROFILE_COLUMN_VALUE', 101, 'PROFILE', '127.0.0.0',
        l_reqObj, '',
        :oCode, :oMessage, :oJsonResp
    );
END;
/

COMMIT;

PRINT oCode
PRINT oMessage
PRINT oJsonResp

PROMPT
PROMPT ======================================================================
PROMPT TEST 31: PROF.I.PROFILE_COLUMN_VALUE (dynamic)   (3 input params)
PROMPT ======================================================================

-- Adds a cell phone (phone-ext). Tests 32 and 33 update and then delete it.
DECLARE
    l_reqObj CLOB;
BEGIN
    XYZ_REQUEST_HANDLER.isSendHardCodedResponse := 0;
    l_reqObj := '{
        "JHeader": {
            "ActionCode": "PROF.I.PROFILE_COLUMN_VALUE",
            "APILogin": "xyzapp@xyz.com",
            "APIPassword": "12345",
            "RequestedURL": "http://domain.com/XYZAPI/ProcessRequest"
        },
        "JMetaData": {},
        "JData": {
            "p_LOGIN_ID": "j.lee@xyzcar.com",
            "p_COLUMN_ID": "6",
            "p_COLUMN_VALUE": "2125550147-12"
        }
    }';
    XYZ_REQUEST_HANDLER.Actions(
        'PROF.I.PROFILE_COLUMN_VALUE', 101, 'PROFILE', '127.0.0.0',
        l_reqObj, '',
        :oCode, :oMessage, :oJsonResp
    );
END;
/

COMMIT;

PRINT oCode
PRINT oMessage
PRINT oJsonResp

PROMPT
PROMPT ======================================================================
PROMPT TEST 32: PROF.U.PROFILE_COLUMN_VALUE (hardcoded)   (4 input params)
PROMPT ======================================================================

DECLARE
    l_reqObj CLOB;
BEGIN
    XYZ_REQUEST_HANDLER.isSendHardCodedResponse := 1;
    l_reqObj := '{
        "JHeader": {
            "ActionCode": "PROF.U.PROFILE_COLUMN_VALUE",
            "APILogin": "xyzapp@xyz.com",
            "APIPassword": "12345",
            "RequestedURL": "http://domain.com/XYZAPI/ProcessRequest"
        },
        "JMetaData": {},
        "JData": {
            "p_LOGIN_ID": "j.lee@xyzcar.com",
            "p_COLUMN_ID": "6",
            "p_COLUMN_VALUE_OLD": "2125550147-12",
            "p_COLUMN_VALUE_NEW": "2125550148-12"
        }
    }';
    XYZ_REQUEST_HANDLER.Actions(
        'PROF.U.PROFILE_COLUMN_VALUE', 101, 'PROFILE', '127.0.0.0',
        l_reqObj, '',
        :oCode, :oMessage, :oJsonResp
    );
END;
/

COMMIT;

PRINT oCode
PRINT oMessage
PRINT oJsonResp

PROMPT
PROMPT ======================================================================
PROMPT TEST 32: PROF.U.PROFILE_COLUMN_VALUE (dynamic)   (4 input params)
PROMPT ======================================================================

DECLARE
    l_reqObj CLOB;
BEGIN
    XYZ_REQUEST_HANDLER.isSendHardCodedResponse := 0;
    l_reqObj := '{
        "JHeader": {
            "ActionCode": "PROF.U.PROFILE_COLUMN_VALUE",
            "APILogin": "xyzapp@xyz.com",
            "APIPassword": "12345",
            "RequestedURL": "http://domain.com/XYZAPI/ProcessRequest"
        },
        "JMetaData": {},
        "JData": {
            "p_LOGIN_ID": "j.lee@xyzcar.com",
            "p_COLUMN_ID": "6",
            "p_COLUMN_VALUE_OLD": "2125550147-12",
            "p_COLUMN_VALUE_NEW": "2125550148-12"
        }
    }';
    XYZ_REQUEST_HANDLER.Actions(
        'PROF.U.PROFILE_COLUMN_VALUE', 101, 'PROFILE', '127.0.0.0',
        l_reqObj, '',
        :oCode, :oMessage, :oJsonResp
    );
END;
/

COMMIT;

PRINT oCode
PRINT oMessage
PRINT oJsonResp

PROMPT
PROMPT ======================================================================
PROMPT TEST 33: PROF.D.PROFILE_COLUMN_VALUE (hardcoded)   (3 input params)
PROMPT ======================================================================

DECLARE
    l_reqObj CLOB;
BEGIN
    XYZ_REQUEST_HANDLER.isSendHardCodedResponse := 1;
    l_reqObj := '{
        "JHeader": {
            "ActionCode": "PROF.D.PROFILE_COLUMN_VALUE",
            "APILogin": "xyzapp@xyz.com",
            "APIPassword": "12345",
            "RequestedURL": "http://domain.com/XYZAPI/ProcessRequest"
        },
        "JMetaData": {},
        "JData": {
            "p_LOGIN_ID": "j.lee@xyzcar.com",
            "p_COLUMN_ID": "6",
            "p_COLUMN_VALUE": "2125550148-12"
        }
    }';
    XYZ_REQUEST_HANDLER.Actions(
        'PROF.D.PROFILE_COLUMN_VALUE', 101, 'PROFILE', '127.0.0.0',
        l_reqObj, '',
        :oCode, :oMessage, :oJsonResp
    );
END;
/

COMMIT;

PRINT oCode
PRINT oMessage
PRINT oJsonResp

PROMPT
PROMPT ======================================================================
PROMPT TEST 33: PROF.D.PROFILE_COLUMN_VALUE (dynamic)   (3 input params)
PROMPT ======================================================================

DECLARE
    l_reqObj CLOB;
BEGIN
    XYZ_REQUEST_HANDLER.isSendHardCodedResponse := 0;
    l_reqObj := '{
        "JHeader": {
            "ActionCode": "PROF.D.PROFILE_COLUMN_VALUE",
            "APILogin": "xyzapp@xyz.com",
            "APIPassword": "12345",
            "RequestedURL": "http://domain.com/XYZAPI/ProcessRequest"
        },
        "JMetaData": {},
        "JData": {
            "p_LOGIN_ID": "j.lee@xyzcar.com",
            "p_COLUMN_ID": "6",
            "p_COLUMN_VALUE": "2125550148-12"
        }
    }';
    XYZ_REQUEST_HANDLER.Actions(
        'PROF.D.PROFILE_COLUMN_VALUE', 101, 'PROFILE', '127.0.0.0',
        l_reqObj, '',
        :oCode, :oMessage, :oJsonResp
    );
END;
/

COMMIT;

PRINT oCode
PRINT oMessage
PRINT oJsonResp

PROMPT
PROMPT ======================================================================
PROMPT TEST 34: PROF.S.USER_PROFILE_ADDRESSES (hardcoded)   (1 input param)
PROMPT ======================================================================

DECLARE
    l_reqObj CLOB;
BEGIN
    XYZ_REQUEST_HANDLER.isSendHardCodedResponse := 1;
    l_reqObj := '{
        "JHeader": {
            "ActionCode": "PROF.S.USER_PROFILE_ADDRESSES",
            "APILogin": "xyzapp@xyz.com",
            "APIPassword": "12345",
            "RequestedURL": "http://domain.com/XYZAPI/ProcessRequest"
        },
        "JMetaData": {},
        "JData": {
            "p_LOGIN_ID": "j.lee@xyzcar.com"
        }
    }';
    XYZ_REQUEST_HANDLER.Actions(
        'PROF.S.USER_PROFILE_ADDRESSES', 101, 'PROFILE', '127.0.0.0',
        l_reqObj, '',
        :oCode, :oMessage, :oJsonResp
    );
END;
/

COMMIT;

PRINT oCode
PRINT oMessage
PRINT oJsonResp

PROMPT
PROMPT ======================================================================
PROMPT TEST 34: PROF.S.USER_PROFILE_ADDRESSES (dynamic)   (1 input param)
PROMPT ======================================================================

DECLARE
    l_reqObj CLOB;
BEGIN
    XYZ_REQUEST_HANDLER.isSendHardCodedResponse := 0;
    l_reqObj := '{
        "JHeader": {
            "ActionCode": "PROF.S.USER_PROFILE_ADDRESSES",
            "APILogin": "xyzapp@xyz.com",
            "APIPassword": "12345",
            "RequestedURL": "http://domain.com/XYZAPI/ProcessRequest"
        },
        "JMetaData": {},
        "JData": {
            "p_LOGIN_ID": "j.lee@xyzcar.com"
        }
    }';
    XYZ_REQUEST_HANDLER.Actions(
        'PROF.S.USER_PROFILE_ADDRESSES', 101, 'PROFILE', '127.0.0.0',
        l_reqObj, '',
        :oCode, :oMessage, :oJsonResp
    );
END;
/

COMMIT;

PRINT oCode
PRINT oMessage
PRINT oJsonResp

PROMPT
PROMPT ======================================================================
PROMPT TEST 35: PROF.I.DB_LOG_ERROR (hardcoded)   (5 input params)
PROMPT ======================================================================

DECLARE
    l_reqObj CLOB;
BEGIN
    XYZ_REQUEST_HANDLER.isSendHardCodedResponse := 1;
    l_reqObj := '{
        "JHeader": {
            "ActionCode": "PROF.I.DB_LOG_ERROR",
            "APILogin": "xyzapp@xyz.com",
            "APIPassword": "12345",
            "RequestedURL": "http://domain.com/XYZAPI/ProcessRequest"
        },
        "JMetaData": {},
        "JData": {
            "p_MESS_TEXT": "Profile module test run",
            "p_ERROR_CODE": "TEST-001",
            "p_PROC_NAME": "XYZ_REQUEST_HANDLER.Actions",
            "p_DEBUG_LEVEL": "1",
            "p_USER_ID": "j.lee@xyzcar.com"
        }
    }';
    XYZ_REQUEST_HANDLER.Actions(
        'PROF.I.DB_LOG_ERROR', 101, 'PROFILE', '127.0.0.0',
        l_reqObj, '',
        :oCode, :oMessage, :oJsonResp
    );
END;
/

COMMIT;

PRINT oCode
PRINT oMessage
PRINT oJsonResp

PROMPT
PROMPT ======================================================================
PROMPT TEST 35: PROF.I.DB_LOG_ERROR (dynamic)   (5 input params)
PROMPT ======================================================================

-- Writes one row to OPTIMA.DEBUG_TB.
DECLARE
    l_reqObj CLOB;
BEGIN
    XYZ_REQUEST_HANDLER.isSendHardCodedResponse := 0;
    l_reqObj := '{
        "JHeader": {
            "ActionCode": "PROF.I.DB_LOG_ERROR",
            "APILogin": "xyzapp@xyz.com",
            "APIPassword": "12345",
            "RequestedURL": "http://domain.com/XYZAPI/ProcessRequest"
        },
        "JMetaData": {},
        "JData": {
            "p_MESS_TEXT": "Profile module test run",
            "p_ERROR_CODE": "TEST-001",
            "p_PROC_NAME": "XYZ_REQUEST_HANDLER.Actions",
            "p_DEBUG_LEVEL": "1",
            "p_USER_ID": "j.lee@xyzcar.com"
        }
    }';
    XYZ_REQUEST_HANDLER.Actions(
        'PROF.I.DB_LOG_ERROR', 101, 'PROFILE', '127.0.0.0',
        l_reqObj, '',
        :oCode, :oMessage, :oJsonResp
    );
END;
/

COMMIT;

PRINT oCode
PRINT oMessage
PRINT oJsonResp

PROMPT
PROMPT ======================================================================
PROMPT TEST 36: PROF.S.CORPORATE_ADDRESSES (hardcoded)   (1 input param)
PROMPT ======================================================================

DECLARE
    l_reqObj CLOB;
BEGIN
    XYZ_REQUEST_HANDLER.isSendHardCodedResponse := 1;
    l_reqObj := '{
        "JHeader": {
            "ActionCode": "PROF.S.CORPORATE_ADDRESSES",
            "APILogin": "xyzapp@xyz.com",
            "APIPassword": "12345",
            "RequestedURL": "http://domain.com/XYZAPI/ProcessRequest"
        },
        "JMetaData": {},
        "JData": {
            "p_ACCOUNT_NUM": "99005"
        }
    }';
    XYZ_REQUEST_HANDLER.Actions(
        'PROF.S.CORPORATE_ADDRESSES', 101, 'PROFILE', '127.0.0.0',
        l_reqObj, '',
        :oCode, :oMessage, :oJsonResp
    );
END;
/

COMMIT;

PRINT oCode
PRINT oMessage
PRINT oJsonResp

PROMPT
PROMPT ======================================================================
PROMPT TEST 36: PROF.S.CORPORATE_ADDRESSES (dynamic)   (1 input param)
PROMPT ======================================================================

DECLARE
    l_reqObj CLOB;
BEGIN
    XYZ_REQUEST_HANDLER.isSendHardCodedResponse := 0;
    l_reqObj := '{
        "JHeader": {
            "ActionCode": "PROF.S.CORPORATE_ADDRESSES",
            "APILogin": "xyzapp@xyz.com",
            "APIPassword": "12345",
            "RequestedURL": "http://domain.com/XYZAPI/ProcessRequest"
        },
        "JMetaData": {},
        "JData": {
            "p_ACCOUNT_NUM": "99005"
        }
    }';
    XYZ_REQUEST_HANDLER.Actions(
        'PROF.S.CORPORATE_ADDRESSES', 101, 'PROFILE', '127.0.0.0',
        l_reqObj, '',
        :oCode, :oMessage, :oJsonResp
    );
END;
/

COMMIT;

PRINT oCode
PRINT oMessage
PRINT oJsonResp
