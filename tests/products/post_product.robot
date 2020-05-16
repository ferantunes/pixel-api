***Settings***
Documentation    Pixel Api POST /products

Resource    ../../resources/services.robot
Resource    ../../resources/db.robot

Suite Setup       Connect DB
Suite Teardown    Disconnect From Database
Test Setup        Clear Product Table

***Test Cases***
Create new product
    [tags]    success

    ${token}=    Get Auth Token    ${USER_AUTH}    ${PASSWORD_AUTH}

    ${payload}=    Get Json        dk.json
    ${resp}=       Post Product    ${payload}    ${token}

    Status Should Be    200    ${resp}

Duplicated Product
    [tags]    conflict

    ${token}=    Get Auth Token    ${USER_AUTH}    ${PASSWORD_AUTH}

    ${payload}=         Get Json        duplicated.json
    ${resp_created}=    Post Product    ${payload}         ${token}

    Status Should Be    200    ${resp_created}    

    ${resp}=    Post Product    ${payload}    ${token}

    Status Should Be    409    ${resp}

Required title
    [tags]    bad_request

    ${token}=    Get Auth Token    ${USER_AUTH}    ${PASSWORD_AUTH}

    ${payload}=    Get Json        no_title.json
    ${resp}=       Post Product    ${payload}       ${token}

    Status Should Be    400                      ${resp}
    Should Be Equal     ${resp.json()['msg']}    Oops! title cannot be empty

    Dictionary Should Contain Value    ${resp.json()}    Oops! title cannot be empty

Required category
    [tags]    bad_request

    ${token}=    Get Auth Token    ${USER_AUTH}    ${PASSWORD_AUTH}

    ${payload}=    Get Json        no_cat.json
    ${resp}=       Post Product    ${payload}     ${token}

    Status Should Be    400                      ${resp}
    Should Be Equal     ${resp.json()['msg']}    Oops! category cannot be empty

Required price
    [tags]    bad_request

    ${token}=    Get Auth Token    ${USER_AUTH}    ${PASSWORD_AUTH}

    ${payload}=    Get Json        no_price.json
    ${resp}=       Post Product    ${payload}       ${token}

    Status Should Be    400                      ${resp}
    Should Be Equal     ${resp.json()['msg']}    Oops! price cannot be empty