require 'rspec'
require_relative 'signin_parser.rb'

describe SigninParse do
  before(:each) do
    @signin_parse = SigninParse.new
    @url = 'https://catalogs.vladloz.pp.ua'
    @login = 'teacher_128'
    @password = 'teacher_128_pass'
    @enter = "Вхід"
    @radio = 'depart_subj_spring'
    @quit = "Вийти"
  end

  it "should be signed in, parsed and signed_out" do
    signed = @signin_parse.sign_in(@url, @login, @password, @enter)
    expect(signed.class).to eq Capybara::Node::Element
    parsed_items = @signin_parse.parse("TeacherSubject", @radio)
    expect(parsed_items.size).to eq 69
    parsed_items.each do |item|
      expect(item).to match /^Дисципліна_.+/
    end
    @signin_parse.sign_out(@quit)
  end

  it "should be valid login and password" do
    signed = @signin_parse.sign_in(@url, '', '', @enter)
    expect(signed.class).to eq Capybara::Node::Element
  end

end