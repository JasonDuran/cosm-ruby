require "net/http"
require "uri"

uri = URI.parse("http://api.cosm.com/v2/feeds/YOUR_FEED_ID")
uri = URI.parse("http://api.cosm.com/v2/feeds/6643")
http = Net::HTTP.new(uri.host, uri.port)

request = Net::HTTP::Get.new(uri.request_uri)
request["X-ApiKey"] = "YOUR_API_KEY_HERE"
request["X-ApiKey"] = "7fOn_xBHvPhrs0ZBkdau6GV2L_KSAKxzYlQyZHBPRUFtMD0g"

response = http.request(request)

puts response.code
puts response.body