require 'selenium-webdriver'

driver = Selenium::WebDriver.for :firefox
driver.get 'https://www.google.com/'
driver.manage.window.maximize
current_title = driver.title
puts current_title
driver.close