require 'sinatra'
require 'sendgrid-ruby'
include SendGrid

get "/" do
  erb :home
end

get "/shop" do
  erb :shop
end


get "/contact" do
  erb :contact
end

get "/cakes" do
  erb :cakes

  class Cakes
    attr_accessor :url
    def initialize(price, description, url)
      @price = price
      @description = description
      @url = url
    end
  end

  @c1 = Cakes.new(18, 'Chocolate Silk Cake', "https://upload.wikimedia.org/wikipedia/commons/thumb/f/f1/2ChocolateChipCookies.jpg/1200px-2ChocolateChipCookies.jpg")
end

get "/cookies" do
  erb :cookies
end

get "/muffins" do
  erb :muffins
end


post "/email" do
  from = Email.new(email: params['email'])
  to = Email.new(email: 'ogidan@abv.bg')
  subject = params['subject']
  content = Content.new(type: 'text/plain', value: params['body'])
  mail = Mail.new(from, subject, to, content)
  puts subject
  sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
  response = sg.client.mail._('send').post(request_body: mail.to_json)
  puts response.status_code
  puts response.body
  puts response.headers

  redirect "/thanks"
end

get "/thanks" do

  erb :thanks
end
