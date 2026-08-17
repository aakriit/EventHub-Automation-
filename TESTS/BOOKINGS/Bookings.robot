*** Settings ***
Resource    ../../RESOURCES/ReusableKeywords.robot

Test Setup       Open EventHub
Test Teardown    Close EventHub


*** Test Cases ***

TC06 - Verify User Can Book Tickets With Valid Details
    [Documentation]    Verify user can successfully book an event with valid customer details
    [Tags]    positive    booking

    Login User    aakriti.test001@example.com    Test@1234
    Open Event From Events Page
    Enter Booking Details    Aakriti Sigdel    aakriti.booking001@example.com    9801234567
    Confirm Booking
    Verify Booking Confirmed

TC07 - Verify Booking Fails With Invalid Details
    [Documentation]    Verify booking cannot be completed with invalid customer details
    [Tags]    negative    booking

    Login User    aakriti.test001@example.com    Test@1234
    Open Event From Events Page
    Enter Booking Details    A    invalid1-email    123
    Confirm Booking
    Verify Booking Validation Errors

TC08 - Verify User Can Increase Ticket Quantity
    [Documentation]    Verify user can increase the number of tickets before booking
    [Tags]    positive    booking

    Login User    aakriti.test001@example.com    Test@1234
    Open Event From Events Page
    Increase Ticket Quantity
   

TC09 - Verify Booking Details Are Displayed After Successful Booking
    [Documentation]    Verify booking confirmation displays the booking reference, customer, tickets and total
    [Tags]    positive    booking    confirmation

    Login User    aakriti.test001@example.com    Test@1234
    Open Event From Events Page
    Enter Booking Details    Aakriti Sigdel    aakriti.booking004@example.com    9801234567
    Confirm Booking
    Verify Booking Details

TC10 - Verify User Can View Booking In My Bookings
    [Documentation]    Verify a successfully created booking appears in the user's My Bookings page
    [Tags]    positive    booking    my-bookings

    Login User    aakriti.test001@example.com    Test@1234
    Open Event From Events Page
    Enter Booking Details    Aakriti Sigdel    aakriti.booking005@example.com    9801234567
    Confirm Booking
    Open My Bookings
   Verify Booking In My Bookings