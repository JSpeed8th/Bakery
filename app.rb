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
