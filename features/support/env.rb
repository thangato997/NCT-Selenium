require "rubygems"
require "httparty"
require "cucumber"
require "report_builder"
require "selenium-webdriver"
# require "webdrivers"
require "itms_automation"

$browser_type = ENV["BROWSER"] || "firefox"
$platform = ENV["PLATFORM"] || "desktop"
$os_version = ENV["OS_VERSION"]
$device_name = ENV["DEVICE_NAME"]
$udid = ENV["UDID"]
$app_path = ENV["APP_PATH"]

# check for valid parameters
validate_parameters $platform, $browser_type, $app_path

# If platform is android or ios create driver instance for mobile browser
if $platform == "android" or $platform == "iOS"
  if $browser_type == "native"
    $browser_type = "Browser"
  end

  if $platform == "android"
    $device_name, $os_version = get_device_info
  end

  # desired_caps = {
  #   caps:       {
  #     platformName: $platform,
  #     browserName: $browser_type,
  #     versionNumber: $os_version,
  #     deviceName: $device_name,
  #     udid: $udid,
  #     app: ".//#{$app_path}"
  #     }
  #   }
  #   appium_url = 'http://localhost:4723/wd/hub'
  #   opts = {
  #   desired_capabilities: { # or { caps: {....} }
  #     platformName: :android,
  #     deviceName: 'Android Simulator',
  #     app: "WikipediaSample.apk"
  #   },
  #   appium_lib: {
  #     wait: 30
  #   }
  # }

  opts = {
    desired_capabilities: { # or { caps: {....} }
      platformName: $platform,
      browserName: $browser_type,
      deviceName: $device_name,
      versionNumber: $os_version,
      app: "WikipediaSample.apk",
    },
    appium_lib: {
      wait: 30,
    },
  }

  begin
    # $driver = Appium::Driver.new(desired_caps, url: appium_url).start_driver

    # $driver = Selenium::WebDriver.for(:remote, :url => appium_url, :desired_capabilities => desired_caps)
    @core = Appium::Core.for(opts) # create a core driver with `opts`
    $driver = @core.start_driver
  rescue Exception => e
    puts e.message
    Process.exit(0)
  end
else # else create driver instance for desktop browser
  begin
    $driver = case $browser_type
      when "chrome"
        Selenium::WebDriver.for(:chrome)
      when "safari"
        Selenium::WebDriver.for(:safari)
      when "internet_explorer"
        Selenium::WebDriver.for(:internet_explorer)
      when "chrome_headless"
        Selenium::WebDriver.for(:chrome, :desired_capabilities => Selenium::WebDriver::Remote::Capabilities.chrome(chromeOptions: { args: %w(headless) }))
      when "remote"
        if ENV["SERVER_URL"].nil? || ENV["REMOTE_BROWSER"].nil?
          puts "\nMissing SERVER_URL : SERVER_URL=http://SERVER_URL:4444/wd/hub"
          puts "\nMissing REMOTE_BROWSER: REMOTE_BROWSER=browser_name"
          Process.exit(0)
        else
          caps = Selenium::WebDriver::Remote::Capabilities.new
          caps["browserName"] = ENV["REMOTE_BROWSER"]
          caps["enableVNC"] = !ENV["ENABLE_VNC"].nil? && ENV["ENABLE_VNC"] == "true"
          caps["enableVideo"] = !ENV["ENABLE_VIDEO"].nil? && ENV["ENABLE_VIDEO"] == "true"
          caps["screenResolution"] = ENV["SCREEN_RESOLUTION"] unless ENV["SCREEN_RESOLUTION"].nil?
          caps["projectId"] = ENV["PROJECT_ID"] unless ENV["PROJECT_ID"].nil?
          caps["issueId"] = ENV["ISSUE_ID"] unless ENV["ISSUE_ID"].nil?
          Selenium::WebDriver.for(:remote, :url => ENV["SERVER_URL"], :desired_capabilities => caps)
        end
      else
        Selenium::WebDriver.for(:firefox)
      end
    $driver.manage().window().maximize()
  rescue Exception => e
    puts e.message
    Process.exit(0)
  end
end
