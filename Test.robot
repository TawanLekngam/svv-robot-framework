*** Settings ***
Documentation     Simple example using SeleniumLibrary.
Library           SeleniumLibrary

*** Variables ***
${BROWSER}        Edge
${LOGIN URL}      https://fekmitl.pythonanywhere.com/kratai-bin
${ORDER URL}      https://fekmitl.pythonanywhere.com/kratai-bin/order
${CHECKOUT URL}   https://fekmitl.pythonanywhere.com/kratai-bin/confirm
${PAYMENT URL}    https://fekmitl.pythonanywhere.com/kratai-bin/pay

*** Keywords ***
Validate Order Page ${num_tum_thai} ${num_tum_poo}
    Wait Until Location Is   ${ORDER URL}
    ${num_tum_thai_order}   Get Value    id=txt_tum_thai
    Should Be Equal As Integers    ${num_tum_thai_order}    ${num_tum_thai}
    ${num_tum_poo_order}    Get Value    id=txt_tum_poo
    Should Be Equal As Integers    ${num_tum_poo_order}    ${num_tum_poo}

Validate Checkout Page ${num_tum_thai} ${num_tum_poo}
    Wait Until Location Contains    ${CHECKOUT URL}
    ${num_tum_thai_checkout}   Get Text    id=msg_num_tum_thai
    Should Be Equal As Integers    ${num_tum_thai_checkout}    ${num_tum_thai}
    ${num_tum_poo_checkout}    Get Text    id=msg_num_tum_poo
    Should Be Equal As Integers    ${num_tum_poo_checkout}    ${num_tum_poo}

*** Test Cases ***
Case 1: Add 4 tum thai and error
    Open Browser    ${LOGIN URL}    ${BROWSER}
    Title Should Be    Kratai Bin
    Wait Until Element Is Visible    id=start
    Click Element    id=start

    Validate Order Page 0 0

    Click Element    id=add_tum_thai
    Click Element    id=add_tum_thai
    Click Element    id=add_tum_thai
    Click Element    id=add_tum_thai
    Alert Should Be Present

    [Teardown]    Close Browser

Case 2: Add 3 Tum Thai without error
    Open Browser    ${LOGIN URL}    ${BROWSER}
    Title Should Be    Kratai Bin
    Wait Until Element Is Visible    id=start
    Click Element    id=start

    Validate Order Page 0 0

    Click Element    id=add_tum_thai
    Click Element    id=add_tum_thai
    Click Element    id=add_tum_thai
    
    ${num_tum_thai}   Get Value    id=txt_tum_thai
    Should Be Equal As Integers    ${num_tum_thai}    3

    [Teardown]    Close Browser

Case 3: Add 4 tum poo and error
    Open Browser    ${LOGIN URL}    ${BROWSER}
    Title Should Be    Kratai Bin
    Wait Until Element Is Visible    id=start
    Click Element    id=start

    Validate Order Page 0 0

    Click Element    id=add_tum_poo
    Click Element    id=add_tum_poo
    Click Element    id=add_tum_poo
    Click Element    id=add_tum_poo
    Alert Should Be Present

    [Teardown]    Close Browser

Case 4: Add 3 tum poo without error
    Open Browser    ${LOGIN URL}    ${BROWSER}
    Title Should Be    Kratai Bin
    Wait Until Element Is Visible    id=start
    Click Element    id=start

    Validate Order Page 0 0

    Click Element    id=add_tum_poo
    Click Element    id=add_tum_poo
    Click Element    id=add_tum_poo

    ${num_tum_poo}   Get Value    id=txt_tum_poo
    Should Be Equal As Integers    ${num_tum_poo}    3

    [Teardown]    Close Browser

Case 5: Add 3 tum thai, 2 tum poo and cancel
    Open Browser    ${LOGIN URL}    ${BROWSER}
    Title Should Be    Kratai Bin
    Wait Until Element Is Visible    id=start
    Click Element    id=start

    Validate Order Page 0 0

    Click Element    id=add_tum_thai
    Click Element    id=add_tum_thai
    Click Element    id=add_tum_thai
    Click Element    id=add_tum_poo
    Click Element    id=add_tum_poo

    Click Element    id=btn_cancel
    Wait Until Location Is    ${LOGIN URL}

    [Teardown]    Close Browser

