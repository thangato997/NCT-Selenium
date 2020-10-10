Given("user navigate to the tiki page") do
    $driver.get "https://tiki.vn/"
end

When("user enter {string}") do |string|
    $driver.find_element(css: ".eUnWAD").send_keys string, :enter
end

Then("user verify the {int} of products") do |int|
    # use implicit_wait to wait for the page to load
    $driver.manage.timeouts.implicit_wait = 10
    # use find_elements by css via class4
    sleep 1
    elements = $driver.find_elements(css: ".search-a-product-item")
    # get total of products by getting size of the value elements 
    count = elements.size
    # confirm the count is correct or not
    expect(count).to eql(int)
    # print to the screen
    puts count.to_s + " products are counted"
end