# Khởi tạo biến n để làm điều kiện
$n = 0 
# Hàm để close or refresh trang
def exit_browser()
    # Điều kiện để đóng hoặc làm mới trang web 
    if $n > 0 && $n < 3
        $driver.navigate.refresh
        $n += 1
    else
        $driver.close
        $n += 1
    end
end

Given("Navigate to the login page") do
    if $n < 2 # Điều kiện để mở trình duyệt và đi tới trang web
    $driver = Selenium::WebDriver.for :chrome
    $driver.navigate.to 'http://the-internet.herokuapp.com/login'
    end
end
  
When("User enter {string} and {string}") do |string, string2|
    $driver.find_element(css: "#username").send_keys string
    $driver.find_element(css: "#password").send_keys string2
    $driver.find_element(css: ".fa.fa-2x.fa-sign-in").click
end

Then("User verify the message {string}") do |string|
    text = $driver.find_element(css: "#flash").text
    expect(text).to include(string)
    exit_browser()
end
