def validate_params_exist
  raise "❌  ERROR: Missing param SERVER_URL." if ENV['SERVER_URL'].nil?
  raise "❌  ERROR: Missing param BROWSER." if ENV['BROWSER'].nil?
  if ENV['REPORT']
    raise "❌  ERROR: Missing param TESTSUITE." if ENV['TESTSUITE'].nil?
    raise "❌  ERROR: Missing param TESTCASE_REPORT_NAME." if ENV['TESTCASE_REPORT_NAME'].nil?
    $report_path = "Reports/#{ENV['TESTSUITE']}"
    $testcase_report_name = ENV['TESTCASE_REPORT_NAME']
  end
end

at_exit do
  # quite driver
  $driver.close()
  if ENV['REPORT']
    begin
      # validateReport
      time = Time.now.getutc
      ReportBuilder.configure do |config|
        config.report_path = "#{$report_path}/#{$testcase_report_name}"
        config.input_path = "#{$report_path}/#{$testcase_report_name}.json"
        config.report_types = [:json, :html]
        config.color = 'blue'
        config.additional_info = {
          'Browser' => $browser_type,
          'Platform' => $platform ,
          'OS Version' => $os_version,
          'Report Generated' => time
        }
      end
      options = { report_title: "INFODation - Test Management System" }
      ReportBuilder.build_report options
    rescue Exception => e
      puts e.message
      Process.exit( 0 )
    end
  end
end
