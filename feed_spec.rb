require "./feed.rb"
require "rspec"


describe Feed do

  before :all do
    @json_string = File.open(File.join('spec', 'fixtures', '49679.json')).read
    @current_feed = Feed.new(@json_string)
  end

  context "can parse any particular datastream from a feed" do

    it "and provide the tag array" do
      @current_feed.tags_array_for_datastream(1).should == ["Rental"]
    end

    it "and provide the current value" do
      @current_feed.current_value_for_datastream(1).should == "123"
    end

    it "and provide the unit label" do
      @current_feed.unit_label_for_datastream(1).should == "W"
    end
  end

  context "can take an array of feeds and create a timeseries from a datastream" do
    before do
      @low_value_json_string = File.open(File.join('spec', 'fixtures', '49679_rental_low_value.json')).read
      @peak_value_json_string = File.open(File.join('spec', 'fixtures', '49679_rental_peak_value.json')).read
      @plateau_value_json_string = File.open(File.join('spec', 'fixtures', '49679_rental_plateau_value.json')).read
      @feeds = [Feed.new(@low_value_json_string),
                Feed.new(@low_value_json_string),
                Feed.new(@low_value_json_string),
                Feed.new(@peak_value_json_string),
                Feed.new(@plateau_value_json_string),
                Feed.new(@low_value_json_string)]
    end
    it "specified by number" do
      datastream = 1
      Feed.time_series(@feeds, datastream).should == ["12", "12", "12", "137", "122", "12"]
    end

    it "specified by a string" do
      Feed.time_series(@feeds, "Rental").should == ["12", "12", "12", "137", "122", "12"]
    end

  end


end
