require 'rspec'
require_relative 'signin_parser.rb'

describe SigninParse do
  before(:each) do
    @signin_parse = SigninParse.new
    @url = 'https://catalogs.vladloz.pp.ua'
    @sign_options = Hash.new
    @sign_options[:login_field_name] = 'login'
    @sign_options[:login] = 'teacher_128'
    @sign_options[:password_field_name] = 'psswd'
    @sign_options[:password] = 'teacher_128_pass'
    @sign_options[:submit_name] = 'enter'
    @sign_options[:submit] = 'Вхід'

    @parse_options = Hash.new
    @parse_options[:radio_id] = 'depart_subj_spring'

    @exit_options = Hash.new
    @exit_options[:exit] = 'Вийти'
  end

  it "should be SigninParse class" do
    expect(@signin_parse.class).to eq SigninParse
  end

  it "should be signed in, parsed and signed_out" do
    signed = @signin_parse.sign_in(@url, @sign_options)
    expect(signed.class).to eq Capybara::Node::Element
    expect(signed.to_s.downcase).to match /^#<capybara::node::element:0x?[0-9a-f]{16}>$/
    parsed_items = @signin_parse.parse("TeacherSubject", @parse_options)
    expect(parsed_items.size).to eq 69
    signed_out = @signin_parse.sign_out(@exit_options)
    expect(signed_out.class).to eq Capybara::Node::Element
  end

  it "should be valid url" do
    url = ""
    signed = @signin_parse.sign_in(url, @sign_options)
    expect(signed.class).to eq FalseClass
    url = "/"
    signed = @signin_parse.sign_in(url, @sign_options)
    expect(signed.class).to eq FalseClass
    url = "catalogs.vladloz.pp.ua"
    signed = @signin_parse.sign_in(url, @sign_options)
    expect(signed.class).to eq FalseClass
    url = "xxx://catalogs.vladloz.pp.ua"
    signed = @signin_parse.sign_in(url, @sign_options)
    expect(signed.class).to eq FalseClass
    url = "http://example.com" # Required fields don't exists on website
    signed = @signin_parse.sign_in(url, @sign_options)
    expect(signed.class).to eq FalseClass
    url = "http://xxx.vladloz.pp.ua" # Required website don't exists
    signed = @signin_parse.sign_in(url, @sign_options)
    expect(signed.class).to eq FalseClass
  end

  it "should be valid login and password" do
    sign_options = @sign_options
    sign_options[:login] = ''
    sign_options[:password] = ''
    signed = @signin_parse.sign_in(@url, sign_options)
    expect(signed.class).to eq Capybara::Node::Element
  end

  it "should be valid field names" do
    sign_options = @sign_options
    sign_options[:login_field_name] = 'field_login'
    sign_options[:password_field_name] = 'field_password'
    signed = @signin_parse.sign_in(@url, sign_options)
    expect(signed.class).to eq FalseClass
  end

  it "should be valid submit name" do
    sign_options = @sign_options
    sign_options[:submit_name] = 'Exit'
    signed = @signin_parse.sign_in(@url, sign_options)
    expect(signed.class).to eq FalseClass
  end

  it "should be signed in, radio not found and signed out" do
    @signin_parse.sign_in @url, @sign_options
    parse_options = Hash.new
    parse_options[:select] = "depart_subj_spring"
    parsed_items = @signin_parse.parse("Teacher", parse_options)
    expect(parsed_items.size).to eq 0
    signed_out = @signin_parse.sign_out(@exit_options)
    expect(signed_out.class).to eq Capybara::Node::Element
  end

  it "should be signed in, class to parse not found and signed out" do
    @signin_parse.sign_in @url, @sign_options
    parsed_items = @signin_parse.parse("Teacher", @parse_options)
    expect(parsed_items.size).to eq 0
    signed_out = @signin_parse.sign_out(@exit_options)
    expect(signed_out.class).to eq Capybara::Node::Element
  end

  it "should be signed in, exit link not found" do
    @signin_parse.sign_in @url, @sign_options
    exit_options = Hash.new
    signed_out = @signin_parse.sign_out(exit_options)
    expect(signed_out.class).to eq FalseClass
    exit_options[:exit] = ''
    signed_out = @signin_parse.sign_out(exit_options)
    expect(signed_out.class).to eq FalseClass
    exit_options[:exit] = 'Exit'
    signed_out = @signin_parse.sign_out(exit_options)
    expect(signed_out.class).to eq FalseClass
  end

end