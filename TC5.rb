require 'selenium-webdriver'

driver = Selenium::WebDriver.for :firefox
driver.get 'https://www.google.com/'
driver.manage.window.maximize
current_page_source = driver.page_source
puts current_page_source
driver.close