Case 6: Add 3 tum thai, 2 tum poo and check out
    Open Browser    ${LOGIN URL}    ${BROWSER}
    Title Should Be    Kratai Bin
    Wait Until Element Is Visible    id=start
    Click Element    id=start

    Validate Order Page 0 0

    Click Element    id=add_tum_thai
    Click Element    id=add_tum_thai
    Click Element    id=add_tum_thai
    Click Element    id=add_tum_poo
    Click Element    id=add_tum_poo

    Click Element    id=btn_check_out

    Validate Checkout Page 3 2

    [Teardown]    Close Browser

Case 7: Add 3 tum thai, 3 tum poo, check out and change order
    Open Browser    ${LOGIN URL}    ${BROWSER}
    Title Should Be    Kratai Bin
    Wait Until Element Is Visible    id=start
    Click Element    id=start

    Validate Order Page 0 0

    Click Element    id=add_tum_thai
    Click Element    id=add_tum_thai
    Click Element    id=add_tum_thai
    Click Element    id=add_tum_poo
    Click Element    id=add_tum_poo
    Click Element    id=add_tum_poo

    Click Element    id=btn_check_out

    Validate Checkout Page 3 3

    Click Element    id=btn_change
    Wait Until Location Is    ${ORDER URL}

    [Teardown]    Close Browser

Case 8: Confirm with invalid credit card 3 times
    Open Browser    ${LOGIN URL}    ${BROWSER}
    Title Should Be    Kratai Bin
    Wait Until Element Is Visible    id=start
    Click Element    id=start

    Validate Order Page 0 0

    Click Element    id=add_tum_thai
    Click Element    id=add_tum_thai
    Click Element    id=add_tum_thai
    Click Element    id=add_tum_poo
    Click Element    id=add_tum_poo
    Click Element    id=add_tum_poo

    Click Element    id=btn_check_out

    Validate Checkout Page 3 3

    Click Element    id=btn_confirm
    Wait Until Location Contains    ${PAYMENT URL}
    Click Element    id=btn_pay
    Wait Until Element Is Visible    id=msg_error
    ${error_message}      Get Text     id=msg_error
    Should Be Equal as Strings     ${error_message}  ERROR: Payment failed. 2 retries remaining.
    Click Element    id=btn_pay
    Wait Until Element Is Visible    id=msg_error
    ${error_message}      Get Text     id=msg_error
    Should Be Equal as Strings     ${error_message}  ERROR: Payment failed. 1 retries remaining.
    Click Element    id=btn_pay
    Wait Until Element Is Visible    id=start

    [Teardown]    Close Browser

Case 9: Confirm with invalid credit card 1 times then valid credit card
    Open Browser    ${LOGIN URL}    ${BROWSER}
    Title Should Be    Kratai Bin
    Wait Until Element Is Visible    id=start
    Click Element    id=start

    Validate Order Page 0 0

    Click Element    id=add_tum_thai
    Click Element    id=add_tum_thai
    Click Element    id=add_tum_thai
    Click Element    id=add_tum_poo
    Click Element    id=add_tum_poo
    Click Element    id=add_tum_poo

    Click Element    id=btn_check_out

    Validate Checkout Page 3 3

    Click Element    id=btn_confirm
    Wait Until Location Contains    ${PAYMENT URL}
    Click Element    id=btn_pay
    Wait Until Element Is Visible    id=msg_error
    ${error_message}      Get Text     id=msg_error
    Should Be Equal as Strings     ${error_message}  ERROR: Payment failed. 2 retries remaining.

    Input Text    name=txt_credit_card_num     1234567890
    Input Text    name=txt_name_on_card     John Doe
    Click Element    id=btn_pay

    Sleep    11

    [Teardown]    Close Browser

Case 10: Comfirm with valid credit card
    Open Browser    ${LOGIN URL}    ${BROWSER}
    Title Should Be    Kratai Bin
    Wait Until Element Is Visible    id=start
    Click Element    id=start

    Validate Order Page 0 0

    Click Element    id=add_tum_thai
    Click Element    id=add_tum_thai
    Click Element    id=add_tum_thai
    Click Element    id=add_tum_poo
    Click Element    id=add_tum_poo
    Click Element    id=add_tum_poo

    Click Element    id=btn_check_out

    Validate Checkout Page 3 3

    Click Element    id=btn_confirm
    Wait Until Location Contains    ${PAYMENT URL}
    Input Text    name=txt_credit_card_num     1234567890
    Input Text    name=txt_name_on_card     John Doe
    Click Element    id=btn_pay

    Sleep    11

    Wait Until Location Contains    ${LOGIN URL}
    ${clear_message}      Get Text     id=msg_clearing
    Should Be Equal as Strings     ${clear_message}  Clearing in progress. Please wait.

    [Teardown]    Close Browser