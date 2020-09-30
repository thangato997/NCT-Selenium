Feature: Login
    As a User,
    I wanna sign in,
    So that verify status of login.

    Background:
    Given Navigate to the login page
    @valid
    Scenario: Valid login  
    When User enter valid "tomsmith" and "SuperSecretPassword!"
    Then User verify the message "You logged into a secure area!"
    @invalid
    Scenario Outline: Invalid login
    When User enter invalid "<username>" and "<password>"
    Then User verify the message "<message>"
    # "Your username is invalid!"

    Examples:
        |username   |password            |message                  |
        |alala      |hahaha              |Your username is invalid!|
        |hohoh36#   |hihih               |Your username is invalid!|
        |tomsmith   |akas2qqweqwas       |Your password is invalid!|
