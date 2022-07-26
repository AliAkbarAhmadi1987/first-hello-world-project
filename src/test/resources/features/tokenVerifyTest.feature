Feature: Security test Token Generation test

  Scenario: generate token with valid user password
    Given url "https://tek-insurance-api.azurewebsites.net"
    And path "/api/token"
    And request {"username": "supervisor", "password":"tek_supervisor"}
    When method post
    Then status 200
    And print response

  Scenario: generate token with invalid user password
    Given url "https://tek-insurance-api.azurewebsites.net"
    And path "/api/token"
    And request {"username": "super", "password":"tek_supervisor"}
    When method post
    Then status 404
    And print response
    * def errorMessage = response.errorMessage
    And assert errorMessage == "USER_NOT_FOUND"

  Scenario: valid token
    Given url "https://tek-insurance-api.azurewebsites.net"
    And path "/api/token"
    And request {"username": "supervisor", "password":"tek_supervisor"}
    When method post
    Then status 200
    * def generatedToken = response.token
    Given path "/api/token/verify"
    And param username = "supervisor"
    And param token = generatedToken
    When method get
    Then status 200
    And print response

  Scenario: verify invaid token
    Given url "https://tek-insurance-api.azurewebsites.net"
    Given path "/api/token/verify"
    And param username = "supervisor"
    And param token = "invalid tekoon"
    When method get
    Then status 400
    And print response
