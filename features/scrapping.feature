Feature: Obtain information from datos.gob.cl
  Chilean gov. publishes the required information in Excel spreadsheets in
  http://datos.gob.cl/datasets/ver/1547
  Dturno must be able to scrap that page, download the files, parse them and put them into the database

Scenario: Scrap the government page for each region
  Given I run the feeding task
  	Then I should find 15 excel download links
  	  And I should download the files
  	  And I should parse the files to ruby
  	  And I should save the drugstores to the database