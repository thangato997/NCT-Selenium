require 'selenium-webdriver'

driver = Selenium::WebDriver.for :firefox
wait = Selenium::WebDriver::Wait.new(:timeout => 10)
driver.get 'https://www.google.com/'
driver.manage.window.maximize
driver.find_element(:css, '[name="q"]').send_keys('iTMS Coaching')
driver.find_element(:css, '[name="q"]').send_keys(:enter)
wait.until { driver.find_element(:xpath, "//a[@id='logo']//img").displayed? }
current_title = driver.title
puts current_title
driver.close
