require 'json'
require 'httparty'
apiEndpointForcarts = 'https://api.us-central1.gcp.commercetools.com/obongg26te1hxzh/carts'
headers = {
    'Authorization' =>'Bearer JJTvx3YvE8lxwwFvL473JALia52Mw-0W'
    }
    response = HTTParty.get(apiEndpointForcarts, headers: headers)
  pop=response.body
  ruby_hash = JSON.parse(pop)
  arrayoflineitems=ruby_hash['results'].last["lineItems"]
  puts(arrayoflineitems)