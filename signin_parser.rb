require 'uri'
require 'selenium-webdriver'
require 'capybara'

class SigninParse

  class VisitError < StandardError; end
  class SigninFailedError < StandardError; end

  URL = "https://catalogs.vladloz.pp.ua"
  ENTER = "Вхід"
  QUIT = "Вийти"

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
    @page = Capybara.current_session
  end

  def sign_in(login = "", password = "")
    return VisitError unless visit_ok?
    @page.fill_in('login', with: login)
    @page.fill_in('password', with: password)
    @page.click_button(ENTER)
    signed_in? ? @page : SigninFailedError
  end

  def parse_subjects
    @page.choose('depart_subj_spring')
    @page.all(:css, '.TeacherSubject').map do |elem|
      elem.text
    end
  end

  def sign_out
    @page.click_link(QUIT)
    signed_out?
  end

  private

  def visit_ok?
    begin
      @page.visit(URL)
      true
    rescue Selenium::WebDriver::Error::UnknownError # Any visit error
      false
    end
  end

  def signed_in?
    (@page.has_link?(QUIT) && @page.has_css?('#depart_subj_spring')) ? @page : false
  end

  def signed_out?
    @page.has_button?(ENTER)
  end

end