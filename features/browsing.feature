Feature: Show in a map drugstores currently on nightly service
  In Chile drugstores in each comuna alterante to provide emergency nightly service
  Those are presented in ugly and difficult to find tables
  The idea is to put them on a nifty, responsive, single google map

Scenario: Visit the home page
  Given I browse to the root page
    Then I should see a h1 that says "DTurno.cl"