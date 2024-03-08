*** Settings ***
Documentation     Simple example using SeleniumLibrary.
Library           SeleniumLibrary

*** Variables ***
${BROWSER}        Edge
${LOGIN URL}      https://fekmitl.pythonanywhere.com/kratai-bin
${ORDER URL}      https://fekmitl.pythonanywhere.com/kratai-bin/order
${CHECKOUT URL}   https://fekmitl.pythonanywhere.com/kratai-bin/confirm

*** Keywords ***
Validate Order Page
    Wait Until Location Contains   ${ORDER URL}
    ${num_tum_thai}   Get Value    id=txt_tum_thai
    Should Be Equal As Integers    ${num_tum_thai}    0
    ${num_tum_poo}    Get Value    id=txt_tum_poo
    Should Be Equal As Integers    ${num_tum_poo}    0

*** Test Cases ***
Case 1: Add 4 tum thai
    Open Browser    ${LOGIN URL}    ${BROWSER}
    Title Should Be    Kratai Bin
    Wait Until Element Is Visible    id=start
    Click Element    id=start

    Wait Until Location Is   ${ORDER URL}
    ${num_tum_thai}   Get Value    id=txt_tum_thai
    Should Be Equal As Integers    ${num_tum_thai}    0
    ${num_tum_poo}    Get Value    id=txt_tum_poo
    Should Be Equal As Integers    ${num_tum_poo}    0

    Click Element    id=add_tum_thai
    Click Element    id=add_tum_thai
    Click Element    id=add_tum_thai
    Click Element    id=add_tum_thai
    Alert Should Be Present

    [Teardown]    Close Browser

Case 2: Add 4 tum poo
    Open Browser    ${LOGIN URL}    ${BROWSER}
    Title Should Be    Kratai Bin
    Wait Until Element Is Visible    id=start
    Click Element    id=start

    Validate Order Page

    Click Element    id=add_tum_poo
    Click Element    id=add_tum_poo
    Click Element    id=add_tum_poo
    Click Element    id=add_tum_poo
    Alert Should Be Present

    [Teardown]    Close Browser

Case 3: Add 3 tum thai, 2 tum poo and cancel
    Open Browser    ${LOGIN URL}    ${BROWSER}
    Title Should Be    Kratai Bin
    Wait Until Element Is Visible    id=start
    Click Element    id=start

    Validate Order Page

    Click Element    id=add_tum_thai
    Click Element    id=add_tum_thai
    Click Element    id=add_tum_thai
    Click Element    id=add_tum_poo
    Click Element    id=add_tum_poo

    Click Element    id=btn_cancel
    Wait Until Location Is    ${LOGIN URL}

    [Teardown]    Close Browser

Case 4: Add 3 tum thai, 2 tum poo and check out
    Open Browser    ${LOGIN URL}    ${BROWSER}
    Title Should Be    Kratai Bin
    Wait Until Element Is Visible    id=start
    Click Element    id=start

    Validate Order Page

    Click Element    id=add_tum_thai
    Click Element    id=add_tum_thai
    Click Element    id=add_tum_thai
    Click Element    id=add_tum_poo
    Click Element    id=add_tum_poo

    Click Element    id=btn_check_out
    Wait Until Location Contains    ${CHECKOUT URL}

    [Teardown]    Close Browser


