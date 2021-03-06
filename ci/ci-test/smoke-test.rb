require 'rspec'
require 'watir'
require 'openssl'

include RSpec::Matchers

ENV['http_proxy'] = ENV['HTTP_PROXY'] = nil
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

prefs = {
  'download' => {
    'prompt_for_download' => false,
    'directory_directory' => false
  },
  'profile' => {
    'default_content_setting_values' => { 'automatic_downloads' => 1 }
  }
}

begin
  selenium_host = ENV['SELENIUM-GRID-HOST']
  browser = Watir::Browser.new :firefox, url: "#{selenium_host}/wd/hub" , options: { prefs: prefs, options: { 'useAutomationExtension' => false } }
  browser.window.maximize
  puts "browser launched"
  # launch and run test
  browser.goto 'https://stark-castle-29113.herokuapp.com/'
  sleep 5
  expect(browser.body.text).to eq('Hello World! - Deployed')
  puts "test completed - passed"
rescue RSpec::Expectations::ExpectationNotMetError => e
  puts "Test failed"
  puts "#{e.message}"
  return 1
ensure
  browser.close unless browser.nil?
end


