# frozen_string_literal:true

require 'test/unit'

require_relative '../JsonUtils/json_utils'

# this class contains unit tests for the JsonUtils class of methods
class TestJsonUtils < Test::Unit::TestCase
  def test_parse_data
    test_data_string = '{"data":"test"}'

    expect_data_hash = { 'data' => 'test' }

    assert_equal(JsonUtils.parse_data(test_data_string), expect_data_hash)
  end

  def test_retrieve_creds
    expect_subdomain = 'adibcodingchallenge'
    assert_equal(JsonUtils.retrieve_credentials['subdomain'], expect_subdomain)
  end
end
