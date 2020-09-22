require 'selenium-webdriver'

driver = Selenium::WebDriver.for :firefox
driver.get 'https://www.google.com/'
driver.manage.window.maximize
current_url = driver.current_url
puts current_url
driver.close
