require 'uri'
require 'selenium-webdriver'
require 'capybara'

class SigninParse
  def initialize
    super
    # Configurations
    Capybara.register_driver :selenium do |app|
      Capybara::Selenium::Driver.new(app, browser: :chrome)
    end
    Capybara.javascript_driver = :chrome
    Capybara.configure do |config|
      config.default_max_wait_time = 15 # seconds
      config.default_driver = :selenium
    end
    @browser = Capybara.current_session
  end

  def sign_in(url = "", login = "", password = "", enter = "")
    begin
      @browser.visit(url)
    rescue Selenium::WebDriver::Error::UnknownError # Any visit error
      return false
    end
    @browser.fill_in('login', with: login)
    @browser.fill_in('password', with: password)
    @browser.click_button(enter)
    @browser
  end

  def parse(**options)
    @browser.choose(options[:radio])
    @browser.all(:css, '.' + options[:class_to_parse]).map do |elem|
      elem.text
    end
  end

  def sign_out(quit = "")
    @browser.click_link(quit)
  end
end q