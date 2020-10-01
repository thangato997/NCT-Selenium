require "selenium-webdriver"

$value = "book"

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
        # use implicit_wait to wait the page is loaded
        @driver.manage.timeouts.implicit_wait = 10
        # use find_elements by css via class
        elements = @driver.find_elements(css: ".search-a-product-item")
        # get total of products by get size of value elements 
        count = elements.size
        puts ("Có " + count.to_s + " sản phầm được hiển thị")
    end
end