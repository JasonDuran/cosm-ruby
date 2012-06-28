require "./cosm_parser.rb"

class Feed

  def initialize(input)
    case input
      when String
        @feed_object = CosmParser.convert_json_to_ruby_object(input)
      when Hash
        @feed_object = input
    end
  end

  def tags_array_for_datastream(stream_number)
    @feed_object["datastreams"][stream_number]["tags"]
  end


  def current_value_for_datastream(stream_number)
    @feed_object["datastreams"][stream_number]["current_value"]
  end

  def unit_label_for_datastream(stream_number)
    @feed_object["datastreams"][stream_number]["unit"]["label"]
  end

  def datastream_number_from_string(tag)
    tag_hash = Hash.new
    @feed_object["datastreams"].each_index do |index|
      tags = self. tags_array_for_datastream(index)
      tags.each { |tag| tag_hash[tag] = index }
    end
    tag_hash[tag]
  end

  def self.time_series(feeds_array, datastream)
    if datastream.is_a?(Integer)
      feeds_array.collect { |feed| feed.current_value_for_datastream(datastream) }
    else
      datastream = feeds_array[0].datastream_number_from_string(datastream)
      feeds_array.collect { |feed| feed.current_value_for_datastream(datastream) }
    end

  end

end