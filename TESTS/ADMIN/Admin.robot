*** Settings ***
Resource    ../../RESOURCES/ReusableKeywords.robot

Test Setup    Open EventHub
Test Teardown    Close EventHub


*** Test Cases ***
TC11 - Verify Admin Can Access Manage Events
    [Documentation]    Verify that a logged-in user can access the Manage Events page through the Admin menu
    [Tags]    positive    admin    events    manage-events

    Login User    aakriti.test001@example.com    Test@1234
    Verify Successful Login
    Open Admin Manage Events
    Page Should Contain    New Event
    Page Should Contain    All Events

TC12 - Admin Can Add New Event
    [Documentation]    Verify that an admin can successfully create a new event from the Manage Events page
    [Tags]    positive    admin    event    add-event

    Login User    aakriti.test001@example.com    Test@1234
    Verify Successful Login
    Open Admin Manage Events

    Add New Event
    ...    Kathmandu Tech Innovation Summit 2026
    ...    A technology conference bringing together IT professionals, developers, and technology enthusiasts to discuss emerging innovations.
    ...    Conference
    ...    Kathmandu
    ...    Soaltee Kathmandu
    ...    2026-10-30T10:00
    ...    150
    ...    200

    Verify Event Added    Kathmandu Tech Innovation Summit 2026

TC13 - Admin Cannot Add Event Without Date
    [Documentation]    Verify that an admin cannot add an event without providing the event date and time
    [Tags]    negative    admin    events    validation

    Login User    aakriti.test001@example.com    Test@1234
    Verify Successful Login
    Open Admin Manage Events

    Add Event Without Date
    ...    Kathmandu Tech Conference 2026
    ...    Annual technology conference featuring discussions on cloud computing, cybersecurity, and artificial intelligence.
    ...    Conference
    ...    Kathmandu
    ...    Kathmandu Convention Center
    ...    100
    ...    50

    Page Should Contain    Event date is required

TC14 - Admin Can Access Manage Bookings
    [Documentation]    Verify that an admin can access the Manage Bookings page.
    [Tags]    Admin    ManageBookings    
    
    Login User    aakriti.test001@example.com    Test@1234
    Verify Successful Login
    Open Admin Manage Bookings
    Page Should Contain    Manage Bookings

TC15 - Admin Can View Booking Details
    [Documentation]    Verify that an admin can view the details of an existing booking
    [Tags]    positive    admin    bookings    view-booking

    Login User    aakriti.test001@example.com    Test@1234
    Verify Successful Login
    Open Admin Manage Bookings
    View Booking Details
    Page Should Contain    Reference
    Page Should Contain    Status
    Page Should Contain    Title
    