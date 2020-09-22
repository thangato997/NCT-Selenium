require 'selenium-webdriver'

# Call browser
driver = Selenium::WebDriver.for :firefox
# Navigate to the page
driver.get 'https://itmscoaching.herokuapp.com/form'
# Resize window
driver.manage.window.maximize
driver.find_element(:xpath, "//input[@id='first-name']").send_keys('iTMS')
driver.find_element(:xpath, "//input[@id='last-name']").send_keys('Coaching')
driver.find_element(:xpath, "//input[@id='job-title']").send_keys('QA')
# Check the radio button is checked or not
radio_button = driver.find_element(:xpath, "//input[@id='radio-button-2']")
if (radio_button.selected?)
    pass
else
    radio_button.click
end
# Check the checkbox is checked or not
checkbox = driver.find_element(:xpath, "//input[@id='checkbox-1']")
if (checkbox.selected?)
    pass
else
    checkbox.click
end
# Clicking an option in DropDown 
text = driver.find_element(:xpath, "//option[contains(text(),'2-4')]").text # Get text of element
select_list = driver.find_element(:xpath, "//select[@id='select-menu']") # Get dropdown list
dropdown = Selenium::WebDriver::Support::Select.new(select_list) # Create dropdown list
dropdown.select_by(:text, text) # Select value by text from dropdown list

driver.find_element(:xpath, "//input[@id='datepicker']").send_keys('27/10/2025')
driver.find_element(:xpath, "//a[@class='btn btn-lg btn-primary']").click
sleep 2
driver.close
