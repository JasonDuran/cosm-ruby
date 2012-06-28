require "net/http"
require "uri"
require 'json'

class CosmParser

  def self.get_feed(feed_number)
    uri = URI.parse("http://api.cosm.com/v2/feeds/" +feed_number)
    http = Net::HTTP.new(uri.host, uri.port)

    request = Net::HTTP::Get.new(uri.request_uri)
    request["X-ApiKey"] = "7fOn_xBHvPhrs0ZBkdau6GV2L_KSAKxzYlQyZHBPRUFtMD0g"

    http.request(request).body
  end


  def self.convert_json_to_ruby_object(json_string)
    JSON(json_string)
  end


end

