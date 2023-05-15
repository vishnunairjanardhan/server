require 'json'
require 'httparty'
apiEndpointForcarts = 'https://api.us-central1.gcp.commercetools.com/obongg26te1hxzh/carts'
headers = {
    'Authorization' =>'Bearer gyqgh-0_yw9R1_5ipE3hV7WzdtpicUfA'
    }
    response = HTTParty.get(apiEndpointForcarts, headers: headers)
  pop=response.body
  ruby_hash = JSON.parse(pop)
  arrayoflineitems=ruby_hash['results'][16]["lineItems"]
  puts(arrayoflineitems)