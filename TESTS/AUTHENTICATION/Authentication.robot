*** Settings ***
Resource    ../../RESOURCES/ReusableKeywords.robot

Test Setup       Open EventHub
Test Teardown    Close EventHub

*** Test Cases ***

TC01 - Verify User Can Register With Valid Details
    [Documentation]    Verify user can register with valid details
    [Tags]    positive    registration

    Register User    aakriti.test001@example.com    Test@1234
    Wait Until Page Contains    Discover & Book    10s

TC02 - Register User With Invalid Details
    [Documentation]    Verify registration shows validation errors for invalid details
    [Tags]    invalid    registration

    Register User    aakriti.email  abc123 
    Verify Registration Validation Error

TC03 - Verify Registration Fails With Existing Email
    [Documentation]    Verify registration fails when an already registered email is used
    [Tags]    negative    existing-email    registration

    Register User    aakriti.test001@example.com    Test@1234
    Verify Existing Email Error

TC04 - Verify User Can Login With Valid Credentials
    [Documentation]    Verify user can log in successfully with valid credentials
    [Tags]    positive    login

    Login User    aakriti.test001@example.com    Test@1234
    Verify Successful Login

TC05 - Verify Login Fails With Invalid Credentials
    [Documentation]    Verify login fails when invalid credentials are entered
    [Tags]    negative    login

    Login User    aakriti.test001@example.com    Wrong@1234
    Verify Login Error