require "net/http"
require "uri"
require 'json'

class CosmParser

  def self.get_feed(string)
    #preconditions
    #1. Ensure String is not empty
    if !string.kind_of? String
      raise "Get Feed needs a string file name"
    end

    filename = File.join('spec','fixtures', string + '.json')

    #2. Ensure file exists
    if !File.exists?(filename)
      return "File Not Found " + filename
    end

    #Main Operation
    json_string = File.open(filename).read

    #post conditions
    if json_string.length < 1
      raise "Bad File {" + json_string + "}"
    end

    json_string
  end

  def self.convert_json_to_ruby_object(input)
    #Preconditions
    #1. input can not be nil
    if input == nil   
      raise "convert_json_to_ruby_object(input) - input can not be null"
    end

    #2. Ensure String is not empty
    if !input.kind_of? String
      raise "Inut needs to be a string"
    end

    #Main
    begin
      json = JSON.parse(input)
    rescue JSON::ParserError
      return nil #Do not fail on error but return nil
    end

    return json
  end

end

