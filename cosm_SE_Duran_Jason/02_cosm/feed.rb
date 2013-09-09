require "./cosm_parser.rb"
require "json"

class Feed

  attr_accessor :datastreams

  def initialize(input)
    case input
      when String
	json = JSON.parse(input)
        @datastreams = json['datastreams']
      when Hash
	@datastreams = json['datastreams']
      else
        raise "Invalid input data type pass to Feed initialize"
    end
  end

  def tags_array_for_datastream(index)
    #Preconditions
    #1. index can not be nil
    if index == nil   
      raise "Feed.tags_array_for_datastream(index) can not be null"
    end

    #2. Must be an Integer
    if !index == Integer
      raise "Feed.tags_array_for_datastream(index) must be passed an integer"
    end

    #3. index must >= 0 
    if index < 0
      raise "Feed.tags_array_for_datastream index must be >= 0"
    end

    #4. Length < index 
    if @datastreams.length <= index
      raise "Feed.tags_array_for_datastream(index) @datastreams.length > index"
    end

    if !@datastreams[index] == Hash
	raise "Invalid data struct stored in hash"
    end

    #Main. Return the tag name will return nil if tags not a key in the hash
    @datastreams[index]['tags']

  end

  def current_value_for_datastream(index)
    #Preconditions
    #1. index can not be nil
    if index == nil   
      raise "Feed.current_value_for_datastream(index) can not be null"
    end

    #2. Must be an Integer
    if !index == Integer
      raise "Feed.current_value_for_datastream(index) must be passed an integer"
    end

    #3. index must >= 0 
    if index < 0
      raise "Feed.current_value_for_datastream index must be >= 0"
    end

    #4. Length < index 
    if @datastreams.length <= index
      raise "Feed.current_value_for_datastream(index) @datastreams.length > index"
    end

    #Main. Return the current value will return nil if 'current_value' not a key in the hash
    @datastreams[index]['current_value']
  end

  def unit_label_for_datastream(index)
    #Preconditions
    #1. index can not be nil
    if index == nil   
      raise "Feed.current_value_for_datastream(index) can not be null"
    end

    #2. Must be an Integer
    if !index == Integer
      raise "Feed.current_value_for_datastream(index) must be passed an integer"
    end

    #3. index must >= 0 
    if index < 0
      raise "Feed.current_value_for_datastream index must be >= 0"
    end

    #4. Length < index 
    if @datastreams.length <= index
      raise "Feed.current_value_for_datastream(index) @datastreams.length > index"
    end

    #5. @datastreams[index] must return a hash
    if !@datastreams[index] == Hash
      raise "Feed.current_value_for_datastream(index) @datastreams[index] Must return a Hash."
    end

    #Main. Will return nil if ['label'] not a key in the hash
    @datastreams[index]['unit']['label']
  end

  def self.time_series(feeds, index)
    #Preconditions
    #1. Feeds must be an array
    if !feeds == Array
      raise "self.time_series(feeds, index) - feeds must be an array"
    end

    data = []
    case index
     when Integer
      #Highly likely that there will be a chronological enforcement of any time series
      #sorted = feeds.sort_by {|k| k.datastreams[index]['at']}
      #sorted.each do |stream|
      feeds.each do |stream|
        data.push(stream.current_value_for_datastream(index))
      end
    when String
      feeds.each do |stream|
        stream.datastreams.each do |source|
          if source['tags'] == [index]
            data.push(source['current_value'])                
          end
        end
      end
    end
    data
  end

end
