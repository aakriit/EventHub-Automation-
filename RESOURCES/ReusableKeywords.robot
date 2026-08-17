*** Settings ***
Library    SeleniumLibrary
Resource    ../VARIABLES/variables.robot

*** Keywords ***

Open EventHub
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window

Close EventHub
    Close All Browsers

Register User
    [Arguments]    ${email}    ${password}

    Wait Until Element Is Visible    css=[data-testid="register-email"]    20s
    Input Text    css=[data-testid="register-email"]    ${email}
    Input Text    css=[data-testid="register-password"]    ${password}
    Input Text    xpath=//input[@placeholder="Repeat your password"]    ${password}
    Click Button    id=register-btn

Verify Registration Validation Error
    Page Should Contain    Enter a valid email

Verify Existing Email Error
    Wait Until Page Contains    Email already registered    10s

Login User
    [Arguments]    ${email}    ${password}
    Go To    ${LOGIN_URL}
    Wait Until Element Is Visible    id=email    20s
    Input Text    id=email    ${email}
    Input Text    id=password    ${password}
    Click Button    id=login-btn
Verify Successful Login
    Wait Until Page Contains    Discover & Book    10s

Verify Login Error
    Wait Until Page Contains    Invalid email or password    10s

Open Event From Events Page
    Wait Until Element Is Visible    id=book-now-btn    10s
    Scroll Element Into View    id=book-now-btn
    Wait Until Element Is Enabled    id=book-now-btn    10s
    Click Element    id=book-now-btn
    Wait Until Page Contains    Book Tickets    10s

Enter Booking Details
    [Arguments]    ${name}    ${email}    ${phone}
    Wait Until Element Is Visible    id=customerName    10s
    Input Text    id=customerName    ${name}
    Input Text    css=[data-testid="customer-email"]    ${email}
    Input Text    id=phone    ${phone}

Confirm Booking
    Wait Until Element Is Visible    id=confirm-booking    10s
    Click Button    id=confirm-booking

Verify Booking Confirmed
    Wait Until Page Contains    Booking Confirmed!    10s

Verify Booking Validation Errors
    Page Should Contain    Name must be at least 2 chars
    Page Should Contain    Enter a valid email
    Page Should Contain    Enter a valid 10-digit phone

Increase Ticket Quantity
    Wait Until Element Is Visible    id=ticket-count    10s
    ${initial_count}=    Get Text    id=ticket-count
    Click Button    xpath=//span[@id="ticket-count"]/following-sibling::button[1]
    ${expected_count}=    Evaluate    int(${initial_count}) + 1
    ${new_count}=    Get Text    id=ticket-count
    Should Be Equal As Integers    ${new_count}    ${expected_count}

Verify Booking Details
    Wait Until Page Contains    Booking Confirmed!    10s
    Page Should Contain    Booking Ref
    Page Should Contain    Customer
    Page Should Contain    Tickets
    Page Should Contain    Total

Open My Bookings
    Wait Until Element Is Visible    xpath=//a[contains(.,'My Bookings')]    10s
    Click Link    xpath=//a[contains(.,'My Bookings')]
    Wait Until Location Contains    /bookings    10s
    Wait Until Page Contains    My Bookings    10s

Verify Booking In My Bookings
    Wait Until Page Contains    My Bookings    10s
    Wait Until Page Contains    confirmed    15s
    Page Should Contain    ticket

Open Admin Menu
    Wait Until Element Is Visible    xpath=//button[contains(.,'Admin')]    10s
    Click Button    xpath=//button[contains(.,'Admin')]

Open Admin Manage Events
    Open Admin Menu
    Wait Until Element Is Visible    xpath=//a[@href="/admin/events"]    10s
    Click Link    xpath=//a[@href="/admin/events"]
    Wait Until Page Contains    New Event    10s

Add New Event
    [Arguments]    ${title}    ${description}    ${category_name}    ${city}    ${venue}    ${date_time}    ${price}    ${total_seats}

    Wait Until Element Is Visible    id=event-title-input    10s
    Input Text    id=event-title-input    ${title}
    Input Text    css=textarea[placeholder="Describe the event…"]    ${description}
    Select From List By Label    id=category    ${category_name}
    Input Text    id=city    ${city}
    Input Text    id=venue    ${venue}
    Click Element    id=event-date-&-time
    Press Keys    id=event-date-&-time    CTRL+A
    Press Keys    id=event-date-&-time    10/30/2026
    Press Keys    id=event-date-&-time    TAB
    Press Keys    id=event-date-&-time    10:00AM
    Press Keys    id=event-date-&-time    TAB
    Input Text    id=price-($)    ${price}
    Input Text    id=total-seats    ${total_seats}

    Scroll Element Into View    id=add-event-btn
    Wait Until Element Is Visible    id=add-event-btn    10s
    Wait Until Element Is Enabled    id=add-event-btn    10s
    Click Element    id=add-event-btn


Verify Event Added
    [Arguments]    ${title}

    Wait Until Page Contains    ${title}    10s

Add Event Without Date
    [Arguments]    ${title}    ${description}    ${category_name}    ${city}    ${venue}    ${price}    ${total_seats}

    Wait Until Element Is Visible    id=event-title-input    10s
    Input Text    id=event-title-input    ${title}
    Input Text    css=textarea[placeholder="Describe the event…"]    ${description}
    Select From List By Label    id=category    ${category_name}
    Input Text    id=city    ${city}
    Input Text    id=venue    ${venue}
    Input Text    id=price-($)    ${price}
    Input Text    id=total-seats    ${total_seats}

    Scroll Element Into View    id=add-event-btn
    Wait Until Element Is Visible    id=add-event-btn    10s
    Wait Until Element Is Enabled    id=add-event-btn    10s
    Click Element    id=add-event-btn

Open Admin Manage Bookings
    Open Admin Menu
    Wait Until Element Is Visible    xpath=//a[@href="/admin/bookings"]    10s
    Click Link    xpath=//a[@href="/admin/bookings"]
    Wait Until Page Contains    Manage Bookings    10s

View Booking Details
    Wait Until Element Is Visible    xpath=//button[normalize-space()='View']    10s
    Click Button    xpath=(//button[normalize-space()='View'])[1]
    Wait Until Page Contains    Reference    10s