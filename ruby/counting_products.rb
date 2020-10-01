require "selenium-webdriver"

$value = "book"
$products = 52

describe "Count Products that were displayed" do
    before(:all) do
        @driver = Selenium::WebDriver.for :chrome
    end

    before(:each) do
        @driver.get "https://tiki.vn/"
    end

    after(:all) do
        @driver.close
    end
    it "count the books were displayed" do
        @driver.find_element(css: ".eUnWAD").send_keys $value, :enter
        # use implicit_wait to wait for the page to load
        @driver.manage.timeouts.implicit_wait = 10
        # use find_elements by css via class
        elements = @driver.find_elements(css: ".search-a-product-item")
        # get total of products by getting size of the value elements 
        count = elements.size
        # confirm the count is correct or not
        expect(count).to eql($products)
        # print to the screen
        puts count.to_s + " products are counted"
    end
end