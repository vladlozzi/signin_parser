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
      options[:login].class.to_s != "String" ||
      options[:password].class.to_s != "String" ||
      options[:login_field_name].class.to_s != "String" ||
      options[:password_field_name].class.to_s != "String" ||
      options[:submit_name].class.to_s != "String" ||
      options[:submit].class.to_s != "String"
    )
    return false if !(URI.parse(url).kind_of?(URI::HTTP))

    @browser.visit(url)
    @browser.fill_in(options[:login_field_name], with: options[:login])
    @browser.fill_in(options[:password_field_name], with: options[:password])
    @browser.click_button(options[:submit])
  end

  def parse(class_to_parse = "", options = {})
    @browser.choose(options[:radio_id])
    parsed_content = []
    @browser.all(:css, '.' + class_to_parse).map do |el|
      parsed_content.push(el.text)
    end
    parsed_content
  end
end
