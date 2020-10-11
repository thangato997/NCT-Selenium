Given("user go to tiki page") do
  $driver.manage.window.maximize
  $driver.get "http://tiki.vn/"
end

When("user search and buy the products") do
  # số sản phẩm
  $product_number = "2"
  # tìm kiếm apple
  $driver.find_element(css: ".eUnWAD").send_keys "apple", :enter

  sleep 5
  # Chọn checkbox tikinow
  $driver.find_element(:css, "label.is-tikinow:nth-child(2)").click

  # xác nhận popup
  $driver.find_element(css: ".apply-btn").click

  # tìm element của các selectlist bằng find_elements
  options = $driver.find_elements(css: "select.form-control")

  # Chọn thành phố
  select_object = Selenium::WebDriver::Support::Select.new(options[0])
  $driver.manage.timeouts.implicit_wait = 2
  select_object.select_by(:text, "Hồ Chí Minh")

  # Chọn quận
  select_object = Selenium::WebDriver::Support::Select.new(options[1])
  $driver.manage.timeouts.implicit_wait = 2
  select_object.select_by(:text, "Quận 1")

  # Chọnp hường
  select_object = Selenium::WebDriver::Support::Select.new(options[2])
  $driver.manage.timeouts.implicit_wait = 2
  select_object.select_by(:text, "Phường Bến Nghé")

  # Click xác nhận
  $driver.find_element(css: ".apply-btn").click

  sleep 1
  # tìm tất cả các sản phảm được hiển thị trên site bằng find_elements thông qua title của sản phẩm
  products = $driver.find_elements(css: "p.title")
  # lấy title của sản phẩm bỏ và bỏ đi 3 dấu chấm ở cuối để verify title khi thêm vào giỏ hàng
  $product_title = products[4].text.delete("...")
  # chọn sản phẩm sô 5
  products[4].click

  $driver.manage.timeouts.implicit_wait = 10
  # verify title của sản phâm khi tìm kiếm và sau khi thêm vào giỏ hàng, nếu sai testcase sẽ dừng lại
  begin
    expect($driver.find_element(css: "h1.title").text).to include($product_title)
  rescue => exception
    puts exception.message
    Process.exit(0)
  end

  # làm rỗng field để thêm giá trị
  $driver.find_element(css: "input.input").send_keys :backspace
  # thêm số sản phẩm
  $driver.find_element(css: "input.input").send_keys $product_number
  # thêm vào giỏ hàng
  $driver.find_element(css: ".btn.btn-add-to-cart").click
end

Then("user check the products at cart") do
  $driver.manage.timeouts.implicit_wait = 5
  # di chuyển đến giỏ hàng
  $driver.find_element(css: ".dFYIFY").click

  $driver.manage.timeouts.implicit_wait = 5
  # lấy giá sản phẩm
  cost = $driver.find_element(css: ".cart-products__real-prices").text.delete(".").delete("đ")

  # lấy tổng tiền thanh toán
  total = $driver.find_element(css: ".prices__total").text.delete("(Đã bao gồm VAT nếu có)").delete(".").delete("đ").delete("Thành tiền")

  # lấy giá sản phẩm nhân với số sản phẩm, nếu khác với tống thanh toán sẽ báo lỗi và dừng testcase
  begin
    expect($product_number.to_i * cost.to_i).to eq(total.to_i)
  rescue => exception
    puts exception.message
    Process.exit(0)
  end
end
