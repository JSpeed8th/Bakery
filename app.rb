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

  class Cake
    attr_accessor :name, :description, :price, :image
    def initialize(name, description, price, image)
      @name = name
      @description = description
      @price = price
      @image = image
    end
  end

  @cake_array = []

  def class_push(name, description, price, image)
    @new_cake = Cake.new(name, description, price, image)
    @cake_array.push(@new_cake)
  end

  class_push('Charlotte Royale', 'A charlotte is a type of dessert or trifle that can be served hot or cold. It is also referred to as an "icebox cake". Bread, sponge cake or biscuits/cookies are used to line a mold, which is then filled with a fruit puree or custard.', '30.00', '../../img/cakeImages/charlotteRoyale.jpg')

  class_push('Tiramisu Cake', 'Made of a tender vanilla cake soaked with coffee syrup, topped with creamy mascarpone frosting, and dusted with cocoa powder. Just like classic tiramisu in cake form!', '30.00', '../../img/cakeImages/tiramisuCake.png')

  class_push('Hazelnut Dacquoise', 'French dessert of layers of hazelnut meringue, hazelnut praline, chocolate ganache and a coffee custard filling.', '40.00', '../../img/cakeImages/hazelnutDacquoise.jpg')

  class_push('Prinsesstårta', 'A princess cake is a traditional Swedish layer cake or torte consisting of alternating layers of airy sponge cake, jam, pastry cream, and a thick-domed layer of whipped cream. This is topped by marzipan, giving the cake a smooth rounded top.', '60.00', '../../img/cakeImages/prinsesstarta.png')

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
