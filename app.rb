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

class Bake
  attr_accessor :name, :description, :price, :image
  def initialize(name, description, price, image)
    @name = name
    @description = description
    @price = price
    @image = image
  end
end


get "/cakes" do

  @cake_array = []

  def class_push(name, description, price, image)
    @new_cake = Bake.new(name, description, price, image)
    @cake_array.push(@new_cake)
  end

  class_push('Charlotte Royale', 'A charlotte is a type of dessert or trifle that can be served hot or cold. It is also referred to as an "icebox cake". Bread, sponge cake or biscuits/cookies are used to line a mold, which is then filled with a fruit puree or custard.', '30.00', '../../img/cakeImages/charlotteRoyale.jpg')

  class_push('Tiramisu Cake', 'Made of a tender vanilla cake soaked with coffee syrup, topped with creamy mascarpone frosting, and dusted with cocoa powder. Just like classic tiramisu in cake form!', '30.00', '../../img/cakeImages/tiramisuCake.png')

  class_push('Hazelnut Dacquoise', 'French dessert of layers of hazelnut meringue, hazelnut praline, chocolate ganache and a coffee custard filling.', '40.00', '../../img/cakeImages/hazelnutDacquoise.jpg')

  class_push('Prinsesstårta', 'A princess cake is a traditional Swedish layer cake or torte consisting of alternating layers of airy sponge cake, jam, pastry cream, and a thick-domed layer of whipped cream. This is topped by marzipan, giving the cake a smooth rounded top.', '60.00', '../../img/cakeImages/prinsesstarta.png')

    erb :cakes
end

get "/cookies" do

  @cookie_array = Array.new

  def class_push(name, description, price, image)
    @new_cookie = Bake.new(name, description, price, image)
    @cookie_array.push(@new_cookie)
  end

  class_push('Chocolate Chunk', 'This tasty favorite is packed with chunks of rich, soft chocolate that melts in your mouth.', '3.00', '../../img/cookieImages/chocoChunk.jpg')

  class_push('Double Chocolate Chunk', 'This cookie is double the fun with chunks of smooth chocolate inside a moist chocolate cookie.', '3.00', '../../img/cookieImages/doubleChoco.jpg')

  class_push('Chocolate Peanut Butter Cup', "This colossal treat is Loaded with chunks of Reese's peanut butter cups and baked into a peanut butter cookie.", '3.00', '../../img/cookieImages/chocoPeanut.jpg')

  class_push('Double Chocolate Mint', "Our delicious chocolate cookie baked with rich chocolate chunks and mint chocolate chips.", '3.00', '../../img/cookieImages/mintChoco.jpg')

  erb :cookies
end

get "/muffins" do

  @muffin_array = Array.new

  def class_push(name, description, price, image)
    @new_muffin = Bake.new(name, description, price, image)
    @muffin_array.push(@new_muffin)
  end

  class_push('Chocolate Chunk', 'This tasty favorite is packed with chunks of rich, soft chocolate that melts in your mouth.', '3.00', '../../img/muffinImages/blueberryMuffin.jpg')

  class_push('Double Chocolate Chunk', 'This cookie is double the fun with chunks of smooth chocolate inside a moist chocolate cookie.', '3.00', '../../img/muffinImages/chocoMuffin.jpg')

  class_push('Chocolate Peanut Butter Cup', "This colossal treat is Loaded with chunks of Reese's peanut butter cups and baked into a peanut butter cookie.", '3.00', '../../img/muffinImages/pecanPieMuffin.jpg')

  class_push('Double Chocolate Mint', "Our delicious chocolate cookie baked with rich chocolate chunks and mint chocolate chips.", '3.00', '../../img/muffinImages/pumpkinMuffin.jpg')

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

get "/aboutus" do

  erb :aboutus
end
