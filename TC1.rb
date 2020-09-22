require 'selenium-webdriver'

$driver = Selenium::WebDriver.for :firefox

$driver.get 'https://www.google.com/'

$driver.close