require "./cosm_parser.rb"
require "rspec"
require "fake_web"
require 'json'


# Hint to use the json gem then
#    parsed_json = JSON(your_json_string)
#
#

describe CosmParser do

  before :all do
    FakeWeb.allow_net_connect = false
    @json_string = File.open(File.join('spec','fixtures','49679.json')).read
  end

  it "connects to COSM to retrieve a datapoint as a json string" do
    @url = "http://api.cosm.com/v2/feeds/49679"
    json_string = File.open(File.join('spec','fixtures','49679.json')).read
    FakeWeb.register_uri(:get, @url, :body => json_string ,  :content_type => "application/json")
    FakeWeb.register_uri(:get, @url + ".json", :body => json_string ,  :content_type => "application/json")
    response = CosmParser.get_feed("49679")
    response.should == json_string
  end

  # convert_json_to_object
  # Input:
  #   {"title":"House","status":"live","creator":"https://cosm.com/users/kaneohe1450","datastreams":[{"at":"2012-06-21T22:23:27.725649Z","tags":["Mains"],"unit":{"type":"derivedSI","label":"W"},"max_value":"16958.0","current_value":"820","id":"0","min_value":"0.0"},{"at":"2012-06-21T22:23:27.725649Z","tags":["Rental"],"unit":{"type":"derivedSI","label":"W"},"max_value":"12428.0","current_value":"123","id":"1","min_value":"0.0"},{"at":"2012-06-21T22:23:27.725649Z","tags":["Office"],"unit":{"type":"derivedSI","label":"W"},"max_value":"638.0","current_value":"315","id":"2","min_value":"0.0"},{"at":"2012-06-21T22:23:27.725649Z","tags":["Refrig"],"unit":{"type":"derivedSI","label":"W"},"max_value":"838.0","current_value":"74","id":"3","min_value":"0.0"},{"at":"2012-06-21T22:23:27.725649Z","tags":["Freezer"],"unit":{"type":"derivedSI","label":"W"},"max_value":"2530.0","current_value":"140","id":"4","min_value":"0.0"},{"at":"2012-06-21T22:23:27.725649Z","tags":["M Bedroom"],"unit":{"type":"derivedSI","label":"W"},"max_value":"1444.0","current_value":"40","id":"5","min_value":"0.0"},{"at":"2012-06-21T22:23:27.725649Z","tags":["Water Heater"],"unit":{"type":"derivedSI","label":"W"},"max_value":"5189.0","current_value":"0","id":"6","min_value":"0.0"}],"location":{"domain":"physical","lat":20.632784250388,"lon":-158.203125},"created":"2012-02-25T03:26:13.453958Z","feed":"https://api.cosm.com/v2/feeds/49679.json","private":"false","id":49679,"version":"1.0.0","updated":"2012-06-21T22:23:27.754273Z"}
  # Output:
  #  {"title"=>"House", "status"=>"live", "creator"=>"https://cosm.com/users/kaneohe1450", "datastreams"=>[{"at"=>"2012-06-21T22:23:27.725649Z", "tags"=>["Mains"], "unit"=>{"type"=>"derivedSI", "label"=>"W"}, "max_value"=>"16958.0", "current_value"=>"820", "id"=>"0", "min_value"=>"0.0"}, {"at"=>"2012-06-21T22:23:27.725649Z", "tags"=>["Rental"], "unit"=>{"type"=>"derivedSI", "label"=>"W"}, "max_value"=>"12428.0", "current_value"=>"123", "id"=>"1", "min_value"=>"0.0"}, {"at"=>"2012-06-21T22:23:27.725649Z", "tags"=>["Office"], "unit"=>{"type"=>"derivedSI", "label"=>"W"}, "max_value"=>"638.0", "current_value"=>"315", "id"=>"2", "min_value"=>"0.0"}, {"at"=>"2012-06-21T22:23:27.725649Z", "tags"=>["Refrig"], "unit"=>{"type"=>"derivedSI", "label"=>"W"}, "max_value"=>"838.0", "current_value"=>"74", "id"=>"3", "min_value"=>"0.0"}, {"at"=>"2012-06-21T22:23:27.725649Z", "tags"=>["Freezer"], "unit"=>{"type"=>"derivedSI", "label"=>"W"}, "max_value"=>"2530.0", "current_value"=>"140", "id"=>"4", "min_value"=>"0.0"}, {"at"=>"2012-06-21T22:23:27.725649Z", "tags"=>["M Bedroom"], "unit"=>{"type"=>"derivedSI", "label"=>"W"}, "max_value"=>"1444.0", "current_value"=>"40", "id"=>"5", "min_value"=>"0.0"}, {"at"=>"2012-06-21T22:23:27.725649Z", "tags"=>["Water Heater"], "unit"=>{"type"=>"derivedSI", "label"=>"W"}, "max_value"=>"5189.0", "current_value"=>"0", "id"=>"6", "min_value"=>"0.0"}], "location"=>{"domain"=>"physical", "lat"=>20.632784250388, "lon"=>-158.203125}, "created"=>"2012-02-25T03:26:13.453958Z", "feed"=>"https://api.cosm.com/v2/feeds/49679.json", "private"=>"false", "id"=>49679, "version"=>"1.0.0", "updated"=>"2012-06-21T22:23:27.754273Z"}
  context "converts a json string into a ruby object" do
    before do
      @json_object = CosmParser.convert_json_to_object(@json_string)
    end

    it { @json_object.should be_a_kind_of(Hash) }
    it { @json_object["datastreams"].should be_a_kind_of(Array) }
    it { @json_object["datastreams"][0]["tags"].should be_a_kind_of(Array) }
  end

  it "be able to read any particular datastream from a feed" do
    json_object = CosmParser.convert_json_to_object(@json_string)
    current_settings = Feed.new(json_object)

    current_settings["title"].should == "House"
    out["datastreams"][0]["tags"][0].should == "Mains"
    out["datastreams"][1]["current_value"].should == "820"
    out["datastreams"][1]["unit"]["label"].should == "W"

    current_settings.datastream(1)["tags"].should == "Mains"
    current_settings.datastream(1)["current_value"].should == "820"
    current_settings.datastream(1)["unit_label"].should == "W"
  end


end