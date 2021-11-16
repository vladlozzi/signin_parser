require 'rspec'
require_relative 'signin_parser.rb'

describe SigninParse do
  before(:each) do
    @signin_parse = SigninParse.new
    @url = 'https://catalogs.vladloz.pp.ua'
    @login = 'teacher_128'
    @password = 'teacher_128_pass'
    @enter = "Вхід"
    @quit = "Вийти"
  end

  it "should be signed in and sign out" do
    signed = @signin_parse.sign_in(@url, @login, @password, @enter)
    expect(signed.class).to eq Capybara::Session
    expect(signed.find('a', text: @quit).class).to eq Capybara::Node::Element
    @signin_parse.sign_out(@quit)
    expect(signed.find_button(@enter).class).to eq Capybara::Node::Element
  end

  it "should be valid login and password" do
    signed = @signin_parse.sign_in(@url, '', '', @enter)
    begin
      quit_found = signed.find('a', text: @quit)
    rescue Capybara::ElementNotFound
      quit_found = false
    end
    expect(quit_found.class).to eq FalseClass
  end

  it "should be parsed subjects" do
    @signin_parse.sign_in(@url, @login, @password, @enter)
    parsed_items = @signin_parse.parse
    expect(parsed_items.size).to eq 69
    parsed_items.each do |item|
      expect(item).to match /^Дисципліна_.+/
    end
    @signin_parse.sign_out(@quit)
  end

end