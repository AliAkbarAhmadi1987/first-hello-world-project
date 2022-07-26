Feature: Assignment

  Background: generate token for all scenarios.
    Given url "https://tek-insurance-api.azurewebsites.net"
    And path "/api/token"
    And request {"username": "supervisor","password": "tek_supervisor"}
    When method post
    Then status 200
    * def generatedToken = response.token

  Scenario: Add new Account with Existing email address
    Given path "/api/accounts/add-primary-account"
    And request {"email": "DrissZain@gmail.com", "title": "Mr.","firstName": "driss","lastName": "touil","gender": "MALE","maritalStatus": "SINGLE","employmentStatus": "tiger","dateOfBirth": "1982-02-27"}
    And header Authorization = "Bearer " + generatedToken
    When method post
    Then status 400
    And print response
    * def errorMessage = response.errorMessage
    And assert errorMessage == "Account with Email DrissZain@gmail.com is exist"

  Scenario: add car to existing account.
    Given path "/api/accounts/add-account-car"
    And param primaryPersonId = 6
    And request {"make": "benz","model": "4Matic","year": "2022","licensePlate": "wrp5492"}
    And header Authorization = "Bearer " + generatedToken
    When method post
    Then status 201
    And print response

  Scenario: add Phone number to existing account.
    Given path "/api/accounts/add-account-phone"
    And param primaryPersonId = 6
    And request {"phoneNumber": "252-566-7879","phoneExtension": "12","phoneTime": "Any Time","phoneType": "Mobile"}
    And header Authorization = "Bearer " + generatedToken
    When method post
    Then status 201
    And print response

  Scenario: add address to existing account.
    Given path "/api/accounts/add-account-address"
    And param primaryPersonId = 6
    And request {"addressType": "Home","addressLine1": "123 14th st s","city": "arlington","state": "va","postalCode": "22204","countryCode": "120","current": true}
    And header Authorization = "Bearer " + generatedToken
    When method post
    Then status 201
    And print response
