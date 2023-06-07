# This example sets up an endpoint using the Sinatra framework.
# Watch this video to get started: https://youtu.be/8aA9Enb8NVc.

require 'json'
require 'sinatra'
require 'stripe'
require 'httparty'

# Set your secret key. Remember to switch to your live secret key in production.
# See your keys here: https://dashboard.stripe.com/apikeys
# set :static, true
set :port, 4242

YOUR_DOMAIN = 'http://localhost:3000/success'
Stripe.api_key = 'sk_test_51MyqLjSI2D9QZHezmFOXiVtw4idzlxFMr5x9KDtvJxfoxkKtFkoRnoYBz1Lna3L6HGQ5vbTVobO9pp0NzfQkeuBy00MgMgIC3y'

#  code for to get all carts 
apiEndpointForcarts = 'https://api.us-central1.gcp.commercetools.com/99minds/carts'
apiendpointforcreatingcart='https://api.us-central1.gcp.commercetools.com/99minds/carts'
  #this is cart id

headers = {
  'Authorization' =>'Bearer ge-zWn63c4Jg3-MQGuBSvcwRXRvRX2NC'
  }

post '/create-checkout-session' do
  
  response = HTTParty.get(apiEndpointForcarts, headers: headers)
  pop=response.body

  ruby_hash = JSON.parse(pop)
  arrayoflineitems=ruby_hash['results'].last["lineItems"]
  arr2=[]
  for i in arrayoflineitems do
    arr2<<{price_data: {currency: 'usd',product_data: {name: i["name"]["en"],},
    unit_amount: if i.key?("discountedPrice")
    i["discountedPrice"]["value"]["centAmount"]
    else
    i["price"]["value"]["centAmount"] end,},quantity: i["quantity"],}
    puts(unit_amount: i["totalPrice"]["centAmount"])
  end
  session = Stripe::Checkout::Session.create({
    line_items: arr2,
    mode: 'payment',
    # These placeholder URLs will be replaced in a following step.
    success_url: YOUR_DOMAIN + '?success=true',
    cancel_url: YOUR_DOMAIN + '?canceled=true',
    
  })
  
  redirect session.url, 303
  
  puts(session,"chek this bro")
 
end