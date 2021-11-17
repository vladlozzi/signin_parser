require 'rspec'
require_relative 'signin_parser.rb'

describe SigninParse do

  before(:all) do
    @signin_parse = SigninParse.new
    @login = 'teacher_128'
    @password = 'teacher_128_pass'
  end

  it "should be signed in" do
    signed = @signin_parse.sign_in(@login, @password)
    expect(signed.class).to eq Capybara::Session
  end

  it "should be parse subjects" do
    parsed_items = @signin_parse.parse_subjects
    expect(parsed_items.size).to eq 69
    parsed_items.each do |item|
      expect(item).to match /^Дисципліна_.+/
    end
  end

  it "should be signed out" do
    signed_out = @signin_parse.sign_out
    expect(signed_out.class).to eq TrueClass
  end

  it "should be valid login and password" do
    signed = @signin_parse.sign_in('', '')
    expect(signed.class).to eq FalseClass
  end

end