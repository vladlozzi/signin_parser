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
      config.default_max_wait_time = 10 # seconds
      config.default_driver = :selenium
    end
    @browser = Capybara.current_session
    # driver = @browser.driver.browser
  end

  def sign_in(url = "", options = {})
    return false if (options.class.to_s != "Hash")
    return false if (
      url.class.to_s != "String" ||
      options[:login_field_name].class.to_s != "String" ||
      options[:login].class.to_s != "String" ||
      options[:password_field_name].class.to_s != "String" ||
      options[:password].class.to_s != "String" ||
      options[:submit_name].class.to_s != "String" ||
      options[:submit].class.to_s != "String"
    )
    return false if !(URI.parse(url).kind_of?(URI::HTTP))
    begin
      @browser.visit(url)
    rescue Selenium::WebDriver::Error::UnknownError # Any visit error
      return false
    end
    begin
      @browser.find_field(options[:login_field_name])
    rescue Capybara::ElementNotFound
      return false
    end
    begin
      @browser.find_field(options[:password_field_name])
    rescue Capybara::ElementNotFound
      return false
    end
    begin
      @browser.find_button(options[:submit_name])
    rescue Capybara::ElementNotFound
      return false
    end
    @browser.fill_in(options[:login_field_name], with: options[:login])
    @browser.fill_in(options[:password_field_name], with: options[:password])
    @browser.click_button(options[:submit])
  end

  def parse(class_to_parse = "", options = {})
    parsed_content = []
    begin
      @browser.choose(options[:radio_id])
    rescue Capybara::ElementNotFound
      return parsed_content
    end
    begin
      @browser.all(:css, '.' + class_to_parse).map do |el|
        parsed_content.push(el.text)
      end
    rescue Capybara::ElementNotFound
      return parsed_content
    end
    parsed_content
  end

  def sign_out(options = {})
    if options[:exit].class.to_s == "String"
      begin
        @browser.click_link(options[:exit])
      rescue Capybara::ElementNotFound
        false
      end
    else
      false
    end
  end

end