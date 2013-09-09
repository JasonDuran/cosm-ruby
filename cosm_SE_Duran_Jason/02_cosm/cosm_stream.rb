$: << 'lib' << '../lib'
require 'rubygems'
require 'eventmachine'
require 'pachube-stream'

require './feed.rb'

#Code from https://github.com/carboncalculated/pachube-stream/blob/master/examples/subscribe.rb

EM.run do                
  connection = PachubeStream::Connection.connect(:api_key => ENV["PACHUBE_API_KEY"])

  connection.on_reconnect do |timeout, reconnect_retries|
    puts timeout
    puts reconnect_retries
  end
  
  connection.on_max_reconnects do |timeout, reconnect_retries|
    puts timeout
    puts reconnect_retries
  end
  
  feed = connection.subscribe("/feeds/6643") # random Feed  
  
  feed.on_datastream do |response|
    puts "on_datastream"
    puts response
    current_value = Feed.new(response["body"]).current_value_for_datastream(1)
    puts "current value: " + current_value
  end
  
  feed.on_complete do |response|
    puts "on complete"
    puts response
  end
  
  feed.on_error do |response|
    puts response
  end
end