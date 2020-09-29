Feature: Login
    As a User,
    I wanna sign in,
    So that verify status of login.

    Background:
    Given Navigate to the login page

    Scenario: Valid login  
    When User enter valid "tomsmith" and "SuperSecretPassword!"
    Then User verify the message "You logged into a secure area!"

    Scenario Outline: Invalid login
    When User enter invalid "<username>" and "<password>"
    Then User verify the message "Your username is invalid!"

    Examples:
        |username   |password   |
        |alala      |hahaha     |
        |cacaca1    |lalala     |
        |hohoh36#   |hihih      |
