Feature: tiki
    As a User,
    I wanna count products are displayed,
    So that verify the total of products.

    Background:
        Given user navigate to the tiki page

    @invalid
    Scenario Outline: Invalid login
        When user enter "<something>"
        Then user verify the <total> of products

        Examples:
            | something | total |
            | book      | 52    |
            | shoe      | 48    |
            | pen       | 48    |