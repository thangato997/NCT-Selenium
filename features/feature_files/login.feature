Feature: Login
    As a User,
    I wanna sign in,
    So that verify status of login.

    Background:
        Given user navigate to the login page

    @valid
    Scenario: Valid login
        When user enter "tomsmith" and "SuperSecretPassword!"
        Then user verify the message "You logged into a secure area!"

    @invalid
    Scenario Outline: Invalid login
        When user enter "<username>" and "<password>"
        Then user verify the message "<message>"

        Examples:
            | username | password      | message                   |
            | cdfgc'   | hahaha        | Your username is invalid! |
            | hohoh36# | hihih         | Your username is invalid! |
            | tomsmith | akas2qqweqwas | Your password is invalid! |
