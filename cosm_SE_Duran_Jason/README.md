01_dictionary
=========
1. Modify 01_dictionary/dictionary.rb so that this command will pass all of the test cases:

  `cd 01_dictionary`
  `rspec dictionary_spec.rb`

02_cosm-ruby
=========

1. From the command line run `bundle install` to install the needed ruby gem libraries.
2. Start by getting the tests in `feed_spec.rb` to pass.
3. Then get the tests in `cosm_parser_spec.rb` to pass.


  * Hint to use the json gem then:

      `parsed_json = JSON(your_json_string)`

  * Hint: see `example_cosm_access_by_http.rb` for connecting to cosm through ruby.

4. You can ignore cosm_stream.rb -- cosm is now xively and this code no longer works with their API
