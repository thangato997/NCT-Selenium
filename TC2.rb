require 'selenium-webdriver'


driver = Selenium::WebDriver.for :firefox

driver.get 'https://www.google.com/'

# driver.manage.window.maximize

driver.manage.window.resize_to(1600,900)

driver.close