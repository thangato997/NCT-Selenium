$n = 0
Given("Navigate to the login page") do
    if $n < 2
    $driver = Selenium::WebDriver.for :firefox
    $driver.navigate.to 'http://the-internet.herokuapp.com/login'
    end
end
  
When("User enter {string} and {string}") do |string, string2|
    $driver.find_element(css: "#username").send_keys string
    $driver.find_element(css: "#password").send_keys string2
    $driver.find_element(css: ".fa.fa-2x.fa-sign-in").click
end
  
# Then("User verify that login was successful with message {string}") do |string|
#     expect($driver.find_element(css: "#flash").text).to include(string)
#     $driver.close
# end

# When("User enter invalid {string} and {string}") do |string, string2|
#     # wait()
#     $driver.find_element(css: "#username").send_keys string
#     $driver.find_element(css: "#password").send_keys string2
#     $driver.find_element(css: ".fa.fa-2x.fa-sign-in").click
# end

def exit_browser()
    # if $n > 0
    if $n > 0 && $n < 3
        $driver.navigate.refresh
        $n += 1
    else
        $driver.close
        $n += 1
    end
end

# def wait()
#     $wait = Selenium::WebDriver::Wait.new(timeout: 10)
#     $wait.until{$driver.find_element(xpath: "//h2[contains(text(),'Login Page')]").displayed?}
# end

Then("User verify the message {string}") do |string|
    text = $driver.find_element(css: "#flash").text
    expect(text).to include(string)
exit_browser()
end