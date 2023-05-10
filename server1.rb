require 'sinatra'
require 'stripe'
# This is your test secret API key.
Stripe.api_key = 'sk_test_51MyqLjSI2D9QZHezmFOXiVtw4idzlxFMr5x9KDtvJxfoxkKtFkoRnoYBz1Lna3L6HGQ5vbTVobO9pp0NzfQkeuBy00MgMgIC3y'

set :static, true
set :port, 4242

# Securely calculate the order amount
def calculate_order_amount(_items)
  # Replace this constant with a calculation of the order's amount
  # Calculate the order total on the server to prevent
  # people from directly manipulating the amount on the client
  14000
end

# An endpoint to start the payment process
post '/create-payment-intent' do
  content_type 'application/json'
  data = JSON.parse(request.body.read)
  puts("data is here budd*****************",data) #{"items"=>[{"id"=>"xl-tshirt"}]}

  # Create a PaymentIntent with amount and currency
  payment_intent = Stripe::PaymentIntent.create(
    amount: calculate_order_amount(data['items']),
    currency: 'inr',
    automatic_payment_methods: {
      enabled: true,
    },
  )
puts("payment_intent is here////////////////" ,payment_intent)
  {
    clientSecret: payment_intent['client_secret']
  }.to_json
end