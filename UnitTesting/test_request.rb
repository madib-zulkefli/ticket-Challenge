# frozen_string_literal:true

require 'test/unit'

require_relative '../Request/ticket_request'
require_relative '../JsonUtils/json_utils'

# this class contains unit tests for the JsonUtils class of methods
class TestTicketRequests < Test::Unit::TestCase
  @@creds = JsonUtils.retrieve_credentials
  @@requester = TicketRequest.new(@@creds)

  # referred here for how to use assert_raise
  # https://stackoverflow.com/questions/7296600/proper-assert-raise-unit-testing-and-use-of-exception-class
  def test_bad_creds_request
    bad_creds = JsonUtils.retrieve_credentials('UnitTesting/bad_config.json')
    assert_raise(BadRequestException) do
      @@requester.check_auth(
        bad_creds['email'],
        bad_creds['pass']
      )
    end
  end

  def test_bad_url_request
    url = 'https://www.badurlexample.com/test'
    assert_raise(BadRequestException) do
      @@requester.make_request(url)
    end
  end

  def test_make_request_id_ticket
    url = @@requester.make_ticket_id_url('2')
    request_data = @@requester.make_request(url)
    assert_equal(request_data['ticket']['id'], 2)
  end

  def test_check_auth
    req_code = @@requester.check_auth
    expected_code = 200
    assert_equal(req_code, expected_code)
  end
end
