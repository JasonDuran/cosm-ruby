01_dictionary
=========
1. Modify 01_dictionary/dictionary.rb so that this command will pass all of the test cases:

cd 01_dictionary
rspec dictionary_spec.rb

02_cosm-ruby
=========

1. Start by getting the tests in feed_spec.rb to pass
2. Then get the tests in cosm_parser_spec.rb to pass


# Hint to use the json gem then
#    parsed_json = JSON(your_json_string)
#
#
# Hint see example_cosm_access_by_http.rb for connecting to cosm through ruby
#
#
#

3. See a real stream. If you modify cosm_stream.rb with your API_KEY, then you can see the current live
values with the code you have written

ruby cosm-stream.rb
