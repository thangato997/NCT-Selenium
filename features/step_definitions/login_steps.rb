Given("user navigate to the login page") do
  $driver.get "http://the-internet.herokuapp.com/login"
end

When("user enter {string} and {string}") do |string, string2|
  $driver.find_element(css: "#username").send_keys string
  $driver.find_element(css: "#password").send_keys string2
  $driver.find_element(css: ".fa.fa-2x.fa-sign-in").click
end

Then("user verify the message {string}") do |string|
  text = $driver.find_element(css: "#flash").text
  expect(text).to include(string)
end
